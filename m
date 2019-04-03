Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8C1206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0X295gtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDCIgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:36:39 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:48049 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:36:37 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x338a6Ul026202;
        Wed, 3 Apr 2019 17:36:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x338a6Ul026202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554280567;
        bh=ssbkUIua/m/+5zOWSQm0W4YQV+JTIDw1jpSReeX7BRg=;
        h=From:To:Cc:Subject:Date:From;
        b=0X295gtfS9DwwP9iyHtne4INLt28FFOfru4OQZYUYCJIZNMlAG0NLLoqcvOqbHE8a
         O/mFh+WY7iHAmNZHiBYQ9OTU3A0b6AKwt/QoXDr2AEheF5aMPcBjZO8nW9bPpN4/qw
         RLu9j4H/T9MGX30Q/3rifNAbVrPIJNdNgHegEuLBQFN0ZVb7IlQMO1RJFqE3cJdmX0
         8xgAs1pZjMe0GszLGTKgWGlbodvgSdWjbCp2UsxkexltWBhOFp05I9HvfQrBt7gZ2b
         nUc2TQ3/10NHgSTgHShVuHh6pSBL2aqS8VPoc/bC/2iNM0xqSqfv0/SAEi0SXpUVBx
         Zr7rsrrj5livg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] nds32: add vmlinux.lds and vdso.so to .gitignore
Date:   Wed,  3 Apr 2019 17:35:45 +0900
Message-Id: <1554280545-11318-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are build artifacts, which should be ignored by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nds32/kernel/.gitignore      | 1 +
 arch/nds32/kernel/vdso/.gitignore | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 arch/nds32/kernel/.gitignore
 create mode 100644 arch/nds32/kernel/vdso/.gitignore

diff --git a/arch/nds32/kernel/.gitignore b/arch/nds32/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/nds32/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
diff --git a/arch/nds32/kernel/vdso/.gitignore b/arch/nds32/kernel/vdso/.gitignore
new file mode 100644
index 0000000..f8b69d8
--- /dev/null
+++ b/arch/nds32/kernel/vdso/.gitignore
@@ -0,0 +1 @@
+vdso.lds
-- 
2.7.4

