Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762EAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51374206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCKNop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:44:45 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfCKNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:44:44 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Miqzy-1gXav80WTE-00evdi; Mon, 11 Mar 2019 14:44:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] secuirty: integrity: ima: pedantic formatting
Date:   Mon, 11 Mar 2019 14:44:40 +0100
Message-Id: <1552311880-20569-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:PsHHcT4Tpa1S4Vp1mNpHDxzDVtgQPUCgfsiTZSN4jJBgt9YenZE
 ksR2TurPmxv7DIv6ihGGK+HaZLN8HrFO+d/yx4xCWGae8LmJz5PiCmAHoyOTakdPwPpde7v
 +lEfJFspf0A4Fmfk+HfI/IHqkf/2u1PK1sBNQvm0Dy7mnfAaFnxIew+SC8VrENYWE2qX1L2
 OyR6CJqUaphAAffPueE6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qoXUpY55EHM=:ekEH1NgvYyNTz25aP03c0Z
 L4PeFrFfaPm2p6LSESUzi6Xf3e8+tBow4QSM21U4/pIcGElfKrt6qVXfSgtyFq49Ri9MnRd4u
 ncASwAkCu6zcgfDwyIa+RA5zw4BMhwcFEbRrvyqrRAtJa+ZydKSKOdSAK9a0xlZFVd5VTqgyF
 cjyb9ETv4lJPqCps0XmPKH1EvuxVAkvuIQSsp5pI2dgqPFIS65rsYooFdFQ5OBiB1uSQya9Tt
 9WTUYuSXjkmrznImj0RrULKGi8Lwy0LhSQPPfsRysL/IM2xjDpVgis96DX0qKNTjN7gnadyuE
 FGBLHnQpcT+1T+ITab5uCG6bSiImQHvXt2g0swFLxTWwMa67hSSqIJOZUAJ2z9ldM7f8iFBXy
 FYmy3gPujw/WX2y86rQFkOaH6hL3vMVIX3yVbnqJbUa27cKIRZ70CC5qg60HU0ZWauq5DzrIx
 z/uA4Q8lZ0zZoElzszFvWEol/gjDe9dmykUCG2obcylxJup7RyewD3GFTudgcS21vJ9U0V+xL
 HKlrkgOw0AWalsJTvo6L7YBBp6Wv+K/S2wBVbbkux1X4PW0T2gYnAAzbRBzQgSZacwhJpAuLA
 TKX9sK1CkE7zGvlvuaa1gYSz6S/Vo+VC3gka9doZ/XJpko4vVBDXbHVg2A7en0cXdGRbN22lA
 zq+vnUTpAS/QmL+L6IkT8lPpAzzWqwYO0GCRq82alzuzNFVbdUCpIpTdYT0qen/U0zZ94BqSs
 0PtsEbW7+buU3Sx+c5wxSqq3KaDKqonSbhtJJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 security/integrity/ima/Kconfig | 64 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6..416b724 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -34,12 +34,12 @@ config IMA_KEXEC
 	depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
 	default n
 	help
-	   TPM PCRs are only reset on a hard reboot.  In order to validate
-	   a TPM's quote after a soft boot, the IMA measurement list of the
-	   running kernel must be saved and restored on boot.
+	  TPM PCRs are only reset on a hard reboot.  In order to validate
+	  a TPM's quote after a soft boot, the IMA measurement list of the
+	  running kernel must be saved and restored on boot.
 
-	   Depending on the IMA policy, the measurement list can grow to
-	   be very large.
+	  Depending on the IMA policy, the measurement list can grow to
+	  be very large.
 
 config IMA_MEASURE_PCR_IDX
 	int
@@ -91,10 +91,10 @@ choice
 	default IMA_DEFAULT_HASH_SHA1
 	depends on IMA
 	help
-	   Select the default hash algorithm used for the measurement
-	   list, integrity appraisal and audit log.  The compiled default
-	   hash algorithm can be overwritten using the kernel command
-	   line 'ima_hash=' option.
+	  Select the default hash algorithm used for the measurement
+	  list, integrity appraisal and audit log.  The compiled default
+	  hash algorithm can be overwritten using the kernel command
+	  line 'ima_hash=' option.
 
 	config IMA_DEFAULT_HASH_SHA1
 		bool "SHA1 (default)"
@@ -138,9 +138,9 @@ config IMA_READ_POLICY
 	default y if IMA_WRITE_POLICY
 	default n if !IMA_WRITE_POLICY
 	help
-	   It is often useful to be able to read back the IMA policy.  It is
-	   even more important after introducing CONFIG_IMA_WRITE_POLICY.
-	   This option allows the root user to see the current policy rules.
+	  It is often useful to be able to read back the IMA policy.  It is
+	  even more important after introducing CONFIG_IMA_WRITE_POLICY.
+	  This option allows the root user to see the current policy rules.
 
 config IMA_APPRAISE
 	bool "Appraise integrity measurements"
@@ -158,12 +158,12 @@ config IMA_APPRAISE
 	  If unsure, say N.
 
 config IMA_ARCH_POLICY
-        bool "Enable loading an IMA architecture specific policy"
-        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
-        default n
-        help
-          This option enables loading an IMA architecture specific policy
-          based on run time secure boot flags.
+	bool "Enable loading an IMA architecture specific policy"
+	depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+	default n
+	help
+	  This option enables loading an IMA architecture specific policy
+	  based on run time secure boot flags.
 
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
@@ -238,10 +238,10 @@ config IMA_TRUSTED_KEYRING
 	select INTEGRITY_TRUSTED_KEYRING
 	default y
 	help
-	   This option requires that all keys added to the .ima
-	   keyring be signed by a key on the system trusted keyring.
+	  This option requires that all keys added to the .ima
+	  keyring be signed by a key on the system trusted keyring.
 
-	   This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
+	  This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
@@ -266,32 +266,32 @@ config IMA_BLACKLIST_KEYRING
 	depends on IMA_TRUSTED_KEYRING
 	default n
 	help
-	   This option creates an IMA blacklist keyring, which contains all
-	   revoked IMA keys.  It is consulted before any other keyring.  If
-	   the search is successful the requested operation is rejected and
-	   an error is returned to the caller.
+	  This option creates an IMA blacklist keyring, which contains all
+	  revoked IMA keys.  It is consulted before any other keyring.  If
+	  the search is successful the requested operation is rejected and
+	  an error is returned to the caller.
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
 	depends on IMA_TRUSTED_KEYRING
 	default n
 	help
-	   File signature verification is based on the public keys
-	   loaded on the .ima trusted keyring. These public keys are
-	   X509 certificates signed by a trusted key on the
-	   .system keyring.  This option enables X509 certificate
-	   loading from the kernel onto the '.ima' trusted keyring.
+	  File signature verification is based on the public keys
+	  loaded on the .ima trusted keyring. These public keys are
+	  X509 certificates signed by a trusted key on the
+	  .system keyring.  This option enables X509 certificate
+	  loading from the kernel onto the '.ima' trusted keyring.
 
 config IMA_X509_PATH
 	string "IMA X509 certificate path"
 	depends on IMA_LOAD_X509
 	default "/etc/keys/x509_ima.der"
 	help
-	   This option defines IMA X509 certificate path.
+	  This option defines IMA X509 certificate path.
 
 config IMA_APPRAISE_SIGNED_INIT
 	bool "Require signed user-space initialization"
 	depends on IMA_LOAD_X509
 	default n
 	help
-	   This option requires user-space init to be signed.
+	  This option requires user-space init to be signed.
-- 
1.9.1

