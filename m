Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F4C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9473320644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bNcnoEEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfGWLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:31:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:16437 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:31:53 -0400
X-Greylist: delayed 13295 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 07:31:52 EDT
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6NBUlfL009979;
        Tue, 23 Jul 2019 20:30:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6NBUlfL009979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881448;
        bh=ek5fX7jirXhSrc0zijLJq9soxIn74LwbNyps/vviFNE=;
        h=From:To:Cc:Subject:Date:From;
        b=bNcnoEEt/rqgRZ2oyKDGrXH7Dm5JZERdwXRP8IKPxB3rFTaio12i1LKtVKPMlcnN6
         8DWweeWlEVuHeKiHflIT9Zr+J57+jzktfr8bcpt90/ZGk5uF2EvU8cIZcPSNy++E5N
         pmAlViyfNd7kMo/2RB20ziIuDoOPlOXdGVfz4nD6ckOhQOmgKpXNlKB7d1+Z/wx5I2
         mCSoZpsniF6ubZqDq35r3GXKn1Za1m25NvPadKWxommFWQdmsu+T3vBwz1TzyloUKz
         RP20AAAV5s3j5BigWJP9MDr3oPlUcyWxQqyb0P0H7z6iACrR5lkJmybbcJjLu3WexW
         9TBHBwgX+JhpQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove unneeded uapi asm-generic wrappers
Date:   Tue, 23 Jul 2019 20:30:36 +0900
Message-Id: <20190723113036.14576-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/uapi/asm/setup.h | 2 --
 arch/sh/include/uapi/asm/types.h | 2 --
 2 files changed, 4 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/setup.h
 delete mode 100644 arch/sh/include/uapi/asm/types.h

diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
deleted file mode 100644
index 4bd19f80f9b0..000000000000
--- a/arch/sh/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/setup.h>
diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
deleted file mode 100644
index 68100e108ea6..000000000000
--- a/arch/sh/include/uapi/asm/types.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/types.h>
-- 
2.17.1

