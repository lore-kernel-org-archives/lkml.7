Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F561C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543B8208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="S4kl0Yq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394147AbfIUNTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 09:19:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24022 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbfIUNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 09:19:00 -0400
Received: from grover.flets-west.jp (softbank126021098169.bbtec.net [126.21.98.169]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x8LDImo3014366;
        Sat, 21 Sep 2019 22:18:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x8LDImo3014366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569071928;
        bh=XVVno40agGdniDiS2Ob/nbsE/04CiPA8IGTW3qDnaaA=;
        h=From:To:Cc:Subject:Date:From;
        b=S4kl0Yq91pVQxQ2NUslSds3FW/yAC1ZqRjhDqIFJ1kUwOVU+9zPnxPdTBy4pfblDd
         sUtFZwefHABK29hcFFJEqMJnBpOhQ9ieqWRfL3ckjocYBG9cdVbdM4l8LBWPt44j1O
         ZjnW8AFLge6yxGiPyuDuyRyl16lWmvH7f5xgTgw5QsyKQltQjwgudQxWES/gLnvXAg
         JsW1CFb27W5cbvkHHY3y7+n2nPZTHP7mJjArD48zFOCSdVGxxXR4frX5Ajz0+RDFTa
         aoOIPhuIF50TiCKW6rnrbT/ggdrG+5tiHHRqCfRS0yFTtFTQAZn0030b/1XjKRhTFy
         k/sVfRpuJs+sA==
X-Nifty-SrcIP: [126.21.98.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: update comment about KBUILD_ALLDIRS
Date:   Sat, 21 Sep 2019 22:18:46 +0900
Message-Id: <20190921131846.18981-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 000ec95fbe75 ("kbuild: pkg: rename scripts/package/Makefile to
scripts/Makefile.package") missed to update this comment.

Fixes: 000ec95fbe75 ("kbuild: pkg: rename scripts/package/Makefile to scripts/Makefile.package")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6206cd358411..4808377f2db8 100644
--- a/Makefile
+++ b/Makefile
@@ -1037,7 +1037,7 @@ export KBUILD_VMLINUX_OBJS := $(head-y) $(init-y) $(core-y) $(libs-y2) \
 export KBUILD_VMLINUX_LIBS := $(libs-y1)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
-# used by scripts/package/Makefile
+# used by scripts/Makefile.package
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) LICENSES arch include scripts tools)
 
 vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
-- 
2.17.1

