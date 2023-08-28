let url = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

module Decode = {
  open Json.Decode

  let option = object(field => {
    open ReactSelect
    {
      label: field.required(. "label", string),
      value: field.required(. "value", string),
    }
  })
}

let getCountries = async () => {
  open Fetch

  let response = await fetch(
    url,
    {
      method: #GET,
    },
  )

  let jsonResult = await response->Response.json

  switch Json.decode(jsonResult, Json.Decode.array(Decode.option)) {
  | Ok(options) => options
  | Error(exn) => Js.Exn.raiseError(exn)
  }
}
