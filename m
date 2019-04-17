Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD254C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF66217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519350;
	bh=thySivS04g/SKEFjDFcJ4xVwcS/ytD4Eyozd5TvjJIw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HuaHJngzBOoTC5goeVRPyql15KmKFPLbxYcLFv107N5rkGUH98g8SaGI2VQGrHzM6
	 A+z7QITEKAU8VGzA1lPgvRkK4l+0nWyvy8y+NQfuscgd7Tslx28nzRfku19HZCzJ6B
	 ppRBmjmc+iS20V7EA1U7aqfB7+QuxPMwjYTvZghw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfDQQm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732917AbfDQQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cYfL21DRc+S8+tzCW6wA8TIyNOQcF1w9J6pJxXs1LNU=; b=FRUxacI3yU+R
        oVbDfF47JXDIozcWTi+GRCjITATfp/VW1ep+v1cq7vexQjghFVDwsFJMp6HzI7R+c6VybE3rt/fPC
        bwrDVFiCxurhI2k04PzJoir5yQRskJ5qmuwCUSWvoEXoZ50xeYAenHutgt0aAyyxckO1iFDqhCV8f
        +52Us=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndX-000155-Ju; Wed, 17 Apr 2019 16:42:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D47A1128FC8; Wed, 17 Apr 2019 17:42:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Applied "regulator: arizona: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190417164215.4D47A1128FC8@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

