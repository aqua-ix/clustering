# https://github.com/ntyaan/some-datasets
# $ make (vectorクラス等の中間ファイル作成、-Bで強制コンパイル) 
# $ make ターゲット(.out)で実行ファイルコンパイル
# ---推薦システム---
# 実データ一覧 
# 名前		:マクロ名	
# BookCrossing	:BOOK		:1091ユーザ2248アイテム
# MovieLens1M	:MOVIE		:905ユーザ684アイテム
# Jester	:JESTER		:2916ユーザ140アイテム
# Libimseti	:LIBIMSETI	:866ユーザ1156アイテム
# Epinions	:EPINIONS	:1022ユーザ835アイテム
# Sushi		:SUSHI		:5000ユーザ100アイテム
# 実データの場合:
# $ make ターゲット data=マクロ名
# 例(klfcsをBookCrossingに適用する場合):w
# $ make rklfcs.out data=BOOK
# クラスの呼び出し等デバグしたいとき
# $ make ターゲット data=マクロ名 class=1
# 人工データの場合:
# $ make ターゲット
CXX = g++
CXXFLAGS = -O3 -Wall -Wextra -std=c++17 -I src/header
FS = -lstdc++fs
objects = .o/vector.o .o/svector.o .o/matrix.o .o/smatrix.o
bfcs = $(objects) .o/hcm.o .o/hcma.o .o/hcs.o .o/bfcm.o .o/bfcs.o
efcs = $(objects) .o/hcm.o .o/hcma.o .o/hcs.o .o/efcm.o .o/efcs.o
qfcs = $(objects) .o/hcm.o .o/hcma.o .o/hcs.o \
.o/efcm.o .o/bfcm.o .o/qfcm.o .o/qfcs.o
bpcs = $(bfcs) .o/pcm.o .o/bpcs.o
epcs = $(efcs) .o/pcm.o .o/epcs.o
qpcs = $(qfcs) .o/pcm.o .o/qpcs.o

method_all = $(all) \
$(bfcs) $(efcs) $(qfcs) \
$(klfccm) $(bfccm) $(qfccm) \
$(klfccmm) $(bfccmm) $(qfccmm) \
$(bpcs) $(epcs) $(qpcs) $(erfcm) $(brfcm) $(qrfcm) \
artificiality_grouplens.out \
artificiality_efcs.out \
artificiality_bfcs.out \
artificiality_qfcs.out \
artificiality_klfccm.out \
artificiality_bfccm.out \
artificiality_qfccm.out \
artificiality_klfccmm.out \
artificiality_qfccmm.out \
artificiality_bpcs.out \
artificiality_epcs.out \
artificiality_qpcs.out \
grouplens.out \
bfcs.out \
efcs.out \
qfcs.out \
klfccm.out \
bfccm.out \
qfccm.out \
klfccmm.out \
bfccmm.out \
qfccmm.out \
bpcs.out \
epcs.out \
qpcs.out \
erfcm.out \
brfcm.out \
qrfcm.out \
clustering_artificiality_efcs.out \
clustering_artificiality_bfcs.out \
clustering_artificiality_qfcs.out \
clustering_artificiality_klfccm.out \
clustering_artificiality_bfccm.out \
clustering_artificiality_qfccm.out \
clustering_artificiality_klfccmm.out \
clustering_artificiality_bfccmm.out \
clustering_artificiality_qfccmm.out \
clustering_artificiality_bpcs.out \
clustering_artificiality_epcs.out \
clustering_artificiality_qpcs.out \
clustering_efcs.out \
clustering_bfcs.out \
clustering_qfcs.out \
clustering_klfccm.out \
clustering_bfccm.out \
clustering_qfccm.out \
clustering_klfccmm.out \
clustering_bfccmm.out \
clustering_qfccmm.out \

ifdef data
	DATASET=-D$(data) 
endif
ifdef class
	MACRO=-DCHECK_CLASS 
