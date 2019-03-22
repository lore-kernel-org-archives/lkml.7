Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4363FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13456218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q5CN6eaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCVPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:22:17 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25326 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfCVPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:22:16 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2MFLktT010380;
        Sat, 23 Mar 2019 00:21:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2MFLktT010380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553268107;
        bh=kw8squKqVw0XX54bBQuXnFBXBdFYvAYOJPYRgTnwFb0=;
        h=From:To:Cc:Subject:Date:From;
        b=q5CN6eaLAqSmc25e7nyjuPfCpP544SYQsa7mNSEoD4zTc8lPzPpWA4wnz7J6zns87
         kCnNaIIhesa24J67YK1d7EmQkfSet+9ob+b64lXSAO9/E7k8yzqFgDx6tkUqVyErbz
         HnqF+X1CeuskAL+UyIsM1h2JuGCUfZ+u8oCe+X1GIEf9j9OWImq7oxBDFh6vO+gvUm
         og6DfccguSWfB+52q8uadigf5n1IGD6pEuAY0VKDkijR2fqOlEZv3oQPc/nBqvr2uP
         FC61YvmieSW9JNHN8FpyWREkttKm96xLVBz8e4Zo+1AP2FuiSOtaAWwQ+btBY09M0d
         ce65kIUNwX4pw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nickhu <nickhu@andestech.com>
Subject: [PATCH] nds32: remove unused generic-y += cmpxchg-local.h
Date:   Sat, 23 Mar 2019 00:21:41 +0900
Message-Id: <1553268101-18742-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NDS32 is the only architecture that creates <asm/cmpxchg-local.h>,
which is not included anyone.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nds32/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 7ef8695..c131e0e 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
 generic-y += cmpxchg.h
-generic-y += cmpxchg-local.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
-- 
2.7.4

