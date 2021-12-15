import { compareAsc, format } from 'date-fns'

export const isServer = typeof window === 'undefined'

type Formats =
  | 'full-localized'
  | 'short-localized'
  | 'short-time-with-date-localized'
  | 'time-localized'

const formatsMap = {
  'full-localized': 'PPPP',
  'short-localized': 'PP',
  'short-time-with-date-localized': 'P ppp',
  'time-localized': 'ppp',
}

export const hasBeenModified = (modifiedAt: string, createdAt: string) => {
  return Boolean(compareAsc(new Date(modifiedAt), new Date(createdAt)))
}

export const formatDateTime = (
  dateTimeString: string,
  presentation?: Formats
) => {
  return format(
    new Date(dateTimeString),
    formatsMap[presentation || 'full-localized']
  )
}