endif
ifdef a
	A=-D$(a) 
endif

all : $(objects) 

method_all : $(method_all)

.o/vector.o : src/define/vector.cxx 
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/svector.o : src/define/sparseVector.cxx 
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/matrix.o : src/define/matrix.cxx 
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/smatrix.o : src/define/sparseMatrix.cxx 
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/3dvector.o : src/define/vector3d.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/hcm.o : src/define/hcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/hcma.o : src/define/hcma.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/hcs.o : src/define/hcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/hccm.o : src/define/hccm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/hccmm.o : src/define/hccmm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/pcm.o : src/define/pcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/rfcm.o : src/define/rfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/bfcm.o : src/define/bfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/bfcs.o : src/define/bfcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/efcm.o : src/define/efcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/efcs.o : src/define/efcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qfcm.o : src/define/qfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qfcs.o : src/define/qfcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/klfccm.o : src/define/klfccm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/bfccm.o : src/define/bfccm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qfccm.o : src/define/qfccm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/klfccmm.o : src/define/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/bfccmm.o : src/define/bfccmm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qfccmm.o : src/define/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/bpcs.o : src/define/bpcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/epcs.o : src/define/epcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qpcs.o : src/define/qpcs.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/erfcm.o : src/define/erfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/brfcm.o : src/define/brfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@
.o/qrfcm.o : src/define/qrfcm.cxx
	$(CXX) $(CXXFLAGS) $(MACRO)-c $^ -o $@

#推薦システム人工データ
artificiality_grouplens.out : $(objects) src/define/recom.cxx \
src/main/artificiality/grouplens.cxx
	$(CXX) $(CXXFLAGS)  $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_efcs.out : $(efcs) src/define/recom.cxx \
src/main/artificiality/efcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_bfcs.out : $(bfcs) src/define/recom.cxx \
src/main/artificiality/bfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_qfcs.out : $(qfcs) src/define/recom.cxx \
src/main/artificiality/qfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_klfccm.out : $(klfccm) src/define/recom.cxx \
src/main/artificiality/klfccm.cxx
	$(CXX) $(CXXFLAGS)  $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_bfccm.out : $(bfccm) src/define/recom.cxx \
src/main/artificiality/bfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_qfccm.out : $(qfccm) src/define/recom.cxx \
src/main/artificiality/qfccm.cxx
	$(CXX) $(CXXFLAGS)  $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_klfccmm.out : $(klfccmm) src/define/recom.cxx \
src/main/artificiality/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_bfccmm.out : $(bfccmm) src/define/recom.cxx \
src/main/artificiality/bfccmm.cxx
	$(CXX) $(CXXFLAGS)  $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_qfccmm.out : $(qfccmm) src/define/recom.cxx \
src/main/artificiality/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_bpcs.out : $(bpcs) src/define/recom.cxx \
src/main/artificiality/bpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_epcs.out : $(epcs) src/define/recom.cxx \
src/main/artificiality/epcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_qpcs.out : $(qpcs) src/define/recom.cxx \
src/main/artificiality/qpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_erfcm.out : $(erfcm) src/define/recom.cxx \
src/main/artificiality/erfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_brfcm.out : $(brfcm) src/define/recom.cxx \
src/main/artificiality/brfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@
artificiality_qrfcm.out : $(qrfcm) src/define/recom.cxx \
src/main/artificiality/qrfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	-DARTIFICIALITY $(FS) -o $@

