Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23450C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7883206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCKN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:54 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6KMR-1h1TJ93KiP-016gPy for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 055/114] drivers: crypto: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:07 +0100
Message-Id: <1552310346-7629-56-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Qs92QJYHHlovHnnmDeYgAnxgdjxuNh6k8gw7bdQRw7sikYrOR6Q
 S4tpf0VrSK/zbwrmNcb6EDzfNxT6RUza0CTn8fIOa23Tzu4rcuNXowkOPEE70MD+/jqgSBy
 dZuFndrkeOEyX4smDRfGsxzYMP7J2/BoNVRo9PR5PrhDHaOZ5jIZAB9/eq5sL9XeFwp0vS1
 uzYW73ZkKPzqeGujTaBdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p72EqIIaiqg=:7srBaSw4E+2mSYPKMiFGGY
 Ln6zeJB708HAK4QrCMy+2vyzJbCPjglhXZ+5gQJaYTjz6z2LEb6gzzuJwN8ZfFeHpfjcQAh0j
 sgGikfuQuzub61lB/j1QLY/rwk3LEMiMxMUCpB8VQ0uG8YLerUtFEKjCtJATxV/2/ksGeb2ZH
 eV3wVVhgC9mXwVf5bPBWXL7F8daWwdu0Tjd00vmQxXGZSBgTFBvEZCP9aMxBhTldmN4JEnPol
 +mtBKnepPupZSOCG1jsxCwmu0OVXuDyucPf5+Df6gpoPkyVudHJZxZ6Ch/SZlM9nrp57HZA/x
 w32cVnnbszjAtJAeD3H0NARD2UsXxW0HW/xVUoc2fiVqCshZkhf28gVxeVYbeDItyEsDw+fiS
 KSwAdFIC+W3BqlqB7W1Qlmy9XAD2npJnYBkkoecjJvgzKcY6KPb7o8biEaNvsXnig6Re7M7/q
 6VSI1yMG6xl2TveoTiiwSIE9gAp9mFNkgJ9X2eDVk0ZvLKMEciXsycU7pt0wA+bsPoIlGFrLQ
 dH8Q+Lt6AYxnbyzg14m0xUgEA/BaHGTJN5yT8h6LEDYhHQgNGEhHgxuf+aZfCWln6C3EYstRo
 UYfifMha3hUb995WDjUfGyfdcaN3umf/4gKa94Djz55YMOjyXEK+gFQlq2kKOreE+CGXFN8ZZ
 6lvqhJAvzEJHVJoC3APeHLbqNcvLJtzAZ9drMh7AMra7/0QjqfaLOD1ONAsqSdJQM0G9R8kzr
 +1GZ3DFXPloApyz/CjhWmeZPPU1/QWpK1ESMmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/crypto/Kconfig         | 28 ++++++++++++++--------------
 drivers/crypto/caam/Kconfig    | 18 +++++++++---------
 drivers/crypto/ccp/Kconfig     | 10 +++++-----
 drivers/crypto/chelsio/Kconfig | 30 +++++++++++++++---------------
 drivers/crypto/stm32/Kconfig   |  6 +++---
 drivers/crypto/ux500/Kconfig   | 16 ++++++++--------
 6 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0be55fc..ddbfff5 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -18,7 +18,7 @@ config CRYPTO_DEV_PADLOCK
 	  (so called VIA PadLock ACE, Advanced Cryptography Engine)
 	  that provides instructions for very fast cryptographic
 	  operations with supported algorithms.
-	  
+
 	  The instructions are used only when the CPU supports them.
 	  Otherwise software encryption is used.
 
@@ -225,15 +225,15 @@ config CRYPTO_DEV_MARVELL_CESA
 	  This driver supports CPU offload through DMA transfers.
 
 config CRYPTO_DEV_NIAGARA2
