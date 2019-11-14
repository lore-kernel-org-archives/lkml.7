Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3AA206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNDpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:45:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKNDpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:45:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41F804A8649434657F94;
        Thu, 14 Nov 2019 11:45:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 11:45:08 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <andriin@fb.com>,
        <davem@davemloft.net>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH net] bpf: doc: change right arguments for JIT example code
Date:   Thu, 14 Nov 2019 11:43:51 +0800
Message-ID: <20191114034351.162740-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example codes for JIT of x86_64, use wrong
arguments to when call function bar().

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 Documentation/networking/filter.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index 319e5e0..c4a328f 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -770,10 +770,10 @@ Some core changes of the new internal format:
     callq foo
     mov %rax,%r13
     mov %rbx,%rdi
-    mov $0x2,%esi
-    mov $0x3,%edx
-    mov $0x4,%ecx
-    mov $0x5,%r8d
+    mov $0x6,%esi
+    mov $0x7,%edx
+    mov $0x8,%ecx
+    mov $0x9,%r8d
     callq bar
     add %r13,%rax
     mov -0x228(%rbp),%rbx
-- 
2.7.4

