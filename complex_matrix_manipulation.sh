#!/bin/sh
clear
declare -A matrix
declare -A matrix1
declare -A matrix2
declare -A matrix1i
declare -A matrix2i
declare -A matrix3
declare -A matrix3i
num_rows_matrix1=$(expr 0)
num_columns_matrix1=$(expr 0)
num_rows_matrix2=$(expr 0)
num_columns_matrix2=$(expr 0)
num_rows_matrix3=$(expr 0)
num_columns_matrix3=$(expr 0)
file1=
file2=

read2files(){
    echo "please enter the name of the first file"
    read file1 
    while [ ! -e "$file1" ]
    do
	echo "No such file"
	echo "Please Enter Another file name"
	read file1
    done
    echo "please enter the name of the second file"    
    read file2
    while [ ! -e "$file2" ]
    do
	echo "No such file"
	echo "Please Enter Another file name"
	read file2
    done
    state=$(expr 0)
    num_rows_matrix1=$(head -1 $file1 | cut -d, -f1)
    num_columns_matrix1=$(head -1 $file1 | cut -d, -f2)
    sed '1d' $file1 > ${file1}_$$_$$
    num_rows_matrix2=$(head -1 $file2 | cut -d, -f1)
    num_columns_matrix2=$(head -1 $file2 | cut -d, -f2)
    sed '1d' $file2 > ${file2}_$$_$$
    i=$(expr 0)
    j=$(expr 0)
    for word in $(< ${file1}_$$_$$)
    do
	state=$(expr 0)
	w2=${word}
	x=${#w2}		
	lj=$(echo "$w2" | tr -cd '^j')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 3)
	fi
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 1)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 6)
	fi
	lj=$(echo "$w2" | tr -cd '^-')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 2)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 7)
	fi	
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    lj=$(echo "$w2" | tr -cd '^-')
	    ljnum=${#lj}
	    if [ "$ljnum" -eq 1 ]
	    then 
	    	state=$(expr 8)
	    fi
	    
	fi
	case "$state"
	    in 
	    [0-2])
		matrix1[$i,$j]=$(expr $w2)
		matrix1i[$i,$j]=$(expr 0)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    3)
		lj=$(echo "$w2" | tr -d 'j')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		matrix1[$i,$j]=$(expr 0)
		matrix1i[$i,$j]=$(expr $w2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    4)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    5)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    6)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		f3=$(echo "$w2" | cut -d'+' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;    
	    7)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		f3=$(echo "$w2" | cut -d'-' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		else
		    f2=$(expr 0 - $f2)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    8)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(echo "$w2" | cut -d'-' -f1)
		    f2=$(echo "$w2" | cut -d'-' -f2)
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '-')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr -1)
		    else 
			w2=$(expr 0 - $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix1i[$i,$j]=$(expr $w2)
		    matrix1[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix1 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		else
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '+')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr 1)
		    else 
			w2=$(expr $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix1i[$i,$j]=$(expr $w2)
		    matrix1[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix1 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		fi ;;
	esac
    done	
    i=$(expr 0)
    j=$(expr 0)
    for word in $(< ${file2}_$$_$$)
    do
	state=$(expr 0)
	w2=${word}
	x=${#w2}		
	lj=$(echo "$w2" | tr -cd '^j')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 3)
	fi
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 1)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 6)
	fi
	lj=$(echo "$w2" | tr -cd '^-')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 2)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 7)
	fi
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    lj=$(echo "$w2" | tr -cd '^-')
	    ljnum=${#lj}
	    if [ "$ljnum" -eq 1 ]
	    then 
	    	state=$(expr 8)
	    fi  
	fi
	case "$state"
	    in 
	    [0-2])
		matrix2[$i,$j]=$(expr $w2)
		matrix2i[$i,$j]=$(expr 0)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    3)
		lj=$(echo "$w2" | tr -d 'j')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		matrix2[$i,$j]=$(expr 0)
		matrix2i[$i,$j]=$(expr $w2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    4)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix2i[$i,$j]=$(expr $w2)
		matrix2[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    5)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix2i[$i,$j]=$(expr $w2)
		matrix2[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    6)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		f3=$(echo "$w2" | cut -d'+' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		fi
		matrix2i[$i,$j]=$(expr $w2)
		matrix2[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;    
	    7)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		f3=$(echo "$w2" | cut -d'-' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		else
		    f2=$(expr 0 - $f2)
		fi
		matrix2i[$i,$j]=$(expr $w2)
		matrix2[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix2 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    8)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(echo "$w2" | cut -d'-' -f1)
		    f2=$(echo "$w2" | cut -d'-' -f2)
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '-')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr -1)
		    else 
			w2=$(expr 0 - $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix2i[$i,$j]=$(expr $w2)
		    matrix2[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix2 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		else
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '+')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr 1)
		    else 
			w2=$(expr $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix2i[$i,$j]=$(expr $w2)
		    matrix2[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix2 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		fi ;;
	esac
    done
    rm ${file1}_$$_$$	
    rm ${file2}_$$_$$
}

read1file(){
    echo "please enter the name of the file"
    read file1 
    while [ ! -e "$file1" ]
    do
	echo "No such file"
	echo "Please Enter Another file name"
	read file1
    done
    state=$(expr 0)
    num_rows_matrix1=$(head -1 $file1 | cut -d, -f1)
    num_columns_matrix1=$(head -1 $file1 | cut -d, -f2)
    sed '1d' $file1 > ${file1}_$$_$$
    i=$(expr 0)
    j=$(expr 0)
    for word in $(< ${file1}_$$_$$)
    do
	state=$(expr 0)
	w2=${word}
	x=${#w2}		
	lj=$(echo "$w2" | tr -cd '^j')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 3)
	fi
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 1)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 6)
	fi
	lj=$(echo "$w2" | tr -cd '^-')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    state=$(expr $state + 2)
	elif [ "$ljnum" -eq 2 ]
	then
	    state=$(expr 7)
	fi
	lj=$(echo "$w2" | tr -cd '^+')
	ljnum=${#lj}
	if [ "$ljnum" -eq 1 ]
	then 
	    lj=$(echo "$w2" | tr -cd '^-')
	    ljnum=${#lj}
	    if [ "$ljnum" -eq 1 ]
	    then 
	    	state=$(expr 8)
	    fi
	fi
	case "$state"
	    in 
	    [0-2])
		matrix1[$i,$j]=$(expr $w2)
		matrix1i[$i,$j]=$(expr 0)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    3)
		lj=$(echo "$w2" | tr -d 'j')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		matrix1[$i,$j]=$(expr 0)
		matrix1i[$i,$j]=$(expr $w2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    4)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    5)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		lj=$(echo "$f2" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f1)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    6)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		f3=$(echo "$w2" | cut -d'+' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '+')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr 1)
		else 
		    w2=$lj
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;  
	    7)
		f1=$(echo "$w2" | cut -d'-' -f1)
		f2=$(echo "$w2" | cut -d'-' -f2)
		f3=$(echo "$w2" | cut -d'-' -f3)
		lj=$(echo "$f3" | tr -d 'j')
		lj=$(echo "$lj" | tr -d '-')
		ljnum=${#lj}
		if [ "$ljnum" -eq 0 ]
		then 
		    w2=$(expr -1)
		else 
		    w2=$(expr 0 - $lj)
		fi
		lf=${#f2}
		if [ "$lf" -eq 0 ]
		then 
		    f2=$(expr 0)
		else
		    f2=$(expr 0 - $f2)
		fi
		matrix1i[$i,$j]=$(expr $w2)
		matrix1[$i,$j]=$(expr $f2)
		j=$(expr $j + 1)
		n=$(expr $num_columns_matrix1 + 0 )
		if [ "$j" -ge "$n" ];
		then
		    i=$(expr $i + 1)
		    j=$(expr 0 )
		fi ;;
	    8)
		f1=$(echo "$w2" | cut -d'+' -f1)
		f2=$(echo "$w2" | cut -d'+' -f2)
		lf=${#f1}
		if [ "$lf" -eq 0 ]
		then 
		    f1=$(echo "$w2" | cut -d'-' -f1)
		    f2=$(echo "$w2" | cut -d'-' -f2)
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '-')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr -1)
		    else 
			w2=$(expr 0 - $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix1i[$i,$j]=$(expr $w2)
		    matrix1[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix1 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		else
		    lj=$(echo "$f2" | tr -d 'j')
		    lj=$(echo "$lj" | tr -d '+')
		    ljnum=${#lj}	
		    if [ "$ljnum" -eq 0 ]
		    then 
			w2=$(expr 1)
		    else 
			w2=$(expr $lj)
		    fi
		    lf=${#f1}
		    if [ "$lf" -eq 0 ]
		    then 
			f1=$(expr 0)
		    else
			f1=$(expr $f1)
		    fi
		    matrix1i[$i,$j]=$(expr $w2)
		    matrix1[$i,$j]=$(expr $f1)
		    j=$(expr $j + 1)
		    n=$(expr $num_columns_matrix1 + 0 )
		    if [ "$j" -ge "$n" ];
		    then
			i=$(expr $i + 1)
			j=$(expr 0 )
		    fi
		fi ;;
	esac
    done	
    rm ${file1}_$$_$$	
}

add2matrices(){
    num_rows_matrix3=$(expr "$num_rows_matrix1" )
    num_columns_matrix3=$(expr "$num_columns_matrix1" )
    if [ ! "$num_rows_matrix1" -eq "$num_rows_matrix2" ]
    then
	echo "miss match in the number of rows of the two matrices"
	exit 5
    fi
    if [ ! "$num_columns_matrix1" -eq "$num_columns_matrix2" ]
    then
	echo "miss match in the number of columns of the two matrices"
	exit 6
    fi    
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do		
	    matrix3[$j,$i]=$(expr ${matrix1[$j,$i]} + ${matrix2[$j,$i]} )
	    matrix3i[$j,$i]=$(expr ${matrix1i[$j,$i]} + ${matrix2i[$j,$i]} )
	done
    done
}

sub2matrices(){
    num_rows_matrix3=$(expr "$num_rows_matrix1" )
    num_columns_matrix3=$(expr "$num_columns_matrix1" )
    if [ ! "$num_rows_matrix1" -eq "$num_rows_matrix2" ]
    then
	echo "miss match in the number of rows of the two matrices"
	exit 7
    fi
    if [ ! "$num_columns_matrix1" -eq "$num_columns_matrix2" ]
    then
	echo "miss match in the number of columns of the two matrices"
	exit 8
    fi
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do		
	    matrix3[$j,$i]=$(expr ${matrix1[$j,$i]} - ${matrix2[$j,$i]} )
	    matrix3i[$j,$i]=$(expr ${matrix1i[$j,$i]} - ${matrix2i[$j,$i]} )
	done
    done    
}

multiplyC(){
    num_rows_matrix3=$(expr "$num_rows_matrix1" )
    num_columns_matrix3=$(expr "$num_columns_matrix1" )
    echo "enter the constant to multiply with"
    read constant
    c=$(echo "$constant" | tr -d '[0-9+]')
    lc=${#c}
    while [  "$lc" -gt 0 ]
    do	
	echo "wrong arrgument"
	echo "Please enter posotive integer"
	read constant
	c=$(echo "$constant" | tr -d '[0-9+]')
	lc=${#c}
    done
    c=$(echo "$constant" | tr -d '+')
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do		
	    matrix3[$j,$i]=$(expr ${matrix1[$j,$i]} \* "$c" )
	    matrix3i[$j,$i]=$(expr ${matrix1i[$j,$i]} \* "$c" )
	done
    done
}

transpose(){
    num_rows_matrix3=$(expr "$num_rows_matrix1" )
    num_columns_matrix3=$(expr "$num_columns_matrix1" )
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do		
	    matrix3[$j,$i]=$(expr ${matrix1[$i,$j]} )
	    matrix3i[$j,$i]=$(expr ${matrix1i[$i,$j]} )
	done
    done    
}

multiply(){
    if [ ! "$num_columns_matrix1" -eq "$num_rows_matrix2" ]
    then
	echo "miss match in the number of rows and columns of the two matrices"
	exit 9
    fi
    num_rows_matrix3=$(expr $num_rows_matrix1 )
    num_columns_matrix3=$(expr $num_columns_matrix2 )
    sumr=$(expr 0)
    sumi=$(expr 0)
    for ((i=0;i<num_rows_matrix1;i++))
    do
	for ((j=0;j<num_columns_matrix2;j++)) 
	do
	    sumr=$(expr 0)
	    sumi=$(expr 0)
	    for((k=0;k<num_columns_matrix1;k++))
	    do		
		sumr1=$(expr ${matrix1[$i,$k]} \* ${matrix2[$k,$j]} )		    
		sumr2=$(expr ${matrix1i[$i,$k]} \* ${matrix2i[$k,$j]} )
		sumr3=$(expr "$sumr1" - "$sumr2" )
		sumr=$(expr "$sumr" + "$sumr3")	
		sumi1=$(expr ${matrix1[$i,$k]} \* ${matrix2i[$k,$j]} )		    
		sumi2=$(expr ${matrix1i[$i,$k]} \* ${matrix2[$k,$j]} )
		sumi3=$(expr "$sumi1" + "$sumi2" )
		sumi=$(expr "$sumi" + "$sumi3")
	    done
	    matrix3[$i,$j]=$(expr "$sumr" )
	    matrix3i[$i,$j]=$(expr "$sumi" )
	done
    done 
}

copyM1toM3(){
    num_rows_matrix3=$(expr "$num_rows_matrix1" )
    num_columns_matrix3=$(expr "$num_columns_matrix1" )
    for ((jw=0;jw<num_rows_matrix1;jw++))
    do
	for ((iw=0;iw<num_columns_matrix1;iw++)) 
	do		
	    matrix3[$jw,$iw]=$(expr ${matrix1[$jw,$iw]} + 0 )
	    matrix3i[$jw,$iw]=$(expr ${matrix1i[$jw,$iw]} + 0 )
	done
    done    
}

copyM3toM2(){
    num_rows_matrix2=$(expr "$num_rows_matrix3" )
    num_columns_matrix2=$(expr "$num_columns_matrix3" )
    for ((jq=0;jq<num_rows_matrix3;jq++))
    do
	for ((iq=0;iq<num_columns_matrix3;iq++)) 
	do		
	    matrix2[$jq,$iq]=$(expr ${matrix3[$jq,$iq]} + 0 )
	    matrix2i[$jq,$iq]=$(expr ${matrix3i[$jq,$iq]} + 0 )
	done
    done    
}

power(){
    if [ ! "$num_columns_matrix1" -eq "$num_rows_matrix1" ]
    then
	echo "miss match in the number of rows and columns of the matrix"
	echo "the matrix should be square matrix"
	exit 9
    fi
    echo "enter the power you want to raise the matrix for"
    echo "ps: should be positive integer"
    read pow
    p=$(echo "$pow" | tr -d '[0-9+]')
    lp=${#p}
    while [  "$lp" -gt 0 ]
    do	
	echo "wrong arrgument"
	echo "Please enter posotive integer"
	read pow
	p=$(echo "$pow" | tr -d '[0-9+]')
	lp=${#p}
    done
    p=$(echo "$pow" | tr -d '+')
    p=$(expr $p)
    copyM1toM3
    z=$(expr 1)    
    while [ "$z" -lt "$p" ]
    do
	copyM3toM2
	multiply
	z=$((z + 1))	
    done   
}

display(){
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do	
	    m=$(echo "${matrix1[$j,$i]}" | tr -cd '-')
	    lm=${#m}	
	    if [ "$lm" -eq 0 ]
	    then
		if [ ! "${matrix1[$j,$i]}" -eq 0 ]
		then 	
		    printf "+"
		    printf "%d" ${matrix1[$j,$i]}
		fi
	    else
		if [ ! "${matrix1[$j,$i]}" -eq 0 ]
		then 		    
		    printf "%d" ${matrix1[$j,$i]}
		fi
	    fi
	    m=$(echo "${matrix1i[$j,$i]}" | tr -cd '-')
	    lm=${#m}
	    if [ "$lm" -eq 0 ]
	    then
		if [ ! "${matrix1i[$j,$i]}" -eq 0 ]
		then
		    printf "+"
		    printf "%dj" ${matrix1i[$j,$i]}
		fi
	    else
		if [ ! "${matrix1i[$j,$i]}" -eq 0 ]
		then
		    printf "%dj" ${matrix1i[$j,$i]}
		fi
	    fi
	    if [ "${matrix1i[$j,$i]}" -eq 0 -a "${matrix1[$j,$i]}" -eq 0 ]
	    then 
		printf "%d" ${matrix1[$j,$i]}
	    fi
	    printf "\t"
	done
	echo
    done    
    echo
    echo
}

save(){
    echo "please enter the name of the file to save the results to"
    read file1 
    while [ -e "$file1" ]
    do
	echo "file already exist"
	echo "Please Enter Another file name"
	read file1
    done
    
    if [ "$num_rows_matrix3" -eq 0 ]
    then	
	echo "no results to save"
	echo
	echo
    elif [ "$num_columns_matrix3" -eq 0 ]
    then
	echo "no results to save"
	echo
	echo
    else
	echo "$num_rows_matrix3,$num_columns_matrix3">>$file1
	for ((j=0;j<num_rows_matrix3;j++))
	do
	    for ((i=0;i<num_columns_matrix3;i++)) 
	    do	
		m=$(echo "${matrix3[$j,$i]}" | tr -cd '-')
		lm=${#m}	
		if [ "$lm" -eq 0 ]
		then
		    if [ ! "${matrix3[$j,$i]}" -eq 0 ]
		    then 	
			echo -ne "+" >> $file1
			echo -ne ${matrix3[$j,$i]} >> $file1
		    fi
		else
		    if [ ! "${matrix3[$j,$i]}" -eq 0 ]
		    then 		    
			echo -ne ${matrix3[$j,$i]} >> $file1
		    fi
		fi
		m=$(echo "${matrix3i[$j,$i]}" | tr -cd '-')
		lm=${#m}
		if [ "$lm" -eq 0 ]
		then
		    if [ ! "${matrix3i[$j,$i]}" -eq 0 ]
		    then
			echo -ne "+" >> $file1
			echo -ne "${matrix3i[$j,$i]}j" >>$file1
		    fi
		else
		    if [ ! "${matrix3i[$j,$i]}" -eq 0 ]
		    then
			echo -ne "${matrix3i[$j,$i]}j" >>$file1
		    fi
		fi
		if [ "${matrix3i[$j,$i]}" -eq 0 -a "${matrix3[$j,$i]}" -eq 0 ]
		then 
		    echo -ne ${matrix3[$j,$i]} >>$file1
		fi
		echo -ne "\t" >>$file1
		#echo -ne " " >>$file1
	    done
	    echo "">>$file1
	done  
    fi
}

main(){
    while [ 1 -eq 1 ]
    do
	echo -e "\t Matrix operations
\t ----------------- 

1. Addition of 2 matrices
2. Subtraction of 2 matrices
3. Multiply a matrix by a constant
4. Multiply two matrices
5. A matrix to the power of a positive integer constant
6. Transpose of a matrix
7. Display a matrix
8. Save matrix
q. Exit"
	echo "-> Your choice:" 
	read number
	case "$number"
	    in
	    1)
		clear
		read2files
		add2matrices
		;;
	    2)
		clear
		read2files
		sub2matrices
		;;
	    3)
		clear
		read1file
		multiplyC
		;;
	    4)
		clear
		read2files
		multiply
		;;
	    5)
		clear
		read1file
		power
		;;
	    6)
		clear
		read1file
		transpose
		;;
	    7)
		clear
		read1file
		display
		;;   
	    8)
		clear
		save
		;;
	    q)
		echo "Have a nice day :)"
		exit 0 
		;;
	    *) clear
		;;
	esac
    done
}

print1(){
    f3="%d\t"
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do		
	    printf "$f3" ${matrix1[$j,$i]}
	done
	echo
    done
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix1;j++))
    do
	for ((i=0;i<num_columns_matrix1;i++)) 
	do
	    printf "$f3" ${matrix1i[$j,$i]}
	done
	echo
    done
}

print2(){
    f3="%d\t"
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix2;j++))
    do
	for ((i=0;i<num_columns_matrix2;i++)) 
	do
	    printf "$f3" ${matrix2[$j,$i]}
	done
	echo
    done
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix2;j++))
    do
	for ((i=0;i<num_columns_matrix2;i++)) 
	do
	    printf "$f3" ${matrix2i[$j,$i]}
	done
	echo
    done
}

print3(){
    f3="%d\t"
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix3;j++))
    do
	for ((i=0;i<num_columns_matrix3;i++)) 
	do
	    printf "$f3" ${matrix3[$j,$i]}
	done
	echo
    done
    printf "____________________\n"
    for ((j=0;j<num_rows_matrix3;j++))
    do
	for ((i=0;i<num_columns_matrix3;i++)) 
	do
	    printf "$f3" ${matrix3i[$j,$i]}
	done
	echo
    done
    printf "____________________\n"
}

main