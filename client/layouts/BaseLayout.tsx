import * as React from 'react'

import { useSession } from '@hooks/useSession'

interface Props {}

export const BaseLayout: React.FC<Props> = ({ children }) => {
  const { session, signOut } = useSession()
  return (
    <div className="">
      <nav className="flex items-center justify-between px-6 py-4 bg-gray-700">
        <div className="">
          <h1 className="text-xl text-blue-900">Cositas</h1>
        </div>
        {session && (
          <div className="flex items-center space-x-4">
            <div className="flex flex-col">
              <p className="font-bold">
                {session.user.firstName} {session.user.lastName}{' '}
                <span className="font-light text-gray-600">
                  (@{session.user.username})
                </span>
              </p>
            </div>
            <button
              className="px-6 py-2 bg-yellow-200 border-transparent rounded-lg shadow-lg"
              onClick={signOut}
            >
              Sign Out
            </button>
          </div>
        )}
      </nav>
      <div className="flex flex-col min-h-screen py-8">{children}</div>
    </div>
  )
}
