#include <iostream>
#include <fstream>
#include <sstream>

using namespace std;

int one_count(long long int num);

int main(int argc, char **argv)
{
    ifstream ifs("C-large.in");
    string str;

    int c = 1;
    getline(ifs, str); // Tの値
    while( ifs && getline(ifs, str) ) {
        stringstream ss;        
        ss << str;
        long long int i;
        ss >> i;

        // one count
        int max = 0;
        for(int k=0; k<=(i/2); k++) {
            int fa = one_count(k);
            int fb = one_count(i-k);

            int cand = fa + fb;
            if( max < cand ) { max = cand; }
        }

        cout << "Case #" << c << ": " << max << endl;
        c++;
    }

    return 0;
}

int one_count(long long int num) {
    int one_num = 0;

    long long int q = num;
    int r = 0;

    while(1) {
        long long int q_tmp = q / 2;
        r = q % 2;

        if( r == 1 ) { one_num++; }
        if( q_tmp == 0 ) { break; }

        q = q_tmp;
    }

    return one_num;
}
