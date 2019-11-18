#include <vector>
#include <algorithm>
#include <istream>
#include <fstream>
#include <sstream>

#include "params.h"

void importNDDataset(std::vector< std::vector<DTYPE> > * dataPoints, char * fname)
{
    std::vector<DTYPE> tmpAllData;
    std::ifstream in(fname);
    int cnttmp = 0;
    for (std::string f; getline(in, f, ','); )
    {
        DTYPE i;
        std::stringstream ss(f);
        while (ss >> i)
        {
            tmpAllData.push_back(i);
            if (ss.peek() == ',')
                ss.ignore();
        }
    }

    unsigned int cnt = 0;
    const unsigned int totalPoints = (unsigned int)tmpAllData.size() / GPUNUMDIM;
    printf("Data import: Total size of all data (1-D) vect (number of points * GPUNUMDIM): %zu\n", tmpAllData.size());
    printf("Data import: Total data points: %d\n", totalPoints);

    for (int i = 0; i < totalPoints; i++){
        std::vector<DTYPE> tmpPoint;
        for (int j = 0; j < GPUNUMDIM; j++){
            tmpPoint.push_back(tmpAllData[cnt]);
            cnt++;
        }
        dataPoints->push_back(tmpPoint);
    }
}


bool sortNDComp(const std::vector<DTYPE>& a, const std::vector<DTYPE>& b)
{
    for (int i=0; i<GPUNUMDIM; i++){
        if (int(a[i])<int(b[i])){
            return true;
        }
        else if(int(a[i])>int(b[i])){
            return false;
        }
    }

    return false;
}


void sortInNDBins(std::vector<std::vector <DTYPE> > *dataPoints)
{
    std::sort(dataPoints->begin(), dataPoints->end(), sortNDComp);
}