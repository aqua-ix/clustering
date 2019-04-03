#include"hcm.h"
#include <boost/math/special_functions/binomial.hpp>

Hcm::Hcm(int dimension,
	 int data_number,
	 int centers_number):
  Data(data_number, dimension),
  Centers(centers_number, dimension),
  Tmp_Centers(centers_number, dimension),
  Membership(centers_number, data_number),
  Tmp_Membership(centers_number, data_number),
  Clusters_Size(centers_number),
  Tmp_Clusters_Size(centers_number),
  Dissimilarities(centers_number, data_number),
  CrispMembership(centers_number, data_number),
  CorrectCrispMembership(centers_number, data_number),
  ContingencyTable(centers_number+1, centers_number+1),
  Iterates(0){
  /***↓収束判定のためにDBL_MAXに設定***/
  for(int i=0;i<centers_number;i++){
    Centers[i]=Vector(dimension);
    for(int ell=0;ell<dimension;ell++){
      Centers[i][ell]=DBL_MAX;
    }
  }
  /***↓収束判定のためにDBL_MAXに設定***/
  for(int i=0;i<centers_number;i++){
    for(int k=0;k<data_number;k++){
      Membership[i][k]=DBL_MAX;
    }
  }
}

void Hcm::revise_dissimilarities(void){
  for(int i=0;i<centers_number();i++){
    for(int k=0;k<data_number();k++){
      Dissimilarities[i][k]=norm_square(Data[k]-Centers[i]);
    }}
  return;
}

void Hcm::revise_membership(void){
  Tmp_Membership=Membership;
  for(int k=0;k<data_number();k++){
    int min_index=0; double min_dissimilarity=Dissimilarities[0][k];
    for(int i=1;i<centers_number();i++){
      if(min_dissimilarity>Dissimilarities[i][k]){
	min_index=i;
	min_dissimilarity=Dissimilarities[i][k];
      }
    }
    for(int i=0;i<centers_number();i++){
      Membership[i][k]=0.0;
    }
    Membership[min_index][k]=1.0;
  }
  return;
}

void Hcm::revise_centers(void){
  Tmp_Centers=Centers;
  for(int i=0;i<centers_number();i++){
    double denominator=0.0;
    Vector numerator(Centers[i].size());
    for(int ell=0;ell<numerator.size();ell++){
      numerator[ell]=0.0;
    }
    for(int k=0;k<data_number();k++){
      denominator+=Membership[i][k];
      numerator+=Membership[i][k]*Data[k];
    }
    Centers[i]=numerator/denominator;
  }
  return;
}

int Hcm::dimension(void) const{
  return Data[0].size();
}

int Hcm::data_number(void) const{
  return Data.rows();
}

int Hcm::centers_number(void) const{
  return Centers.rows();
}

Matrix Hcm::centers(void) const{
  return Centers;
}

Matrix Hcm::tmp_centers(void) const{
  return Tmp_Centers;
}

Matrix Hcm::data(void) const{
  return Data;
}

Matrix Hcm::membership(void) const{
  return Membership;
}

Matrix Hcm::tmp_membership(void) const{
  return Tmp_Membership;
}

int &Hcm::iterates(void){
  return Iterates;
}

Matrix Hcm::dissimilarities(void) const{
  return Dissimilarities;
}

double &Hcm::data(int index1, int index2){
  return Data[index1][index2];
}

double &Hcm::centers(int index1, int index2){
  return Centers[index1][index2];
}

double &Hcm::membership(int row, int col){
  return Membership[row][col];
}

double Hcm::objective(void) const{
  return Objective;
}

void Hcm::set_objective(void){
  Objective=0.0;
  for(int i=0;i<centers_number();i++){
    for(int k=0;k<data_number();k++){
      Objective+=Membership[i][k]*Dissimilarities[i][k];
    }}
  return;
}

double &Hcm::dissimilarities(int index1, int index2){
  return Dissimilarities[index1][index2];
}

