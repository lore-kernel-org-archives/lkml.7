Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65623C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C15206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564603748;
	bh=ywC7gB8XQ/17aOOZG37EpBdlHuf+W6vMaWGqefykNwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zj11yI8aeGyTt4QmGlBP8sCWna4GwY797gPFY2yqYh8D/ML8rNwXLuHptybQXLTRc
	 MO1ConkuaBnMzLNnENqicsK3U6aKc+CL7ncV85A4mf8YoIzPEGf1mqU5WhzWymUo+J
	 2WJ7lgeUCgk9Stf+tVGPRguQ3WpFlR39IPsmNDBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfGaUJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:09:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfGaUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RGnIbstR67/d58/2VBeEsEJ/D0YYSvIZYvE9aUkOglI=; b=sXCTHXEsA7iDFFkPD1idGMZHXg
        rljnX14PeB7vCozRMFWMAx92dwvrdMapCECbrpmzysy4xykG2nB25d/IAmmNTkv2qwr1obwhmSs24
        PBT5iy7zEoisaKGVdcoUHBom22tylx57JldxYMsbU5fxVChyHfRycxRWfaK4gIyOToNX82M8QxRXU
        T80P6hzjoV+MXn/JADYfhvA3wTaUxHTT9igt/zZS2BSRqmN3DgEevpWCLfREFWsnlAiiphCpkkSkX
        G5zHBKJpgFnZvtb9sYeT9c2EN2GIv4yt6U6Hu/+0y41PGzAaGziR2djBMnRUNKVazBVAmQXraXxt9
        Dq6GqtZQ==;
Received: from [191.33.152.89] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsuu8-0007qC-HH; Wed, 31 Jul 2019 20:08:56 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hsuu6-00079g-72; Wed, 31 Jul 2019 17:08:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 1/6] docs: fix a couple of new broken references
Date:   Wed, 31 Jul 2019 17:08:48 -0300
Message-Id: <5b4fae5978d309641fa8ba233a9efe2b48201cd6.1564603513.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564603513.git.mchehab+samsung@kernel.org>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are due to recent changes. Most of the issues
can be automatically fixed with:

	$ ./scripts/documentation-file-ref-check --fix

The only exception was the sound binding with required
manual work.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt | 2 +-
 MAINTAINERS                                                 | 4 ++--
 drivers/hwtracing/coresight/Kconfig                         | 2 +-
 fs/jfs/Kconfig                                              | 2 +-
 fs/ufs/Kconfig                                              | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
index 2ca3d138528e..7ecf6bd60d27 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
@@ -4,7 +4,7 @@ Allwinner SUN8I audio codec
 On Sun8i-A33 SoCs, the audio is separated in different parts:
 	  - A DAI driver. It uses the "sun4i-i2s" driver which is
 	  documented here:
-	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+	  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
 	  - An analog part of the codec which is handled as PRCM registers.
 	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
 	  - An digital part of the codec which is documented in this current
diff --git a/MAINTAINERS b/MAINTAINERS
index 6de82f019a52..f109a8bcffda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8659,7 +8659,7 @@ L:	jfs-discussion@lists.sourceforge.net
 W:	http://jfs.sourceforge.net/
 T:	git git://github.com/kleikamp/linux-shaggy.git
 S:	Maintained
-F:	Documentation/filesystems/jfs.txt
+F:	Documentation/admin-guide/jfs.rst
 F:	fs/jfs/
 
 JME NETWORK DRIVER
@@ -16439,7 +16439,7 @@ F:	drivers/hid/hid-udraw-ps3.c
 UFS FILESYSTEM
 M:	Evgeniy Dushistov <dushistov@mail.ru>
 S:	Maintained
-F:	Documentation/filesystems/ufs.txt
+F:	Documentation/admin-guide/ufs.rst
 F:	fs/ufs/
 
 UHID USERSPACE HID IO DRIVER:
diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 14638db4991d..7a9f5fb08330 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -106,7 +106,7 @@ config CORESIGHT_CPU_DEBUG
 	  can quickly get to know program counter (PC), secure state,
 	  exception level, etc. Before use debugging functionality, platform
 	  needs to ensure the clock domain and power domain are enabled
-	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
+	  properly, please refer Documentation/trace/coresight-cpu-debug.rst
 	  for detailed description and the example for usage.
 
 endif
diff --git a/fs/jfs/Kconfig b/fs/jfs/Kconfig
index 22a273bd4648..05cb0e8e4382 100644
--- a/fs/jfs/Kconfig
+++ b/fs/jfs/Kconfig
@@ -5,7 +5,7 @@ config JFS_FS
 	select CRC32
 	help
 	  This is a port of IBM's Journaled Filesystem .  More information is
-	  available in the file <file:Documentation/filesystems/jfs.txt>.
+	  available in the file <file:Documentation/admin-guide/jfs.rst>.
 
 	  If you do not intend to use the JFS filesystem, say N.
 
diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index fcb41516ea59..6d30adb6b890 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -9,7 +9,7 @@ config UFS_FS
 	  this file system as well. Saying Y here will allow you to read from
 	  these partitions; if you also want to write to them, say Y to the
 	  experimental "UFS file system write support", below. Please read the
-	  file <file:Documentation/filesystems/ufs.txt> for more information.
+	  file <file:Documentation/admin-guide/ufs.rst> for more information.
 
           The recently released UFS2 variant (used in FreeBSD 5.x) is
           READ-ONLY supported.
-- 
2.21.0

