import * as React from 'react'
import { AppProps } from 'next/app'
import { QueryClient, QueryClientProvider } from 'react-query'
import { ReactQueryDevtools } from 'react-query/devtools'

import '../styles/global.scss'
import { SessionProvider } from '@contexts/SessionContext'
import { BaseLayout } from '@layouts/BaseLayout'

interface Props extends AppProps {}

const App: React.FC<Props> = ({ Component, pageProps, router }) => {
  const queryClientRef = React.useRef<QueryClient>()

  if (!queryClientRef.current) {
    queryClientRef.current = new QueryClient()
  }

  return (
    <QueryClientProvider client={queryClientRef.current}>
      <SessionProvider>
        <BaseLayout>
          <Component {...pageProps} key={router.asPath} />
        </BaseLayout>
      </SessionProvider>
      <ReactQueryDevtools initialIsOpen />
    </QueryClientProvider>
  )
}

export default App
