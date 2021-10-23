open Mobx
open Js.Int

module ShowName = {
  @react.component
  let make = observer((~name: ref<string>) => {
    <>
      <br />
      {`My name is ${name.contents}`->React.string}
      <br />
      <input
        name="name" onChange={action(x => name := ReactEvent.Form.target(x)["value"])}
      />
    </>
  })
}

module ShowAge = {
  @react.component
  let make = observer((~age: ref<int>) => {
    <>
      <br />
      {`My age is ${toString(age.contents)}`->React.string}
      <br />
      <input name="age" onChange={action(x => age := ReactEvent.Form.target(x)["value"])} />
    </>
  })
}

@react.component
let make = observer((~name: ref<string>, ~age: ref<int>) => {
  <> <ShowName name={name} /> <ShowAge age={age} /> </>
})