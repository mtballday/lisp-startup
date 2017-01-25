<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0"
                xmlns:xt="http://www.jclark.com/xt"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                extension-element-prefixes="xt saxon xalanredirect lxslt">

<xsl:import href="/share/xsl/docbook/html/chunk.xsl"/>

<xsl:strip-space elements="slides foil section"/>

<xsl:param name="chunk">1</xsl:param>
<xsl:param name="ie5">0</xsl:param>
<xsl:param name="css-stylesheet">slides.css</xsl:param>
<xsl:param name="graphics.dir">graphics</xsl:param>

<xsl:attribute-set name="body-attrs">
  <xsl:attribute name="bgcolor">white</xsl:attribute>
  <xsl:attribute name="text">black</xsl:attribute>
  <xsl:attribute name="link">#0000FF</xsl:attribute>
  <xsl:attribute name="vlink">#840084</xsl:attribute>
  <xsl:attribute name="alink">#0000FF</xsl:attribute>
</xsl:attribute-set>

<!-- ============================================================ -->

<xsl:template name="chunk">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="$chunk='0'">0</xsl:when>
    <xsl:when test="name($node)='slides'">1</xsl:when>
    <xsl:when test="name($node)='foil'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*" mode="chunk-filename">
  <xsl:param name="recursive">0</xsl:param>
  <!-- returns the filename of a chunk -->
  <xsl:variable name="ischunk"><xsl:call-template name="chunk"/></xsl:variable>
  <xsl:variable name="filename">
    <xsl:call-template name="dbhtml-filename"/>
  </xsl:variable>
  <xsl:variable name="dir">
    <xsl:call-template name="dbhtml-dir"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$chunk='0'"></xsl:when>
    <xsl:when test="$ischunk='0'">
      <!-- if called on something that isn't a chunk, walk up... -->
      <xsl:choose>
        <xsl:when test="count(./parent::*)>0">
          <xsl:apply-templates mode="chunk-filename" select="./parent::*">
            <xsl:with-param name="recursive" select="$recursive"/>
          </xsl:apply-templates>
        </xsl:when>
        <!-- unless there is no up, in which case return "" -->
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="not($recursive) and $filename != ''">
      <!-- if this chunk has an explicit name, use it -->
      <xsl:if test="$dir != ''">
        <xsl:value-of select="$dir"/>
        <xsl:text>/</xsl:text>
      </xsl:if>
      <xsl:value-of select="$filename"/>
    </xsl:when>

    <xsl:when test="name(.)='foil'">
      <xsl:variable name="foilnumber">
	<xsl:number count="foil" level="any"/>
      </xsl:variable>

      <xsl:text>foil</xsl:text>
      <xsl:number value="$foilnumber" format="01"/>
      <xsl:text>.html</xsl:text>
    </xsl:when>

    <xsl:otherwise>
      <xsl:text>chunk-filename-error-</xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:number level="any" format="01" from="set"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="slides">
  <xsl:variable name="title" select="(slidesinfo/title|title)[1]"/>

  <xsl:choose>
    <xsl:when test="$chunk=0">
      <!--nop-->
    </xsl:when>
    <xsl:when test="$ie5='0'">
      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="'frames.html'"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title><xsl:value-of select="$title"/></title>
            </head>
            <frameset cols="250,*">
              <frame src="toc.html" name="toc"/>
              <frame src="titlefoil.html" name="foil"/>
            </frameset>
            <body xsl:use-attribute-sets="body-attrs">
              <a href="titleframe.html">
                <xsl:text>Your browser doesn't support frames.</xsl:text>
              </a>
            </body>
          </html>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="'frames.html'"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title><xsl:value-of select="$title"/></title>
            </head>
            <frameset cols="250,*">
              <frame src="toc.html" name="toc"/>
              <frameset rows="20,*,20">
                <frame src="navbar.html" name="header" noresize="noresize"
                       scrolling="no"
                       marginwidth="0" marginheight="0" frameborder="no"/>
                <frame src="titlefoil.html" name="foil" frameborder="no"/>
                <frame src="navbar.html" name="navbar" noresize="noresize"
                       scrolling="no"
                       marginwidth="0" marginheight="0" frameborder="no"/>
              </frameset>
            </frameset>
            <body xsl:use-attribute-sets="body-attrs">
              <a href="titleframe.html">
                <xsl:text>Your browser doesn't support frames.</xsl:text>
              </a>
            </body>
          </html>
        </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="'navbar.html'"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title><xsl:value-of select="$title"/></title>
            </head>
            <body><!-- complete dummy doc, rewritten by javascript --></body>
          </html>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="$chunk=0">
      <html><body xsl:use-attribute-sets="body-attrs">
	<xsl:apply-templates/>
      </body></html>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="'toc.html'"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title>TOC - <xsl:value-of select="$title"/></title>
              <link type="text/css" rel="stylesheet" href="{$css-stylesheet}"/>
              <xsl:if test="$ie5 != '0'">
                <script src="slides.js"/>
              </xsl:if>
            </head>
            <body xsl:use-attribute-sets="body-attrs">
              <xsl:if test="$ie5!='0'">
                <xsl:attribute name="onload">
                  <xsl:text>newPage('toc.html');</xsl:text>
                </xsl:attribute>
              </xsl:if>
              <div class="toc">
                <xsl:apply-templates mode="toc"/>
              </div>
            </body>
          </html>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="slidesinfo">
  <xsl:choose>
    <xsl:when test="$chunk=0">
      <div class="{name(.)}">
	<xsl:apply-templates/>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="'titlefoil.html'"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title><xsl:value-of select="title"/></title>
              <link type="text/css" rel="stylesheet" href="{$css-stylesheet}"/>
              <xsl:if test="$ie5 != '0'">
                <script src="slides.js"/>
              </xsl:if>
            </head>
            <body xsl:use-attribute-sets="body-attrs">
              <xsl:if test="$ie5!='0'">
                <xsl:attribute name="onload">
                  <xsl:text>newPage('titlefoil.html');</xsl:text>
                </xsl:attribute>
              </xsl:if>
              <div class="{name(.)}">
                <xsl:apply-templates/>

                <xsl:choose>
                  <xsl:when test="$ie5 = '0'">
                    <div class="navfoot" style="padding-top: 2in;">
                      <hr/>
                      <table width="100%" border="0">
                        <tr>
                          <td align="left" width="50%" valign="top">
                            <span class="navfooter">
                              <xsl:apply-templates select="/slides/slidesinfo/copyright"
                                                   mode="titlepage.mode"/>
                            </span>
                          </td>
                          <td align="right" width="50%" valign="top">
                            <a href="foil01.html">
                              <img src="{$graphics.dir}/right.gif" border="0"/>
                            </a>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="navfoot" style="padding-top: 2in;">
                      <hr/>
                      <table width="100%" border="0">
                        <tr>
                          <td align="center" width="100%" valign="top">
                            <span class="navfooter">
                              <xsl:apply-templates select="/slides/slidesinfo/copyright"
                                                   mode="titlepage.mode"/>
                            </span>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </body>
          </html>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="slidesinfo/title">
  <h1 class="{name(.)}"><xsl:apply-templates/></h1>
