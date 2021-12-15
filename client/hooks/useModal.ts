import * as React from 'react'

export const useModal = () => {
  const [isOpen, setIsOpen] = React.useState(false)

  return {
    close: () => setIsOpen(false),
    isOpen,
    open: () => setIsOpen(true),
  }
}
