CC=dmd

scriptDir=$(shell pwd)
objectDir=bin
srcDir=src

compileFile=compilation.bat

CFLAGS=-g -I"$(srcDir)"
EFLAGS=-g

srcExt=.d
objExt=.o

launcher=test.exe

directories=$(shell find $(srcDir) -type d | sed '1d')

srcFile=$(foreach dir, $(directories), $(wildcard $(dir)/*$(srcExt)))

objects=$(foreach file, $(srcFile:$(srcExt)=$(objExt)), $(objectDir)/$(notdir $(file)))

all: $(launcher)

win_only: compilation
	echo "$(CC) -of"$(launcher)" $(objects) $(EFLAGS)" >> compilation.bat

#all:
#	@echo $(scriptDir)/$(objectDir)

$(launcher): win_only
	chmod +x compilation.bat
	./compilation.bat


compilation:
	@mkdir $(objectDir) -p
	@cp /dev/null $(compileFile)
	@for dir in $(directories); do \
		if [ ! `ls $$dir | grep $(srcExt) | wc -l` -eq 0 ]; then \
			if [ ! -e $$dir/Makefile ]; then \
					cp Makefile_type $$dir/Makefile; \
			fi; \
			make --no-print-directory -C $$dir directory="$$dir" objectDir="$(scriptDir)" objectDirName="$(objectDir)" CC=$(CC) CFLAGS="$(CFLAGS)" srcExt="$(srcExt)" objExt="$(objExt)" compilFile="$(scriptDir)/$(compileFile)"; \
		fi; \
	done

clean_all: clean clean_Makefile
	rm -f $(launcher)

clean:
	rm -rf $(objectDir)
	rm -f compilation.bat

clean_error:
	@for dir in $(directories); do \
		rm -f $$dir/*$(objExt); \
	done

clean_Makefile:
	@for dir in $(directories); do	\
		rm -f $$dir/Makefile;	\
	done