-       tristate "Niagara2 Stream Processing Unit driver"
-       select CRYPTO_DES
-       select CRYPTO_BLKCIPHER
-       select CRYPTO_HASH
-       select CRYPTO_MD5
-       select CRYPTO_SHA1
-       select CRYPTO_SHA256
-       depends on SPARC64
-       help
+	tristate "Niagara2 Stream Processing Unit driver"
+	select CRYPTO_DES
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_HASH
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	depends on SPARC64
+	help
 	  Each core of a Niagara2 processor contains a Stream
 	  Processing Unit, which itself contains several cryptographic
 	  sub-units.  One set provides the Modular Arithmetic Unit,
@@ -324,15 +324,15 @@ config HW_RANDOM_PPC4XX
 	depends on CRYPTO_DEV_PPC4XX && HW_RANDOM
 	default y
 	---help---
-	 This option provides the kernel-side support for the TRNG hardware
-	 found in the security function of some PowerPC 4xx SoCs.
+	  This option provides the kernel-side support for the TRNG hardware
+	  found in the security function of some PowerPC 4xx SoCs.
 
 config CRYPTO_DEV_OMAP
 	tristate "Support for OMAP crypto HW accelerators"
 	depends on ARCH_OMAP2PLUS
 	help
 	  OMAP processors have various crypto HW accelerators. Select this if
-          you want to use the OMAP modules for any of the crypto algorithms.
+	  you want to use the OMAP modules for any of the crypto algorithms.
 
 if CRYPTO_DEV_OMAP
 
@@ -605,7 +605,7 @@ config CRYPTO_DEV_QCOM_RNG
 	  Generator hardware found on Qualcomm SoCs.
 
 	  To compile this driver as a module, choose M here. The
-          module will be called qcom-rng. If unsure, say N.
+	  module will be called qcom-rng. If unsure, say N.
 
 config CRYPTO_DEV_VMX
 	bool "Support for VMX cryptographic acceleration instructions"
diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 577c984..b904069 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -129,15 +129,15 @@ config CRYPTO_DEV_FSL_CAAM_AHASH_API
 	  will be called caamhash.
 
 config CRYPTO_DEV_FSL_CAAM_PKC_API
-        tristate "Register public key cryptography implementations with Crypto API"
-        default y
-        select CRYPTO_RSA
-        help
-          Selecting this will allow SEC Public key support for RSA.
-          Supported cryptographic primitives: encryption, decryption,
-          signature and verification.
-          To compile this as a module, choose M here: the module
-          will be called caam_pkc.
+	tristate "Register public key cryptography implementations with Crypto API"
+	default y
+	select CRYPTO_RSA
+	help
+	  Selecting this will allow SEC Public key support for RSA.
+	  Supported cryptographic primitives: encryption, decryption,
+	  signature and verification.
+	  To compile this as a module, choose M here: the module
+	  will be called caam_pkc.
 
 config CRYPTO_DEV_FSL_CAAM_RNG_API
 	tristate "Register caam device for hwrng API"
diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index b9dfae4..f9272ee 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -39,8 +39,8 @@ config CRYPTO_DEV_SP_PSP
 	default y
 	depends on CRYPTO_DEV_CCP_DD && X86_64
 	help
-	 Provide support for the AMD Platform Security Processor (PSP).
-	 The PSP is a dedicated processor that provides support for key
-	 management commands in Secure Encrypted Virtualization (SEV) mode,
-	 along with software-based Trusted Execution Environment (TEE) to
-	 enable third-party trusted applications.
+	  Provide support for the AMD Platform Security Processor (PSP).
+	  The PSP is a dedicated processor that provides support for key
+	  management commands in Secure Encrypted Virtualization (SEV) mode,
+	  along with software-based Trusted Execution Environment (TEE) to
+	  enable third-party trusted applications.
diff --git a/drivers/crypto/chelsio/Kconfig b/drivers/crypto/chelsio/Kconfig
index 930d82d..6f461d13 100644
--- a/drivers/crypto/chelsio/Kconfig
+++ b/drivers/crypto/chelsio/Kconfig
@@ -21,22 +21,22 @@ config CRYPTO_DEV_CHELSIO
 	  will be called chcr.
 
 config CHELSIO_IPSEC_INLINE
