\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2015/03/20 by Iskander Sitdikov]

\LoadClass[11pt, varwidth=210mm, border=0.618in]{standalone}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1, T2A]{fontenc}
\RequirePackage[default]{droidserif}
\RequirePackage[english, russian]{babel}
\RequirePackage{csquotes}
\RequirePackage{etoolbox}
\RequirePackage{pbox}
\RequirePackage{calc}
\RequirePackage[table]{xcolor}
\RequirePackage{marvosym}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage[backend=biber, sorting=none, autolang=other]{biblatex}
\RequirePackage[hidelinks]{hyperref}

% Multiple language support.
\newcommand{\cvlanguage}[1]{%
    \expandafter\newcommand\csname cv#1\endcsname[1]{}%
}
\cvlanguage{english}
\cvlanguage{russian}
\newcommand{\cvsetlanguage}[1]{%
    \expandafter\renewcommand\csname cv\@cvlanguage\endcsname[1]{}%
    \expandafter\renewcommand\csname cv#1\endcsname[1]{##1}%
    \renewcommand{\@cvlanguage}{#1}%
}
\newcommand{\@cvlanguage}{english}
\cvsetlanguage{english}

% Name setter.
\newcommand{\@cvname}{}
\newcommand{\cvsetname}[1]{\renewcommand{\@cvname}{#1}}

% Major setter.
\newcommand{\@cvmajor}{}
\newcommand{\cvsetmajor}[1]{\renewcommand{\@cvmajor}{#1}}

% Postal address setter.
\newcommand{\@cvaddress}{}
\newcommand{\cvsetaddress}[1]{\renewcommand{\@cvaddress}{#1}}

% Phone number setter.
\newcommand{\@cvphone}{}
\newcommand{\cvsetphone}[1]{\renewcommand{\@cvphone}{#1}}

% E-mail setter.
\newcommand{\@cvemail}{}
\newcommand{\cvsetemail}[1]{\renewcommand{\@cvemail}{#1}}

% Crypto identity setter.
\newcommand{\@cvcryptoid}{}
\newcommand{\cvsetcryptoid}[1]{\renewcommand{\@cvcryptoid}{#1}}

% Homepage URL setter.
\newcommand{\@cvhomepage}{}
\newcommand{\cvsethomepage}[1]{\renewcommand{\@cvhomepage}{#1}}

% Colors.
\pagecolor{white}
\definecolor{cvbase}{HTML}{000000}
\definecolor{cvlow}{HTML}{52636B}
\definecolor{cvhigh}{HTML}{134E4A}

% Color changing command.
% #1 - name of the color (base, low, or high).
\newcommand{\cvcolor}[1]{\leavevmode\color{cv#1}}

% Icons.
\newcommand{\cvaddressicon}{\Mundus}
\newcommand{\cvphoneicon}{\Telefon}
\newcommand{\cvemailicon}{\Letter}
\newcommand{\cvcryptoidicon}{\Deleatur}
\newcommand{\cvhomepageicon}{\MineSign}

% Lengths.
\newcommand{\cvnewlength}[2]{%
    \expandafter\newlength\csname @cv#1\endcsname%
    \expandafter\setlength\csname @cv#1\endcsname{#2}%
}
\cvnewlength{rulethickness}{0.05ex}
\cvnewlength{entrymargin}{11.089em}
\cvnewlength{itemmargin}{6.854em}
\cvnewlength{sectionskip}{1.618em}
\cvnewlength{entryskip}{1em}
\cvnewlength{paragraphskip}{0.618em}
\cvnewlength{itempadding}{0.618em}
\cvnewlength{listpadding}{0.382em}

% General formatting rules.
\pagenumbering{gobble}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

% Skipping command.
% #1 - name of the skip (section, entry, or paragraph).
\newcommand{\cvskip}[1]{%
    \setlength{\parskip}{\csname @cv#1skip\endcsname}%
    \par%
}

% Hyperlink printing command.
\newcommand{\cvurl}[2]{\href{#2}{\cvcolor{high}#1\cvcolor{base}}}

% E-mail printing command.
\newcommand{\cvemail}[1]{\cvurl{#1}{mailto:#1}}

% Crypto identity printing command.
\newcommand{\cvcryptoid}[1]{\cvurl{#1}{https://app.zerion.io/#1}}

% Generic context environment.
% #1 - exact width of the key column.
% #2 - maximum width of the whole context.
\newenvironment{cvcontext}[2]{%
    % Context item.
    % #1 - key.
    % #2 - value.
    \newcommand{\cvitem}[2]{%
        \cvitembreak%
        \stepcounter{cvitemcounter}%
        \cvcolor{low}\parbox[t]{#1}{\raggedleft##1\unskip\strut}&%
        \pbox[t]{\@cvitemwidth}{##2\unskip\strut}\\%
    }%
    \newcommand{\cvitembreak}{%
        \ifnum\thecvitemcounter>0 & \\[\@cvitembreak]\fi%
    }%
    \setlength{\@cvitemwidth}{#2-#1-2\@cvitempadding-\@cvrulethickness}%
    \setlength{\@cvitembreak}{\@cvparagraphskip-\baselineskip}%
    \setcounter{cvitemcounter}{0}%
    \setlength{\tabcolsep}{\@cvitempadding}%
    \setlength{\arrayrulewidth}{\@cvrulethickness}%
    \arrayrulecolor{cvlow}%
    \begin{tabular}[t]{@{}r|l@{}}%
}{\end{tabular}}
\newlength{\@cvitemwidth}
\newlength{\@cvitembreak}
\newcounter{cvitemcounter}

% Name printing command.
\newcommand{\cvname}{\pbox[t]{\textwidth}{\cvnamestyle\@cvname\unskip\strut}}
\newcommand{\cvnamestyle}{\huge\bfseries}
\newsavebox{\@cvnamebox}
\newlength{\@cvnamewidth}

% Major printing command.
\newcommand{\cvmajor}{\pbox[t]{\textwidth}{\cvmajorstyle\@cvmajor\unskip\strut}}
\newcommand{\cvmajorstyle}{\cvcolor{low}}
\newsavebox{\@cvmajorbox}
\newlength{\@cvmajorwidth}

% Introduction (name and major) printing command.
\newcommand{\cvintroduction}{%
    \savebox{\@cvnamebox}{\cvname}%
    \settowidth{\@cvnamewidth}{\usebox{\@cvnamebox}}%
    \savebox{\@cvmajorbox}{\cvmajor}%
    \settowidth{\@cvmajorwidth}{\usebox{\@cvmajorbox}}%
    \setlength{\@cvintroductionwidth}{\maxof{\@cvnamewidth}{\@cvmajorwidth}}%
    \begin{minipage}[t]{\@cvintroductionwidth}%
        \vspace{-1em}%
        \usebox{\@cvnamebox}%
        \ifdefempty{\@cvmajor}{}{\cvskip{paragraph}\usebox{\@cvmajorbox}}%
    \end{minipage}
}
\newlength{\@cvintroductionwidth}

% Contact information printing command.
\newcommand{\cvcontacts}{%
    \settowidth{\@cviconwidth}{\cvemailicon}%
    \setlength{\@cvcontactswidth}{\textwidth-\@cvintroductionwidth}%
    \begin{cvcontext}{\@cviconwidth}{\@cvcontactswidth}%
        \cvitem{\cvaddressicon}{\@cvaddress}%
        \cvitem{\cvphoneicon}{\@cvphone}%
        \cvitem{\cvemailicon}{\cvemail{\@cvemail}}%
        \cvitem{\cvcryptoidicon}{\cvcryptoid{\@cvcryptoid}}%
        \cvitem{\cvhomepageicon}{\cvurl{\@cvhomepage}{https://\@cvhomepage}}%
    \end{cvcontext}%
}
\newlength{\@cviconwidth}
\newlength{\@cvcontactswidth}

% Header (introduction and contacts) printing command.
\newcommand{\cvheader}{\cvintroduction\hfill\cvcontacts}

% Section environment.
% #1 - title.
\newenvironment{cvsection}[1]{%
    % Section entry.
    % #1 - key.
    % #2 - value.
    \newcommand{\cventry}[2]{%
        \cvskip{entry}%
        \begin{minipage}[t]{\@cventrymargin}%
            \cvskip{paragraph}\cvcolor{high}\raggedleft##1%
        \end{minipage}%
        \hspace{\@cventryskip}%
        \begin{minipage}[t]{\@cvsectionwidth}%
            \cvskip{paragraph}\raggedright##2%
        \end{minipage}%
        \ignorespaces%
    }%
    \cvcolor{high}%
    \savebox{\@cvtitlebox}{#1}%
    \settowidth{\@cvtitlewidth}{\usebox{\@cvtitlebox}}%
    \setlength{\@cvsectionwidth}{\textwidth-\@cventrymargin-\@cventryskip}%
    \cvskip{section}%
    {%
        \cvsectionrule{\@cventrymargin}%
        \hspace{\@cventryskip}%
        \usebox{\@cvtitlebox}%
        \hspace{\@cventryskip}%
        \cvsectionrule{\@cvsectionwidth-\@cvtitlewidth-\@cventryskip}%
    }%
    \cvcolor{base}%
}{}
\newcommand{\cvsectionrule}[1]{%
    \rule[0.5ex-0.5\@cvrulethickness]{#1}{\@cvrulethickness}%
}
\newsavebox{\@cvtitlebox}
\newlength{\@cvtitlewidth}
\newlength{\@cvsectionwidth}

% Description environment.
\newenvironment{cvdescription}[0]{%
    \footnotesize%
    \begin{cvcontext}{\@cvitemmargin}{\textwidth}%
}{%
    \end{cvcontext}%
    \normalsize%
}

% List environment.
\newenvironment{cvlist}[0]{%
    % List item.
    % #1 - value.
    \newcommand{\cvitem}[1]{\item{##1\unskip\strut}}%
    \begin{itemize}[\Pointinghand, nosep, before=\vspace{\@cvlistpadding}, after=\vspace{\@cvlistpadding}, leftmargin=*, labelindent=\@cvlistpadding, labelsep=\@cvparagraphskip]%
        \setlength{\itemsep}{\@cvparagraphskip}%
}{\end{itemize}}

% Bibliography printing command.
\addbibresource{publications.bib}
\nocite{*}
\newcommand{\cvbibliography}{%
    \cvskip{entry}%
    \begin{minipage}[t]{\textwidth}%
        \setlength{\@cvbibliographygap}{\topsep}%
        \vspace{-\@cvbibliographygap}%
        \setlength{\biblabelsep}{\@cventryskip}%
        \setlength{\bibhang}{0pt}%
        \setlength{\bibitemsep}{\@cventryskip}%
        \printbibliography[heading=none]%
    \end{minipage}%
}
\newlength{\@cvbibliographygap}

% Footnote definition command.
% #1 - slug (unique for each footnote).
% #2 - text.
\newcommand{\cvnewfootnote}[2]{%
    \ifcsname @cvfootnote@#1\endcsname%
    \else%
        \stepcounter{cvfootnotecounter}%
        \begingroup\edef\cvfootnotedefinition{%
            \noexpand\g@addto@macro\noexpand\@cvfootnotelist{%
                \noexpand\cvfootnote@{\thecvfootnotecounter}{\ignorespaces#2}%
            }%
            \noexpand\newcommand{\csname @cvfootnote@#1\endcsname}{%
                \thecvfootnotecounter%
            }%
        }\expandafter\endgroup\cvfootnotedefinition%
    \fi%
}
\newcounter{cvfootnotecounter}
\newcommand{\@cvfootnotelist}{}

% Footnote reference command.
% #1 - slug.
\newcommand{\cvfootnote}[1]{%
    \textsuperscript{\csname @cvfootnote@#1\endcsname}%
}

% Internal footnote printing command.
\newcommand{\cvfootnote@}[2]{%
    \cvskip{paragraph}%
    \textsuperscript{#1}~#2%
}

% Footnote list printing command.
\newcommand{\cvfootnotes}{%
    \ifstrempty{\@cvfootnotelist}{}{%
        \unskip\cvskip{section}%
        \footnotesize%
        \cvcolor{low}%
        \@cvfootnotelist%
        \normalsize%
        \cvcolor{base}%
    }%
}

% Command that prints the number of years passed since the given year.
% #1 - year to count from.
\newcommand{\cvyearssince}[1]{%
    {\advance\year by -#1 \the\year\advance\year by #1}%
}

% Reference printing command.
% #1 - name.
% #2 - e-mail.
% #3 - position.
\newcommand{\cvreference}[3]{%
    \cventry{\Writinghand}{%
        \textbf{\ignorespaces#1}\hfill\cvemail{#2}%
        \par#3%
    }%
}
