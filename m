Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF8C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DCF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h3ClMoxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHSHML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:12:11 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:47548 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfHSHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:12:10 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7J7BiPU027867;
        Mon, 19 Aug 2019 16:11:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7J7BiPU027867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566198705;
        bh=N38/4P10tJc8AmOp4/Ldol9wMCGoSQSXC5yLHUZWxsc=;
        h=From:To:Cc:Subject:Date:From;
        b=h3ClMoxxwGSMjKhoQqsQpGb+LKXbkAr3Izz/cRcMD6/TLigB0RXYX2auJ6G/XPxcj
         im22aLUQOBCu0FgfBZgsxXIPqrL366nijZN+zqVHOvNY44HELSnYGcaqC/onMTqYv+
         Z0ec56qthFbSwLrk4ogbn61aL55fL6tj17+rVK6UWj/wZKu+OqqF6XGvEANQElCz5b
         pvxhRfI+jOdctnAcWo2Jeiw8k8T4MKFyawDoIuGr9wiBRhTaTvkSHfpaAzQy25UXEr
         l9XZPTMBFyW4+c6GUwV3kXRPIrwWmhG8rWVZu6Fiti0lipSO84w40siSMbgDjVdEvm
         YwdYsLvayuWtQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] device_cgroup: add include guard to device_cgroup.h
Date:   Mon, 19 Aug 2019 16:11:33 +0900
Message-Id: <20190819071133.10588-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/device_cgroup.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 8557efe096dc..7c1d832d29a6 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_DEVICE_CGROUP_H
+#define _LINUX_DEVICE_CGROUP_H
+
 #include <linux/fs.h>
 #include <linux/bpf-cgroup.h>
 
@@ -77,3 +81,5 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 static inline int devcgroup_inode_mknod(int mode, dev_t dev)
 { return 0; }
 #endif
+
+#endif /* _LINUX_DEVICE_CGROUP_H */
-- 
2.17.1

