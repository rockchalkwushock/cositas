import * as React from 'react'
import { useRouter } from 'next/router'

import { Session } from '@hooks/generated'
import { isServer } from '@utils/helpers'

type PickedSession = Omit<Session, '__typename'>

type Context = {
  session: PickedSession | undefined
  setSession: React.Dispatch<React.SetStateAction<PickedSession | undefined>>
}

export const SessionContext = React.createContext<Context | undefined>(
  undefined
)

export const SessionProvider: React.FC = ({ children }) => {
  const router = useRouter()
  const [session, setSession] = React.useState<PickedSession | undefined>(
    undefined
  )

  React.useEffect(() => {
    if (isServer) {
      return
    }
    // If their is not session and user is not on home route then
    // they are not authenticated to see anything, send them home.
    if (typeof session === 'undefined' && router.asPath !== '/') {
      router.push('/')
    }
  }, [router, session])

  return (
    <SessionContext.Provider value={{ session, setSession }}>
      {children}
    </SessionContext.Provider>
  )
}
