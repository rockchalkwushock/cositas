import * as React from 'react'

import { SessionContext } from '@contexts/SessionContext'

export const useSession = () => {
  const context = React.useContext(SessionContext)

  if (context === undefined) {
    throw new Error('useSession must be used within a SessionProvider')
  }

  return context
}
