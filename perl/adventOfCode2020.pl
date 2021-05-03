#! perl

# Initialisation
$moduleName = "adventOfCode2020";

do "./batch_common.pl";

doInit("evocode.uk");

=pod
# Day 1
# Load data into an array
$day1input=readFile("../data/adventOfCode2020/day1input");
@expenseItems=split("\n",$day1input);
foreach $item1 (@expenseItems)
{
	foreach $item2 (@expenseItems)
	{
		foreach $item3 (@expenseItems)
		{
			if ($item1+$item2+$item3==2020)
			{
				log_message("Values are $item1 $item2 $item3");
			}
		}
	}
}
=pod
# Day 2
# Load data into an array
$day2input=readFile("../data/adventOfCode2020/day2input");
@passwords=split("\n",$day2input);
$valid=0;
$p2valid=0;
foreach $pwLine (@passwords)
{
	# Parse out the data
	($minTimes,$maxTimes,$letter,$pw) = ($pwLine =~ /^([0-9]+)\-([0-9]+) ([a-z]): (.*)$/);
	log_message("$minTimes $maxTimes $letter $pw");

	# Part 1
	$count=()=$pw=~/\Q$letter/g;
	if ($count>=$minTimes&&$count<=$maxTimes)
	{
		$valid++;
	}

	# Part 2
	if ((substr($pw,$minTimes-1,1) eq $letter)||(substr($pw,$maxTimes-1,1) eq $letter))
	{
		if (!((substr($pw,$minTimes-1,1) eq $letter)&&(substr($pw,$maxTimes-1,1) eq $letter)))
		{
			$p2valid++;
			}
		}
	}
log_message("Part 1: $valid");
log_message("Part 2: $p2valid");

# Day 3
# Load data into an array
$day3input=readFile("../data/adventOfCode2020/day3input");
@lines=split("\n",$day3input);
$xpos1=0;
$xpos1d2=0;
$xpos3=0;
$xpos5=0;
$xpos7=0;
$treeCount1=0;
$treeCount1d2=0;
$treeCount3=0;
$treeCount5=0;
$treeCount7=0;
foreach $line (@lines)
{
	log_message($line);
	if ((substr($line,$xpos1%31,1)) eq "#")
	{
		$treeCount1++;
	}
	if ((substr($line,$xpos3%31,1)) eq "#")
	{
		$treeCount3++;
	}
	if ((substr($line,$xpos5%31,1)) eq "#")
	{
		$treeCount5++;
	}
	if ((substr($line,$xpos7%31,1)) eq "#")
	{
		$treeCount7++;
	}
	if (((substr($line,$xpos1d2%31,1)) eq "#")&&($xpos1%2==0))
	{
		$treeCount1d2++;
		log_message("tree");
	}
	$xpos1+=1;
	$xpos3+=3;
	$xpos5+=5;
	$xpos7+=7;
	if ($xpos1%2==1)
	{
		$xpos1d2+=1;
	}
}
log_message("Right 1: $treeCount1 trees");
log_message("Right 3: $treeCount3 trees");
log_message("Right 5: $treeCount5 trees");
log_message("Right 7: $treeCount7 trees");
log_message("Right 1 down 2: $treeCount1d2 trees");

