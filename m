Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C355C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6054205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfCFS53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:57:29 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfCFS53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:57:29 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1feo-1gvF080QlU-0121U9; Wed, 06 Mar 2019 19:57:24 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security: keys: Kconfig: pedantic cleanup
Date:   Wed,  6 Mar 2019 19:57:23 +0100
Message-Id: <1551898643-23397-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:+2KiWfNLxm2te2CzlTNLGK6zWDZZHusM6mEeNpGLsQdnzusuQyB
 a7OBqeUy65R8APvJUay9dmiJQD7IgsNiw/PQfCQUqu7izbHXFkLODr7eu3k+t7u3zXC+848
 BMQ4GOMkGAYeHNTUoXTbV8uDknx4VxycrH5YnoaX1zbIWrQC47OCgvSrY8yyjDNGdKmI9i6
 EvdjxCJHwYqsLAjhtr6KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6EipNPsbkY=:ZPvmUv57yEKlHtzjZLmQn+
 HPvYzajFGhrbPuzeSeXNRW0QRB3XYoRvoKIC+C1ou5MEaww03BjbC/rk922R5zV37c9oaaxLL
 3CKLzyKAT8qGumtNoAEpniz8Seh1Ohx4kGeb0ckiGGAsmtIJ7heGNqUsIF9igCvSNBo5nyemI
 ECgRPmoqCfASF+/5gy4rYHRfF2hjXJ73QeZtIiJxI3KGb3CyxGg8WpUVTjkZ7v0yxzdfvg4dI
 uSwInJfYrLgVIOi30mn41J4HsqRqq62dV1gHckTvehvZ03MdjnSy0pcn8QhQ+s2EpNYke07mB
 E66daDEJm6V06JsEk/r7HNH0ifbP/XT37Ql/sH0fpVyXUthLEpP4JDXamTiUErsUenIWuDq2h
 pn45WJyeNtUlNLORpwDL7r4znoAb6baQNGyXQFbt6mh45FllAeJnhxDwCf6EW5nJ8vGxasgKq
 5yT+bwy9nDsrI4fVpGnaUtjsqrPV5AcI7E1OzH/WvhcPOJHSDxMl0RE53mdn9HfADllM5KF8F
 jeltS8XQghCWj4pj0FK29zj+9bS2Er/AzWUvsT5Ov4aRW4wnSuxwG02DWZ/+IgdG4wWE1f367
 S3uc0+ZuQYyd7q1Gd4u4RJophi4hThvC2U5t+sOoI3cdr2redLLADgwe9RPDGFEYOFEBbnSdR
 9+xSaqKLMzUuF0C8btWJ6mQBddxHNCQjMH6z8y+JbSJ2Aw0l3W4/IFhBjcO96/PTNXpDGe6nb
 ozcGEvuRfwX9OuVnNzP4EQfNfGjAUZyobgs3/iotGiu5a/b6ETb4bE7ydSKFTsoN0bICPn4Ur
 Z99+V4mQiWRS7xyqUGdbEUFA3a6mGeC+syBbzt51XxaHoIXhcfK+84HP5DpQHjpE87Ir4rXX5
 ZCRSrviykt9ndZ3LRiw7y058C9TvGR56BIkXwOrtfQRGUHtTzU8NycsAC14Rar96khquvVfQw
 VXloFa5C2bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 security/keys/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 6462e66..6594149 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -90,14 +90,14 @@ config ENCRYPTED_KEYS
 	  If you are unsure as to whether this is required, answer N.
 
 config KEY_DH_OPERATIONS
-       bool "Diffie-Hellman operations on retained keys"
-       depends on KEYS
-       select CRYPTO
-       select CRYPTO_HASH
-       select CRYPTO_DH
-       help
-	 This option provides support for calculating Diffie-Hellman
-	 public keys and shared secrets using values stored as keys
-	 in the kernel.
-
-	 If you are unsure as to whether this is required, answer N.
+	bool "Diffie-Hellman operations on retained keys"
+	depends on KEYS
+	select CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_DH
+	help
+	  This option provides support for calculating Diffie-Hellman
+	  public keys and shared secrets using values stored as keys
+	  in the kernel.
+
+	  If you are unsure as to whether this is required, answer N.
-- 
1.9.1

