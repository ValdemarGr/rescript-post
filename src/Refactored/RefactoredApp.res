open Belt.Array
open Js.Int
open Mobx

@react.component
let make = observer(() => {
  let state = useLocalObservable(() =>
    range(0, 30)->map(x => (ref(x), ref(toString(x))))
  )

  let evenAgeSum = useComputed(() => 
    state
    ->keepWithIndex((_, i) => mod(i, 2) == 0)
    ->reduce(0, (accum, (next, _)) => accum + next.contents)
  )

  <>
    <Sum getSum={evenAgeSum} />
    {state
    ->mapWithIndex((i, (a, n)) => {
      <Entry key={toString(i)} name={n} age={a} /> // indexes are stable
    })
    ->React.array}
  </>
})