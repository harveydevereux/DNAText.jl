module DNAText

    using StringEncodings
    export show, print, println, DNA, ExecuteDNA, DNAPrettify

    function ConvertToDecimal(x::Int,base)
        x = digits(x)
        y = 0
        for i in 1:size(x,1)
            y += x[i]*base^(i-1)
        end
        return y
    end

    HexToDec(x) = parse(Int,string(x,base=10))
    HexToDNA(x) = parse(Int,string(x,base=4))

    DNAToHex(x) = UInt8(ConvertToDecimal(DNATo4(x),4))

    function DNAToBinary(x)
        y = ConvertToDecimal(x,4)
        return string(y,2)
    end

    function ToDNADigts(x::Int)
        y = reverse(digits(x))
        z = ""
        for i in 1:size(y,1)
            if y[i] == 0
                z*="A"
            elseif y[i] == 1
                z*="C"
            elseif y[i] == 2
                z*="G"
            elseif y[i] == 3
                z*="T"
            end
        end
        return z
    end
    function DNATo4(x::String)
        z = ""
        for i in 1:length(x)
            if x[i] == 'A'
                z*="0"
            elseif x[i] == 'C'
                z*="1"
            elseif x[i] == 'G'
                z*="2"
            elseif x[i] == 'T'
                z*="3"
            end
        end
        return parse(Int,z)
    end

    function DNAEncode(text::String;stop="TAG")
        code = encode(text,"UTF-8")
        code_dna = HexToDNA.(code)
        DNA = ToDNADigts.(code_dna)
        for i in 1:length(DNA)
            if length(DNA[i]) < 4
                DNA[i] = "A"^(4-length(DNA[i]))*DNA[i]
            end
        end
        x = join(DNA,stop)
        return x*stop
    end

    function DNADecode(DNA::String;stop="TAG")
        D = []
        pos = 1
        while pos+3 <= length(DNA)
            read = DNA[pos:pos+3]
            if occursin(stop,read)
                # there is a stop char, but first check its
                # not actually part of the char
                if DNA[pos+4:pos+6] == "TAG"
                    # "TAG" is part of a length 4 char like "CTAG"
                    push!(D,DNA[pos:pos+3])
                elseif DNA[pos:pos+2] == "TAG"
                    # "TAG is part of a lenght 4 char like "TAGC"
                    push!(D,DNA[pos:pos+3])
                end
            else
                push!(D,DNA[pos:pos+3])
            end
            pos = pos + 7
        end
        chars = [DNAToHex(D[i]) for i in 1:size(D,1)]
        return join([decode([chars[i]],"UTF-8") for i in 1:length(chars)])
    end

    function DNAPrettify(dna;sep="-",stop="TAG")
        """
            Returns DNA as a pretty DNA strand, e.g

            input = "AGACTAGCCGCTAGATGCTA"
            print(DNAPrettify(input)):
              AT
             G--C
             A---T
             C----G
             T-----A
              A-----T
               G----C
                C---G
                 C--G
                  GC
                  CG
                 T--A
                A---T
               G----C
              A-----T
             T-----A
             G----C
             C---G
             T--A
              AT
        """
        H = "\n"
        # this is the cycle to create a double helix for
        # a length of 10 base pairs between twists
        SpaceCycle = [2,1,1,1,1,2,3,4,5,6,6,5,4,3,2,1,1,1,1,2] # number of spaces to prepend
        SepCycle = [0,2,3,4,5,5,4,3,2,0,0,2,3,4,5,5,4,3,2,0] # number of separators between base pair components
        for i in 1:length(dna)
            char = dna[i]
            if char == 'A'
                pair = "T"
            elseif char == 'T'
                pair = "A"
            elseif char == 'G'
                pair = "C"
            elseif char == 'C'
                pair = "G"
            end

            pos = (i % 20) # pattern repeats at start of second turn
            pos == 0 ? pos = 1 : nothing

            spaces = SpaceCycle[pos]
            seps = SepCycle[pos]
            H*=(" "^spaces)*char*(sep^seps)*pair*"\n"
        end
        return H
    end

    mutable struct DNA
        DNA::String
        Text::String
    end

    function DNA()
        return DNA("","")
    end
    function DNA(Text::String)
        return DNA(DNAEncode(Text),Text)
    end
    import Base.show
    import Base.print
    import Base.println
    Base.show(DNA::DNA;text=false) = text ? Base.show(DNA.Text) : Base.println((DNAPrettify(DNA.DNA)))
    Base.print(DNA::DNA;text=false) = text ? Base.print(DNA.Text) : Base.print((DNAPrettify(DNA.DNA)))
    Base.println(DNA::DNA;text=false) = text ? Base.println(DNA.Text) : Base.println((DNAPrettify(DNA.DNA)))
    function ExecuteDNA(DNA::DNA)
        program = DNADecode(DNA.DNA)
        try
            eval(Meta.parse(program))
        catch e
            println("Error when executing DNA\n")
            println(e)
        end
    end
end # module JuliaDNA
