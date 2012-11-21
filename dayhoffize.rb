#!/usr/bin/env ruby

#converts a string (with arbitrary whitespace) from 3 letter amino acid codes to single letter codes

#lookup tables created using https://en.wikipedia.org/wiki/Amino_acid as of  11/21/2012 5 pm
THREE_TO_ONE = { :ala => :a, :cys => :c, :asp => :d, :glu => :e,
    :phe => :f, :gly => :g, :his => :h, :ile => :i,
    :lys => :k, :leu => :l, :met => :m, :asn => :n,
    :pro => :p, :gln => :q, :arg => :r, :ser => :s,
    :thr => :t, :val => :v, :trp => :w, :tyr => :y,
    :sec => :u, :pyl => :o, :asx => :b, :glx => :z,
    :xle => :j, :xaa => :x
}

AA_DETAILS = {
    :a => {:three_code =>:ala, :name => 'alanine', :polarity =>'nonpolar', :charge =>:neutral},
    :c => {:three_code =>:cys, :name => 'cysteine', :polarity =>'nonpolar', :charge =>:neutral},
    :d => {:three_code =>:asp, :name => 'aspartic acid', :polarity =>'polar', :charge =>:negative},
    :e => {:three_code =>:glu, :name => 'glutamic acid', :polarity =>'polar', :charge =>:negative},
    :f => {:three_code =>:phe, :name => 'phenylalanine', :polarity =>'nonpolar', :charge =>:neutral},
    :g => {:three_code =>:gly, :name => 'glycine', :polarity =>'nonpolar', :charge =>:neutral},
    :h => {:three_code =>:his, :name => 'histidine', :polarity =>'polar', :charge =>:neutral},
    :i => {:three_code =>:ile, :name => 'isoleucine', :polarity =>'nonpolar', :charge =>:neutral},
    :k => {:three_code =>:lys, :name => 'lysine', :polarity =>'polar', :charge =>:positive},
    :l => {:three_code =>:leu, :name => 'leucine', :polarity =>'nonpolar', :charge =>:neutral},
    :m => {:three_code =>:met, :name => 'methionine', :polarity =>'nonpolar', :charge =>:neutral},
    :n => {:three_code =>:asn, :name => 'asparagine', :polarity =>'polar', :charge =>:neutral},
    :p => {:three_code =>:pro, :name => 'proline', :polarity =>'nonpolar', :charge =>:neutral},
    :q => {:three_code =>:gln, :name => 'glutamine', :polarity =>'polar', :charge =>:neutral},
    :r => {:three_code =>:arg, :name => 'arginine', :polarity =>'polar', :charge =>:positive},
    :s => {:three_code =>:ser, :name => 'serine', :polarity =>'polar', :charge =>:neutral},
    :t => {:three_code =>:thr, :name => 'threonine', :polarity =>'polar', :charge =>:neutral},
    :v => {:three_code =>:val, :name => 'valine', :polarity =>'nonpolar', :charge =>:neutral},
    :w => {:three_code =>:trp, :name => 'tryptophan', :polarity =>'nonpolar', :charge =>:neutral},
    :y => {:three_code =>:tyr, :name => 'tyrosine', :polarity =>'polar', :charge =>:neutral},
    :u => {:three_code =>:sec, :name => 'selenocysteine', :charge => nil, :charge => nil},
    :o => {:three_code =>:pyl, :name => 'pyrrolysine', :charge => nil, :charge => nil},
    :b => {:three_code =>:asx, :name => 'asparagine or aspartic acid', :charge => nil, :charge => nil},
    :z => {:three_code =>:glx, :name => 'glutamine or glutamic acid', :charge => nil, :charge => nil},
    :j => {:three_code =>:xle, :name => 'leucine or isoleucine', :charge => nil, :charge => nil},
    :x => {:three_code =>:xaa, :name => 'unspecified or unknown amino acid', :charge => nil, :charge => nil},
}


def three_to_one(input_stream)
  input_stream.each_line do |three_string|
    raise "Input must be a non-zero length string" unless three_string  && three_string.length > 0

    clean_three_string = three_string.gsub(/[\s\.]/,'')
    if clean_three_string.length % 3 != 0
      raise "Input string must contain only 3 letter codes and whitespace (this one is #{clean_three_string.length} characters long)\n #{clean_three_string}"
    end

    codes = []
    clean_three_string.scan(/.{3}/){|code| codes << code.downcase.to_sym}

    print codes.map{|code| THREE_TO_ONE[code].to_s.upcase || "?"}.join
  end
  puts ""
end


if ARGV[0]
  three_to_one File.open(ARGV[0])
elsif ! $stdin.tty?
  three_to_one $stdin
end



