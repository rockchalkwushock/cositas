import * as React from 'react'
import { NextPage } from 'next'

import { ProjectLink } from '@components/ProjectLink'
import { RemoveProjectButton } from '@components/RemoveProjectButton'
import { useAllProjects } from '@hooks/generated'
import { useSession } from '@hooks/useSession'
import { formatDateTime } from '@utils/helpers'
import { AddProjectButton } from '@components/AddProjectButton'

interface Props {}

const UserIndexPage: React.FC<NextPage<Props>> = () => {
  const { session } = useSession()
  const { data: all } = useAllProjects()
  return (
    <div className="w-full">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-2xl font-bold text-indigo-400">
          {session?.user.firstName}'s Dashboard
        </h1>
        <AddProjectButton />
      </div>
      <ul className="grid grid-cols-4 gap-4">
        {all &&
          all.projects &&
          all.projects.length > 0 &&
          all.projects.map(project => (
            <ProjectLink id={project.id} key={project.id}>
              <li className="flex flex-col p-4 space-y-6 text-white bg-indigo-700 rounded-lg shadow-xl hover:shadow-none hover:bg-indigo-800">
                <div className="">
                  <h2 className="text-2xl font-bold">{project.title}</h2>
                </div>
                <div className="flex flex-col">
                  <span>
                    Starts:{' '}
                    {formatDateTime(project.startDate, 'short-localized')}
                  </span>
                  <span>
                    Ends: {formatDateTime(project.endDate, 'short-localized')}
                  </span>
                </div>
                <div className="flex space-x-2">
                  <RemoveProjectButton />
                </div>
              </li>
            </ProjectLink>
          ))}
      </ul>
    </div>
  )
}

export default UserIndexPage
