Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522FC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E9E223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LtHWgw9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfGWK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:28:14 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26183 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbfGWK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:28:13 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6NAS1IM019895;
        Tue, 23 Jul 2019 19:28:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6NAS1IM019895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563877681;
        bh=RM09kFBEe9BZQtN3E3JSIzmta5teq7cqqcqSj788ATE=;
        h=From:To:Cc:Subject:Date:From;
        b=LtHWgw9ndkNfnBP7+YBATh8JEff8HQSoUgI+WJNB1zSu6ClaDf+Tdbvfm83I4xZW9
         3UJJcrnIEmgTUE+gXCPk+JsGj87bFyKEnBw2UyIiLNNAf6ZKXpwRAE62MW8MlcGnW/
         Y0dBS46D+74X/sg5bgcbaV2m1YLM0mqFe6okudhwuv8/6151Va/7pBT7Q0rmVpeZ70
         OQaxqeiWoqvGHl0pJa+4rOJ2BYHAaTdLH9x6uDlLxSraWx+/QxlW4GYsQxdXgSPjjO
         xMUJlwIdE3Ah84r00uQD8LaVNSdgE1JpmiD9W6m6fNN3LE/O6EDGgQwdYC42fS2N9U
         qH7yqHNbA801Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: remove asm/bitsperlong.h
Date:   Tue, 23 Jul 2019 19:27:45 +0900
Message-Id: <20190723102745.13165-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hexagon-specific bitsperlong.h so that it falls back to
include/uapi/asm-generic/bitsperlong.h

Kbuild will automatically create a wrapper of it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/hexagon/include/uapi/asm/bitsperlong.h | 27 ---------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 arch/hexagon/include/uapi/asm/bitsperlong.h

diff --git a/arch/hexagon/include/uapi/asm/bitsperlong.h b/arch/hexagon/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 5adca0d26913..000000000000
--- a/arch/hexagon/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef __ASM_HEXAGON_BITSPERLONG_H
-#define __ASM_HEXAGON_BITSPERLONG_H
-
-#define __BITS_PER_LONG 32
-
-#include <asm-generic/bitsperlong.h>
-
-#endif
-- 
2.17.1

