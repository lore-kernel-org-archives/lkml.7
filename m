Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3921FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB42218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfDRRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:39:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:39:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hHAzx-0008PQ-Im; Thu, 18 Apr 2019 17:38:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kprobes: fix spelling mistake "undefeined" -> "undefined"
Date:   Thu, 18 Apr 2019 18:38:57 +0100
Message-Id: <20190418173857.31285-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake on the TEST_UNSUPPORTED macro. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/probes/kprobes/test-thumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
index b683b4517458..6841909757cd 100644
--- a/arch/arm/probes/kprobes/test-thumb.c
+++ b/arch/arm/probes/kprobes/test-thumb.c
@@ -787,7 +787,7 @@ CONDITION_INSTRUCTIONS(22,
 
 	TEST_UNSUPPORTED(__inst_thumb32(0xf7f08000) " @ smc #0")
 
-	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefeined")
+	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefined")
 
 	TEST_BF(  "b.w	2f")
 	TEST_BB(  "b.w	2b")
-- 
2.20.1

