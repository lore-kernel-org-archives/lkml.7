Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfCKNYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:32795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdvyi-1gSdFF2o3K-00b2uz for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 091/114] block: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:43 +0100
Message-Id: <1552310346-7629-92-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:gzaKwmmNCaI0WKEM6KdClAvE5QLtFHen8RkBsOgj+a0aKic0Vie
 Z/ZGOW0P1nPk5/Ny83MtakP+iye94cy5mv1ACF6LBkkO13BmmeH3oUAwU4O/m82iB8Ton1A
 D8twH90nc3+kup53JYpvSUxKx67qCl473a9eBG5vCjjVIb7gUfBoaNudQ7iDYmCs4tvE2OW
 AqfshkWQpU/avoopH2FMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YFFXD76ycsE=:jG+g5kVuCCF1lk8xO29xTc
 qLumvnLwVidZAfcDT2m8p0n9s/O+xYLyilk9vrbsKKPoKNU9lchareNnS1cRvohUI4UgM/nSy
 zk+S1+I5G9yX1235/N3VxzPJChxp6UJvPQhXYIyaT1VnQ+R+Q51v8rf/BigurnTNvxsSkgkUc
 26NNZG+Lad9XFyDVFOXqgs3MOggPYwBHHoM+HKntcWEx4c0oZWw0UOVYT/AjKo0U8nSpA5ZXz
 y87a2hYYjwWeAPyIP/Gj/JcviX4zyvhmCSN0x+kAsYb3IAUvu58KbxXS5pmLpPSjwHOdXJxCe
 XQ0vAAO6Tf6dnqphLu95rEi3fHeStlCIZkvVOYDwhzInuIFw9n7892xHKwS2Av/5evIyQEooA
 +t7apZWJ/BOfohBX2upfbLMyPm+2tOXRQ3T4UKPvmkhXkm3NM4+JLkY7GZV24V7/91HtcV8G+
 lXeElSRl/Rnj41g0aATtgBHbO0FhpzyBETLiNws5DAwce5u52BX9HhWAMH4aaesLZstoj1hzt
 mFSm3Ri6Gh6M45Ay1BafedQo6FzqvhZWigmW3r//ucMHkGB6P4DRwo9+44lkN8xfd61i25FJL
 7ERG6EiCWvRPFowZJ2ayqNhpKR2i2v3ybWSwspXvPmVfCdKCoIcDhIWANAlSsspoiBwgycwjq
 6vwI+tjxGrQWdYGegpCZp01rwHP2Fq6j8+EGJO2ew9qmBeTdzXuYkl2Wn0qe+i/rBUiaGKhpA
 DC3RclC5QgCU2zW0S6LgVFHw/ci6cGQXYJtPSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 block/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 028bc08..eb7e1bf 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -3,26 +3,26 @@
 # Block layer core configuration
 #
 menuconfig BLOCK
-       bool "Enable the block layer" if EXPERT
-       default y
-       select SBITMAP
-       select SRCU
-       help
-	 Provide block layer support for the kernel.
+	bool "Enable the block layer" if EXPERT
+	default y
+	select SBITMAP
+	select SRCU
+	help
+	  Provide block layer support for the kernel.
 
-	 Disable this option to remove the block layer support from the
-	 kernel. This may be useful for embedded devices.
+	  Disable this option to remove the block layer support from the
+	  kernel. This may be useful for embedded devices.
 
-	 If this option is disabled:
+	  If this option is disabled:
 
 	   - block device files will become unusable
 	   - some filesystems (such as ext3) will become unavailable.
 
-	 Also, SCSI character devices and USB storage will be disabled since
-	 they make use of various block layer definitions and facilities.
+	  Also, SCSI character devices and USB storage will be disabled since
+	  they make use of various block layer definitions and facilities.
 
-	 Say Y here unless you know you really don't want to mount disks and
-	 suchlike.
+	  Say Y here unless you know you really don't want to mount disks and
+	  suchlike.
 
 if BLOCK
 
@@ -177,8 +177,8 @@ config BLK_DEBUG_FS
 	say Y here.
 
 config BLK_DEBUG_FS_ZONED
-       bool
-       default BLK_DEBUG_FS && BLK_DEV_ZONED
+	bool
+	default BLK_DEBUG_FS && BLK_DEV_ZONED
 
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
-- 
1.9.1

