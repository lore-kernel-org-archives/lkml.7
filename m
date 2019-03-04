Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6670720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U+Qv0/S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCDOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:37:29 -0500
Received: from m12-13.163.com ([220.181.12.13]:56335 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VbXM3sh8cBwZmYUc5p
        FiC2EdOF4544N9vYo6c3iC0xQ=; b=U+Qv0/S4WVlQ39+AfxAe8KXAOGsx5AsV+g
        AmUdVU5xWzwIZOUUdr6giupMdZHIgrLvRoNjbY1Kcdb+ajUVaOHeWSh9iYw/u74h
        PtjDYYyhERGT0WQnSPp9GknHFSqYfHSJv72c1gGhk2nATzVaydNLikYlwZ3WDWEV
        gN/3NPBOE=
Received: from yangwei-T440.lan (unknown [118.116.19.146])
        by smtp9 (Coremail) with SMTP id DcCowABHaJLfN31cyEC6Hw--.36866S3;
        Mon, 04 Mar 2019 22:36:16 +0800 (CST)
From:   Yang Wei <albin_yang@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yang.wei9@zte.com.cn, albin_yang@163.com
Subject: [PATCH] perf clang: fix semicolon code style issue
Date:   Mon,  4 Mar 2019 22:36:14 +0800
Message-Id: <1551710174-3349-1-git-send-email-albin_yang@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowABHaJLfN31cyEC6Hw--.36866S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UKw17GF15XFy7ZFyDGFg_yoW3CrX_Kw
        1xJF1Igry5ZFZ8Kw18uFWY9as5XryfXFWjvrnxGrZrGan5Ga15uF4UGFWvvF15GrW7Jr17
        ua1rury3Ar4UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbHUDJUUUUU==
X-Originating-IP: [118.116.19.146]
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbBEQBtolaD204JowAAs0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <yang.wei9@zte.com.cn>

Delete a superfluous semicolon in getBPFObjectFromModule().

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 tools/perf/util/c++/clang.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 39c0004..fc361c3 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -156,7 +156,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 #endif
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
+		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
 	}
 	PM.run(*Module);
 
-- 
2.7.4


