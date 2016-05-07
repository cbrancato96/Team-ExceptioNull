#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <cstdlib>
#include <fstream>
#include <string.h>

using namespace std;

string progFileName = "test.code";
string binFileName = "instMem.bin";

int main () {
		ifstream assFile;
		ofstream binFile;
		stringstream assSplitter; 
		assFile.open (progFileName.c_str());
		binFile.open(binFileName.c_str()); 
		string assRawCmd, assCmd;

		while(getline(assFile,assRawCmd)){

			assCmd = assRawCmd.substr(0,assRawCmd.find('#'));

			if(!assCmd.find("j"))
				assCmd = assCmd + " 00";

			if(!assRawCmd.compare("") || !assCmd.compare(""))
				continue; 
			else assCmd = assCmd + " ";

			string oper, inOne, inTwo;
			string opCode, binInOne, binInTwo; 
			assSplitter << assCmd; 
			assSplitter >> oper;
			assSplitter >> inOne; 
			assSplitter >> inTwo; 

			if(!oper.compare("addl")){   // add large

				if(!inOne.compare("$r0")){
					binInOne = "00";
				}else if(!inOne.compare("$r1")){
					binInOne = "01";
				}
				else if(!inOne.compare("$r2")){
					binInOne = "10";
				}
				else if(!inOne.compare("$sp")){
					binInOne ="11";
				} 

				int param = atoi(inTwo.c_str());

				if(param < 0){
					param = -param;
					for(int i = 0; i < param; i++)
						binFile << "1110" << binInOne << "11" << endl;
				}
				else{
					for(int i = 0; i < param; i++)
						binFile << "1110" << binInOne << "01" << endl;
				}


			}else if (!oper.compare("lil")){ //load immediate large

				if(!inOne.compare("$r0")){
					binInOne = "00";
				}else if(!inOne.compare("$r1")){
					binInOne = "01";
				}
				else if(!inOne.compare("$r2")){
					binInOne = "10";
				}
				else if(!inOne.compare("$sp")){
					binInOne ="11";
				} 

				int param = atoi(inTwo.c_str());

				binFile << "1111" << binInOne << "00" << endl;

				if(param < 0){
					param = -param;
					for(int i = 0; i < param; i++)
						binFile << "1110" << binInOne << "11" << endl;
				}
				else{
					for(int i = 0; i < param; i++)
						binFile << "1110" << binInOne << "01" << endl;
				}

			}else if(!oper.compare("slll")){ // shift left logical large

				if(!inOne.compare("$r0")){
					binInOne = "00";
				}else if(!inOne.compare("$r1")){
					binInOne = "01";
				}
				else if(!inOne.compare("$r2")){
					binInOne = "10";
				}
				else if(!inOne.compare("$sp")){
					binInOne ="11";
				} 

				int param = atoi(inTwo.c_str());

				if(param < 0)
					param = -param;

				for(int i = 0; i < param; i++)
					binFile << "0110" << binInOne << "01" << endl;


			} else if(!oper.compare("srll")){ //shift right logical large
				
				if(!inOne.compare("$r0")){
					binInOne = "00";
				}else if(!inOne.compare("$r1")){
					binInOne = "01";
				}
				else if(!inOne.compare("$r2")){
					binInOne = "10";
				}
				else if(!inOne.compare("$sp")){
					binInOne ="11";
				} 

				int param = atoi(inTwo.c_str());

				if(param < 0)
					param = -param;

				for(int i = 0; i < param; i++)
					binFile << "0111" << binInOne << "01" << endl;

			} else{

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

				if(!inOne.compare("$r0")){
					binInOne = "00";
				}else if(!inOne.compare("$r1")){
					binInOne = "01";
				}
				else if(!inOne.compare("$r2")){
					binInOne = "10";
				}
				else if(!inOne.compare("$sp")){
					binInOne ="11";
				}

				if(!inTwo.compare("$r0") || !opCode.compare("1000")){
					binInTwo = "00";
				}else if(!inTwo.compare("$r1")){
					binInTwo = "01";
				}
				else if(!inTwo.compare("$r2")){
					binInTwo = "10";
				}
				else if(!inTwo.compare("$sp")){
					binInTwo ="11";
				}else{
					binInTwo = inTwo;
				}

				binFile << opCode << binInOne << binInTwo << "\n";

			}
		}
	assFile.close();
	binFile.close();

	ifstream checkSizeBin(binFileName.c_str());
	string line; 
	int numLines=0;

	while(getline(checkSizeBin, line)){
		numLines++;
	}

	checkSizeBin.close();

	if(numLines > 64){
		cout << "Instruction overflow! Decrease your program size!" << endl;
		cout << "Program exiting!" << endl;
		return 0;
	}
	else{
		int padSize = 64-numLines;

		ofstream zeroPadBin; 

		zeroPadBin.open(binFileName.c_str(), ios::app);

		for(int i = 0; i < padSize; i++)
			zeroPadBin << "00000000" << endl;

		zeroPadBin.close();
		cout << "Compilation complete!" << endl;
		cout << "Exiting program..." << endl; 
		return 0;
	}

}