# Day 4
# Load data into an array
$day4input=readFile("../data/adventOfCode2020/day4input");
@passports=split("\n\n",$day4input);
$part1valid=0;
$part2valid=0;
foreach $passport (@passports)
{
	if (($passport=~m/byr/)&&($passport=~m/iyr/)&&($passport=~m/eyr/)&&($passport=~m/hgt/)&&($passport=~m/hcl/)&&($passport=~m/ecl/)&&($passport=~m/pid/))
	{
		$part1valid++;
		# Get and validate the values
		$valid=1;
		@pairs=split /\s+/,$passport;
		foreach $pair (@pairs)
		{
			@kv=split(":",$pair);
			$key=$kv[0];
			$value=$kv[1];
			if ($key eq "byr")
			{
				if ((!($value=~m/[0-9][0-9][0-9][0-9]/))||($value<1920)||($value>2002))
				{
					$valid=0;
				}
			}
			elsif ($key eq "iyr")
			{
				if ((!($value=~m/[0-9][0-9][0-9][0-9]/))||($value<2010)||($value>2020))
				{
					$valid=0;
				}
			}
			elsif ($key eq "eyr")
			{
				if ((!($value=~m/[0-9][0-9][0-9][0-9]/))||($value<2020)||($value>2030))
				{
					$valid=0;
				}
			}
			elsif ($key eq "hgt")
			{
				if ($value=~m/([0-9]*)(cm|in)/)
				{
					$height=$1;
					$unit=$2;
					if (($unit eq "cm")&&($height<150||$height>193))
					{
						$valid=0;
					}
					if (($unit eq "in")&&($height<59||$height>76))
					{
						$valid=0;
					}
				}
				else
				{
					$valid=0;
				}
			}
			elsif ($key eq "hcl")
			{
				if (!($value=~m/#([0-9]|[a-f])([0-9]|[a-f])([0-9]|[a-f])([0-9]|[a-f])([0-9]|[a-f])([0-9]|[a-f])/))
				{
					$valid=0;
				}
			}
			elsif ($key eq "ecl")
			{
				if(!($value=~m/(amb|blu|brn|gry|grn|hzl|oth)/))
				{
					$valid=0;
				}
			}
			elsif ($key eq "pid")
			{
				if(!($value=~m/^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$/))
				{
					$valid=0;
				}
			}
			elsif ($key ne "cid")
			{
				$valid=0;
			}
		}
		if ($valid==1)
		{
			$part2valid++;
		}
	}
}
log_message("Part 1 valid count: $part1valid");
log_message("Part 2 valid count: $part2valid");
=pod

# Day 5
# Load data into an array
$day5input=readFile("../data/adventOfCode2020/day5input");
@passes=split("\n",$day5input);
$maxSeatnum=0;
foreach $seat (0..1023)
{
	$missing=1;
	foreach $pass (@passes)
	{
		$row=substr($pass,0,7);
		$row=~s/F/0/g;
		$row=~s/B/1/g;
		$row=oct("0b" . $row);
		$col=substr($pass,7,3);
		$col=~s/L/0/g;
		$col=~s/R/1/g;
		$col=oct("0b" . $col);
		$seatnum=(8*$row)+$col;
		if ($seatnum>$maxSeatnum)
		{
			$maxSeatnum=$seatnum;
		}
		if ($seat==$seatnum)
		{
			$missing=0;
		}
	}
	if ($missing==1)
	{
		log_message("$seat is missing");
	}
}

log_message("Part 1: $maxSeatnum");

# Day 6
# Load data into an array
$day6input=readFile("../data/adventOfCode2020/day6input");
@answers=split("\n\n",$day6input);
$part1count=0;
$part2count=0;
foreach $answer (@answers)
{
	log_message($answer);
	$people = ($answer=~s/\n//g);
	$people++;

	# Loop through alphabet, adding 1 to answer count if it exists anywhere (part 1) or for all people (part 2)
	foreach $l (97..122)
	{
		$letter=chr($l);
		if ($answer=~m/$letter/)
		{
			$part1count++;
		}
		$yeses = ($answer=~s/$letter//g);
		if ($yeses==$people)
		{
			$part2count++;
		}
	}
}

log_message("Part 1: $part1count");
log_message("Part 1: $part2count");

# Day 7
# Load data into an array
$day7input=readFile("../data/adventOfCode2020/day7input");
@bags=split("\n",$day7input);
log_message("There are " . scalar(@bags) . " bags");
@obs=getOuterBags(\@bags,"shiny gold bag");
my %temp_hash;
while (scalar(@obs)>0)
{
	$temp=pop(@obs);
	$temp_hash{$temp}="dummy";
	push(@obs,getOuterBags(\@bags,$temp));
}
$containing=scalar(keys(%temp_hash));
log_message("$containing contain shiny gold bag");

# Part 2
@ibs=getInnerBags(\@bags,"shiny gold bag",1);
$total=0;
while (scalar(@ibs)>0)
{
	$ib=pop(@ibs);
	$ib=~s/^(s|)(,|\.) //;
	if (length($ib)>2)
	{
		# Add these bags to the total, then get the contents and multiply by the number
		$ib=~m/^([0-9]+) (.*)$/;
		$number=$1;
		$bagid=$2 . "bag";
		$total+=$number;
		push(@ibs,getInnerBags(\@bags,$bagid,$number));
	}
}

log_message("Part 2: $total");
=cut

# Day 8
# Load data into an array
$day8input=readFile("../data/adventOfCode2020/day8input");
@insts=split("\n",$day8input);
foreach $j (246..246)
{
	$acc=0;
	@visited=();
	for($i = 0; $i <= $#insts; $i++)
	{
		# Track what lines we have visited
		$linetxt="l" . $i . "l";
		$visitedTxt=join(":",@visited);
		if ($visitedTxt=~m/$linetxt/)
		{
			#log_message("In loop, visiting line $i for second time");
			last;
		}
		push(@visited,$linetxt);
		$insts[$i]=~m/^(...) (.*)$/;
		$op=$1;
		$arg=$2;
		if ($i==$j)
		{
			# Swap nop for jmp or vice-versa
			if ($op eq "jmp")
			{
				$op="nop";
				log_message("Changed operation to nop on line $j");
			}
			elsif ($op eq "nop")
			{
				$op="jmp";
				log_message("Changed operation to jmp on line $j");
			}
		}
		if ($op eq "acc")
		{
			$acc+=$arg;
		}
		if ($op eq "jmp")
		{
			$i+=$arg;
			$i-=1;
		}
		if ($i==634)
		{
			log_message("We reached the end! acc is $acc. Changed line $j");
			last;
		}
	}
	#log_message("Exited at line $i");
}

doSuccess();

# Day 7
sub getOuterBags
{
	my @baglist=@{$_[0]};
	my $bagtocheck=$_[1];
	my @outerbags=();

	foreach my $bag (@baglist)
	{
		$bag=~m/(^.*) contain (.*$)/;
		$outerbag=$1;
		$bagcontains=$2;
		$outerbag=~s/bags/bag/;
		if ($bagcontains=~/$bagtocheck/)
		{
			push(@outerbags,$outerbag);
		}
	}
	return @outerbags;
}

sub getInnerBags
{
	my @baglist=@{$_[0]};
	my $bagtocheck=$_[1];
	my $multiplier=$_[2];
	my @innerbags=();

	foreach my $bag (@baglist)
	{
		$bag=~m/(^.*) contain (.*$)/;
		$outerbag=$1;
		$bagcontains=$2;
		$outerbag=~s/bags/bag/;
		if ($outerbag eq $bagtocheck)
		{
			log_message("$bagtocheck contains $bagcontains");
			$bagcontains=~s/\d+/$&*$multiplier/ge;
			@innerbags=split("bag",$bagcontains);
		}
	}
	return @innerbags;
}
