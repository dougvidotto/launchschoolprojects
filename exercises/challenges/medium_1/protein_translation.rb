class InvalidCodonError < StandardError
end


class Translation

  PROTEINS = { "Methionine" => ['AUG'], 
               "Phenylalanine" => ['UUU', 'UUC'], 
               "Leucine" => ['UUA', 'UUG'],
               "Serine" => ['UCU', 'UCC', 'UCA', 'UCG'],
               "Tyrosine" => ['UAU', 'UAC'],
               "Cysteine" => ['UGU', 'UGC'],
               "Tryptophan" => ['UGG'],
               "STOP" => ['UAA', 'UAG', 'UGA']
             }

  def self.of_codon(codon)
    PROTEINS.each { |protein, codons| return protein if codons.include?(codon) }
    nil
  end

  def self.of_rna(sequence)
    result = []
    start = 0
    ending = 2
    while ending < sequence.size
      protein = of_codon(sequence[start..ending])
      raise InvalidCodonError if protein.nil?
      unless protein == 'STOP'
        result << protein
      else
        break
      end
      start += 3
      ending += 3
    end
    result
  end
end
