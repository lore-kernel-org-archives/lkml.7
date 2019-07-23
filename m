Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EFC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BB2229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OW0O3Phg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfGWELl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:11:41 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:41241 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGWELk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:11:40 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6N4BSu3032209;
        Tue, 23 Jul 2019 13:11:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6N4BSu3032209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563855089;
        bh=3+u4FXDZ3UkH/UUQynLowqWR3N2MZywkaH4WgsUBsbI=;
        h=From:To:Cc:Subject:Date:From;
        b=OW0O3Phg60HGiJcMcfKOl7Gb669EnyUE4xadbEYfTsTYVL080wgjIfhPej7u17Y+r
         m7xDlptVLKSutk5A1pWppZ5zJ3vkhm8Ed6sk8wowPX8mO4Kx9lUXUM27dMLPrL6edT
         1DkRwxPeKzNfwzw2iI8q4e7UEKh+amj7LJjzFu2tSmuByU4/k+VVKyX8HvTVUh8n7t
         uhv4ujTE5K1AK4HL5Lojc//scllXxiBRcT14tG0u8qMxXPhRq7nta/noPjmPXb1o5y
         ZWKvSwzR2OoAIQIYMVHokmN20CUdfM/wMDmNwZ98uAu2kQgdvTnEkmKU9ijwcvYhjJ
         6PETXZakbRjZg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unused objectify macro
Date:   Tue, 23 Jul 2019 13:11:26 +0900
Message-Id: <20190723041126.19897-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 415008af3219 ("docs-rst: convert lsm from DocBook to ReST")
removed the last users of this macro.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 12666fc922ea..10ba926ae292 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -185,9 +185,6 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 # printing commands
 cmd = @set -e; $(echo-cmd) $(cmd_$(1))
 
-# Add $(obj)/ for paths that are not absolute
-objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
-
 ###
 # if_changed      - execute command if any prerequisite is newer than
 #                   target, or command line has changed
-- 
2.17.1