</xsl:template>

<xsl:template match="slidesinfo/authorgroup">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="slidesinfo/author|slidesinfo/authorgroup/author">
  <h1 class="{name(.)}"><xsl:apply-imports/></h1>
</xsl:template>

<xsl:template match="slidesinfo/releaseinfo">
  <h4 class="{name(.)}"><xsl:apply-templates/></h4>
</xsl:template>

<xsl:template match="slidesinfo/date">
  <h4 class="{name(.)}"><xsl:apply-templates/></h4>
</xsl:template>

<xsl:template match="slidesinfo/copyright">
  <xsl:if test="$chunk = 0">
    <xsl:apply-templates select="." mode="titlepage.mode"/>
  </xsl:if>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="section">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="section/title">
</xsl:template>

<xsl:template match="section/title" mode="navheader">
  <span class="navheader"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="slides/title" mode="navheader">
  <span class="navheader"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="slides/slidesinfo/title" mode="navheader">
  <span class="navheader"><xsl:apply-templates/></span>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="foil">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="section" select="ancestor::section"/>

  <xsl:variable name="foilnumber">
    <xsl:number count="foil" level="any"/>
  </xsl:variable>

  <xsl:variable name="thisfoil">
    <xsl:text>foil</xsl:text>
    <xsl:number value="$foilnumber" format="01"/>
    <xsl:text>.html</xsl:text>
  </xsl:variable>

  <xsl:variable name="nextfoil">
    <xsl:if test="following::foil">
      <xsl:text>foil</xsl:text>
      <xsl:number value="$foilnumber + 1" format="01"/>
      <xsl:text>.html</xsl:text>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="prevfoil">
    <xsl:choose>
      <xsl:when test="$foilnumber > 1">
        <xsl:text>foil</xsl:text>
        <xsl:number value="$foilnumber - 1" format="01"/>
        <xsl:text>.html</xsl:text>
      </xsl:when>
      <xsl:otherwise>titlefoil.html</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$chunk=0">
      <hr/>
      <div class="{name(.)}" id="{$id}">
	<a name="{$id}"/>
	<xsl:apply-templates/>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="$thisfoil"/>
        <xsl:with-param name="content">
          <head>
            <title><xsl:value-of select="title"/></title>
            <link type="text/css" rel="stylesheet" href="{$css-stylesheet}"/>
            <xsl:if test="$ie5 != '0'">
              <script src="slides.js"/>
            </xsl:if>
          </head>
          <body xsl:use-attribute-sets="body-attrs">
            <xsl:if test="$ie5!='0'">
              <xsl:attribute name="onload">
                <xsl:text>newPage('</xsl:text>
                <xsl:value-of select="$thisfoil"/>
                <xsl:text>');</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <div class="{name(.)}" id="{$id}">
              <a name="{$id}"/>
              <xsl:if test="$ie5 = '0'">
                <div class="navhead">
                  <table width="100%" border="0">
                    <tr>
                      <td align="left" width="10%">
                        <xsl:choose>
                          <xsl:when test="$prevfoil != ''">
                            <a href="{$prevfoil}">
                              <img src="{$graphics.dir}/left.gif" border="0"/>
                            </a>
                          </xsl:when>
                          <xsl:otherwise>&#160;</xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td align="center" width="80%">
                        <xsl:variable name="prestitle">
                          <xsl:value-of select="(/slides/slidesinfo/title
                                                |/slides/title)[1]"/>
                        </xsl:variable>
                        <xsl:variable name="secttitle">
                          <xsl:if test="$section">
                            <xsl:value-of select="$section/title"/>
                          </xsl:if>
                        </xsl:variable>

                        <span class="navheader">
                          <xsl:value-of select="$prestitle"/>
                          <xsl:if test="$secttitle != ''">
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="$secttitle"/>
                          </xsl:if>
                        </span>
                      </td>
                      <td align="right" width="10%">
                        <xsl:choose>
                          <xsl:when test="$nextfoil != ''">
                            <a href="{$nextfoil}">
                              <img src="{$graphics.dir}/right.gif" border="0"/>
                            </a>
                          </xsl:when>
                          <xsl:otherwise>&#160;</xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                  </table>
                  <hr/>
                </div>
              </xsl:if>

              <xsl:apply-templates/>

              <xsl:if test="$ie5 = '0'">
                <div class="navfoot">
                  <hr/>
                  <table width="100%" border="0">
                    <tr>
                      <td align="left" width="50%" valign="top">
                        <span class="navfooter">
                          <xsl:apply-templates select="/slides/slidesinfo/copyright"
                                               mode="titlepage.mode"/>
                        </span>
                      </td>
                      <td align="right" width="50%" valign="top">
                        <span class="navfooter">
                          <xsl:number count="foil" level="any"/>
                        </span>
                      </td>
                    </tr>
                  </table>
                </div>
              </xsl:if>
            </div>
          </body>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="foil" mode="foilnumber">
  <xsl:number count="foil" level="any"/>
