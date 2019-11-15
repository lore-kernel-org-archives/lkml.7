Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A9C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192BC2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820719;
	bh=TIkjTuLFZfRGguN+Q19jnBKJpC/kidLOBxfcavNj2is=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BqiMixzl+Iy0CTuJ0vL45SbtiaYMhQqOCHNxBHfuqx9g2YTOwgcf4hLMpF1SdHF+y
	 OooCdgKn3+aCuR78uHZLu++kzslxfVL9alLASQHEXXLIPfn4+z4JlW8Q6PxhYMUmBC
	 Pk52f6j0YYGQBaA2E0WBLMgqDo+Ny/FdR6X8k1f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKOMZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:25:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfKOMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JoonrASRx2bVKGKiyTyFxDhCD4/kPUTpfSsyLooSuVw=; b=bhOpTRTDsFqE
        wrThA70oe2XbTfYLL+50tDAbIAe95yh2B9gMPEgP4hsA5jkDlrV6l+KPyXYgdd1Mh4gof063IdrsY
        LdNsE/da4W3DXjYvpAWO2CWNWC2CfmCZ3a0y21AymxGnsMV9WX9v6N5ef9S9VhwyHMzHubCGGSwb0
        Dq7Cg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaey-0000Kp-Af; Fri, 15 Nov 2019 12:25:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BB9EE274162A; Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9062: refactor buck modes into header" to the regulator tree
In-Reply-To: <1573652416-9848-2-git-send-email-chf.fritz@googlemail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122507.BB9EE274162A@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: refactor buck modes into header

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 7d34aec52d292197d6b13395b023c718cac4630f Mon Sep 17 00:00:00 2001
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Wed, 13 Nov 2019 14:40:13 +0100
Subject: [PATCH] regulator: da9062: refactor buck modes into header

This patch refactors buck modes into a header file so that device trees
can make use of these mode constants.

The new header filename uses da9063 because DA9063 was the earlier chip
and its driver code will want updating at some point in a similar manner.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Link: https://lore.kernel.org/r/1573652416-9848-2-git-send-email-chf.fritz@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c          | 28 +++++++------------
 .../regulator/dlg,da9063-regulator.h          | 16 +++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9063-regulator.h

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 4b24518f75b5..601002e3e012 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/mfd/da9062/core.h>
 #include <linux/mfd/da9062/registers.h>
+#include <dt-bindings/regulator/dlg,da9063-regulator.h>
 
 /* Regulator IDs */
 enum {
@@ -75,14 +76,6 @@ struct da9062_regulators {
 	struct da9062_regulator			regulator[0];
 };
 
-/* BUCK modes */
-enum {
-	BUCK_MODE_MANUAL,	/* 0 */
-	BUCK_MODE_SLEEP,	/* 1 */
-	BUCK_MODE_SYNC,		/* 2 */
-	BUCK_MODE_AUTO		/* 3 */
-};
-
 /* Regulator operations */
 
 /* Current limits array (in uA)
@@ -112,13 +105,13 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		val = BUCK_MODE_SYNC;
+		val = DA9063_BUCK_MODE_SYNC;
 		break;
 	case REGULATOR_MODE_NORMAL:
-		val = BUCK_MODE_AUTO;
+		val = DA9063_BUCK_MODE_AUTO;
 		break;
 	case REGULATOR_MODE_STANDBY:
-		val = BUCK_MODE_SLEEP;
+		val = DA9063_BUCK_MODE_SLEEP;
 		break;
 	default:
 		return -EINVAL;
@@ -145,14 +138,13 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 
 	switch (val) {
 	default:
-	case BUCK_MODE_MANUAL:
 		/* Sleep flag bit decides the mode */
 		break;
-	case BUCK_MODE_SLEEP:
+	case DA9063_BUCK_MODE_SLEEP:
 		return REGULATOR_MODE_STANDBY;
-	case BUCK_MODE_SYNC:
+	case DA9063_BUCK_MODE_SYNC:
 		return REGULATOR_MODE_FAST;
-	case BUCK_MODE_AUTO:
+	case DA9063_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
 	}
 
@@ -279,13 +271,13 @@ static int da9062_buck_set_suspend_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		val = BUCK_MODE_SYNC;
+		val = DA9063_BUCK_MODE_SYNC;
 		break;
 	case REGULATOR_MODE_NORMAL:
-		val = BUCK_MODE_AUTO;
+		val = DA9063_BUCK_MODE_AUTO;
 		break;
 	case REGULATOR_MODE_STANDBY:
-		val = BUCK_MODE_SLEEP;
+		val = DA9063_BUCK_MODE_SLEEP;
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/dt-bindings/regulator/dlg,da9063-regulator.h b/include/dt-bindings/regulator/dlg,da9063-regulator.h
new file mode 100644
index 000000000000..1de710dd0899
--- /dev/null
+++ b/include/dt-bindings/regulator/dlg,da9063-regulator.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_REGULATOR_DLG_DA9063_H
+#define _DT_BINDINGS_REGULATOR_DLG_DA9063_H
+
+/*
+ * These buck mode constants may be used to specify values in device tree
+ * properties (e.g. regulator-initial-mode).
+ * A description of the following modes is in the manufacturers datasheet.
+ */
+
+#define DA9063_BUCK_MODE_SLEEP		1
+#define DA9063_BUCK_MODE_SYNC		2
+#define DA9063_BUCK_MODE_AUTO		3
+
+#endif
-- 
2.20.1

