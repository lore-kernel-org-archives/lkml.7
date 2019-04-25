Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC74DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220347;
	bh=tMaBmVNzDZzyba5Sl2Sur4VdYlkLOqjjbnxi4xJm1bI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=exd0Cgs+/bqnBd0mCxnx6XRKUcO1d+9bfV+erdM5ND1xQ1fkjilHvltQvLd0FXepx
	 ufMUdMW3LJJvjMZKSX/d7Sm12RB3dlJ7gBpio83obUpEH1pPChp/D7OVC2MV2GlBvn
	 HVEzKZz/wcE+o6f09AA/S6+stYFyAxmZGbOyLcVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfDYTZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49236 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfDYTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KZRC4KGmaEf56xBdQHGtaywKTsQXcv/ghwcGgGRnZ3M=; b=emnNYs28HKJV
        dWV8ky6v5fmhbmIWAGGmdhLbm+WI3SvJcsF2Ri4vFcgF1gKcDWrKNvvB3vlUJlQhwomQHF7KRcJbR
        UpbqGEQsDAhcs5qv6q2Veyxox8ryGGAG3X+uhNPeudyiFoR1kGPETTwU6IXLiXa9kWWvKKqvGC5Zk
        MklpI=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjz8-0004Zl-M1; Thu, 25 Apr 2019 19:24:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E8116441D3E; Thu, 25 Apr 2019 20:24:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chenglin Xu <chenglin.xu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: mt63xx: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190421022656.5838-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192440.E8116441D3E@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:40 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mt63xx: Switch to SPDX identifier

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

From 0e093f82754daca970df3a2614d5a2492ad3f6d9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 21 Apr 2019 10:26:56 +0800
Subject: [PATCH] regulator: mt63xx: Switch to SPDX identifier

Convert MediaTek mt63xx PMIC drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mt6311-regulator.c | 17 ++++-------------
 drivers/regulator/mt6311-regulator.h | 10 +---------
 drivers/regulator/mt6323-regulator.c | 12 ++++--------
 drivers/regulator/mt6380-regulator.c | 17 ++++-------------
 drivers/regulator/mt6397-regulator.c | 17 ++++-------------
 5 files changed, 17 insertions(+), 56 deletions(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 01d69f43d2b0..af95449d3590 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2015 MediaTek Inc.
- * Author: Henry Chen <henryc.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2015 MediaTek Inc.
+// Author: Henry Chen <henryc.chen@mediatek.com>
 
 #include <linux/err.h>
 #include <linux/gpio.h>
diff --git a/drivers/regulator/mt6311-regulator.h b/drivers/regulator/mt6311-regulator.h
index 5218db46a798..4904d6751714 100644
--- a/drivers/regulator/mt6311-regulator.h
+++ b/drivers/regulator/mt6311-regulator.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Henry Chen <henryc.chen@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __MT6311_REGULATOR_H__
diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index 25b002328910..893ea190788a 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -1,11 +1,7 @@
-/*
- * Copyright (c) 2016 MediaTek Inc.
- * Author: Chen Zhong <chen.zhong@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2016 MediaTek Inc.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 86bc332df3f2..b6aed090b5e0 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2017 MediaTek Inc.
- * Author: Chenglin Xu <chenglin.xu@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2017 MediaTek Inc.
+// Author: Chenglin Xu <chenglin.xu@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 3e6c8d99ec0f..fd9ed864a0c1 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (c) 2014 MediaTek Inc.
- * Author: Flora Fu <flora.fu@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2014 MediaTek Inc.
+// Author: Flora Fu <flora.fu@mediatek.com>
 
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.20.1

