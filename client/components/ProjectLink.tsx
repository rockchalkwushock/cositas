import * as React from 'react'
import Link from 'next/link'
import { useRouter } from 'next/router'

type ProjectLinkProps = React.AnchorHTMLAttributes<HTMLAnchorElement> & {
  id: string
}

// eslint-disable-next-line react/display-name
export const ProjectLink = React.forwardRef<
  HTMLAnchorElement,
  ProjectLinkProps
>(({ children, id, onClick, ...rest }, ref) => {
  const { query } = useRouter()
  return (
    <Link href={`/u/${query.userId}/p/${id}/`} passHref>
      <a {...rest} onClick={onClick} ref={ref}>
        {children}
      </a>
    </Link>
  )
})
