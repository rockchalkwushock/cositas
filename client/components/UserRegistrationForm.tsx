import * as React from 'react'
import { useForm } from 'react-hook-form'

import { useAuth } from '@hooks/useAuth'

interface Props {}

export const UserRegistrationForm: React.FC<Props> = ({}) => {
  const {
    formState: { isSubmitting },
    handleSubmit,
    register,
  } = useForm()
  const { registerNewUser } = useAuth()

  return (
    <form
      className="flex flex-col max-w-md p-4 space-y-4 bg-white rounded-lg"
      onSubmit={handleSubmit(registerNewUser)}
    >
      <h2 className="text-2xl text-center">Register Account</h2>
      <div className="flex flex-col p-2 space-y-2 bg-gray-300 rounded-md">
        <label hidden htmlFor="email">
          Email
        </label>
        <input
          className="px-3 py-2 border-transparent rounded-md"
          placeholder="Email"
          {...register('email')}
          type="email"
        />
      </div>
      <div className="flex flex-col p-2 space-y-2 bg-gray-300 rounded-md">
        <label hidden htmlFor="firstName">
          First Name
        </label>
        <input
          className="px-3 py-2 border-transparent rounded-md"
          placeholder="First Name"
          {...register('firstName')}
        />
      </div>
      <div className="flex flex-col p-2 space-y-2 bg-gray-300 rounded-md">
        <label hidden htmlFor="lastName">
          Last Name
        </label>
        <input
          className="px-3 py-2 border-transparent rounded-md"
          placeholder="Last Name"
          {...register('lastName')}
        />
      </div>
      <div className="flex flex-col p-2 space-y-2 bg-gray-300 rounded-md">
        <label hidden htmlFor="username">
          Username
        </label>
        <input
          className="px-3 py-2 border-transparent rounded-md"
          placeholder="Username"
          {...register('username')}
        />
      </div>
      <div className="flex flex-col p-2 space-y-2 bg-gray-300 rounded-md">
        <label hidden htmlFor="password">
          Password
        </label>
        <input
          className="px-3 py-2 border-transparent rounded-md"
          placeholder="Password"
          {...register('password')}
          type="password"
        />
      </div>
      <button
        disabled={isSubmitting}
        className="px-6 py-2 text-white transition duration-200 transform bg-blue-500 border-transparent rounded-lg shadow-lg hover:bg-blue-600 hover:shadow-none hover:scale-95"
        type="submit"
      >
        Register
      </button>
    </form>
  )
}
