module Menu = {
  @react.component
  let make = (~children: React.element) => {
    <div
      style={{
        borderRadius: "2px",
        background: Theme.background,
        boxShadow: "0px 3px 18px 0px rgba(0, 0, 0, 0.15), 0px 0px 0px 1px rgba(0, 0, 0, 0.08)",
        marginTop: "3px",
        position: "absolute",
        zIndex: "2",
      }}>
      {children}
    </div>
  }
}

let fontStyles: JsxDOM.style = {
  fontFamily: "Arial",
  fontSize: "14px",
  fontWeight: "400",
  lineHeight: "18px",
  color: Theme.colors["text"]["primary"],
}

@react.component
let make = (
  ~children: React.element,
  ~isOpen: bool,
  ~target: React.element,
  ~onClose: unit => unit,
) => {
  <div style=fontStyles>
    {target}
    {isOpen ? <Menu> {children} </Menu> : React.null}
    {isOpen ? <Blanket onClick={onClose} /> : React.null}
  </div>
}