</xsl:template>

<xsl:template match="foil/title">
  <h1 class="{name(.)}">
    <xsl:if test="$chunk = 0">
      <xsl:text>Slide </xsl:text>
      <xsl:apply-templates select="parent::*" mode="foilnumber"/>
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </h1>
</xsl:template>

<xsl:template match="processing-instruction('Pub')">
  <xsl:variable name="pidata"><xsl:value-of select="(.)"/></xsl:variable>
  <xsl:choose>
    <xsl:when test="contains($pidata,'UDT')"></xsl:when>
    <xsl:when test="contains($pidata,'/_font')">
      <xsl:text disable-output-escaping="yes">&lt;/font&gt;</xsl:text>
    </xsl:when>
    <xsl:when test="contains($pidata,'_font')">
      <xsl:text disable-output-escaping="yes">&lt;font </xsl:text>
      <xsl:choose>
        <xsl:when test="contains($pidata,'green')">color="green"</xsl:when>
        <xsl:when test="contains($pidata,'orange')">color="orange"</xsl:when>
        <xsl:when test="contains($pidata,'red')">color="red"</xsl:when>
        <xsl:when test="contains($pidata,'brown')">color="brown"</xsl:when>
        <xsl:when test="contains($pidata,'violet')">color="violet"</xsl:when>
        <xsl:when test="contains($pidata,'black')">color="black"</xsl:when>
        <xsl:otherwise>weight="bold"</xsl:otherwise>
      </xsl:choose>
      <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->
