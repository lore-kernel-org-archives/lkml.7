Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0540206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCKN1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Frd-1h6Nub0KRz-006Mns for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 049/114] security: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:01 +0100
Message-Id: <1552310346-7629-50-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5UVKGaTxSvBPk3XUR+umg1lwCuSiTVWsb9KFTlbWEV745MamKyO
 9TB4UPiAlFkPcLaVWLJYZuL/NV9bxQKcKW35qQmSgrRADdXPJAgVP9A0wDeH7+tqfkT8Atx
 hhCct1HbazfO/c/zJ4672H2R9Mo0nBwnt4PyorOaM9hi2js0VIPpJ/Qg6SFuGvGT22HzHQb
 5vUdoTx66Lopo8hdLdSmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpourU3eU08=:k2r7y49m5UnI1xz7coR/9v
 058sOugi2wO/zvnKTIvIZnwFYlyjViYx5BU6noPZ8UMbQMQW5VBFAEUud1KRchOZlHt9/Mvoo
 llEzPaWKsoFNeK/z11IrVUWea4uslWhIUW9jiYtflb6UI8E1Dc2Rcqa6qClLSDjZwQ50twXz1
 oFTUASaATUqvFoTtByucMTRC5goUr/SZEZJsp59DI1FkFPefnC9MsWQOvzc5zn7rmGJQbu89L
 dyUpFo8O1BkUnszfu/3ruUjRnnJLgN6EBgwNc8lCkuz/TOd0w38QtGV2DXRAMalkzZJs15Jda
 sIGgoY2bNA+R1YTbj87QtQdppb0ne47kq26W570DJJ/Yo/QxNoEjl+yUlFUFA5PxBuMSYrUJg
 6hHwMV+ZkLcxn+5g9UAwAxz1O17JZa0mUE0SSIgIlnSVgqYDMKeMjojjc+CvkGi8ID3x8ZneV
 AzjiwYEVKVEM/1c2ZD63gvoUpasanvr7vAh3dROzmKIOgpX7Fashdx8NbZqdHJjEoYbLJUJwI
 Bb76TLWU+jMdmwrAkGsoHMBXpGw5G00/BcfGgU8PzB+2UM3ekVb/5qSN/M2RqJ49LIUEBO0WG
 pjdlJ5xsz1CgrRL0ZlfTyzM1xfa9hpsfUp8z6Bvm9udfpmT7Co7ccPUNDBRs2iDCfB6/zMpsp
 Bh3u+1U/W9NeThGnav6Tcx4WZTISTJmB3A6zZDqg/dBs/ZiNpip8+RSSYJR1W1+g5aljxU0qg
 KbA1wTZzcAbtWBfTqJ8/z3IeiVP6d7l+2IDyjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 security/apparmor/Kconfig      | 22 +++++++++++-----------
 security/integrity/Kconfig     | 32 ++++++++++++++++----------------
 security/integrity/evm/Kconfig | 10 +++++-----
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 3de21f4..d93810d 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -25,17 +25,17 @@ config SECURITY_APPARMOR_HASH
 	  is available to userspace via the apparmor filesystem.
 
 config SECURITY_APPARMOR_HASH_DEFAULT
-       bool "Enable policy hash introspection by default"
-       depends on SECURITY_APPARMOR_HASH
-       default y
-       help
-         This option selects whether sha1 hashing of loaded policy
-	 is enabled by default. The generation of sha1 hashes for
-	 loaded policy provide system administrators a quick way
-	 to verify that policy in the kernel matches what is expected,
-	 however it can slow down policy load on some devices. In
-	 these cases policy hashing can be disabled by default and
-	 enabled only if needed.
+	bool "Enable policy hash introspection by default"
+	depends on SECURITY_APPARMOR_HASH
+	default y
+	help
+	  This option selects whether sha1 hashing of loaded policy
+	  is enabled by default. The generation of sha1 hashes for
+	  loaded policy provide system administrators a quick way
+	  to verify that policy in the kernel matches what is expected,
+	  however it can slow down policy load on some devices. In
+	  these cases policy hashing can be disabled by default and
+	  enabled only if needed.
 
 config SECURITY_APPARMOR_DEBUG
 	bool "Build AppArmor with debug code"
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 2ea4ec9..690bc1d 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -33,10 +33,10 @@ config INTEGRITY_ASYMMETRIC_KEYS
 	bool "Enable asymmetric keys support"
 	depends on INTEGRITY_SIGNATURE
 	default n
-        select ASYMMETRIC_KEY_TYPE
-        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-        select CRYPTO_RSA
-        select X509_CERTIFICATE_PARSER
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO_RSA
+	select X509_CERTIFICATE_PARSER
 	help
 	  This option enables digital signature verification using
 	  asymmetric keys.
@@ -47,20 +47,20 @@ config INTEGRITY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	default y
 	help
-	   This option requires that all keys added to the .ima and
-	   .evm keyrings be signed by a key on the system trusted
-	   keyring.
+	  This option requires that all keys added to the .ima and
+	  .evm keyrings be signed by a key on the system trusted
+	  keyring.
 
 config INTEGRITY_PLATFORM_KEYRING
-        bool "Provide keyring for platform/firmware trusted keys"
-        depends on INTEGRITY_ASYMMETRIC_KEYS
-        depends on SYSTEM_BLACKLIST_KEYRING
-        depends on EFI
-        help
-         Provide a separate, distinct keyring for platform trusted keys, which
-         the kernel automatically populates during initialization from values
-         provided by the platform for verifying the kexec'ed kerned image
-         and, possibly, the initramfs signature.
+	bool "Provide keyring for platform/firmware trusted keys"
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on EFI
+	help
+	  Provide a separate, distinct keyring for platform trusted keys, which
+	  the kernel automatically populates during initialization from values
+	  provided by the platform for verifying the kexec'ed kerned image
+	  and, possibly, the initramfs signature.
 
 config INTEGRITY_AUDIT
 	bool "Enables integrity auditing support "
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index 6022185..ab5d9ae 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -59,15 +59,15 @@ config EVM_LOAD_X509
 	depends on EVM && INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
-	   Load an X509 certificate onto the '.evm' trusted keyring.
+	  Load an X509 certificate onto the '.evm' trusted keyring.
 
-	   This option enables X509 certificate loading from the kernel
-	   onto the '.evm' trusted keyring.  A public key can be used to
-	   verify EVM integrity starting from the 'init' process.
+	  This option enables X509 certificate loading from the kernel
+	  onto the '.evm' trusted keyring.  A public key can be used to
+	  verify EVM integrity starting from the 'init' process.
 
 config EVM_X509_PATH
 	string "EVM X509 certificate path"
 	depends on EVM_LOAD_X509
 	default "/etc/keys/x509_evm.der"
 	help
-	   This option defines X509 certificate path.
+	  This option defines X509 certificate path.
-- 
1.9.1

