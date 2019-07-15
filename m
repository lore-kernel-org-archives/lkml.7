Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57AFC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B939A2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfGOQS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:18:56 -0400
Received: from mail.coding4coffee.org ([5.9.171.142]:43678 "EHLO
        mail.coding4coffee.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:18:56 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 12:18:55 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.coding4coffee.org (Postfix) with ESMTP id E5956D69;
        Mon, 15 Jul 2019 18:09:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at coding4coffee.org
Received: from mail.coding4coffee.org ([127.0.0.1])
        by localhost (mail.coding4coffee.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tuBPWevrCjfZ; Mon, 15 Jul 2019 18:09:14 +0200 (CEST)
Received: from coding4coffee.org (unknown [46.114.39.130])
        by mail.coding4coffee.org (Postfix) with ESMTPSA id B761EC8;
        Mon, 15 Jul 2019 18:09:13 +0200 (CEST)
From:   Fabian Mewes <architekt@coding4coffee.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabian Mewes <architekt@coding4coffee.org>
Subject: [PATCH] MIPS: Kconfig: remove HAVE_LATENCYTOP_SUPPORT
Date:   Mon, 15 Jul 2019 18:08:49 +0200
Message-Id: <20190715160849.25964-1-architekt@coding4coffee.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE_LATENCYTOP_SUPPORT was removed all together in da48d094ce5d7.
This commit removes a leftover in the MIPS Kconfig.

Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
---
 arch/mips/Kconfig |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd..4958734 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3069,10 +3069,6 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-config HAVE_LATENCYTOP_SUPPORT
-	bool
-	default y
-
 config PGTABLE_LEVELS
 	int
 	default 4 if PAGE_SIZE_4KB && MIPS_VA_BITS_48
-- 
2.11.0

