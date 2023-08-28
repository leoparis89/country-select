type fetchingState = Ok(array<ReactSelect.selectOption>) | Error(exn) | Loading

@react.component
let make = () => {
  let (status, setStatus) = React.useState(() => None)

  React.useEffect1(() => {
    setStatus(_ => Some(Loading))
    CountryAPI.getCountries()
    ->Promise.then(options => {
      setStatus(_ => Some(Ok(options)))
      Promise.resolve()
    })
    ->Promise.catch(exn => {
      setStatus(_ => Error(exn)->Some)
      Promise.resolve()
    })
    ->ignore

    None
  }, [])

  <div className="p-6">
    {status
    ->Belt.Option.map(options =>
      switch options {
      | Ok(options) => <CountrySelect options />
      | Error(_) => <div> {React.string("Error")} </div>
      | Loading => <div> {React.string("Loading")} </div>
      }
    )
    ->Belt.Option.getWithDefault(React.null)}
  </div>
}
