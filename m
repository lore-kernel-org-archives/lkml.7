Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF32C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C96204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfCKNYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McY0J-1gVfFO2Ht7-00cxnC for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 090/114] certs: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:42 +0100
Message-Id: <1552310346-7629-91-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AH7+Le4QnMS0hpt31d5hTWamx0uXNrJ9Yw2updwRnCLucxQQLV6
 skJtdetGMe1sBpAo0NAEu9pPMWUtll98IRIpDdHilUiEkGNMiwH/7p32EDRisgRdKhZbYJ+
 gezWDz/bBxnI0gskXg55FNQ6CkIR7xbsERD+pWqJ48gl3eznqg1iP4TYOBoDRny9+pBc9YB
 z56Bcfguuy0j9Clu/edFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xT3zUN9VWIw=:rCdpwYvmnb2NYXNj8zP6nC
 tkZKR4+xUdSt2EAQNyRIHeb+XpW9XleSQQDVqkHpltTfHuUZ9tQMvm6K2pBcSIjh2CdvIMG3a
 8+wveob1/cAuJwKYRKUwJvVzRoI8wohZxH3JpNuK8J7pbcX6RJJvqbq37tW+8OrrqyeSolJkK
 I76mOtR/cZe7i3I6BvEo6lF2993ETVKoHlTqqZXmDUeNVjYjGbF4oLNgT3nIuJaploEMahiso
 4pwlOvwft9/2U4Mtoc0I7HXW3hxso18L/2YcUcRXTx0pbItsaBzTDkzHvVygodik6kwCQShLa
 +L32mT4VzqXEfGlOW2c2a1SzRq9dm2EIP4RJzRrdgJbtdQ3Hcfj89/JhYb/fQ3IuBuXZCu1gg
 L2umnR88qvscANp1zwy5PsCNl2kXjEIGDXXhaHQafeVgUfG5U1Zc9tIVyqMor23JwKTcqPOiH
 FfMH8Y9g7C026oqNLkBbSKR53NIk0Kyzr+nVKTvQ8EE9MQaxNqGS29jVbGc8FWUsuZAngGXOo
 QafhK6BcAnYLBL9yEDRp5tQh4W9UITeUQlL1ike3iv5nuenTKJ//ZK0Bk/xJuwVtlq59lExi1
 0sUoR0/63Jt2sv+Tduk34caEHxGy0wNKOZ1KMxEB9UNSrmylqBETRD5HQYZAkuMXxgXH2qneg
 sIJLqA5yAXRV/m9CQIP0g1I5/1S7EhfTUsu8m5uPZATdOTxYIbIe9qXZ8i7y1r7sVXKeDIRku
 sgHO+2gEjO8OV5uhW/Fx+6Jj8Zv9hybgxM3Ptg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 certs/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d..e8a5fd4 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -6,14 +6,14 @@ config MODULE_SIG_KEY
 	default "certs/signing_key.pem"
 	depends on MODULE_SIG
 	help
-         Provide the file name of a private key/certificate in PEM format,
-         or a PKCS#11 URI according to RFC7512. The file should contain, or
-         the URI should identify, both the certificate and its corresponding
-         private key.
+	  Provide the file name of a private key/certificate in PEM format,
+	  or a PKCS#11 URI according to RFC7512. The file should contain, or
+	  the URI should identify, both the certificate and its corresponding
+	  private key.
 
-         If this option is unchanged from its default "certs/signing_key.pem",
-         then the kernel will automatically generate the private key and
-         certificate as described in Documentation/admin-guide/module-signing.rst
+	  If this option is unchanged from its default "certs/signing_key.pem",
+	  then the kernel will automatically generate the private key and
+	  certificate as described in Documentation/admin-guide/module-signing.rst
 
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
-- 
1.9.1

