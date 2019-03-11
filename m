Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E999C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C62183F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfCKN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfCKNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MspyA-1go0uh39yq-00tGHz for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 031/114] secuirty: integrity: ima: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:43 +0100
Message-Id: <1552310346-7629-32-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VCenAdhw+CmTs0l3MlMt6KO3A9CSa/qoxvdjdjYu0355V5uH9WZ
 OZc5TCXmZbl6OjaM+c5jCTZ/VZq2Kzu7D2/tZIP4y8DMfTEgov6C3h2wlhbeMB8lLoYwSVA
 meQgRS03H0Xg47tH5HcwFhzPBBEzpW3eMthWiEQB6y8IbtO2SgtPVFIAYyne3KbUXxaPZcq
 fn7mAnK6EyNiQn0QgMkLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KtZsIPA1tFE=:Tg4tE3P7wevmtW11UMBipw
 7sIBGBuh5Fvr7N7H0gh3VVW//tK6u4LRtBzNwu2uuzRUcQTQGS6FH483KTP9CyTrKdspylxLb
 JEXhPYDGXZ2mOqL9GY4T5Lyn0L0C9/fQL3FbO23Bg6MjQiVz/fCRGl3jgMn6vYbO0dkXEltjT
 MCa3AoSxk095U1yd3vO2IaY5dp36SgcC/NjTjK+TbIMxYgcs6I1VG3hvx7EX+1eCielSSdLGC
 ZFm5eckCL6HVPXFSVBFa1EJpltntX6iiYapEfcyKCF2uYpNqJ0rGwIwQgxIQC/xz+69mHB2Uo
 HxHMoaa06aT1xO4QeHjZG6UYGYtA805+qoP64m/1fk9rnsuIQdcHog8eodm/n5jc6TYaAN9GD
 aWciae8kTX34bkAuDLfSjaWQ8ELSYLJmCl4dGy5jmnDBnm2YzW84moXHLDjjSMHG/Fn3wbVK0
 TS3gesTfqYaPBG1tpIrkEJ6CDjTDk46m0GG18edJ2S2MID3NPGpxskVc/6j08f0l4j0IWypqY
 1QOq9jpboqhfq7kwKj/MYuivNyGsIzyDoBlnuxMweE/37OyR6YrCPpFC65RfM2yQOpbBJWvAy
 NC2U066AChyLJ97yOajkEb5Mruj5PczKiX2aHFctKAYRmwl8dJo4GiRJFXwyz1UoKCaaILy0v
 cPCihUELBXD6Xq8617685nmBkXJOSzY9a9dAlF0RTmK90b65nDKMDnYqxSjnHz5v7SE/9NvuV
 BN5xp6vSaP5Yh84pJPLns/pdJaBvFNV+FvX7KQ==
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

