import * as React from 'react'

import { useSession } from '@hooks/useSession'

interface Props {}

export const BaseLayout: React.FC<Props> = ({ children }) => {
  const { session, signOut } = useSession()
  return (
    <>
      <nav className="flex items-center justify-between py-4">
        <div className="">
          <h1 className="text-4xl italic text-indigo-400 underline ">
            Cositas
          </h1>
        </div>
        {session && (
          <div className="flex items-center space-x-4">
            <div className="flex flex-col">
              <p className="font-bold text-indigo-400">
                {session.user.firstName} {session.user.lastName}{' '}
              </p>
              <span className="font-light text-indigo-600">
                @{session.user.username}
              </span>
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
      <div className="flex flex-col items-center justify-center min-h-screen py-8">
        {children}
      </div>
    </>
  )
}
