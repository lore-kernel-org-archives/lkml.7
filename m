Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35EEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE7E2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGBNIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:08:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfGBNIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:08:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 10F81FE92335F53B933A;
        Tue,  2 Jul 2019 21:08:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:08:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <dhowells@redhat.com>,
        <keescook@chromium.org>, <paul@paul-moore.com>,
        <zohar@linux.vnet.ibm.com>, <janne.karhunen@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] security: remove duplicated include from security.h
Date:   Tue, 2 Jul 2019 21:07:50 +0800
Message-ID: <20190702130750.35448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/security.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441a..4314477 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -30,7 +30,6 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/fs.h>
 
 struct linux_binprm;
 struct cred;
-- 
2.7.4


