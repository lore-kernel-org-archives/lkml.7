Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DFF204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H/QNOBq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKWN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:43 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39545 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbka000733;
        Sat, 23 Nov 2019 22:27:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbka000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515659;
        bh=SAOvNT84T6xkejq7UF7LxRxPz4hv3O9WHTksxFtpRFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/QNOBq0Zk6CKGMqWoCEuAz2fi60YD1+FO7Lr7biE94WhZLYyRrERh3MlsKV4VoqM
         vQXAL5EjB4pVnLD1cTWeMikh0xCAqgo5KElZpCJ39tmQecK8dRGxtLFXfz8KD8Bx06
         c8EXuPkpm9sZU+J62WsE8gF073ii1xDfnaSTBKyLBJo3lOfVTNsbnCdp8cSAtl9yVF
         4q45wtiwY2e+dbeoEwPgVV+FpJX6VuLMl5rzSZuds6MxrI3+3l0o1Ec5tsDtOQIYZD
         v3nq+QU4PQkxY0oLAYRS0W5c0ccY0x41tYt2qJdiYnOAWrNGTz/va6auTdHtXkqS/Y
         M3IpqY7aeFojA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] scripts/kallsyms: remove unneeded #ifndef ARRAY_SIZE
Date:   Sat, 23 Nov 2019 22:27:12 +0900
Message-Id: <20191123132727.30151-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not defined in the standard headers. #ifndef is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ae6504d07fd6..918c2ba071b5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -24,9 +24,7 @@
 #include <ctype.h>
 #include <limits.h>
 
-#ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
-#endif
 
 #define KSYM_NAME_LEN		128
 
-- 
2.17.1

