import * as React from 'react'
import { useRouter } from 'next/router'

import { Session, useCurrentUser } from '@hooks/generated'
import { isServer } from '@utils/helpers'

type PickedSession = Omit<Session, '__typename'>

type Context = {
  session: PickedSession | undefined
  setSession: React.Dispatch<React.SetStateAction<PickedSession | undefined>>
  signOut: () => void
}

export const SessionContext = React.createContext<Context | undefined>(
  undefined
)

// Will match all routes "/u/{digit}"
const authRouteRegex = new RegExp(/\/u\/\d/)

export const SessionProvider: React.FC = ({ children }) => {
  const { asPath, push } = useRouter()
  const [session, setSession] = React.useState<PickedSession | undefined>(
    undefined
  )

  const { data: user } = useCurrentUser()

  React.useEffect(() => {
    if (!isServer) {
      const isAuthRoute = authRouteRegex.test(asPath)
      // We can look for a token.
      const token = sessionStorage.getItem('x')
      // Determine if we are currently on an auth route.
      if (isAuthRoute) {
        // The session will be undefined on initialization,
        // but check this after every subsequent render to
        // verify we are in fact tracking a session.
        if (typeof session === 'undefined') {
          // The following is present for that 'undefined' at
          // initialization case. It does not mean that a session
          // is not present the first time the app loads.
          // If a token is present the useCurrentUser hook will
          // evaluate with user data.
          if (user && user.me) {
            // This check is really only here to appease the TypeScript
            // Gods as the above check would not evaluate if their were
            // not a token present in the browser.
            if (token) {
              // All the things are present to set the current session.
              setSession({
                token,
                user: user.me,
              })
              return
            }
          }
          // If their is no `user` their is no chance at their being a
          // `token` as well so send the user to the home page.
          push('/')
        } else {
          // A session was found, let's make sure the tokens match.
          // And if they do then let them continue viewing the page.
          if (session.token === token) {
            return
          }
          // If not then GTFO!
          push('/')
        }
      } else {
        // We are now in the case that the user in not on an auth
        // protected page. This could be them routing back to the
        // application from elsewhere. We first need to check if
        // a token is present and route them as needed instead of
        // having them log in again.
        if (token) {
          // The final guard here protects against an infinite loop.
          if (user && user.me && !isAuthRoute) {
            // Situation occurred where session is being set as undefined on
            // initial render because we cannot get access to the browser from
            // the server, yet their is a token in the browser and the user
            // query did execute as it should have.
            setSession({
              token,
              user: user.me,
            })
            return
          }
        }
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [asPath, session])

  const signOut = () => {
    if (!isServer) {
      sessionStorage.removeItem('x')
      setSession(undefined)
      push('/')
    }
  }

  return (
    <SessionContext.Provider value={{ session, setSession, signOut }}>
      {children}
    </SessionContext.Provider>
  )
}
