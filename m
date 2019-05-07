Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B6DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3880205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ur1LfKkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEGMtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:49:00 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:23556 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEGMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:49:00 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x47Cmr6D025198;
        Tue, 7 May 2019 21:48:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x47Cmr6D025198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557233334;
        bh=QHgrx9JlLgTxo5RIiXOXGXOqS1tuTFILxM8klYbVGNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ur1LfKkVfxqXAHwJ+HcCg0FXWJHwa5aL8BIYsLtXOSt3FZoB7BaTWSMheRs62uG4+
         dAQT4unggsHegY8A/FFSlxK1q9FqCkSCp77rZXgzoOswd/jGWnCh3ajewdPX+KWpkK
         011FsptQ8m+LfKsLRYErZKsdIR5cNyGyqKREeXoIg+oszGRvzymMh6ZLFq0DAxSG8J
         6Ml33H8qFOx3wUrWkMPabJGXh7suKFf5s0SApMcRnYT3Y5U2xZ/fW38gelBUX5U9xR
         xu9Q7YX2LVn6dhxGIO1KIdKh+rXQIEf8NCdTUQSVKWFp86hti0X4E6b0fO7WrREjG+
         q0FI5PBQk7P2A==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] .gitignore: add more all*.config patterns
Date:   Tue,  7 May 2019 21:48:46 +0900
Message-Id: <1557233326-13247-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness, ignore all the allconfig variants.

I added a leading slash because they are only searched in the
top of the tree.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .gitignore | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 2fb1765..d263ca9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,7 +130,12 @@ signing_key.x509
 x509.genkey
 
 # Kconfig presets
-all.config
+/all.config
+/alldef.config
+/allmod.config
+/allno.config
+/allrandom.config
+/allyes.config
 
 # Kdevelop4
 *.kdev4
-- 
2.7.4

