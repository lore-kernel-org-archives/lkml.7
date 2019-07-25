Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE582238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564060812;
	bh=GSqPHwkENM/AAnYLaWV75aqY26gqm5mfAQfQpZ5B/h4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s+z8mWwyI3BVJv0iF1+29hSGPmwVEhr/438Ki01SFc0/X1vtbF56nTHhBXxPXT0nK
	 vPlECPX7DHY8L6igJvi51lmcvNArRyVkaHc29oT/jhP8rLVUj6LK7CMz0+s6TVj0Xm
	 DP1wthO1IVsCHXrrwJXcFeeY5yu9YeBSVoCDoC+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfGYNUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:20:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389776AbfGYNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Mbxu8AN5/JoOf4Q5zWfvCpbaISPtwSaSppkQ+bMDnVQ=; b=mTNJ6hCK5QvP
        Z9QzX/SuQ38Av+GnnEv57mtloeTDqm/3CrTvWAb94Pq8KJquuG9qGyqzNwpkjkvzEW6y/oE2Xv8HX
        gQRKrjIS4CEBdpXz9sK/+j6bZ2bGQ9Op88UrH83iShiWX0WjReM6xFfg9fde/vZZMfLt7ch2nxHck
        zaYhQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqdeY-0002rR-Ix; Thu, 25 Jul 2019 13:19:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D36082742B5F; Thu, 25 Jul 2019 14:19:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        kernel-janitors@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.com, yang.jie@linux.intel.com
Subject: Applied "ASoC: Intel: Fix some acpi vs apci typo in somme comments" to the asoc tree
In-Reply-To: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
Date:   Thu, 25 Jul 2019 14:19:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: Fix some acpi vs apci typo in somme comments

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 72ea86391cd3249638fbef340b865c4bfa31465b Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 25 Jul 2019 07:35:23 +0200
Subject: [PATCH] ASoC: Intel: Fix some acpi vs apci typo in somme comments

Fix some typo to have the filaname given in a comment match the real name
of the file.
Some 'acpi' have erroneously been written 'apci'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190725053523.16542-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-skl-match.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 229e39586868..4a5adae1d785 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
+ * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index b94b482ac34f..1cc801ba92eb 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-byt-match.c - tables and support for BYT ACPI enumeration.
+ * soc-acpi-intel-byt-match.c - tables and support for BYT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index b7f11f6be1cf..d0fb43c2b9f6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-cht-match.c - tables and support for CHT ACPI enumeration.
+ * soc-acpi-intel-cht-match.c - tables and support for CHT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index c36c0aa4f683..771b0ef21051 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
+ * soc-acpi-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 616eb09e78a0..60dea358fa04 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-glk-match.c - tables and support for GLK ACPI enumeration.
+ * soc-acpi-intel-glk-match.c - tables and support for GLK ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-hda-match.c b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
index 68ae43f7b4b2..cc972d2ac691 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hda-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
@@ -2,7 +2,7 @@
 // Copyright (c) 2018, Intel Corporation.
 
 /*
- * soc-apci-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
+ * soc-acpi-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
  *
  */
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index d27853e7a369..34eb0baaa951 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
+ * soc-acpi-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 0b430b9b3673..38977669b576 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.
+ * soc-acpi-intel-icl-match.c - tables and support for ICL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 4b331058e807..e200baa11011 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
+ * soc-acpi-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
index 0c9c0edd35b3..42fa40a8d932 100644
--- a/sound/soc/intel/common/soc-acpi-intel-skl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-skl-match.c - tables and support for SKL ACPI enumeration.
+ * soc-acpi-intel-skl-match.c - tables and support for SKL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
-- 
2.20.1

