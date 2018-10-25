export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
rm *.class
rm *.tokens
rm our_smoola*.java
java -jar /usr/local/lib/antlr-4.7.1-complete.jar our_smoola.g4
javac our_smoola*.java
echo 1
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/1.txt
echo 2
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/2.txt
echo 3
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/3.txt
echo 4
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/4.txt
echo 5
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/5.txt
echo 6
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/6.txt
echo 7
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/7.txt
echo 8
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/8.txt
echo 9
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/9.txt
echo 10
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/10.txt
echo 11
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/11.txt
echo 12
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/12.txt
echo 13
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/13.sml
echo 14
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/14.sml