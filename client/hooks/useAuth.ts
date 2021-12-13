import * as React from 'react'
import { useRouter } from 'next/router'

import {
  RegistrationInputs,
  SignInInputs,
  useRegisterNewUser,
  useSignIn,
} from '@hooks/generated'
import { useSession } from './useSession'

type RegisterNewUserFn = (values: RegistrationInputs) => void
type SignInFn = (values: SignInInputs) => void
type UseAuthHook = () => {
  registerNewUser: RegisterNewUserFn
  signIn: SignInFn
}

export const useAuth: UseAuthHook = () => {
  const { push } = useRouter()
  const { setSession } = useSession()
  const { mutateAsync: register } = useRegisterNewUser()
  const { mutateAsync: signInUser } = useSignIn()

  const registerNewUser = React.useCallback<RegisterNewUserFn>(
    async values => {
      try {
        const { res } = await register({ inputs: { ...values } })
        if (res?.errors) {
          throw new Error('Oops!')
        }
        if (res?.data) {
          sessionStorage.setItem('x', res.data.token)
          setSession(res.data)
          push(`/u/${res.data.user.id}/`)
        }
      } catch (error) {
        throw new Error('[useAuth:registration] Failed')
      }
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    []
  )
  const signIn = React.useCallback<SignInFn>(async values => {
    try {
      const { res } = await signInUser({ inputs: { ...values } })
      if (res?.errors) {
        throw new Error('Oops!')
      }
      if (res?.data) {
        sessionStorage.setItem('x', res.data.token)
        setSession(res.data)
        push(`/u/${res.data.user.id}/`)
      }
    } catch (error) {
      throw new Error('[useAuth:signIn] Failed')
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return { registerNewUser, signIn }
}
