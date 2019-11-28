Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D0BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A874D215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfK1AuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:50:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726947AbfK1AuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:50:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5813DA9AF3017E5ACBF;
        Thu, 28 Nov 2019 08:50:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 28 Nov 2019 08:49:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <pmladek@suse.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tj@kernel.org>, <arnd@arndb.de>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/4] printk: Drop pr_warning definition
Date:   Thu, 28 Nov 2019 08:47:51 +0800
Message-ID: <20191128004752.35268-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all pr_warning are removed, saftely drop pr_warning definition.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/printk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index c09d67edda3a..1e6108b8d15f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -302,9 +302,8 @@ extern int kptr_restrict;
 	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_err(fmt, ...) \
 	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warning(fmt, ...) \
+#define pr_warn(fmt, ...) \
 	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warn pr_warning
 #define pr_notice(fmt, ...) \
 	printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info(fmt, ...) \
-- 
2.20.1

