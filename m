Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF7C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A383020693
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G+6MmYEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfILLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:45:17 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:18674 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:45:16 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x8CBjAt4004032;
        Thu, 12 Sep 2019 20:45:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x8CBjAt4004032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568288711;
        bh=2M0up4LIeskg9YqU1k+TvAhbbcDxiQlSbhzZNes/4oA=;
        h=From:To:Cc:Subject:Date:From;
        b=G+6MmYEkGnAIxvxzMl5N3hOvusWHTCef8jFSmQSmT5nPjHMq7t8OTfLdnl3KNRTi+
         MS5iPWLogF8BepwTGo59Ol8rRpFchlTGMZz5oJm0VyQ2Yyv/In2wW5NY3auk15MJ3h
         J8KdqzdQGQGWDUAWQ7LPPSPzGe1m5zz/RDAWwSLMs6495DZRh8ftHHINvvV0Tzp4Yx
         3N69zDr9L0fIhkcb190LrO8CYGaWGr2RdE/sktKXda7ecqNtahLsx8Z0IKugP6cXJ6
         Qm+1JMwDHOW7o5hidnOkCRj+I2qa4hFo05ibzA5tthjZVh4X8qAdtL4tdyFyk3KMX0
         vSww5DHwspy5A==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] genksyms: convert to SPDX License Identifier for lex.l and parse.y
Date:   Thu, 12 Sep 2019 20:45:07 +0900
Message-Id: <20190912114507.6699-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I used the C comment style (/* ... */) for the flex and bison files
as in Kconfig (scripts/kconfig/{lexer.l,parser.y})

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/genksyms/lex.l   | 32 ++++++++++----------------------
 scripts/genksyms/parse.y | 32 ++++++++++----------------------
 2 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/scripts/genksyms/lex.l b/scripts/genksyms/lex.l
index d29c774f51b6..e265c5d96861 100644
--- a/scripts/genksyms/lex.l
+++ b/scripts/genksyms/lex.l
@@ -1,25 +1,13 @@
-/* Lexical analysis for genksyms.
-   Copyright 1996, 1997 Linux International.
-
-   New implementation contributed by Richard Henderson <rth@tamu.edu>
-   Based on original work by Bjorn Ekwall <bj0rn@blox.se>
-
-   Taken from Linux modutils 2.4.22.
-
-   This program is free software; you can redistribute it and/or modify it
-   under the terms of the GNU General Public License as published by the
-   Free Software Foundation; either version 2 of the License, or (at your
-   option) any later version.
-
-   This program is distributed in the hope that it will be useful, but
-   WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundation,
-   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
-
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Lexical analysis for genksyms.
+ * Copyright 1996, 1997 Linux International.
+ *
+ * New implementation contributed by Richard Henderson <rth@tamu.edu>
+ * Based on original work by Bjorn Ekwall <bj0rn@blox.se>
+ *
+ * Taken from Linux modutils 2.4.22.
+ */
 
 %{
 
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index 1ebcf52cd0f9..e22b42245bcc 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -1,25 +1,13 @@
-/* C global declaration parser for genksyms.
-   Copyright 1996, 1997 Linux International.
-
-   New implementation contributed by Richard Henderson <rth@tamu.edu>
-   Based on original work by Bjorn Ekwall <bj0rn@blox.se>
-
-   This file is part of the Linux modutils.
-
-   This program is free software; you can redistribute it and/or modify it
-   under the terms of the GNU General Public License as published by the
-   Free Software Foundation; either version 2 of the License, or (at your
-   option) any later version.
-
-   This program is distributed in the hope that it will be useful, but
-   WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundation,
-   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
-
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * C global declaration parser for genksyms.
+ * Copyright 1996, 1997 Linux International.
+ *
+ * New implementation contributed by Richard Henderson <rth@tamu.edu>
+ * Based on original work by Bjorn Ekwall <bj0rn@blox.se>
+ *
+ * This file is part of the Linux modutils.
+ */
 
 %{
 
-- 
2.17.1

