Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98634C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640B9208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441429;
	bh=k2Fm8O7MpK7iMc2x5aUh4fkrU9CEDJUXv7diw1dPJ4U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FmSNDlGYTNRK82ArgKVPgBYEWNPWT80VjIIBMyvD0ZkQvOr05o5v6b+NfKh/xFoTm
	 096TS72hVzvoSR2+tw7q4vnVUq8XUt0bLoPtxVMeBtUnYixpDRns0Hez1zfY9tiUOx
	 n4GGyc0Xny/ikGc6ezpjJstJ42/+VNnC5mNlFFvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbfFMP5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:57:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58202 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390390AbfFMP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XLqrwinvOXCmZNr3g6KRL6b7QVnkHmhZzUuw0O8ojyg=; b=SaxSvMD/lzXK
        u0MH8GdScn9rjHBQ4uQl+cJ12vzEMW48eiwYteFfVGmgyKtYcsZdZv/cdjnBVfKayHFeVwMDwIZUF
        s+gp54h4XX+BXtdS/kEBfjYx+6+HMuN2BeI2ksYTP/6FRk10OfLAzvfd4AQevijcOfzD9xZ4uGmKh
        Pv3Zw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbS5m-0005HL-Gm; Thu, 13 Jun 2019 15:56:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0AF3C440046; Thu, 13 Jun 2019 16:56:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Applied "regulator: max8952: Convert to use GPIO descriptors" to the regulator tree
In-Reply-To: <20190609114812.28375-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190613155646.0AF3C440046@finisterre.sirena.org.uk>
Date:   Thu, 13 Jun 2019 16:56:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8952: Convert to use GPIO descriptors

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From fd742eaab827b47c5f2de6c1811a17075608da60 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 9 Jun 2019 13:48:12 +0200
Subject: [PATCH] regulator: max8952: Convert to use GPIO descriptors

This finalizes the descriptor conversion of the MAX8952 driver
by letting the VID0 and VID1 GPIOs be fetched from descriptors.

Both VID0 and VID1 must be supplied for the VID selection to work,
I add some code to preserve the semantics that if only one of
the two VID gpios is supplied, it will be initialized to low.
This might be a bit overzealous, but I want to preserve any
implicit semantics.

This is currently only used by device tree in-kernel but it is
still also possible to supply the same GPIOs using a machine
descriptor table if a board file is used.

Ideally this should be phased over to using gpio-regulator.c
that does the same thing, but it might require some refactoring
and needs testing on real hardware.

