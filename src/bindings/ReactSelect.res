type selectOption = {
  label: string,
  value: string,
}

type components = {
  \"DropdownIndicator"?: unit => React.element,
  \"IndicatorSeparator"?: unit => React.element,
}

type state = {isFocused: bool, isSelected: bool}

type selectStyles = {
  control?: JsxDOM.style => JsxDOM.style,
  input?: JsxDOM.style => JsxDOM.style,
  container?: JsxDOM.style => JsxDOM.style,
  menu?: JsxDOM.style => JsxDOM.style,
  option?: (JsxDOM.style, state) => JsxDOM.style,
  singleValue?: (JsxDOM.style, state) => JsxDOM.style,
}

@react.component @module("react-select")
external make: (
  ~autoFocus: bool=?,
  ~backspaceRemovesValue: bool=?,
  ~components: components=?,
  ~controlShouldRenderValue: bool=?,
  ~hideSelectedOptions: bool=?,
  ~isClearable: bool=?,
  ~menuIsOpen: bool=?,
  ~onChange: selectOption => unit=?,
  ~options: array<selectOption>=?,
  ~placeholder: React.element=?,
  ~styles: 'selectStyles=?,
  ~tabSelectsValue: bool=?,
  ~value: option<selectOption>=?,
  ~formatOptionLabel: selectOption => React.element=?,
  ~classNamePrefix: string=?,
) => React.element = "default"
