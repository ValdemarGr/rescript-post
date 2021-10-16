module SubComponent = {
  module ShowName = {
    @react.component
    let make = Mobx.observer((~name: ref<string>) => {
      <>
        <br />
        {`My name is ${name.contents}`->React.string}
        <br />
        <input
          name="name" onChange={Mobx.action(x => name := ReactEvent.Form.target(x)["value"])}
        />
      </>
    })
  }

  module ShowAge = {
    @react.component
    let make = Mobx.observer((~age: ref<int>) => {
      <>
        <br />
        {`My age is ${age.contents->Js.Int.toString}`->React.string}
        <br />
        <input name="age" onChange={Mobx.action(x => age := ReactEvent.Form.target(x)["value"])} />
      </>
    })
  }

  @react.component
  let make = Mobx.observer((~name: ref<string>, ~age: ref<int>) => {
    <> <ShowName name={name} /> <ShowAge age={age} /> </>
  })
}

@react.component
let make = Mobx.observer(() => {
  let state = Mobx.useLocalObservable(() =>
    Belt.Array.range(0, 30)->Js.Array2.map(x => (ref(x), ref(x->Js.Int.toString)))
  )

  let evenAgeSum = Mobx.useComputedNow(() =>
    state
    ->Js.Array2.filteri((_, i) => mod(i, 2) == 0)
    ->Js.Array2.reduce((accum, (next, _)) => accum + next.contents, 0)
  )

  <>
    {`Sum is ${evenAgeSum->Js.Int.toString}`->React.string}
    {state
    ->Js.Array2.mapi(((a, n), i) => {
      <SubComponent key={i->Js.Int.toString} name={n} age={a} /> // indexes are stable
    })
    ->React.array}
  </>
})
