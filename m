Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34230C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090D720719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jMRMBPFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKWN2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39541 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:27:59 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkp000733;
        Sat, 23 Nov 2019 22:27:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkp000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515666;
        bh=luGOrRAMG4Y9tsglVetzZHHjl9Wj2M3UbgJuHFlQLIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMRMBPFrPMoV8uQ78+xnQ35IvxVtduNrPhP2JftuIYO2wGY19bLTLM8/BXv6Kitjj
         W8x8Q80hpb4vGpG3kIkjQcZ2hop9KiCCKDk+JF0ALU3C+YOG9B3cp3+ZTTNv9LSMFk
         jQqfBwdJgzMZCz6IUzVjp99fJQxIAWw4J21QSOlCDHdABx6tXus5NlkTbKfFAq6WPy
         I4ubZdVGYezT1WzhxXHFmoF+EIXRem6Yz6cesRgwkZn+8QI3xYGLtEle9EhtrQnVXq
         WvKg1JZIZM8L2u1TLCOY6AMhaw7g8+GM8HjPCllzCx4D+pXUDCwnKeGN41P9jJSnum
         OAw6nhJ4E7RvA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] scripts/kallsyms: remove redundant initializers
Date:   Sat, 23 Nov 2019 22:27:27 +0900
Message-Id: <20191123132727.30151-17-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are set to zero without the explicit initializers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 22ff206e2533..803df71e5069 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -57,9 +57,9 @@ static struct addr_range percpu_range = {
 
 static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
-static int all_symbols = 0;
-static int absolute_percpu = 0;
-static int base_relative = 0;
+static int all_symbols;
+static int absolute_percpu;
+static int base_relative;
 
 static int token_profit[0x10000];
 
-- 
2.17.1

