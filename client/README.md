# Client

The client for `cositas` is a [NextJS](https://nextjs.org) application using [React-Query](https://react-query.tanstack.com) as it's data fetching layer and [TailwindCSS](https://tailwindcss.com) for styling and written in [TypeScript](https://www.typescriptlang.org/). The client application is deployed to [Vercel](https://vercel.com). Because the Elixir/Phoenix API is written using [GraphQL]() this client also makes use of [GraphQL-CodeGen](https://www.graphql-code-generator.com) for creating React Hooks for the specific queries and mutations written in the `/graphql` directory.

# Development

If you do not have `pnpm` on your machine is as easy as:

```bash
npm install -g pnpm
```

```bash
pnpm run dev # development server
pnpm run start # production server
pnpm run lint # eslint
pnpm run type-check # typescript
pnpm run generate # graphql-codegen
pnpm run build # production build
pnpm run format # prettier
```
