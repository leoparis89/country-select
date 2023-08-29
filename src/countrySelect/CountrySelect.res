// :active pseudo class is not supported in JsxDOM.style
// so it's styling is done with css
%%raw("import './styles.css'")

let reactSelectStyles: ReactSelect.selectStyles = {
  menu: _ => {
    width: "230px",
    borderTop: Theme.border,
  },
  control: props => {
    {
      ...props,
      flexDirection: "row-reverse",
      paddingLeft: "10px",
      paddingRight: "10px",
      border: "none",
      boxShadow: "none",
    }
  },
  option: (props, state) => {
    ...props,
    padding: "4px 10px 4px 10px",
    color: Theme.colors["text"]["primary"],
    backgroundColor: {
      if state.isSelected {
        "#FFDBB3"
      } else if state.isFocused {
        "#ffe9d1"
      } else {
        "transparent"
      }
    },
  },
}

module Chevron = {
  @react.component
  let make = () => {
    <svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" viewBox="0 0 8 8" fill="none">
      <path fillRule="evenodd" clipRule="evenodd" d="M0 2H8L4 7L0 2Z" fill="#333333" />
    </svg>
  }
}

let flag = (~countryCode: string) =>
  <span
    style={{
      height: "14px",
      width: "14px",
    }}
    className={"fi fi-" ++ countryCode}
  />
module FlagAndName = {
  @react.component
  let make = (~option: ReactSelect.selectOption) => {
    <div
      style={{
        display: "flex",
        alignItems: "center",
        gap: "6px",
      }}>
      {flag(~countryCode=option.value)}
      <span> {React.string(option.label)} </span>
    </div>
  }
}

module Target = {
  @react.component
  let make = (~value, ~onClick) => {
    <div
      style={{
        display: "inline-flex",
        gap: "8px",
        alignItems: "center",
        borderRadius: "3px",
        padding: "4px 10px 4px 10px",
        border: Theme.border,
        backgroundColor: Theme.background,
      }}
      onClick={_ => onClick()}>
      {value->Option.mapWithDefault(React.string("Select a country"), (
        option: ReactSelect.selectOption,
      ) => <FlagAndName option />)}
      <Chevron />
    </div>
  }
}

let placeholder =
  <span style={{color: Theme.colors["text"]["tertiary"]}}> {React.string("Search")} </span>

module OptionDisplay = {
  let roundOneDecimal = (n: float) => Js.Math.round(n *. 10.) /. 10.

  @react.component
  let make = (~option: ReactSelect.selectOption) => {
    let labelLength = option.label->String.length->Belt.Float.fromInt
    // Create a mock stat value against the string length
    let mockStat = labelLength *. 10. +. labelLength *. 0.2
    let stat = mockStat->roundOneDecimal->Belt.Float.toString ++ "K"

    <div
      style={{
        display: "flex",
        justifyContent: "space-between",
      }}>
      <FlagAndName option />
      <span style={{fontSize: "14px", color: Theme.colors["text"]["secondary"]}}>
        {React.string(stat)}
      </span>
    </div>
  }
}

@react.component
let make = (~options) => {
  let (isOpen, setIsOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => None)

  <DropDown
    target={<Target value={value} onClick={_ => setIsOpen(v => !v)} />}
    isOpen
    onClose={_ => setIsOpen(_ => false)}>
    <ReactSelect
      styles=reactSelectStyles
      autoFocus=false
      backspaceRemovesValue=false
      components={{
        \"DropdownIndicator": () => <DropdownIndicator />,
        \"IndicatorSeparator": () => React.null,
      }}
      controlShouldRenderValue=false
      hideSelectedOptions=false
      isClearable=false
      menuIsOpen=true
      onChange={opt => {
        setValue(_ => Some(opt))
        setIsOpen(_ => false)
      }}
      options
      placeholder
      tabSelectsValue=false
      value
      classNamePrefix="react-select"
      formatOptionLabel={option => <OptionDisplay option />}
    />
  </DropDown>
}
