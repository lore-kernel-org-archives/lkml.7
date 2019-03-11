Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09496C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78022084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCKNWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYeV3-1hXm7b2XCN-00Vhhw for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 098/114] crypto: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:50 +0100
Message-Id: <1552310346-7629-99-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:4hp95NZW0hmp8MxFkslB0LsZaa0lcPc/mfAwSsFg0axQxLfu9x8
 GzQH+7YE9lmeKY/4p3bKGbhbQifG/xNQ4+XX2mu2T1KDOj9kHgmxVOws/hxCsLDhKIvMx6P
 UDIXIqGOOsVcwjqm2iPLy8ACtzg1NbQEFGkgN7WYvgrKnRq5m8oyGf0p0V66fZkQcb11MxI
 2m1ssqXgYFM+bGvG//EHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:soq7cR4TBI0=:IGLzfzec07Z9e8Y6fpdMER
 nxqaVn569pKIePqjhB9dsS4wwhZW0JIUBmo7rvpqT49AIE1k82k494zRI/sOu4fZv/iCcW21i
 /VG3zIsCGlz6qFkiJxTXPFy14cgKG+tdMP5QpoEnFyLyPpWZ7D6HN0YIx79gxTWQVK6Au0BGb
 7nh5/T5m6466ZB5a8x1S2bn/68OF+dz52MP9CENcznlIM22L7PKPYNAoD4XzqxJ5oDREMb3xj
 MZkEoQTJUKljkIoNsewhiB+R3xNUgXV1KUb5inmcSUh4BeHIvlv7pKcVD2VYTgpd48iPN0P29
 UePoPMc9PPZR9I9QXJYCkwa/ePaVDqPv5+GzK7xnHuoAkwMwr0Q1y/8CX8LxcYF9XH/upgmUI
 yNfR7AT8vPVmvacjfv9WdunLDtI8heguvfzZi38vp+u7xBGvu3QDC/j8QpzvAW4m17tR7Gzow
 h920BuePvllLWbTNiiphhryvjqJPLUhhyTKgGElKJ/I3SiD+lWFefL8uI65r9RBgdM8IILxQ0
 BV7LCyssKE2WwYw45W/qeuLzmfS+zD07UhuJeMc4h6GC6jLu0NMtIV+AQ4y71WJ/VTfnDZoEo
 DzLpYwLhUl7mjE2qnqJhQlpdWASakshNd428yT6brbhdCYvcjV3QbQTVcPMB/s75h4CI+qQWz
 Wh9uXr2qBZNHOp14X0eZZlbi9iPDXcwozau433Z5EbzmCPNpWQE87HBXCQA+qffL5dByKSH16
 GWIpujzQgVLSErp275fbQvYlLyl7JyDdUZVPMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 crypto/Kconfig | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index bbab6bf..3395b1a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -210,7 +210,7 @@ config CRYPTO_PCRYPT
 	  algorithm that executes in kernel threads.
 
 config CRYPTO_WORKQUEUE
-       tristate
+	tristate
 
 config CRYPTO_CRYPTD
 	tristate "Software async crypto daemon"
@@ -290,21 +290,21 @@ config CRYPTO_AEGIS128
 	select CRYPTO_AEAD
 	select CRYPTO_AES  # for AES S-box tables
 	help
-	 Support for the AEGIS-128 dedicated AEAD algorithm.
+	  Support for the AEGIS-128 dedicated AEAD algorithm.
 
 config CRYPTO_AEGIS128L
 	tristate "AEGIS-128L AEAD algorithm"
 	select CRYPTO_AEAD
 	select CRYPTO_AES  # for AES S-box tables
 	help
-	 Support for the AEGIS-128L dedicated AEAD algorithm.
+	  Support for the AEGIS-128L dedicated AEAD algorithm.
 
 config CRYPTO_AEGIS256
 	tristate "AEGIS-256 AEAD algorithm"
 	select CRYPTO_AEAD
 	select CRYPTO_AES  # for AES S-box tables
 	help
-	 Support for the AEGIS-256 dedicated AEAD algorithm.
+	  Support for the AEGIS-256 dedicated AEAD algorithm.
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
@@ -312,7 +312,7 @@ config CRYPTO_AEGIS128_AESNI_SSE2
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
-	 AESNI+SSE2 implementation of the AEGSI-128 dedicated AEAD algorithm.
+	  AESNI+SSE2 implementation of the AEGSI-128 dedicated AEAD algorithm.
 
 config CRYPTO_AEGIS128L_AESNI_SSE2
 	tristate "AEGIS-128L AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
@@ -320,7 +320,7 @@ config CRYPTO_AEGIS128L_AESNI_SSE2
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
-	 AESNI+SSE2 implementation of the AEGSI-128L dedicated AEAD algorithm.
+	  AESNI+SSE2 implementation of the AEGSI-128L dedicated AEAD algorithm.
 
 config CRYPTO_AEGIS256_AESNI_SSE2
 	tristate "AEGIS-256 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
@@ -328,7 +328,7 @@ config CRYPTO_AEGIS256_AESNI_SSE2
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
-	 AESNI+SSE2 implementation of the AEGSI-256 dedicated AEAD algorithm.
+	  AESNI+SSE2 implementation of the AEGSI-256 dedicated AEAD algorithm.
 
 config CRYPTO_MORUS640
 	tristate "MORUS-640 AEAD algorithm"
@@ -577,9 +577,8 @@ config CRYPTO_XCBC
 	select CRYPTO_MANAGER
 	help
 	  XCBC: Keyed-Hashing with encryption algorithm
-		http://www.ietf.org/rfc/rfc3566.txt
-		http://csrc.nist.gov/encryption/modes/proposedmodes/
-		 xcbc-mac/xcbc-mac-spec.pdf
+	        <http://www.ietf.org/rfc/rfc3566.txt>
+	        <http://csrc.nist.gov/encryption/modes/proposedmodes/xcbc-mac/xcbc-mac-spec.pdf>
 
 config CRYPTO_VMAC
 	tristate "VMAC support"
@@ -1830,7 +1829,7 @@ config CRYPTO_DRBG
 	select CRYPTO_RNG
 	select CRYPTO_JITTERENTROPY
 
-endif	# if CRYPTO_DRBG_MENU
+endif # if CRYPTO_DRBG_MENU
 
 config CRYPTO_JITTERENTROPY
 	tristate "Jitterentropy Non-Deterministic Random Number Generator"
@@ -1902,4 +1901,4 @@ source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
 
-endif	# if CRYPTO
+endif # if CRYPTO
-- 
1.9.1

