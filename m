Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8AC31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BF420665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VCqGRQfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFRDLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:11:12 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:37765 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:11:12 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x5I39ceS006664;
        Tue, 18 Jun 2019 12:09:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x5I39ceS006664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560827379;
        bh=w4XaL6DWiMYpTTLcCsZBTR/341ShCtHYlKihuEWxr64=;
        h=From:To:Cc:Subject:Date:From;
        b=VCqGRQfqg7FKlT6XeLpvCjmUWP/l/a5jGC4yCAMB5tT8HiAkKBU5yPYOse0+DHylm
         t4ucw7vLHJX5d8laPEl2rYvJKjwQYLBozaAjxFXI9Ev2TDg1d9ZJaV+qS6TZlXjH8h
         +BtM/qmZLZ8+Tz8Gvcr0OsBvMXdN7dEDV4GBnVqjj2D9vQ2Z6fBqn12huGQkby9ep1
         hfEoHadDNqLmxptfBc7RttKdpktJoLEZKICRwS13qctmF+ZaHV7P4GRA1VPR5Wb2O0
         Rh6XGQpYCnt3+1sfxVvyQm7hGeCFx6jM/t+iykeq0/mmkDcaeQkTEibbbOPEYsbdH/
         UmL1tFervQqFg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] jffs2: remove C++ style comments from uapi header
Date:   Tue, 18 Jun 2019 12:09:26 +0900
Message-Id: <20190618030926.30616-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel tolerates C++ style comments these days. Actually, the
SPDX License tags for .c files start with //.

On the other hand, uapi headers are written in more strict C, where
the C++ comment style is forbidden.

I simply dropped these lines instead of fixing the comment style.

This code has been always commented out since it was added around
Linux 2.4.9 (i.e. commented out for more than 17 years).

'Maybe later...' will never happen.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Delete the comments entirely instead of fixing the comment style

 include/uapi/linux/jffs2.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
index a18b719f49d4..784ba0b9690a 100644
--- a/include/uapi/linux/jffs2.h
+++ b/include/uapi/linux/jffs2.h
@@ -77,11 +77,6 @@
 
 #define JFFS2_ACL_VERSION		0x0001
 
-// Maybe later...
-//#define JFFS2_NODETYPE_CHECKPOINT (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | 3)
-//#define JFFS2_NODETYPE_OPTIONS (JFFS2_FEATURE_RWCOMPAT_COPY | JFFS2_NODE_ACCURATE | 4)
-
-
 #define JFFS2_INO_FLAG_PREREAD	  1	/* Do read_inode() for this one at
 					   mount time, don't wait for it to
 					   happen later */
-- 
2.17.1

