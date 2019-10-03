Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD36BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA021D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="if8kKidK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfJCKaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:30:12 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:49390 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:30:12 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x93ATIYu014338;
        Thu, 3 Oct 2019 19:29:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x93ATIYu014338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570098559;
        bh=pMnHQORs2NGZ3n4d6znGdbIAOnjr2/F3UzN5iG+hjIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=if8kKidKQ1gQ+bVFAZ1Cvyf9TwWp30f3uYtC1RTDZvuEIwwPX5/y6B/4iuLUpOb7+
         7IyZj1Y/2IjnSvPy/9e6IRK6tj8m2Ji30mJaFxB/mbSpNma5TvuE5yhELJdRxOp2G0
         H2OtCblY2Sr+d6hGJJkXQAd4zPrlLOiHKnC9qoDpZv+kNYETy5scLlF8PHoSiW0XK6
         /GZ7kjbOq/135juWsjnfDZo3byz850TlKdjPMdyd3JMcNz91um1a97y0vLk1HU5FGE
         W7/TN/u9i5+TekSKMhKEWOgUQyX58WoO2pGJiXS0YGCiTOTwK0ndBazZqdL1/w88eh
         bqLc6UYlLHYlQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: two minor updates for Documentation/kbuild/modules.rst
Date:   Thu,  3 Oct 2019 19:29:12 +0900
Message-Id: <20191003102915.28301-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capitalize the first word in the sentence.

Use obj-m instead of obj-y. obj-y still works, but we have no built-in
objects in external module builds. So, obj-m is better IMHO.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/modules.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d2ae799237fd..dd1d2a0688e8 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -501,7 +501,7 @@ build.
 --- 6.3 Symbols From Another External Module
 
 	Sometimes, an external module uses exported symbols from
-	another external module. kbuild needs to have full knowledge of
+	another external module. Kbuild needs to have full knowledge of
 	all symbols to avoid spitting out warnings about undefined
 	symbols. Three solutions exist for this situation.
 
@@ -521,7 +521,7 @@ build.
 		The top-level kbuild file would then look like::
 
 			#./Kbuild (or ./Makefile):
-				obj-y := foo/ bar/
+				obj-m := foo/ bar/
 
 		And executing::
 
-- 
2.17.1