#推薦システム実データ
grouplens.out : $(objects) src/define/recom.cxx src/main/grouplens.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET) $(FS) -o $@
bfcs.out : $(bfcs) src/define/recom.cxx src/main/bfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
efcs.out : $(efcs) src/define/recom.cxx src/main/efcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
qfcs.out : $(qfcs) src/define/recom.cxx src/main/qfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
bfccm.out : $(bfccm) src/define/recom.cxx src/main/bfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
klfccm.out : $(klfccm) src/define/recom.cxx src/main/klfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
qfccm.out : $(qfccm) src/define/recom.cxx src/main/qfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
klfccmm.out : $(klfccmm) src/define/recom.cxx src/main/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
bfccmm.out : $(bfccmm) src/define/recom.cxx src/main/bfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
qfccmm.out : $(qfccmm) src/define/recom.cxx src/main/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
bpcs.out : $(bpcs) src/define/recom.cxx src/main/bpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
epcs.out : $(epcs) src/define/recom.cxx src/main/epcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
qpcs.out : $(qpcs) src/define/recom.cxx src/main/qpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
brfcm.out : $(brfcm) src/define/recom.cxx src/main/brfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
erfcm.out : $(erfcm) src/define/recom.cxx src/main/erfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@
qrfcm.out : $(qrfcm) src/define/recom.cxx src/main/qrfcm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(DATASET)$(MACRO)$(FS) -o $@


#クラスタリング人工データ
clustering_artificiality_bfcs.out : $(bfcs) \
main_clustering/artificiality/bfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(FS) -o $@
clustering_artificiality_efcs.out : $(efcs) \
main_clustering/artificiality/efcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(FS) -o $@
clustering_artificiality_qfcs.out : $(qfcs) \
main_clustering/artificiality/qfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(FS) -o $@
clustering_artificiality_klfccm.out : $(klfccm) \
main_clustering/artificiality/klfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_bfccm.out : $(bfccm) \
main_clustering/artificiality/bfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_qfccm.out : $(qfccm) \
main_clustering/artificiality/qfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_klfccmm.out : $(klfccmm) \
main_clustering/artificiality/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_bfccmm.out : $(bfccmm) \
main_clustering/artificiality/bfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_qfccmm.out : $(qfccmm) \
main_clustering/artificiality/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_bpcs.out : $(bpcs) \
main_clustering/artificiality/bpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_epcs.out : $(epcs) \
main_clustering/artificiality/epcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_artificiality_qpcs.out : $(qpcs) \
main_clustering/artificiality/qpcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@

#クラスタリング実データ
clustering_bfcs.out : $(bfcs) main_clustering/bfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_efcs.out : $(efcs) main_clustering/efcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_qfcs.out : $(qfcs) main_clustering/qfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_klfccm.out : $(klfccm) main_clustering/klfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_bfccm.out : $(bfccm) main_clustering/bfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_qfccm.out : $(qfccm) main_clustering/qfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_klfccmm.out : $(klfccmm) main_clustering/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_bfccmm.out : $(bfccmm) main_clustering/bfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
clustering_qfccmm.out : $(qfccmm) main_clustering/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@

#クラスタリング実データ
init_centers_clustering_bfcs.out : $(bfcs) \
main_clustering/initialize_centers/bfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_efcs.out : $(efcs) \
main_clustering/initialize_centers/efcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_qfcs.out : $(qfcs) \
main_clustering/initialize_centers/qfcs.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_klfccm.out : $(klfccm) \
main_clustering/initialize_centers/klfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_bfccm.out : $(bfccm) \
main_clustering/initialize_centers/bfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_qfccm.out : $(qfccm) \
main_clustering/initialize_centers/qfccm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_klfccmm.out : $(klfccmm) \
main_clustering/initialize_centers/klfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_bfccmm.out : $(bfccmm) \
main_clustering/initialize_centers/bfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@
init_centers_clustering_qfccmm.out : $(qfccmm) \
main_clustering/initialize_centers/qfccmm.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(MACRO)$(FS) -o $@

100times.out : $(qfccmm) $(qfccm) $(qfcs) $(bfccmm) \
$(bfccm) $(bfcs) $(klfccmm) $(klfccm) $(efcs) \
main_clustering/initialize_centers/100times.cxx
	$(CXX) $(CXXFLAGS) $^ \
	$(A)$(MACRO)$(FS) -o $@

clean :
	rm -f *.out
clean.o :
	rm -f .o/*.o
