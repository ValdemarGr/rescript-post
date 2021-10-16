@module("mobx-react-lite")
external observer: React.component<'props> => React.component<'props> = "observer"

@module("mobx-react-lite") external useLocalObservable: (unit => 'a) => 'a = "useLocalObservable"

@module("mobx") external _veryUnsafeAction: ('a => 'b) => 'c = "action"
let action: ('a => 'b) => 'a => 'b = _veryUnsafeAction

type suspended<'a> = {
    get: ((. unit) => 'a)
}

@module("mobx") external _computed: (. unit => 'a) => suspended<'a> = "computed"
let _computed: (unit => 'a) => ((. unit) => 'a) = expensive => ((.) => _computed(. expensive).get(.))
let computed: (unit => 'a) => (unit => 'a) = f => () => _computed(f)(.)

let useComputed: (unit => 'a) => (unit => 'a) = f => {
    let (out, _) = React.useState(() => computed(f))
    out
}

let useComputedNow = f => useComputed(f)()
