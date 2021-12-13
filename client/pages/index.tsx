import * as React from 'react'

import { UserRegistrationForm } from '@components/UserRegistrationForm'
import { UserSignInForm } from '@components/UserSignInForm'

const IndexPage: React.FC = () => {
  const [display, setDisplay] = React.useState<'register' | 'signin'>(
    'register'
  )
  return (
    <div className="flex flex-col items-center justify-center">
      {display === 'register' && (
        <>
          <UserRegistrationForm />
          <p className="mt-8">
            No account?{' '}
            <button
              className="font-bold text-blue-900"
              onClick={() => setDisplay('signin')}
            >
              Sign In
            </button>
          </p>
        </>
      )}

      {display === 'signin' && (
        <>
          <UserSignInForm />
          <p className="mt-8">
            Have an account?{' '}
            <button
              className="font-bold text-blue-900"
              onClick={() => setDisplay('register')}
            >
              Register
            </button>
          </p>
        </>
      )}
    </div>
  )
}

export default IndexPage
