<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>
  

  
  <xsl:template match="/hobby">
    <Zainteresowania>
      <xsl:apply-templates select="informacje"/>
      <lista_szczytow>
        <xsl:apply-templates select="zdobyte/pasmo_górskie//szczyt"/>
        <xsl:apply-templates select="planowane/kontynent//szczyt_planowany"/>
      </lista_szczytow>
    </Zainteresowania>
  </xsl:template>



  <xsl:template match="informacje">
    <dane_autora>
      <xsl:apply-templates select="autor"/>
    </dane_autora>
  </xsl:template>



  <xsl:template match="autor">
    <xsl:element name="autor_info">
      <xsl:attribute name="czy_student">
        <xsl:value-of select="@student"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>



  <xsl:template match="szczyt">
    <szczyt_dane>
      <nazwa><xsl:value-of select="nazwa"/></nazwa>
      <typ>zdobyty</typ>
      <wysokosc jednostka="m">
        <xsl:value-of select="wysokość"/>
      </wysokosc>
      <xsl:copy>
        <xsl:apply-templates select="opis"/>
      </xsl:copy>
    </szczyt_dane>
  </xsl:template>



  <xsl:template match="szczyt_planowany">
    <szczyt_dane>
      <nazwa><xsl:value-of select="nazwa"/></nazwa>
      <typ>planowany</typ>
      <wysokosc jednostka="m">
        <xsl:value-of select="wysokość"/>
      </wysokosc>
      <rok_wyprawy><xsl:value-of select="@rok"/></rok_wyprawy>
      <xsl:copy-of select="kraje"/>
    </szczyt_dane>
  </xsl:template>

</xsl:stylesheet>