Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C74C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C20920821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDPK6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:58:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:58:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGLmh-0007HM-Ds; Tue, 16 Apr 2019 10:57:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/Kconfig: fix spelling mistake "effectivness" -> "effectiveness"
Date:   Tue, 16 Apr 2019 11:57:51 +0100
Message-Id: <20190416105751.18899-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The Kconfig text contains a spelling mistake, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bbd26f68ef56..baefe76481b8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1502,7 +1502,7 @@ config X86_CPA_STATISTICS
 	depends on DEBUG_FS
 	---help---
 	  Expose statistics about the Change Page Attribute mechanims, which
-	  helps to determine the effectivness of preserving large and huge
+	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
 config ARCH_HAS_MEM_ENCRYPT
-- 
2.20.1

