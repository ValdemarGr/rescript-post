@react.component
let make = () => {
  let (state, setState) = React.useState(() => 0)
  let increment = _ => setState(prev => prev + 1)

  <>
    {"Hello"->React.string}
    {`counter: ${Js.Int.toString(state)}`->React.string}
    <button onClick={increment}> {"Increment"->React.string} </button>
  </>
}
