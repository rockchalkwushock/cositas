import * as React from 'react'

import { useCurrentUser } from '@hooks/generated'

interface Props {}

const UserIndexPage: React.FC<Props> = () => {
  const { data } = useCurrentUser()
  return (
    <div className="">
      <h1>User Index Page</h1>
      Authenticated as: {data?.me?.firstName} {data?.me?.lastName}
    </div>
  )
}

export default UserIndexPage
