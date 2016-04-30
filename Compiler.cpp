	#include <iostream>
#include <fstream>
using namespace std;

int main () {
	ofstream assFile, binFile;
	stringstream assSplitter; 
	assFile.open ("Program.txt");
	binFile.open("CompiledBinary.txt"); 
  	string assRawCmd, asCmd;

	while ( getline (assFile,assRawCmd) ){

		assCmd = assRawCmd.substr(0,assRawCmd.fild('#'));
		string oper, inOne, inTwo;
		string opCode, binInOne, binInTwo; 
		assSplitter << assCmd; 
		assSplitter >> oper;
		assSplitter >> inOne; 
		assSplitter >> inTwo; 

		if(!oper.compare("mv")){
			opCode = "0000"; 
		}else if(!oper.compare("add")){
			opCode = "0001";
		} else if(!oper.compare("and")){
			opCode = "0010";
		} else if(!oper.compare("not")){
			opCode = "0011";
		}else if(!oper.compare("nor")){
			opCode = "0100"; 
		}else if(!oper.compare("slt")){
			opCode = "0101";
		}else if(!oper.compare("sll")){
			opCode = "0110";
		}else if(!oper.compare("srl")){
			opCode = "0111"; 
		}else if(!oper.compare("j")){
			opCode = "1000";
		}else if(!oper.compare("jal")){
			opCode = "1001";
		}else if(!oper.compare("lw")){
			opCode = "1010";
		}else if(!oper.compare("sw")){
			opCode = "1011"; 
		}else if(!oper.compare("beq")){
			opCode = "1100";
		}else if(!oper.compare("bne")){
			opCode = "1101"; 
		}else if(!oper.compare("addi")){
			opCode = "1110"; 
		}else if(!oper.compare("li")){
			opCode = "1111";
		}

		if(!inOne.compare("$t0")){
			binInOne = "00";
		}else if(!inOne.compare("$t1")){
			binInOne = "01";
		}
		else if(!inOne.compare("$t2")){
			binInOne = "10";
		}
		else if(!inOne.compare("$t3")){
			binInOne ="11";
		}

		if(!inTwo.compare("$t0")){
			binInTwo = "00";
		}else if(!inTwo.compare("$t1")){
			binInTwo = "01";
		}
		else if(!inTwo.compare("$t2")){
			binInTwo = "10";
		}
		else if(!inTwo.compare("$t3")){
			binInTwo ="11";
		}

		binFile << opCode << binInOne << binInTwo << "\n";

	}
	
	assFile.close();
	binFile.close();
  return 0;
}

