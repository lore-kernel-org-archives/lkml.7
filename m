Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC950C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E282173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfC1JYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:24:01 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:32598 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1JYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:24:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75c9c92a8f92-65a6a; Thu, 28 Mar 2019 17:23:52 +0800 (CST)
X-RM-TRANSID: 2ee75c9c92a8f92-65a6a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from dxhost1.openstacklocal (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95c9c92a86b6-f17f8;
        Thu, 28 Mar 2019 17:23:52 +0800 (CST)
X-RM-TRANSID: 2ee95c9c92a86b6-f17f8
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     rubini@gnudd.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/fmc: remove unneeded NULL check
Date:   Thu, 28 Mar 2019 17:23:17 +0800
Message-Id: <1553764997-26484-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable will check in debugfs_remove_recursive, so
the NULL check here is not needed

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fmc/fmc-debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 3293072..ab868a3 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -168,6 +168,5 @@ int fmc_debug_init(struct fmc_device *fmc)
 
 void fmc_debug_exit(struct fmc_device *fmc)
 {
-	if (fmc->dbg_dir)
-		debugfs_remove_recursive(fmc->dbg_dir);
+	debugfs_remove_recursive(fmc->dbg_dir);
 }
-- 
1.9.1



