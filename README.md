# DNAText.jl 
## Travis [![Build Status](https://travis-ci.com/harveydevereux/DNAText.jl.svg?branch=master)](https://travis-ci.com/harveydevereux/DNAText.jl) AppVeyor [![Build status](https://ci.appveyor.com/api/projects/status/r3x53cnn3n7352tf?svg=true)](https://ci.appveyor.com/project/harveydevereux/dnatext-jl)


Convert text (including Julia code) to a "DNA strand", print nicely and execute DNA strands as Julia code! 

Use this for fun e.g to obfuscate you Julia code as "DNA" but still be able to run it

### E.g
```Julia
julia> DNAProgram = DNA("for i in 1:10 print(i,\" \") end");
julia> ExecuteDNA(DNAProgram)
1 2 3 4 5 6 7 8 9 10
julia> print(DNAProgram) # output edited (truncated) for readme

  CG
 G--C
 C---G
 G----C
 T-----A
  A-----T
   G----C
    C---G
     G--C
      TA
      .
      .
      .
      GC
     C--G
    C---G
   T----A
  A-----T
 G-----C
 C----G
 G---C
 T--A
  GC
  TA
 A--T
 G---C
 C----G
 G-----C
  C-----G
   A----T
    T---A
     A--T
      GC
```

### TODO
- [ ] Write the encoder/decoder to be able to handle more charset (UTF-XX)
- [ ] Add an encoding option to DNA

### Limitations

Currently have only implemented UTF-8 in the DNAEncode and DNADecode functions

Because of this quite a few characters in variable names will cause errors, i.e Julia
code like:
```Julia
using Distributions, Plots
σ = 1.0
histogram(rand(Normal(0.0,σ),10000),normed=true)
```
will fail, purely because σ will not encode
