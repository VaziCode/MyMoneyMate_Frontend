import prisma from '@/lib/prisma'
import type { NextApiRequest, NextApiResponse } from 'next'


type UsersAndGroups = {
  pk_id: number,
  user_name: string,
  login_name: string,
  date_created:string,
  role: number,
  fk_user_id: number,
  fk_group_id: number,
  group_name: string,
  auth: string
}
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const {userId} = JSON.parse(req.body)
  
  const usersGroups = await prisma.$queryRawUnsafe(`
    select *
    from users u 
    join usergroups ug on u.pk_id = ug.fk_user_id
    join groups g on g.pk_id = ug.fk_group_id
  `) as UsersAndGroups[]
  
  // is user admin? 
  const isUserAdmin = (await prisma.users.findFirst({
    where:{
      pk_id:userId
    }
  }))?.is_admin

  const usersGroupsMap:Record<string,any> = {}

    usersGroups.filter((g)=>isUserAdmin ? true :  g.fk_user_id ===userId ).forEach((d)=>{
  
    const groupKey  =d.fk_group_id;
    usersGroupsMap[groupKey]={
      groupName:d.group_name,
      groupId:d.fk_group_id,
      users:usersGroups.filter((d)=>d.fk_group_id ===groupKey).map((d)=>{
        return {
          id:d.fk_user_id,
          name:d.user_name
        }
      })
    }
  })


  // return user to the client
  return res.status(200).json({usersGroupsMap,isUserAdmin})
}
