module SubComponent = {
  @react.component
  let make = (~name: string, ~setName: string => unit, ~age: int, ~setAge: int => unit) => {
    <>
      <br />
      {`I am a list entry with name ${name} and age ${age->Js.Int.toString}`->React.string}
      <br />
      <input name="name" onChange={x => setName(ReactEvent.Form.target(x)["value"])} />
      <input name="age" onChange={x => setAge(ReactEvent.Form.target(x)["value"])} />
    </>
  }
}

@react.component
let make = () => {
  let (state, setState) = React.useState(() =>
    Belt.Array.range(0, 30)->Js.Array2.map(x => (x, x->Js.Int.toString))
  )

  let updateAt: (array<'a>, 'a, int) => array<'a> = (arr, a, i) => {
    let newArr = Js.Array2.copy(arr)
    newArr->Js.Array2.unsafe_set(i, a)
    newArr
  }

  <>
    {state
    ->Js.Array2.mapi(((a, n), i) => {
      <SubComponent
        key={i->Js.Int.toString} // indexes are stable
        name={n}
        setName={newName => setState(xs => xs->updateAt((a, newName), i))}
        age={a}
        setAge={newAge => setState(xs => xs->updateAt((newAge, n), i))}
      />
    })
    ->React.array}
  </>
}
