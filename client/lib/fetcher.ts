import { isServer } from '@utils/helpers'

let endpointUrl: string

if (typeof process.env.NEXT_PUBLIC_API_ENDPOINT === 'undefined') {
  throw new Error('NEXT_PUBLIC_API_ENDPOINT is required!')
} else {
  endpointUrl = process.env.NEXT_PUBLIC_API_ENDPOINT
}

/**
 * @name fetcher
 * @param query The GraphQL Query/Mutation.
 * @param variables The arguments passed/required by the Query/Mutation.
 * @description This function is only used in the codegen.yml.
 * It should not be used manually elsewhere.
 * @returns Promise<TData>
 */
export const fetcher = <TData, TVariables>(
  query: string,
  variables?: TVariables
): (() => Promise<TData>) => {
  return async () => {
    let headers: HeadersInit | undefined
    if (!isServer) {
      const token = sessionStorage.getItem('x')
      headers = token
        ? {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          }
        : { 'Content-Type': 'application/json' }
    }
    const res = await fetch(endpointUrl, {
      body: JSON.stringify({ query, variables }),
      headers,
      method: 'POST',
    })

    const { errors, data } = await res.json()

    if (errors) {
      const { message } = errors[0] || 'Fuck!'
      throw new Error(message)
    }

    return data as TData
  }
}
