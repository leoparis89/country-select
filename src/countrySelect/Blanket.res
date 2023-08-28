@react.component
let make = (~onClick: unit => unit) => {
  <div
    onClick={_ => onClick()}
    style={
      bottom: "0",
      left: "0",
      top: "0",
      right: "0",
      position: "fixed",
      zIndex: "1",
    }
  />
}
