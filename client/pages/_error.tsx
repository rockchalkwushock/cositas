import Error, { ErrorProps } from 'next/error'

interface Props extends ErrorProps {}

class CustomError extends Error<Props> {
  render(): JSX.Element {
    const { statusCode, title } = this.props
    return (
      <div className="">
        <h1 className="">{statusCode}</h1>
        <h4>{title}</h4>
      </div>
    )
  }
}

export default CustomError
