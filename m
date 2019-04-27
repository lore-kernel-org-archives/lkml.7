Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F2206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zOZSCXYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:17159 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3R3XieB029345;
        Sat, 27 Apr 2019 12:33:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3R3XieB029345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556336026;
        bh=Lp3Gmg6qyYoJ/Ao3+VN9R6sCvvcCE+oPZMkiRMOz9Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOZSCXYfGx6pHD3NFafX2uMdIOT7CxsicDg/SHVioY/XHQ6+kk+yAl1aQIyTthnO+
         2EwvYORXo1SQ/LcgVoh73PokeUES7b9iLEKxk8IBqtFMuYbOMAB1wBeaOqpWF8FO16
         CabY9I82dOr/EsH1pxxL8fT6cZKfDTCeCrwZaeLRJkyLwtIQMbJlPecjcLAQ+t4Z8D
         fvEYQAPWb+AYTfcgiAiCQphmO7QOr+RkABNlQCg2XAcnjU/IrcGmUrPrF1dhMH9GHi
         5hmgh+WKQ/sP0+Lb5x4CCwC8ts+BxaeOrMO6w0sgTPtUCiCGhmMC5jFgRQ6b1VDd0C
         6fH9vC7xcDbog==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] samples: kobject: allow CONFIG_SAMPLE_KOBJECT to become y
Date:   Sat, 27 Apr 2019 12:33:40 +0900
Message-Id: <1556336020-15634-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sample works well as builtin.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 samples/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index b98a763..399ae53 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -20,8 +20,7 @@ config SAMPLE_TRACE_PRINTK
 	 test various trace_printk() calls from a module.
 
 config SAMPLE_KOBJECT
-	tristate "Build kobject examples -- loadable modules only"
-	depends on m
+	tristate "Build kobject examples"
 	help
 	  This config option will allow you to build a number of
 	  different kobject sample modules showing how to use kobjects,
-- 
2.7.4

