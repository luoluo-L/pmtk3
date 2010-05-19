function generateHelpTable(directory, outputFile)
%% Create an html table of files and one line descriptions for a directory.
%
if nargin < 2, outputFile = ''; end
files        = filelist(directory, '*.m', true);
files        = setdiff(files, listPackageFiles(directory)); 
files        = files(sortidx(lower(files))); 
if isempty(files), return; end
descriptions = colvec(cellfuncell(@helpline, files)); 
fnames       = colvec(cellfuncell(@(c)c(length(directory)+2:end-2), files)); 
flinks       = cellfuncell(@(c)c(length(pmtk3Root())+2:end), files); 
ftext        = cellfun(@googleCodeLink, flinks, fnames, 'uniformoutput', false);

pmtkRed  = '#990000';
header = [...
    sprintf('<font align="left" style="color:%s"><h2>PMTK Listing: %s</h2></font>\n', ...
    pmtkRed, directory(length(pmtk3Root())+1:end)),...
    sprintf('<br>Revision Date: %s<br>\n', date()),...
    sprintf('<br>Auto-generated by %s<br>\n', mfilename),...
    sprintf('<br>\n')...
    ];
htmlTable('data', [ftext, descriptions], ...
    'colNames'          , {'FILE', 'DESCRIPTION'}, ...
    'header'            , header, ...
    'colNameColors'     , {pmtkRed, pmtkRed},...
    'dataAlign'         , 'left' , ...
    'doshow'            , nargin < 2, ...
    'dosave'            , nargin > 1, ...
    'filename'          , outputFile);
end