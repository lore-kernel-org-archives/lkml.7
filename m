Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683E121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDCGDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:03:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10725 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbfDCGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:03:33 -0400
X-IronPort-AV: E=Sophos;i="5.60,303,1549900800"; 
   d="scan'208";a="58362123"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2019 14:03:31 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id DB66A4CD7FDE;
        Wed,  3 Apr 2019 14:03:31 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 3 Apr 2019 14:03:29 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <jlayton@kernel.org>, <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] fcntl header: drop duplicate O_NDELAY
Date:   Wed, 3 Apr 2019 14:03:37 +0800
Message-ID: <20190403060337.9765-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: DB66A4CD7FDE.AEBD2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop it from VALID_OPEN_FLAGS.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 include/linux/fcntl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index d019df946cb2..8a2ca434be6d 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -6,8 +6,8 @@
 
 /* list of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
-	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
-	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
+	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | \
+	 O_TRUNC | O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
-- 
2.17.2



