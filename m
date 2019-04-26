Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E66206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271642;
	bh=Rhh8rqdmmFm30eRc1nkH/iIBbSZ7jpeUjwDd5Al+Ur8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MEF58d+dvS749dLsIL90Kvy8TaK2oyUpqqv+6XR7BnWlF5W549kAfQ+WGbWjhrrLI
	 kT9rkkZ2gHnaiDZquT/fMAnpdVCyBoGkS4IoPQhvM+MdvuIKpOpPDwEvoY36I5+RJp
	 +zCE2j6CvvulfPontpBbW9E1AoZA3iYzRCNBWEnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfDZJkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfDZJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HtNJfC3JbGC06H1X9GFb4ClrTb43KmLdI2TVQazs0eU=; b=sMxgLVsuoLMr
        gFSmwDuxY+Mn+8Jj7kdbAgr+q1TKPAXbophKq2kyUL5kjsWo0DRJ+ZZpOge+9C2pKjK4QDDRJ2s0r
        2iU5w2z+kBzvvXcpmbGa0jbAGNpldvnQA8mBCN4g2wCvspnpY6lbir57rV8g10xyVfsEUp/0suJrm
        UV9xw=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLM-0003JY-3v; Fri, 26 Apr 2019 09:40:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 24E3C441D3B; Fri, 26 Apr 2019 10:40:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Applied "regulator: arizona: Switch to SPDX identifier" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094031.24E3C441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From dfc0c82b3368b26250b4e960ee78ef909feba364 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 17 Apr 2019 22:16:29 +0800
Subject: [PATCH] regulator: arizona: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c    | 19 +++++++------------
 drivers/regulator/arizona-micsupp.c | 19 +++++++------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index bf3ab405eed1..e4bc7b1e5ccd 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -1,15 +1,10 @@
-/*
- * arizona-ldo1.c  --  LDO1 supply for Arizona devices
- *
- * Copyright 2012 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// arizona-ldo1.c  --  LDO1 supply for Arizona devices
+//
+// Copyright 2012 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 120de94caf02..be0d46da51a1 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -1,15 +1,10 @@
-/*
- * arizona-micsupp.c  --  Microphone supply for Arizona devices
- *
- * Copyright 2012 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// arizona-micsupp.c  --  Microphone supply for Arizona devices
+//
+// Copyright 2012 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1

