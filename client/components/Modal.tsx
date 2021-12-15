import * as React from 'react'
import { createPortal } from 'react-dom'
import { X } from 'react-feather'

interface Props {
  isOpen: boolean
  onClose: () => void
  title: string
}

export const Modal: React.FC<Props> = ({
  children,
  isOpen,
  onClose,
  title,
}) => {
  return isOpen
    ? createPortal(
        <>
          <div className="fixed top-0 left-0 z-40 w-screen h-screen bg-gray-700 opacity-80" />
          <div
            aria-modal
            aria-hidden
            tabIndex={-1}
            role="dialog"
            className="fixed left-0 z-50 flex justify-center w-full overflow-hidden outline-none top-1/4"
          >
            <div className="relative z-auto flex flex-col items-center max-w-lg bg-white rounded-lg m-7">
              <div className="flex items-center justify-between w-full px-6 py-4 border-b border-b-gray-600">
                <h1 className="text-xl">{title}</h1>
                <button
                  className="p-1 transition duration-300 rounded-md hover:bg-gray-400"
                  onClick={onClose}
                >
                  <X size={18} />
                </button>
              </div>
              <div className="flex flex-col items-center p-6">{children}</div>
            </div>
          </div>
        </>,
        document.body
      )
    : null
}
