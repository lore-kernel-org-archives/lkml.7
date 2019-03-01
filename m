Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uQ3era+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfCAHKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:10:54 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:16716 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCAHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:10:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x217APwr017759;
        Fri, 1 Mar 2019 16:10:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x217APwr017759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551424225;
        bh=8t7excQEtZ3k0zZuNz5dRZOkstOKAajR6OxsjLRcbGs=;
        h=From:To:Cc:Subject:Date:From;
        b=uQ3era+zc3DAxv59/5kHhrafsI8uOdFCVnltLf4qo+rFtb/qRpK6N/qh+3wbdC3m5
         /KSBiTDjm/UdqEg5iV06b8d/KYx/6XwFKi/Wywj956et37/0zE1mJXqeHeU+wBxpzW
         w4T4ybSG8ihRkglQSM5zAyIJRdyh/xnIvIj3Q55fgC0BuA86miIlqgait9YjblAm6C
         C03KepwLTtIlnejmSxf79q2XAk7/NzHL3khsESCRDXUzyOugG6Q90WOuYU4a/wXTlE
         itY6JFYH3Ghp4XZ7f1rzdkqLYa7kzVRAGv14YHcqmtANczl27ccHBqmoapf0IQpfmp
         slt+jhmWvPYUQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: update comment block of scripts/clang-version.sh
Date:   Fri,  1 Mar 2019 16:10:20 +0900
Message-Id: <1551424222-3727-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 469cb7376c06 ("kconfig: add CC_IS_CLANG and CLANG_VERSION")
changed the code, but missed to update the comment block.

The -p option was gone, and the output is 5-digit (or 6-digit when
Clang 10 is released).

Update the comment now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/clang-version.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
index e65fbc3..6fabf06 100755
--- a/scripts/clang-version.sh
+++ b/scripts/clang-version.sh
@@ -1,14 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
-# clang-version [-p] clang-command
-#
-# Prints the compiler version of `clang-command' in a canonical 4-digit form
-# such as `0500' for clang-5.0 etc.
-#
-# With the -p option, prints the patchlevel as well, for example `050001' for
-# clang-5.0.1 etc.
+# clang-version clang-command
 #
+# Print the compiler version of `clang-command' in a 5 or 6-digit form
+# such as `50001' for clang-5.0.1 etc.
 
 compiler="$*"
 
-- 
2.7.4

