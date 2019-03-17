Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 06:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA402148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 06:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q/YKtGyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfCQGFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 02:05:13 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:16980 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQGFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 02:05:12 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x2H655wt020813;
        Sun, 17 Mar 2019 15:05:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x2H655wt020813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552802705;
        bh=spO50XJ3cGHkPRkcsA4KfqSzD2I9Ahp5fnr0GBgHZp8=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/YKtGyA+AyCaGeYYZmZvrpxWj6xaM9qDU0fI8RdNcSGBYHZJDtSaQxZLIRY1+YyI
         ljagFBxZFlBm/SQ9RAGKGesULEgWCvWyXIZQty6VK8oK2xA8YLV4AZ4I5E9ZLmmKWz
         UKvRM5wZNGie4J0Ey6dWdJaKbrNW8xaypeMZzGG4fHVP089KgrQPFajmxaO5UAxG5n
         Vz2Y6vy7M+AK3FVhbVmMNP7KwFHO8HmRcOCHKxJeZZcJhchhKWHPGTRDuoarhHbuVt
         IUK8VVuJ4mw3SxYE6vr95VsCEet91FBEdK25gQrPZ+vLUOl6azC2OOrJgHb6GVe6E6
         CnPr1Q6Tna7zg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: remove stale lxdialog/.gitignore
Date:   Sun, 17 Mar 2019 15:05:03 +0900
Message-Id: <1552802703-14203-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this .gitignore was added, lxdialog was an independent hostprogs-y.

Now that all objects in lxdialog/ are directly linked to mconf, the
lxdialog is no longer generated.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/lxdialog/.gitignore | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 scripts/kconfig/lxdialog/.gitignore

diff --git a/scripts/kconfig/lxdialog/.gitignore b/scripts/kconfig/lxdialog/.gitignore
deleted file mode 100644
index 90b08ff..0000000
--- a/scripts/kconfig/lxdialog/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-#
-# Generated files
-#
-lxdialog
-- 
2.7.4

