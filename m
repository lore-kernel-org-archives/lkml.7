Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F301220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfCKNTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mj8eB-1gXsAx2Ikv-00f9eo for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 022/114] security: keys: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:34 +0100
Message-Id: <1552310346-7629-23-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3xbV75g4gAW8vahpPwED+P5HjM5JVu2hIvgd4ACuiNb0EvsREtJ
 FYHHlR1rV/YryiyOdt7yD8NekWPerVjy6E2EcqnCZihnk+a2amoJfYk85bu4bt7VUP/JkwQ
 1Qwdd32ufjOn6Ru3ZoceJhtErqmqnYnWmphU2iJicDRJNZeaHdzJtymW6qteZe4HJebuS+v
 NdPBocIs5MVXhmeS+SLFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5SNyAZqwDY=:6C+hNVx/WyntvKqSTymWeq
 3bQrPOeB9BEcS+EEgBGiKA9JjuPLNa1GfV7fngqX5X7agt1FHqVBa6tEDK8SsOEd98BeAxdna
 5FQQcKkC81J7gzgILwg4UNDWwEIZ4O9ivLyugRj/YBz+jUHOIsSncSg+fM9S9zP+ERkXaJf3P
 z5XNtQw/I79tKdh5bIVNOKZC2+JKLGNmCbN5aFfxriRNS61ABDRrKtGUN+7n1kISCAnbWdBVb
 tAaE+p0+aZV9yUfnqi4IGzsv1BAvRsZONIsdqhyxaH+XKAn+7aN1I34UvqwjKw4jNMfNVN+UM
 0OA7cSOjzkD7xs0Qnl9LzSnk7bvy5xAD30NzcS1ixwaudroJ2oc5rCTW3UJmjOO2at1ZJ6haN
 eOmbP2XTCOl5QZL9tAjDoZnH//RzlWcTv9JVkTHAK8WoZYUdM2Tbh8EeTn3hYM0ss/rTVs9Li
 dISD+N1m2arycGUaxc/t5z7WvKWbGPsQXEVjoswU4vQtrAM+JtvGMev61+ooWvhxc4eBRfYDG
 QTKMVwelaogyirFte2o1mF1vlC9wMt3vXNIUK0aAUkWpxOmIVR0xMUeSqXOOm4YFEzeJizy4u
 dFdGBbF6LtRN4Am+eb7DgINcuvp3UvIxtwXeGA/2SjwyRAVutozQluosDR8dYTOc6Rb/PhIK/
 sJBqR7Ivh1+u1N7WCAgJJ01Fxh6L7cqEOVIBfBAPeMx6jMRRqqVGJ1ScDiku5d1V1+K4XakCK
 yPeBtdu1+4DNEZA5oyXzqCcIriln7KFfjZh83g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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

