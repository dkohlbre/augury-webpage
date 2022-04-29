## What processors are affected?

Only Apple silicon processors are affected. We have confirmed the
existence of the DMP on the A14, M1, and M1 Max. We believe some older A-series
processors and the newest M1-family (M1 Pro, etc.) chips are also
affected but have only confirmed this on the M1 Max.

We have tested several recent families of Intel and AMD processors and
seen no evidence they are affected.

## How bad is this?

_Right now_ not that bad! We have not demonstrated any end-to-end
exploits with Augury techniques at this time. Currently, only pointers
can be leaked, and likely only in the sandbox threat model.

If you are counting on ASLR in a sandbox, I'd be worried. Otherwise,
be worried when the next round of attacks using Augury come out :)

## What exactly is a DMP?

A Data Memory-Dependent Prefetcher (DMP) is a prefetcher that takes
into account the content of memory when deciding what to prefetch. A
conceptually simple (if tricky to implement) DMP is one that watches
the stream of cache lines returned from the memory system, and
attempts a prefetch on any 64-bit chunk that appears to form (or help in
the formation of) a pointer.

## What DMP structure did you find?

In Apple Silicon we found an Array-of-Pointers (AoP) DMP. This
prefetcher looks for access patterns of the following form:

```python
for( i=0; i<len(arr); i++ ){
    *arr[i];
}
```

Once it has seen `*arr[0]` ... `*arr[2]` occur (even speculatively!)
it will begin prefetching `*arr[3]` onward.
That is, it will first prefetch ahead the contents of `arr` and then
_dereference_ those contents.  In contrast, a conventional prefetcher would not
perform the second step/dereference operation.

## What makes Augury different from Spectre/MDS/etc?

Augury techniques leverage _only_ the DMP, not transient execution. In
fact, speculative execution could be completely disabled and Augury
would still work.

A more subtle, but important point, is that the types of defenses that
apply to Augury are not the same as other microarchitectural
attacks. Any defense that relies on tracking what data is accessed by
the core (speculatively or non-speculatively) cannot protect against
Augury, as the leaked data is never read by the core!

Some Spectre defenses (notably defenses like Site Isolation) also
apply to Augury attacks since they have a similar effective
reach. Other defenses like Speculative Load Hardening are not
applicable and will not prevent Augury for leaking data.

## What is a "data at rest" attack?

Data at rest microarchitectural leakage is a type of attack where the
targeted data is never read into the core speculatively or
non-speculatively, and yet is leaked. We described the likely
existence of these attacks in
[Pandora](https://homes.cs.washington.edu/~dkohlbre/papers/pandora_isca2021.pdf)
and [Safecracker](https://dl.acm.org/doi/abs/10.1145/3373376.3378453), but had
not found any examples in the wild.

These attacks are problematic because most defensive approaches in
hardware or software for other microarchitectural attacks assume there
is some instruction that accesses the secret. They can then either
stop this access from occurring, or prevent the transmission of the
secret. Data at rest attacks do not have this property, and must be
mitigated differently.

## How did you find this?

We had been looking for DMP implementations in the wild for some time,
and previously discussed the dangers they present in
[Pandora](https://homes.cs.washington.edu/~dkohlbre/papers/pandora_isca2021.pdf).

We began looking at the M1 and A14 after reading this
[Anandtech](https://www.anandtech.com/show/16226/apple-silicon-m1-a14-deep-dive/3)
article including the quote:

> In our microarchitectural investigations we’ve seen signs of “memory
> magic” on Apple’s designs, where we might believe they’re using some
> sort of pointer-chase prefetching mechanism."

## Why "Augury"?

> "the work of an augur; the interpretation of omens."

Augury is a neat word to say.

More seriously, it well describes the process of leaking information
using a DMP. We are, in fact, interpreting the 'signs of the future'
that the DMP has left in microarchitectural state for us. It turns out
that those futures weren't going to happen, but we still learn
something from them!

Plus, no one had taken it :)

## Is Apple patching anything?

As far as we know, no.
We have discussed this issue with Apple and they are aware of all details.
