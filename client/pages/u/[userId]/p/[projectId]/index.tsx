import * as React from 'react'
import type { NextRouter } from 'next/router'

import { EditProjectButton } from '@components/EditProjectButton'
import { RemoveProjectButton } from '@components/RemoveProjectButton'
import { useFindProject } from '@hooks/generated'
import { formatDateTime, hasBeenModified } from '@utils/helpers'

interface Props {
  query: NextRouter['query']
}

const ProjectIndexPage: React.FC<Props> = ({ query: { projectId } }) => {
  const { data } = useFindProject({ id: projectId as string }, {})

  return (
    <div className="flex-1 w-full h-full">
      <div className="flex items-center justify-between">
        <h1>
          Project Name:{' '}
          <span className="font-bold uppercase">{data?.project?.title}</span>
        </h1>
        <div className="flex items-center space-x-4">
          <EditProjectButton />
          <RemoveProjectButton />
        </div>
      </div>
      <div className="">
        <p className="">
          Project Status:{' '}
          <span className="font-bold">{data?.project?.status}</span>
        </p>
        <p className="">
          Project Owner: {data?.project?.owner.firstName}{' '}
          {data?.project?.owner.lastName}
        </p>
        <p className="">
          Created On: {formatDateTime(data?.project?.createdAt)}
        </p>
        {hasBeenModified(
          data?.project?.modifiedAt,
          data?.project?.createdAt
        ) && (
          <p className="">
            Last Modified:{' '}
            {formatDateTime(
              data?.project?.modifiedAt,
              'short-time-with-date-localized'
            )}
          </p>
        )}
        <p className="">
          Project Start Date:{' '}
          {formatDateTime(data?.project?.startDate, 'short-localized')}
        </p>
        <p className="">
          Project End Date:{' '}
          {formatDateTime(data?.project?.endDate, 'short-localized')}
        </p>
        {data?.project?.archivedAt && (
          <p className="">
            Archived: {formatDateTime(data.project.archivedAt)}
          </p>
        )}
      </div>
    </div>
  )
}

// export const getStaticPaths: GetStaticPaths = async () => {
//   return { fallback: false, paths: [] }
// }

// export const getStaticProps: GetStaticProps<Props, {}> = async ctx => {
//   console.log(ctx)
//   return { props: {} }
// }

export default ProjectIndexPage