<!-- blocks -->

<xsl:template match="figure">
  <div class="{name(.)}">
    <xsl:apply-imports/>
  </div>
  <xsl:if test="following-sibling::*"><hr/></xsl:if>
</xsl:template>

<!-- ============================================================ -->
<!-- inlines -->

<xsl:template match="emphasis">
  <i><font color="green"><xsl:apply-templates/></font></i>
</xsl:template>

<xsl:template match="ulink">
  <a href="{@url}" target="_top"><xsl:apply-templates/></a>
  <xsl:text> (</xsl:text>
  <xsl:value-of select="@url"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="title/ulink">
  <a href="{@url}" target="_top"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="graphic">
  <center>
    <!-- can't this be done a better way? -->
    <xsl:apply-imports/>
  </center>
</xsl:template>

<!-- ============================================================ -->
<!-- transclusion -->

<xsl:template match="inlinegraphic[@format='linespecific']">
  <a xml:link="simple" show="embed" actuate="auto" href="{@fileref}"/>
</xsl:template>

<xsl:template match="imagedata[@format='linespecific']">
  <a xml:link="simple" show="embed" actuate="auto" href="{@fileref}"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="foil" mode="foil-filename">
  <xsl:text>foil</xsl:text>
  <xsl:number count="foil" level="any" format="01"/>
  <xsl:text>.html</xsl:text>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="slidesinfo" mode="toc">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div id="{$id}" class="toc-slidesinfo">
    <a href="titlefoil.html" target="foil">
      <xsl:apply-templates select="title" mode="toc"/>
    </a>
    <hr/>
  </div>
</xsl:template>

<xsl:template match="section" mode="toc">
  <xsl:variable name="foil">
    <xsl:apply-templates select="foil[1]" mode="foil-filename"/>
  </xsl:variable>

  <div class="toc-section">
    <img src="{$graphics.dir}/minus.gif" alt="-"/>
    <a href="{$foil}" target="foil">
      <xsl:apply-templates select="title" mode="toc"/>
    </a>
    <xsl:apply-templates select="foil" mode="toc"/>
  </div>
</xsl:template>

<xsl:template match="foil" mode="toc">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <xsl:variable name="foil">
    <xsl:apply-templates select="." mode="foil-filename"/>
  </xsl:variable>

  <div id="{$id}" class="toc-foil">
    <img src="{$graphics.dir}/bullet.gif" alt="-"/>
    <a href="{$foil}" target="foil">
      <xsl:apply-templates select="title" mode="toc"/>
    </a>
  </div>
</xsl:template>

<xsl:template match="title" mode="toc">
  <xsl:apply-templates mode="toc"/>
</xsl:template>


<!-- ============================================================ -->

</xsl:stylesheet>

