export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
rm *.class
rm *.tokens
rm our_smoola*.java
java -jar /usr/local/lib/antlr-4.7.1-complete.jar our_smoola.g4
javac our_smoola*.java
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/10.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/2.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/3.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/4.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/5.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/6.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/7.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/8.txt
java org.antlr.v4.gui.TestRig our_smoola program -gui < ./Tests/9.txt