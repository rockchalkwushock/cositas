import * as React from 'react'

import { useGetName } from '@hooks/generated'

const IndexPage: React.FC = () => {
  const { data, isLoading } = useGetName()
  return (
    <div>
      {isLoading && <h1>Loading...</h1>}
      {data && <h1>{data.name}</h1>}
    </div>
  )
}

export default IndexPage
