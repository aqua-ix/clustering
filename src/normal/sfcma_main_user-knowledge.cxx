 #include<iostream>
#include<fstream>
#include<cstdlib>
#include<random>
#include"sfcma.h"
#include"config.h"

#define MAX_ITERATES 500
#define DIFF_FOR_STOP 1.0E-5

const int centers_number=4;

int main(void){
  double max_ARI_Em, max_ARI;
  double
    start=EM_START,
    end=EM_END,
    diff=EM_DIFF;

  std::string filenameData("user-knowledge.dat");
  std::string filenameCorrectCrispMembership("user-knowledge.correctCrispMembership");

  std::string::size_type filenameDataDotPosition=filenameData.find_last_of(".");
  if(filenameDataDotPosition==std::string::npos){
    std::cerr << "File:" << filenameData
              << " needs \".\" and filename-extention." << std::endl;
    exit(1);
  }

  std::string resultFileName =
    std::string("sFCMA-")
    +filenameData.substr(0, filenameDataDotPosition)
    +std::string(".result_ari");
  std::ofstream outputfile(RESULT_DIR+resultFileName);

  for(double Em=start;Em<=end;Em+=diff){
    std::ifstream ifs(DATA_DIR+filenameData);
    if(!ifs){
      std::cerr << "File:" << filenameData
                << " could not open." << std::endl;
      exit(1);
    }
    int data_number, data_dimension;
    ifs >> data_number;
    ifs >> data_dimension;
	
    Sfcma test(data_dimension, data_number, centers_number, Em);

    for(int cnt=0;cnt<data_number;cnt++){
      for(int ell=0;ell<data_dimension;ell++){
        ifs >> test.data(cnt, ell);
      }
    }

    /***Initial Centers Setting***/
    std::random_device rnd;
    std::mt19937 mt(rnd());
    std::uniform_int_distribution<> randDataNumber(0,test.data_number()-1);
    std::ifstream ifs_correctCrispMembership(DATA_DIR+filenameCorrectCrispMembership);
    if(!ifs_correctCrispMembership){
      std::cerr << "File:" << filenameCorrectCrispMembership
                << " could not open." << std::endl;
      exit(1);
    }
    for(int i=0;i<test.centers_number();i++){
      for(int k=0;k<test.data_number();k++){
        ifs_correctCrispMembership >> test.correctCrispMembership(i, k);
      }
    }
    for(int i=0;i<test.centers_number();i++){
      //test.centers(i)=test.data()[randDataNumber(mt)];
      test.clusters_size(i)=1.0/centers_number;
      for(int k=0;k<test.data_number();k++){
        test.membership(i,k)=test.correctCrispMembership(i, k);
      }
    }

    test.iterates()=0;
    while(1){
      test.revise_centers();
#ifdef VERBOSE
      std::cout << "v:\n" << test.centers() << std::endl;
#endif
      test.revise_dissimilarities();
#ifdef VERBOSE
      std::cout << "d:\n" << test.dissimilarities() << std::endl;
#endif
      test.revise_membership();
#ifdef VERBOSE
      std::cout << "u:\n" << test.membership() << std::endl;
#endif
      test.revise_clusters_size();
#ifdef VERBOSE
      std::cout << "a:\n" << test.clusters_size() << std::endl;
#endif
    
      double diff_u=max_norm(test.tmp_membership()-test.membership());
      double diff_v=max_norm(test.tmp_centers()-test.centers());
      double diff_a=max_norm(test.tmp_clusters_size()-test.clusters_size());
      double diff=diff_u+diff_v+diff_a;
#ifdef DIFF
      std::cout << "#diff:" << diff << "\t";
      std::cout << "#diff_u:" << diff_u << "\t";
      std::cout << "#diff_v:" << diff_v << "\t";
      std::cout << "#diff_a:" << diff_a << "\n";
#endif
      if(diff<DIFF_FOR_STOP)break;
      if(test.iterates()>=MAX_ITERATES)break;
      test.iterates()++;
    }
#ifdef VERBOSE
    std::cout << "v:\n" << test.centers() << std::endl;
#endif

#ifdef CHECK_ANSWER
    test.set_crispMembership();
    test.set_contingencyTable();
    //std::cout << "Contingency Table:\n" << test.contingencyTable() << std::endl;
    std::cout << "Em:" << Em  << "\tARI:" << test.ARI() << std::endl;
    outputfile<<Em<<"\t";
    outputfile<<test.ARI()<<"\t";
    outputfile<<"\n";
#endif

    if(max_ARI<test.ARI()){
      max_ARI_Em=Em;
      max_ARI=test.ARI();
    }
  }
  
  outputfile.close();

  std::cout << "max_ARI_Em:" << max_ARI_Em << std::endl;
  std::cout << "max_ARI:" << max_ARI << std::endl;
  
  return 0;
}
