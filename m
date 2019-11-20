Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8821822529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257105;
	bh=1Y8Y9+h/5x7XSU+qi38AKjd0Z798Std1Vl6r4SrMKYw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZzrazD1Woraiq5vhLiOxTjk/osTEKQunLLQbb46MZaEwAOel6Fx5sUAQNUJNoP4Bl
	 m4r+JxNnaxHkU/8IcmSys+oP6Riiz+VqZjQH6a0YcWO7AYoKy1ZyYlRC5PF0SbmuSd
	 hb0cCJa69VcPXr6M2p/xBrwxnRTqqh+WHDhge+/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfKTNiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfKTNiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:21 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F5B22529;
        Wed, 20 Nov 2019 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257101;
        bh=1Y8Y9+h/5x7XSU+qi38AKjd0Z798Std1Vl6r4SrMKYw=;
        h=From:To:Cc:Subject:Date:From;
        b=N3z6xeqkkWSjHXcrtqTrxqijWDtRG0dJ4gjhN53p45j+riq5MyrOSYSbLizAm/OrG
         ybwxJVy1Xnu0SI6Hb2HBzO6HN984r5FjzDh3078uhRG+YbI9nH94AbAbGyqcjxzUkm
         0U5mBVmDpJImRQ3L4olSMeuX/ZohQ6EXOV9mFHUk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH] certs: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:17 +0800
Message-Id: <20191120133817.12854-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 certs/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..0358c66d3d7c 100644
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
+	 Provide the file name of a private key/certificate in PEM format,
+	 or a PKCS#11 URI according to RFC7512. The file should contain, or
+	 the URI should identify, both the certificate and its corresponding
+	 private key.
 
-         If this option is unchanged from its default "certs/signing_key.pem",
-         then the kernel will automatically generate the private key and
-         certificate as described in Documentation/admin-guide/module-signing.rst
+	 If this option is unchanged from its default "certs/signing_key.pem",
+	 then the kernel will automatically generate the private key and
+	 certificate as described in Documentation/admin-guide/module-signing.rst
 
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
-- 
2.17.1

