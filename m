Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0000C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6B221907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfISG35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:29:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387929AbfISG35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:29:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B89A9442E70042431BFE;
        Thu, 19 Sep 2019 14:29:55 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 19 Sep
 2019 14:29:48 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] MAINTAINERS: erofs: complete sub-entries for erofs
Date:   Thu, 19 Sep 2019 14:28:38 +0800
Message-ID: <20190919062838.106423-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a formal git tree and missing files for erofs
after moving out of staging for everyone to blame
in order for better improvement.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b6f10ea1573..a3822e1866d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6088,7 +6088,10 @@ M:	Gao Xiang <gaoxiang25@huawei.com>
 M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
+F:	Documentation/filesystems/erofs.txt
 F:	fs/erofs/
+F:	include/trace/events/erofs.h
 
 ERRSEQ ERROR TRACKING INFRASTRUCTURE
 M:	Jeff Layton <jlayton@kernel.org>
-- 
2.17.1

