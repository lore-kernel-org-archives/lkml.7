Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF2420656
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKRG7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:59:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63769 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbfKRG7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:59:17 -0500
X-IronPort-AV: E=Sophos;i="5.68,319,1569254400"; 
   d="scan'208";a="78655578"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Nov 2019 14:59:15 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 37245406AB15;
        Mon, 18 Nov 2019 14:50:55 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 18 Nov 2019 14:59:13 +0800
Received: from TSO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 18 Nov 2019 14:59:10 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [RESEND PATCH] x86/setup: Fix typos
Date:   Mon, 18 Nov 2019 15:00:12 +0800
Message-ID: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 37245406AB15.A53F5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOSen -> BIOSes; paing -> paging.
And improve comments via 640"Kb".

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
git client finally works after configuration update.

 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..56ac9ff12461 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -459,7 +459,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * due to mapping restrictions.
  *
  * On 64bit, kdump kernel need be restricted to be under 64TB, which is
- * the upper limit of system RAM in 4-level paing mode. Since the kdump
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
  * jumping could be from 5-level to 4-level, the jumping will fail if
  * kernel is put above 64TB, and there's no way to detect the paging mode
  * of the kernel which will be loaded for dumping during the 1st kernel
@@ -743,8 +743,8 @@ static void __init trim_bios_range(void)
 	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 
 	/*
-	 * special case: Some BIOSen report the PC BIOS
-	 * area (640->1Mb) as ram even though it is not.
+	 * special case: Some BIOSes report the PC BIOS
+	 * area (640Kb->1Mb) as ram even though it is not.
 	 * take them out.
 	 */
 	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM, 1);
-- 
2.21.0



