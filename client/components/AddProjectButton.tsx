import * as React from 'react'
import { useRouter } from 'next/router'
import { useForm } from 'react-hook-form'
import { PlusCircle } from 'react-feather'

import { Modal } from './Modal'
import { useModal } from '@hooks/useModal'

import { useAddProject, AddProjectInputs } from '@hooks/generated'

interface Props {}

export const AddProjectButton: React.FC<Props> = () => {
  const { push, query } = useRouter()
  const { close, isOpen, open } = useModal()
  const {
    formState: { isSubmitting },
    handleSubmit,
    register,
  } = useForm()
  const { mutateAsync: addProject } = useAddProject({
    onError: err => console.error(err),
    onSuccess: ({ addProject }) => {
      if (addProject && addProject.data) {
        close()
        push(`/u/${query.userId}/p/${addProject.data.id}/`)
      }
    },
  })

  const onSubmit = handleSubmit<AddProjectInputs>(async values => {
    try {
      await addProject({ inputs: { ...values } })
    } catch (error) {
      throw new Error('[AddProjectButton]: onSubmit')
    }
  })
  return (
    <>
      <button
        className="flex items-center p-2 space-x-2 text-xl text-white transition duration-300 transform bg-green-500 border-transparent rounded-full shadow-lg group hover:shadow-none hover:bg-green-600 hover:w-max"
        onClick={open}
      >
        <PlusCircle />
        <p className="hidden group-hover:block">Add Project</p>
      </button>
      <Modal isOpen={isOpen} onClose={close} title="Add Project">
        <>
          <div className="p-4 text-gray-600 bg-gray-200 rounded-md shadow-inner">
            <p className="">
              What cool new project are you thinking of getting started on and
              what is the time frame you want to set for yourself to get the job
              done? We will help you track your progress and send you
              notifications as the project progresses.
            </p>
          </div>
          <form
            className="flex flex-col items-center max-w-md p-4 space-y-4 bg-white rounded-lg"
            onSubmit={onSubmit}
          >
            <div className="flex flex-col w-full p-2 space-y-2 bg-gray-300 rounded-md">
              <label hidden htmlFor="title">
                Title
              </label>
              <input
                {...register('title')}
                className="px-3 py-2 border-transparent rounded-md"
                placeholder="What should the project by called?"
                type="text"
              />
            </div>
            <div className="flex flex-col w-full p-2 space-y-2 bg-gray-300 rounded-md">
              <label hidden htmlFor="startDate">
                Start Date
              </label>
              <input
                {...register('startDate')}
                className="px-3 py-2 border-transparent rounded-md"
                placeholder="When should the project start?"
                type="datetime-local"
              />
            </div>
            <div className="flex flex-col w-full p-2 space-y-2 bg-gray-300 rounded-md">
              <label hidden htmlFor="endDate">
                End Date
              </label>
              <input
                {...register('endDate')}
                className="px-3 py-2 border-transparent rounded-md "
                placeholder="When should the project end?"
                type="datetime-local"
              />
            </div>
            <button
              disabled={isSubmitting}
              className="w-full px-6 py-2 text-white transition duration-200 transform bg-blue-500 border-transparent rounded-lg shadow-lg hover:bg-blue-600 hover:shadow-none hover:scale-95"
              type="submit"
            >
              Add Project
            </button>
          </form>
        </>
      </Modal>
    </>
  )
}