Cc: Tomasz Figa <tfiga@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8952.c       | 62 ++++++++++++++-----------------
 include/linux/regulator/max8952.h |  3 --
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 451237efb359..8f0e4dc810f0 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -26,11 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/max8952.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
@@ -50,7 +48,8 @@ enum {
 struct max8952_data {
 	struct i2c_client	*client;
 	struct max8952_platform_data *pdata;
-
+	struct gpio_desc *vid0_gpiod;
+	struct gpio_desc *vid1_gpiod;
 	bool vid0;
 	bool vid1;
 };
@@ -100,16 +99,15 @@ static int max8952_set_voltage_sel(struct regulator_dev *rdev,
 {
 	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
 
-	if (!gpio_is_valid(max8952->pdata->gpio_vid0) ||
-			!gpio_is_valid(max8952->pdata->gpio_vid1)) {
+	if (!max8952->vid0_gpiod || !max8952->vid1_gpiod) {
 		/* DVS not supported */
 		return -EPERM;
 	}
 
 	max8952->vid0 = selector & 0x1;
 	max8952->vid1 = (selector >> 1) & 0x1;
-	gpio_set_value(max8952->pdata->gpio_vid0, max8952->vid0);
-	gpio_set_value(max8952->pdata->gpio_vid1, max8952->vid1);
+	gpiod_set_value(max8952->vid0_gpiod, max8952->vid0);
+	gpiod_set_value(max8952->vid1_gpiod, max8952->vid1);
 
 	return 0;
 }
@@ -147,9 +145,6 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 	if (!pd)
 		return NULL;
 
-	pd->gpio_vid0 = of_get_named_gpio(np, "max8952,vid-gpios", 0);
-	pd->gpio_vid1 = of_get_named_gpio(np, "max8952,vid-gpios", 1);
-
 	if (of_property_read_u32(np, "max8952,default-mode", &pd->default_mode))
 		dev_warn(dev, "Default mode not specified, assuming 0\n");
 
@@ -200,7 +195,7 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	struct gpio_desc *gpiod;
 	enum gpiod_flags gflags;
 
-	int ret = 0, err = 0;
+	int ret = 0;
 
 	if (client->dev.of_node)
 		pdata = max8952_parse_dt(&client->dev);
@@ -253,32 +248,31 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	max8952->vid0 = pdata->default_mode & 0x1;
 	max8952->vid1 = (pdata->default_mode >> 1) & 0x1;
 
-	if (gpio_is_valid(pdata->gpio_vid0) &&
-			gpio_is_valid(pdata->gpio_vid1)) {
-		unsigned long gpio_flags;
-
-		gpio_flags = max8952->vid0 ?
-			     GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		if (devm_gpio_request_one(&client->dev, pdata->gpio_vid0,
-					  gpio_flags, "MAX8952 VID0"))
-			err = 1;
-
-		gpio_flags = max8952->vid1 ?
-			     GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		if (devm_gpio_request_one(&client->dev, pdata->gpio_vid1,
-					  gpio_flags, "MAX8952 VID1"))
-			err = 2;
-	} else
-		err = 3;
-
-	if (err) {
+	/* Fetch vid0 and vid1 GPIOs if available */
+	gflags = max8952->vid0 ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8952->vid0_gpiod = devm_gpiod_get_index_optional(&client->dev,
+							    "max8952,vid",
+							    0, gflags);
+	if (IS_ERR(max8952->vid0_gpiod))
+		return PTR_ERR(max8952->vid0_gpiod);
+	gflags = max8952->vid1 ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8952->vid1_gpiod = devm_gpiod_get_index_optional(&client->dev,
+							    "max8952,vid",
+							    1, gflags);
+	if (IS_ERR(max8952->vid1_gpiod))
+		return PTR_ERR(max8952->vid1_gpiod);
+
+	/* If either VID GPIO is missing just disable this */
+	if (!max8952->vid0_gpiod || !max8952->vid1_gpiod) {
 		dev_warn(&client->dev, "VID0/1 gpio invalid: "
-				"DVS not available.\n");
+			 "DVS not available.\n");
 		max8952->vid0 = 0;
 		max8952->vid1 = 0;
-		/* Mark invalid */
-		pdata->gpio_vid0 = -1;
-		pdata->gpio_vid1 = -1;
+		/* Make sure if we have any descriptors they get set to low */
+		if (max8952->vid0_gpiod)
+			gpiod_set_value(max8952->vid0_gpiod, 0);
+		if (max8952->vid1_gpiod)
+			gpiod_set_value(max8952->vid1_gpiod, 0);
 
 		/* Disable Pulldown of EN only */
 		max8952_write_reg(max8952, MAX8952_REG_CONTROL, 0x60);
diff --git a/include/linux/regulator/max8952.h b/include/linux/regulator/max8952.h
index 686c42c041b5..33b6e2c09c05 100644
--- a/include/linux/regulator/max8952.h
+++ b/include/linux/regulator/max8952.h
@@ -118,9 +118,6 @@ enum {
 #define MAX8952_NUM_DVS_MODE	4
 
 struct max8952_platform_data {
-	int gpio_vid0;
-	int gpio_vid1;
-
 	u32 default_mode;
 	u32 dvs_mode[MAX8952_NUM_DVS_MODE]; /* MAX8952_DVS_MODEx_XXXXmV */
 
-- 
2.20.1

