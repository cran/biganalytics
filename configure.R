pkgLibs=""
# Find the bigmemory directory
bigmemoryDirNames = file.path(.libPaths(), "bigmemory", "include")
# We need to make the path to the bigmemory include files readable
# to mingw.
if (Sys.info()[['sysname']] == "Windows" )
{
  bigmemoryDirNames = gsub('\\\\', "/", path.expand(bigmemoryDirNames))
}
isDir = file.info(bigmemoryDirNames)$isdir
isDir[is.na(isDir)] = FALSE
# use the first one 
isDir = min(which(isDir))
if (length(isDir) == 0)
{
  stop("Could not find bigmemory install directory")
}
print(bigmemoryDirNames)
cppFlags = paste('PKG_CPPFLAGS=-I', bigmemoryDirNames[isDir], '/', sep="")

write( paste(pkgLibs, "\n", cppFlags, sep=''), 'src/Makevars' )

