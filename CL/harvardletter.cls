%
% harvardletter.cls -- a document class for writing letters with
% Harvard Unibresity letterhead 
%
% Copyright 2019, Ahmad Zareei (ahmad@berkeley.edu)
%
% Notes:
%
% 1. This class can be used for creating letters with Harvard SEAS logo at the
%    header and name and address at the footer as standard letter 
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 
% Please contact ahmad@berkeley.edu to report any problems or bugs.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{brownletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\DeclareGraphicsExtensions{.eps}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} 

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}



\usepackage{array}
\newcolumntype{?}{!{\vrule width 1.5pt}}
\usepackage{hhline}
% \usepackage{hyperref}


\newboolean{logofound}
\IfFileExists{SEAS.eps}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}
\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}


\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}?@{\extracolsep{0.1in}}l@{}?@{\extracolsep{0.1in}}l@{}}
    \parbox{.8in}{\raggedright
        \ifthenelse{\boolean{logofound}}
           {\epsfig{file=SEAS.eps, height=0.80in}}
           {\parbox[t][1.0in][t]{2.0in}{\hfill} 
          }
    } &
        \parbox[.10in]{2.9in}{\textbf{\textsc{\large{HARVARD UNIVERSITY}}}\\
                               {John A. Paulson}\\
                               {School of Engineering \& Applied
      Sciences}}
      &
        \parbox[.10in]{2.9in}{\textsc{\textbf{Ariel Amir}}, \\
                              Pierce 321, Cambridge, MA 02138 \\
                              (617) 495-9837, {arielamir@seas.harvard.edu} \\
                              {amir.seas.harvard.edu}
      } 
    \end{tabular*} 
}



\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
    \textsc{Harvard University}, 
    ~Pierce 321, 
    ~Cambridge, MA 02138 
    ~arielamir@seas.harvard.edu
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        {\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            \@date 
            \end{tabular}\par
        }%
     \fi
     \vspace{1\parskip}%
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    % \hspace*{0.6\textwidth}
    \parbox{1.4\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}
