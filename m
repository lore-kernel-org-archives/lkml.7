Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C932184D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763552;
	bh=asrfQSJ8hpwZNAvbHsdwQeI11QbijPd897kuk4Pa2lA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sFcKweOUceEeOOTT/xlcVtkHhQJwzq5YyLF8m6p9+u7caqKGww44fpmA3fvhBncxr
	 GcuR2C/iPHKeHgAKijiqBTOCeLQPKF14nY/wx75vI+vY9F464ECDCfb4g/grB/fv5U
	 zxueEepRRoRzAopjs+iPSaVc812xDuteJaRfuzpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEBCTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfEBCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LmwUh5ppi0jIXNLd0yCXMXthQMJBz2ccK6O6VVIHxIk=; b=pwAkIXn9s5Zz
        xJid5ZilUDMo1D7boLbd2Ik4UEBzUOCa/RisOKTAEyuL8PdxSk2i8EsXdt/7dadwAseBGmU5yKQqN
        xWb8h57sk9s9p+04MDaUZwowX4qdhDek0Zf9vtQfJ1QlrdFgRbP/lkJ7s/+BJO4sQzfwVzXBHLj5p
        xxZm8=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JH-0005uI-A6; Thu, 02 May 2019 02:18:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 16630441D3F; Thu,  2 May 2019 03:18:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Subject: Applied "regulator: hi6xxx: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190501011131.16186-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021852.16630441D3F@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi6xxx: Switch to SPDX identifier

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

From 8b9085200681329233d645466698596b87be77f2 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 1 May 2019 09:11:31 +0800
Subject: [PATCH] regulator: hi6xxx: Switch to SPDX identifier

Convert HiSilicon hi6xxx PMIC drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi6421-regulator.c     | 24 +++++++++-------------
 drivers/regulator/hi6421v530-regulator.c | 26 ++++++++++--------------
 drivers/regulator/hi655x-regulator.c     | 22 ++++++++------------
 3 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 6c7ea4eb4bb0..5ac3d7c29725 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -1,17 +1,13 @@
-/*
- * Device driver for regulators in Hi6421 IC
- *
- * Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
- *              http://www.hisilicon.com
- * Copyright (c) <2013-2014> Linaro Ltd.
- *              http://www.linaro.org
- *
- * Author: Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi6421 IC
+//
+// Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
+//              http://www.hisilicon.com
+// Copyright (c) <2013-2014> Linaro Ltd.
+//              http://www.linaro.org
+//
+// Author: Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/slab.h>
 #include <linux/device.h>
diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index c09bc71538a5..06ae65199afd 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -1,18 +1,14 @@
-/*
- * Device driver for regulators in Hi6421V530 IC
- *
- * Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
- *              http://www.hisilicon.com
- * Copyright (c) <2017> Linaro Ltd.
- *              http://www.linaro.org
- *
- * Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
- *         Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi6421V530 IC
+//
+// Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
+//              http://www.hisilicon.com
+// Copyright (c) <2017> Linaro Ltd.
+//              http://www.linaro.org
+//
+// Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
+//         Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/mfd/hi6421-pmic.h>
 #include <linux/module.h>
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 6f6635daa026..ac2ee2030211 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -1,16 +1,12 @@
-/*
- * Device driver for regulators in Hi655x IC
- *
- * Copyright (c) 2016 Hisilicon.
- *
- * Authors:
- * Chen Feng <puck.chen@hisilicon.com>
- * Fei  Wang <w.f@huawei.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi655x IC
+//
+// Copyright (c) 2016 Hisilicon.
+//
+// Authors:
+// Chen Feng <puck.chen@hisilicon.com>
+// Fei  Wang <w.f@huawei.com>
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-- 
2.20.1

