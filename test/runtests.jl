using DNAText, Test

@testset "DNA Instantiation" begin
    text = "Hello, World! DNA Style!"
    #
    dna = DNA(text)
    @test dna.Text == text
    @test dna.DNA == "CAGATAGCGCCTAGCGTATAGCGTATAGCGTTTAGAGTATAGAGAATAGCCCTTAGCGTTTAGCTAGTAGCGTATAGCGCATAGAGACTAGAGAATAGCACATAGCATGTAGCAACTAGAGAATAGCCATTAGCTCATAGCTGCTAGCGTATAGCGCCTAGAGACTAG"
end

@testset "DNA Print" begin
    text = "Hello, World! DNA Style!"
    dna = DNA(text)
    DNAStrand = DNAPrettify(dna.DNA)
    @test DNAStrand == "\n  CG\n A--T\n G---C\n A----T\n T-----A\n  A-----T\n   G----C\n    C---G\n     G--C\n      CG\n      CG\n     T--A\n    A---T\n   G----C\n  C-----G\n G-----C\n T----A\n A---T\n T--A\n  AT\n  GC\n C--G\n G---C\n T----A\n A-----T\n  T-----A\n   A----T\n    G---C\n     C--G\n      GC\n      TA\n     T--A\n    T---A\n   A----T\n  G-----C\n A-----T\n G----C\n T---A\n A--T\n  TA\n  AT\n G--C\n A---T\n G----C\n A-----T\n  A-----T\n   T----A\n    A---T\n     G--C\n      CG\n      CG\n     C--G\n    T---A\n   T----A\n  A-----T\n G-----C\n C----G\n G---C\n T--A\n  TA\n  TA\n A--T\n G---C\n C----G\n T-----A\n  A-----T\n   G----C\n    T---A\n     A--T\n      GC\n      CG\n     G--C\n    T---A\n   A----T\n  T-----A\n A-----T\n G----C\n C---G\n G--C\n  CG\n  AT\n T--A\n A---T\n G----C\n A-----T\n  G-----C\n   A----T\n    C---G\n     T--A\n      AT\n      GC\n     A--T\n    G---C\n   A----T\n  A-----T\n T-----A\n A----T\n G---C\n C--G\n  AT\n  CG\n A--T\n T---A\n A----T\n G-----C\n  C-----G\n   A----T\n    T---A\n     G--C\n      TA\n      AT\n     G--C\n    C---G\n   A----T\n  A-----T\n C-----G\n T----A\n A---T\n G--C\n  AT\n  GC\n A--T\n A---T\n T----A\n A-----T\n  G-----C\n   C----G\n    C---G\n     A--T\n      TA\n      TA\n     A--T\n    G---C\n   C----G\n  T-----A\n C-----G\n A----T\n T---A\n A--T\n  GC\n  CG\n T--A\n G---C\n C----G\n T-----A\n  A-----T\n   G----C\n    C---G\n     G--C\n      TA\n      AT\n     T--A\n    A---T\n   G----C\n  C-----G\n G-----C\n C----G\n C---G\n T--A\n  AT\n  GC\n A--T\n G---C\n A----T\n C-----G\n  T-----A\n   A----T\n    G---C\n"
end

@testset "DNA Execution" begin
    program = "a = [1,2,3,4,5]; b = sum(a); b"
    dna = DNA(program)
    @test ExecuteDNA(dna) == 15
end
