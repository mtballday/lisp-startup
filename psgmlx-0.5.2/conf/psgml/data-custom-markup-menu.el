;;; data-custom-markup-menu.el - menu data for the "Custom Markup" menu

;; $Id: data-custom-markup-menu.el,v 1.1.1.1 2007/04/20 13:10:56 rich Exp $

;; This file is part of the psgmlx distribution.
;; See the README file for copyright and other information.

;; This file is not part of GNU Emacs.


;;; Commentary:

;; Syntax Summary 
;;  --------------
;;
;;  Entries are two-item lists:
;;
;;  ("Menu Title"  "Stuff to Insert")
;;
;; - escape additional quotes with backslashes \
;;
;; - place a "\r" where you want the cursor to be placed



;;; Code:

;;; Begin Menu section
(setq sgml-custom-markup  
'( 
  ;; BEGIN menu entries 


  ;; EOF snippet for emacs: XML mode

  ("EOF snippet for emacs: XML mode - chapter"	

"
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-parent-document (\"parent-book-filename.xml\" \"book\" \"chapter\")
End:
-->
"
)

  ;; EOF snippet for emacs: SGML mode

  ("EOF snippet for emacs: SGML mode - chapter"	

"
<!-- Keep this comment at the end of the file
Local variables:
mode: sgml
sgml-parent-document (\"parent-book-filename.sgml\" \"book\" \"chapter\")
End:
-->
"
)


  ;; CDATA Section 
	     ; NOTE: \r is where the cursor is placed after the insert

  ("CDATA Section"			; "\r" specifies where the cursor
   "<![CDATA[\r]]>")			; is placed following the insert



  ;; Variable list Template  

  ("<variablelist> template"

   "
        <variablelist>

          <varlistentry><term>\r</term>
            <listitem>
              <para></para>
            </listitem>
          </varlistentry>

          <varlistentry><term></term>
            <listitem>
              <para></para>
            </listitem>
          </varlistentry>

          <varlistentry><term></term>
            <listitem>
              <para></para>
            </listitem>
          </varlistentry>

          <varlistentry><term></term>
            <listitem>
              <para></para>
            </listitem>
          </varlistentry>

        </variablelist>"
   ) 
  ;; End Variable List Template


  ;; Refentry Template  

  ("<refentry> (man page) template"
   "

    <refentry>

      <refmeta>
	<refentrytitle>\rTitle of this entry</refentrytitle>
	<manvolnum>Man page volume??</manvolnum>
      </refmeta>

      <refnamediv>
	<refname>Name of topic</refname>
	<refpurpose>A short (one sentence) synopsis of the topic of a
	  reference page</refpurpose>
      </refnamediv>

     <!-- OPTIONAL SECTION -->
      <refsynopsisdiv>
	<cmdsynopsis>
	  <command>/usr/bin/ls</command>
	  <arg choice=\"opt\">
	    <option>aAbcCdfFgilLmnopqrRstux1</option>
	  </arg>
	  <arg choice=\"opt\" rep=\"repeat\">file</arg>
	</cmdsynopsis>
      </refsynopsisdiv>

      <refsect1>
	<title>Description</title>
	<para>Long description goes here...</para>
      </refsect1>

    </refentry>"
   )
  ;;  END Refentry Template 




  ;; ArticleInfo Template 

  ("<articleinfo> template (Gnome)"
   "
  <articleinfo>

    <authorgroup>
      <author>
	<firstname>Gern</firstname>
	<surname>Blansten</surname>
	<affiliation>
	  <orgname>ACME, Inc.</orgname>
	  <address>
	    <email>gern@acme.com</email>
	  </address>
	</affiliation>
      </author>
    </authorgroup>

    <releaseinfo>This is a pseudo-release.</releaseinfo>

    <revhistory>
      <revision>
	<revnumber>0.1.3</revnumber>
	<date>02/12/01</date>
      </revision>
    </revhistory>

    <copyright>
      <year>2001</year>
      <holder>Gern Blanstenn</holder>
    </copyright>

    <legalnotice>
      <para>
	Permission is granted to copy, distribute and/or modify this
	document under the terms of the <citetitle>GNU Free Documentation
	License</citetitle>, Version 1.1 or any later version published
	by the Free Software Foundation with no Invariant Sections, no
	Front-Cover Texts, and no Back-Cover Texts. You may obtain a copy
	of the <citetitle>GNU Free Documentation License</citetitle> from
	the Free Software Foundation by visiting <ulink type=\"http\"
        url=\"http://www.fsf.org\">their Web site</ulink> or by writing to:
	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
	Boston, MA 02111-1307, USA.
      </para>
    </legalnotice>

    <title>\r</title>

  </articleinfo>"
   )

  ;; END ArticleInfo Template




  ;; BookInfo Template 

  ("<bookinfo> template (kde)"
 
   "
  <bookinfo>
    <title></title>

    <authorgroup>
      <author>
	<firstname>Gern</firstname>
	<surname>Blansten</surname>
	<affiliation>
	  <orgname>ACME, Inc.</orgname>
	  <address>
	    <email>gern@acme.com</email>
	  </address>
	</affiliation>
      </author>
    </authorgroup>

    <copyright>
      <year>2001</year>
      <holder>Gern Blansten</holder>
    </copyright>

    <legalnotice>
      <para>
	Permission is granted to copy, distribute and/or modify this
	document under the terms of the <citetitle>GNU Free Documentation
	License</citetitle>, Version 1.1 or any later version published
	by the Free Software Foundation with no Invariant Sections, no
	Front-Cover Texts, and no Back-Cover Texts. You may obtain a copy
	of the <citetitle>GNU Free Documentation License</citetitle> from
	the Free Software Foundation by visiting <ulink type=\"http\"
        url=\"http://www.fsf.org\">their Web site</ulink> or by writing to:
	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
	Boston, MA 02111-1307, USA.
      </para>
    </legalnotice>

    <date>03/04/2001</date>
    <releaseinfo>1.01.00</releaseinfo>

    <!-- Abstract about this book -->

    <abstract>
      <para>
	ABstract goes here.
      </para>
    </abstract>

    <!-- This is a set of Keywords for indexing by search engines. -->

    <keywordset>
      <keyword>money</keyword>
      <keyword>power</keyword>
      <keyword>apathy</keyword>
      <keyword>nothing</keyword>
      <keyword>nothing else</keyword>
    </keywordset>

  </bookinfo>"
   )
  ;; END BookInfo Template


  ;; END Menu Data
  )) 
;;; END Menu Section





;;; data-custom-markup-menu.el ends here
