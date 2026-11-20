<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- Generic: clear contents of any Config whose Name, Target, or Description mentions "password" or "token" (case-insensitive) -->
  <xsl:template match="/Container/Config[contains(translate(@Name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'password') or contains(translate(@Target,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'password') or contains(translate(@Description,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'password') or contains(translate(@Name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'token') or contains(translate(@Target,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'token') or contains(translate(@Description,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'), 'token')]" priority="0">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- Preserve template-style Default values (placeholders, not secrets) -->
  <xsl:template match="/Container/Config[@Target='DATABASE_URL']/@Default" priority="1">
    <xsl:copy/>
  </xsl:template>

  <!-- Preserve example/placeholder email Defaults (not real secrets) -->
  <xsl:template match="/Container/Config/@Default[contains(., 'example@')]" priority="1">
    <xsl:copy/>
  </xsl:template>

  <!-- Blank Default attributes containing email addresses -->
  <xsl:template match="/Container/Config/@Default[contains(., '@')]">
    <xsl:attribute name="Default"/>
  </xsl:template>

  <!-- Generic: clear contents of any masked Config element -->
  <xsl:template match="/Container/Config[@Mask='true']" priority="0">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- goodreads-mcp.xml -->
  <xsl:template match="/Container/Config[@Target='GOODREADS_USER']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- Insync.xml -->
  <xsl:template match="/Container/Config[@Target='GDRIVE_AUTHCODE']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='GDRIVE_ACCOUNT']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- n8n.xml -->
  <xsl:template match="/Container/Config[@Target='N8N_BASIC_AUTH_PASSWORD']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='N8N_SMTP_USER']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='N8N_SMTP_PASS']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='N8N_SMTP_SENDER']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- pihole.xml -->
  <xsl:template match="/Container/Config[@Target='WEBPASSWORD']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- rundeck.xml -->
  <xsl:template match="/Container/Config[@Target='RUNDECK_MAIL_SMTP_USERNAME']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- traefik.xml -->
  <xsl:template match="/Container/Config[@Target='DUCKDNS_TOKEN']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='ACME_EMAIL_ADDRESS']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='CF_API_KEY']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/Container/Config[@Target='CF_API_EMAIL']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!-- vim: set tabstop=2 shiftwidth=2 vartabstop=2 smarttab softtabstop=2 shiftround expandtab autoindent: -->