void Hcm::set_crispMembership(void){
  for(int k=0;k<data_number();k++){
    for(int i=0;i<centers_number();i++){
      CrispMembership[i][k]=0.0;
    }
    double max=-DBL_MAX;
    int max_index=-1;
    for(int i=0;i<centers_number();i++){
      if(Membership[i][k]>max){
        max=Membership[i][k];
        max_index=i;
      }
    }
    CrispMembership[max_index][k]=1.0;
  }
  return;
}

Matrix Hcm::crispMembership(void) const{
  return CrispMembership;
}

double &Hcm::crispMembership(int index1, int index2){
  return CrispMembership[index1][index2];
}

Matrix Hcm::correctCrispMembership(void) const{
  return CorrectCrispMembership;
}

double &Hcm::correctCrispMembership(int index1, int index2){
  return CorrectCrispMembership[index1][index2];
}

void Hcm::set_contingencyTable(void){
  ContingencyTable.set_sub(0,centers_number()-1, 0, centers_number()-1,CrispMembership*transpose(CorrectCrispMembership));

  for(int i=0;i<ContingencyTable.rows()-1;i++){
    ContingencyTable[i][ContingencyTable.cols()-1]=0.0;
    for(int j=0;j<ContingencyTable.cols()-1;j++){
      ContingencyTable[i][ContingencyTable.cols()-1]+=ContingencyTable[i][j];
    }
  }
  for(int j=0;j<ContingencyTable.cols()-1;j++){
    ContingencyTable[ContingencyTable.rows()-1][j]=0.0;
    for(int i=0;i<ContingencyTable.rows()-1;i++){
      ContingencyTable[ContingencyTable.rows()-1][j]+=ContingencyTable[i][j];
    }
  }
  ContingencyTable[ContingencyTable.rows()-1][ContingencyTable.cols()-1]=data_number();
  return;
}

Matrix Hcm::contingencyTable(void) const{
  return ContingencyTable;
}

double combination(int n, int k){
  if(n<k) return 0.0;
 return boost::math::binomial_coefficient<double>(n, k); 
}

double Hcm::ARI(void) const{
  double Index=0.0;
  for(int i=0;i<ContingencyTable.rows()-1;i++){
    for(int j=0;j<ContingencyTable.cols()-1;j++){
      Index+=ContingencyTable[i][j]*ContingencyTable[i][j];
    }
  }
  Index=0.5*(Index-ContingencyTable[ContingencyTable.rows()-1][ContingencyTable.cols()-1]);
  //  std::cout << "Index:" << Index << std::endl;
  double ExpectedIndexI=0.0;
  for(int i=0;i<ContingencyTable.rows()-1;i++){
    ExpectedIndexI+=combination(ContingencyTable[i][ContingencyTable.cols()-1], 2);
  }
  //  std::cout << "ExpectedIndexI:" << ExpectedIndexI << std::endl;
  double ExpectedIndexJ=0.0;
  for(int j=0;j<ContingencyTable.cols()-1;j++){
    ExpectedIndexJ+=combination(ContingencyTable[ContingencyTable.rows()-1][j], 2);
  }
  //  std::cout << "ExpectedIndexJ:" << ExpectedIndexJ << std::endl;
  double ExpectedIndex=ExpectedIndexI*ExpectedIndexJ/combination(ContingencyTable[ContingencyTable.rows()-1][ContingencyTable.cols()-1], 2);
  //  std::cout << "Denom:" << combination(ContingencyTable[ContingencyTable.rows()-1][ContingencyTable.cols()-1], 2) << std::endl;
  double MaxIndex=0.5*(ExpectedIndexI+ExpectedIndexJ);

  return (Index-ExpectedIndex)/(MaxIndex-ExpectedIndex);
}

Vector &Hcm::data(int index1){
  return Data[index1];
}

Vector &Hcm::centers(int index1){
  return Centers[index1];
}

Vector Hcm::clusters_size(void) const{
  return Clusters_Size;
}

double &Hcm::clusters_size(int index1){
  return Clusters_Size[index1];
}

Vector Hcm::tmp_clusters_size(void) const{
  return Tmp_Clusters_Size;
}
