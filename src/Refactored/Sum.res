open Mobx
open Js.Int

@react.component
let make = observer((~getSum: unit => int) => <> <div> {`Sum is ${toString(getSum())}`->React.string} </div> </>)