-        bool "Chelsio IPSec XFRM Tx crypto offload"
-        depends on CHELSIO_T4
+	bool "Chelsio IPSec XFRM Tx crypto offload"
+	depends on CHELSIO_T4
 	depends on CRYPTO_DEV_CHELSIO
-        depends on XFRM_OFFLOAD
-        depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
-        default n
-        ---help---
-          Enable support for IPSec Tx Inline.
+	depends on XFRM_OFFLOAD
+	depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
+	default n
+	---help---
+	  Enable support for IPSec Tx Inline.
 
 config CRYPTO_DEV_CHELSIO_TLS
-        tristate "Chelsio Crypto Inline TLS Driver"
-        depends on CHELSIO_T4
-        depends on TLS
-        select CRYPTO_DEV_CHELSIO
-        ---help---
-          Support Chelsio Inline TLS with Chelsio crypto accelerator.
+	tristate "Chelsio Crypto Inline TLS Driver"
+	depends on CHELSIO_T4
+	depends on TLS
+	select CRYPTO_DEV_CHELSIO
+	---help---
+	  Support Chelsio Inline TLS with Chelsio crypto accelerator.
 
-          To compile this driver as a module, choose M here: the module
-          will be called chtls.
+	  To compile this driver as a module, choose M here: the module
+	  will be called chtls.
diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
index 63aa78c..1197138 100644
--- a/drivers/crypto/stm32/Kconfig
+++ b/drivers/crypto/stm32/Kconfig
@@ -3,7 +3,7 @@ config CRYPTO_DEV_STM32_CRC
 	depends on ARCH_STM32
 	select CRYPTO_HASH
 	help
-          This enables support for the CRC32 hw accelerator which can be found
+	  This enables support for the CRC32 hw accelerator which can be found
 	  on STMicroelectronics STM32 SOC.
 
 config CRYPTO_DEV_STM32_HASH
@@ -16,7 +16,7 @@ config CRYPTO_DEV_STM32_HASH
 	select CRYPTO_SHA256
 	select CRYPTO_ENGINE
 	help
-          This enables support for the HASH hw accelerator which can be found
+	  This enables support for the HASH hw accelerator which can be found
 	  on STMicroelectronics STM32 SOC.
 
 config CRYPTO_DEV_STM32_CRYP
@@ -25,5 +25,5 @@ config CRYPTO_DEV_STM32_CRYP
 	select CRYPTO_HASH
 	select CRYPTO_ENGINE
 	help
-          This enables support for the CRYP (AES/DES/TDES) hw accelerator which
+	  This enables support for the CRYP (AES/DES/TDES) hw accelerator which
 	  can be found on STMicroelectronics STM32 SOC.
diff --git a/drivers/crypto/ux500/Kconfig b/drivers/crypto/ux500/Kconfig
index 0e338bf..eca3391 100644
--- a/drivers/crypto/ux500/Kconfig
+++ b/drivers/crypto/ux500/Kconfig
@@ -11,18 +11,18 @@ config CRYPTO_DEV_UX500_CRYP
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_DES
 	help
-        This selects the crypto driver for the UX500_CRYP hardware. It supports
-        AES-ECB, CBC and CTR with keys sizes of 128, 192 and 256 bit sizes.
+	This selects the crypto driver for the UX500_CRYP hardware. It supports
+	AES-ECB, CBC and CTR with keys sizes of 128, 192 and 256 bit sizes.
 
 config CRYPTO_DEV_UX500_HASH
-        tristate "UX500 crypto driver for HASH block"
-        depends on CRYPTO_DEV_UX500
-        select CRYPTO_HASH
+	tristate "UX500 crypto driver for HASH block"
+	depends on CRYPTO_DEV_UX500
+	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
-        help
-          This selects the hash driver for the UX500_HASH hardware.
-          Depends on UX500/STM DMA if running in DMA mode.
+	help
+	  This selects the hash driver for the UX500_HASH hardware.
+	  Depends on UX500/STM DMA if running in DMA mode.
 
 config CRYPTO_DEV_UX500_DEBUG
 	bool "Activate ux500 platform debug-mode for crypto and hash block"
-- 
1.9.1

