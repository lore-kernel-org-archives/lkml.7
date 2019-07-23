Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B002070B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PdVCcOmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfGWLaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:30:12 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:63182 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfGWLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:30:11 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6NBTT9t009036;
        Tue, 23 Jul 2019 20:29:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6NBTT9t009036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881370;
        bh=pnEKyqfOAohbNR2Gvql1ZArOB+TAbhx27FzF/o9Fefw=;
        h=From:To:Cc:Subject:Date:From;
        b=PdVCcOmgrIK98mD62eH5TYnpnYxkPnNxQXMzBqssPyBsvhlH0A+G3uSD7SRVQM0Xh
         5NJqxMGP4RgedFyZpmY/zrg8JPTHUSz7ukuoKj/z2gV6OeB7wTlJaYrVb3Guh03Lwp
         0vH0qvfUeDIaWF7DbnuOuUphHV4pxpMKeY3X/ATYAaBZviMApHs1IZ7YRNj9o2PoCu
         Cjz7K3+tTCGS3VrYjKAkWujGkqvsAEsW7+Dy80A1RYR1hIRLNNsMcGcE6FN+v8Bauq
         zDW1fMBbdgM+QkKO1ccNKAhBz9BPFurNIVlSQAV+ltWxlqRBUXBeZRp3NfMM/375Tw
         pRzsdLROehVhg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: remove unneeded uapi/asm/stat.h
Date:   Tue, 23 Jul 2019 20:29:22 +0900
Message-Id: <20190723112922.14315-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stat.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/include/uapi/asm/stat.h | 17 -----------------
 1 file changed, 17 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/stat.h

diff --git a/arch/arm64/include/uapi/asm/stat.h b/arch/arm64/include/uapi/asm/stat.h
deleted file mode 100644
index 313325fa22fa..000000000000
--- a/arch/arm64/include/uapi/asm/stat.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include <asm-generic/stat.h>
-- 
2.17.1

