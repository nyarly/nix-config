# Defined in /tmp/fish.xGvEnS/__fixed_width_number.fish @ line 2
function __fixed_width_number --argument number
	if [ -z $number ];
    set number 0
  end

  set number (math "floor($number)")

  if [ $number -lt 1000 ];
    printf "%3d" $number
    return
  end

  set -l exponent (math -s0 "log10($number)")
  set -l mantissa (math -s0 "$number / 10 ^ $exponent")

  set -l value {$mantissa}e{$exponent} #XXX add U+23e8 (exponentiation symbol) to monofur
  echo -n $value
end
