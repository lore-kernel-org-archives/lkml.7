Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647421479
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gepxBlwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfEKDOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 23:14:25 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:34419 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 23:14:24 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4B3ECOe025651;
        Sat, 11 May 2019 12:14:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4B3ECOe025651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557544453;
        bh=Ej5OulpEUS8O5pVIHr0SZmVTAlpu2RMa77srJIMPuco=;
        h=From:To:Cc:Subject:Date:From;
        b=gepxBlwgOYgCEM9SEpDQMf93NIP8BmizNa0VsoElIE6c5945J/0kjctJK6y1J+oND
         x1jgWeMcba/X1vwYq5Ny0d6wUxzY+B5++yCMhsnRt4KGlEnYIn0xr4SciNsGGqhGfm
         oATJKVYOCbVhg2ixNSNonm491KQZICf9mYr1j+kPOAjmG7+BQmOrGlHdA0xgY9RCYM
         4Wmsh/sdxEZNoXEiWKAPVJxt03Pt4gxnnP4ggiIi074AuPUoiDLaKZAs6c8FInTZyC
         fgKHm8hHYn3vWc+kMmBrFOTWZxcQ8zQ+2Vi4OicQAcdVpJXjR5oohuIRh1ZruI+0q4
         s6KAM1hC8BaAw==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] .gitignore: exclude .get_maintainer.ignore and .gitattributes
Date:   Sat, 11 May 2019 12:13:54 +0900
Message-Id: <1557544434-21126-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, sort the patterns alphabetically. Update the comment since
we have non-git files here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .gitignore | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index d263ca9..7587ef56 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,12 +81,14 @@ modules.builtin
 /tar-install/
 
 #
-# git files that we don't want to ignore even if they are dot-files
+# We don't want to ignore the following even if they are dot-files
 #
+!.clang-format
+!.cocciconfig
+!.get_maintainer.ignore
+!.gitattributes
 !.gitignore
 !.mailmap
-!.cocciconfig
-!.clang-format
 
 #
 # Generated include files
-- 
2.7.4

