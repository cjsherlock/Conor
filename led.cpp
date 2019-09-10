#include <iostream>
#include <vector>
#include <bitset>
using namespace std;

using byte = int8_t;
using matrixMxN = vector<vector<byte>>;

vector<byte> RC = {
	0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3E, 0x3D, 0x3B, 0x37, 0x2F,
	0x1E, 0x3C, 0x39, 0x33, 0x27, 0x0E, 0x1D, 0x3A, 0x35, 0x2B,
	0x16, 0x2C, 0x18, 0x30, 0x21, 0x02, 0x05, 0x0B, 0x17, 0x2E,
	0x1C, 0x38, 0x31, 0x23, 0x06, 0x0D, 0x1B, 0x36, 0x2D, 0x1A,
	0x34, 0x29, 0x12, 0x24, 0x08, 0x11, 0x22, 0x04
};

int roundNumber = 0;

matrixMxN MC = {
	{4, 1, 2, 2},
	{8, 6, 5, 6},
	{11,14,10, 9},
	{2, 2,15,11},
};

vector<byte> sbox = {12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2};

matrixMxN addRoundKey(matrixMxN currentState, vector<byte> key,int rn){
	for(int i=0; i<4;i++){
		for(int j=0;j<4;j++){
			currentState[i][j] ^= key[(((4*i)+j)+rn*16 )% 16];
		}
	}
	return currentState;
}


matrixMxN addConstants(matrixMxN currentState, int roundNum){
	bitset<8> keySize(string("01000000"));
	bitset<4> kLow,kHigh;
	for (int i=0; i<4;i++){
		kLow[i] = keySize[i];
		kHigh[i] = keySize[i+4];
	}
	byte kLowByte = kLow.to_ulong(),kHighByte = kHigh.to_ulong();

	bitset<6> r = RC.at(roundNum);
	bitset<4> rHigh,rLow;
	for (int i=0;i<3;i++){
		rLow[i] = r[i];
		rHigh[i] = r[i+3];
	}
	byte rLowByte = rLow.to_ulong(),rHighByte = rHigh.to_ulong();
	matrixMxN tmp = {
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
	};
	tmp[0][0] = 0^(kHighByte);
	tmp[1][0] = 1^(kHighByte);
	tmp[2][0] = 2^(kLowByte);
	tmp[3][0] = 3^(kLowByte);

	tmp[0][1] = rHighByte;
	tmp[1][1] = rLowByte;
	tmp[2][1] = rHighByte;
	tmp[3][1] = rLowByte;

	for(int i=0;i<4;i++){
		for (int j=0;j<4;j++){
			currentState[i][j] = currentState[i][j]^tmp[i][j];
		}
	}
	return currentState;
}

matrixMxN subCells(matrixMxN currentState){
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			currentState[i][j] = sbox[currentState[i][j]];
		}
	}
	return currentState;
}

matrixMxN shiftRows(matrixMxN currentState){
	vector<byte> tmp = {0,0,0,0};
	for(int i=1;i<4;i++){
		for(int j=0;j<4;j++)
			tmp[j] = currentState[i][j];
		for(int k=0;k<4;k++){
			currentState[i][k] = tmp[(i+k)%4];
		}
	}
	return currentState;
}

byte fieldMult(byte a, byte b){
	byte c = 0;
	int irr = 0x13, high = 0x10;
	for(int i=3;i>=0;i--){
		if(b&(1<<i)){
			c^=(a<<i);
		}


	}
	for (int i=3; i>=0; i--){
		if(c&(high<<i)){
			c^=(irr<<i);

		}
	}
	return c;
}

matrixMxN mixCols(matrixMxN currentState){
	matrixMxN tmp = {
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
	};

	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			for(int k=0;k<4;k++){
				tmp[j][i] ^= fieldMult(MC[j][k],currentState[k][i]);
			}
		}
	}
	return tmp;
}

matrixMxN LED(matrixMxN currentState, vector<byte> key){
	currentState = addRoundKey(currentState,key,0);
	for(int i=0; i<8; i++){
		for(int j=0;j<4;j++){
			currentState = addConstants(currentState,(i*4)+j);
			currentState = subCells(currentState);
			currentState = shiftRows(currentState);
			currentState = mixCols(currentState);
		}
		currentState = addRoundKey(currentState,key,i+1);
	}
	return currentState;
}

int main(){
	matrixMxN state0 = {
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
		{0, 0, 0, 0},
	};

	matrixMxN state1 = {
		{0, 1, 2, 3},
		{4, 5, 6, 7},
		{8, 9, 10, 11},
		{12, 13, 14, 15},
	};
	matrixMxN state2 = {
		{0xa, 7, 0xf, 1},
		{0xd, 9, 2, 0xa},
		{8, 2, 0xc, 8},
		{0xd, 8, 0xf, 0xe},
	};
	vector<byte> key0 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	vector<byte> key1 = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
	vector<byte> key2 = {4,3,4,0xd,9,8,5,5,8,0xc,0xe,2,0xb,3,4,7};

	state0 = LED(state0,key0);


	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			cout << hex << (int)state0[i][j] << " ";
		}
	cout << endl;
	}
/*
	matrixMxN gf16 = {
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		};

		for(int i=0; i<16;i++){
			for(int j=0;j<16;j++){
				gf16[i][j] = fieldMult((uint8_t)i,(uint8_t)j);
			}
		}
		cout << "\n";
		for(int i=0; i<16;i++){
		cout << "( " ;
			for(int j=0;j<16;j++){
				cout << "x\""<< hex << (int)gf16[i][j]<< "\" ";
			}
			cout << ")" << endl;
		}*/
}
