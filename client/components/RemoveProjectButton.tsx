import * as React from 'react'
import { useRouter } from 'next/router'
import { useForm } from 'react-hook-form'
import { Trash2 } from 'react-feather'

import { Modal } from './Modal'
import { useModal } from '@hooks/useModal'

import { useRemoveProject, RemoveProjectInputs } from '@hooks/generated'

interface Props {}

export const RemoveProjectButton: React.FC<Props> = () => {
  const { push, query } = useRouter()
  const { close, isOpen, open } = useModal()
  const { mutateAsync: removeProject } = useRemoveProject({
    onError: err => console.error(err),
    onSuccess: ({ removeProject }) => {
      if (removeProject && removeProject.data) {
        close()
        push(`/u/${query.userId}/`)
      }
    },
  })
  const {
    formState: { isSubmitting },
    handleSubmit,
    register,
  } = useForm()

  const onSubmit = handleSubmit<RemoveProjectInputs>(async values => {
    try {
      await removeProject({ inputs: { ...values } })
    } catch (error) {
      throw new Error('[RemoveProjectButton]: onSubmit')
    }
  })
  return (
    <>
      <button
        className="flex items-center p-2 space-x-2 text-xl text-white transition duration-300 transform bg-red-500 border-transparent rounded-full shadow-lg group hover:shadow-none hover:bg-red-400 hover:w-max"
        onClick={open}
      >
        <Trash2 />
        <span className="hidden group-hover:block">Remove</span>
      </button>
      <Modal isOpen={isOpen} onClose={close} title="Remove Project">
        <>
          <div className="p-4 text-gray-600 bg-gray-200 rounded-md shadow-inner">
            <p className="mb-4">
              Are you sure you want to remove this project? This operation is
              not reversible! Maybe you would like to just archive the project
              instead?
            </p>
            <button className="w-full px-6 py-2 text-white transition duration-200 transform bg-purple-500 border-transparent rounded-lg shadow-lg hover:bg-purple-600 hover:shadow-none hover:scale-95">
              Archive Project
            </button>
          </div>
          <form
            className="flex flex-col items-center w-full max-w-md py-4 space-y-4 bg-white rounded-lg"
            onSubmit={onSubmit}
          >
            <div className="hidden">
              <label hidden htmlFor="title">
                Title
              </label>
              <input
                {...register('id')}
                className="px-3 py-2 border-transparent rounded-md"
                placeholder="What should the project by called?"
                type="hidden"
                value={query.projectId}
              />
            </div>
            <button
              disabled={isSubmitting}
              className="w-full px-6 py-2 text-white transition duration-200 transform bg-red-500 border-transparent rounded-lg shadow-lg hover:bg-red-600 hover:shadow-none hover:scale-95"
              type="submit"
            >
              Remove Project
            </button>
          </form>
        </>
      </Modal>
    </>
  )
}
