<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- 1. Zagnieżdżenie na ≥3 poziomach + 4 nowe znaczniki -->
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/hobby">
    <nowe_hobby>
      <xsl:apply-templates select="informacje"/>
      <lista_szczytow>
        <xsl:apply-templates select="zdobyte/pasmo_górskie//szczyt"/>
        <xsl:apply-templates select="planowane/kontynent//szczyt_planowany"/>
      </lista_szczytow>
    </nowe_hobby>
  </xsl:template>

  <!-- 2. Nowe elementy i atrybuty -->
  <xsl:template match="informacje">
    <dane_autora>
      <xsl:apply-templates select="autor"/>
    </dane_autora>
  </xsl:template>

  <!-- 3. xsl:element + xsl:attribute (dynamiczne tworzenie) -->
  <xsl:template match="autor">
    <xsl:element name="autor_info">
      <xsl:attribute name="czy_student">
        <xsl:value-of select="@student"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- 4. Szablon dla zdobytych szczytów -->
  <xsl:template match="szczyt">
    <szczyt_dane>
      <nazwa><xsl:value-of select="nazwa"/></nazwa>
      <typ>zdobyty</typ>
      <wysokosc jednostka="m">
        <xsl:value-of select="wysokość"/>
      </wysokosc>
      <!-- 5. xsl:copy - kopiujemy opis -->
      <xsl:copy>
        <xsl:apply-templates select="opis"/>
      </xsl:copy>
    </szczyt_dane>
  </xsl:template>

  <!-- 6. Szablon dla planowanych szczytów -->
  <xsl:template match="szczyt_planowany">
    <szczyt_dane>
      <nazwa><xsl:value-of select="nazwa"/></nazwa>
      <typ>planowany</typ>
      <wysokosc jednostka="m">
        <xsl:value-of select="wysokość"/>
      </wysokosc>
      <rok_wyprawy><xsl:value-of select="@rok"/></rok_wyprawy>
      <!-- 7. xsl:copy-of — kopiujemy cały kraj/kraje -->
      <xsl:copy-of select="kraje"/>
    </szczyt_dane>
  </xsl:template>

</xsl:stylesheet>