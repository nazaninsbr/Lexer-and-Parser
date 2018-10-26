class PrimeCheck
{
   def main(): int
   {		
	writeln("Enter any number:");
	#capture the input in an integer
	num = scan().nextInt();
    scan().close();
	while(i< num/2)
	{
        temp=num*i;
	   if(temp==0) then
	   {
	      isPrime=false;
	   }
	}
	#If isPrime is true then the number is prime else not
	if(isPrime) then
	   writeln(" is a Prime Number");
	else
	   writeln(num + 3);
   }
}