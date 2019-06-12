Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2721019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355195;
	bh=lp3Q4k+h7HcRigBLN86DqzTmPgFW3BroAyaiDE6BMnU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Jz9m9ak3arByC0X5exHMKwIAPLEvQfTTJvyXZM7nNjQBEWnQw7Jd5w6CCAY4cNEAl
	 SYnybyaB1KEbfUF7HmUQbrBsP7MuzAz79j76AaA7K25wRTy4ebNKQXoRjJJxbx32nl
	 swbEBltl30w33pijXokFUQnbv8EGRWgrXZhPKg1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440404AbfFLP7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:59:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44672 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440381AbfFLP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w4trp3tQX4zafbSlN5NsAKA/cqpyMwMXmZvhJ/eBjhg=; b=pgqOJp/NWr0Q
        Obj/J8Jlp8V/dOb9L88l1pP35DZXR4/mQGsNYwkhAPLji4VX0eIr9iHiSqpdS/pBrCpmolBkkO5iT
        c6hyZDDZw8aXcsmsHKW6URbU3uX6RdZhYzyuUntIEt3ThHqq3yhlMv9QtfbmkuKzuARdob+ag2AOH
        FsYrs=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb5f7-00036i-7Y; Wed, 12 Jun 2019 15:59:45 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id AF12C440046; Wed, 12 Jun 2019 16:59:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Applied "regulator: wm831x: Convert to use GPIO descriptors" to the regulator tree
In-Reply-To: <20190612074222.10584-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190612155944.AF12C440046@finisterre.sirena.org.uk>
Date:   Wed, 12 Jun 2019 16:59:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x: Convert to use GPIO descriptors

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

From 9a5ed0bac86edce4097abf7595a7de050b2f87fa Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2019 09:42:22 +0200
Subject: [PATCH] regulator: wm831x: Convert to use GPIO descriptors

This converts the Wolfson Micro WM831x DCDC converter to use
a GPIO descriptor for the GPIO driving the DVS pin.

There is just one (non-DT) machine in the kernel using this, and
that is the Wolfson Micro (now Cirrus) Cragganmore 6410 so we
patch this board to pass a descriptor table and fix up the driver
accordingly.

Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c | 21 ++++++++++++++++++-
 drivers/regulator/wm831x-dcdc.c       | 29 ++++++++++++---------------
 include/linux/mfd/wm831x/pdata.h      |  1 -
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 379424d72ae7..8ec6a4f5eb05 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/leds.h>
 #include <linux/delay.h>
 #include <linux/mmc/host.h>
@@ -398,7 +399,6 @@ static struct pca953x_platform_data crag6410_pca_data = {
 /* VDDARM is controlled by DVS1 connected to GPK(0) */
 static struct wm831x_buckv_pdata vddarm_pdata = {
 	.dvs_control_src = 1,
-	.dvs_gpio = S3C64XX_GPK(0),
 };
 
 static struct regulator_consumer_supply vddarm_consumers[] = {
@@ -596,6 +596,24 @@ static struct wm831x_pdata crag_pmic_pdata = {
 	.touch = &touch_pdata,
 };
 
+/*
+ * VDDARM is eventually ending up as a regulator hanging on the MFD cell device
+ * "wm831x-buckv.1" spawn from drivers/mfd/wm831x-core.c.
+ *
+ * From the note on the platform data we can see that this is clearly DVS1
+ * and assigned as dcdc1 resource to the MFD core which sets .id of the cell
+ * spawning the DVS1 platform device to 1, then the cell platform device
+ * name is calculated from 10*instance + id resulting in the device name
+ * "wm831x-buckv.11"
+ */
+static struct gpiod_lookup_table crag_pmic_gpiod_table = {
+	.dev_id = "wm831x-buckv.11",
+	.table = {
+		GPIO_LOOKUP("GPIOK", 0, "dvs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct i2c_board_info i2c_devs0[] = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("tca6408", 0x20),
@@ -836,6 +854,7 @@ static void __init crag6410_machine_init(void)
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
 	dwc2_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
+	gpiod_add_lookup_table(&crag_pmic_gpiod_table);
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index b422eef97b77..018dbbd96771 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/wm831x/core.h>
@@ -50,7 +50,7 @@ struct wm831x_dcdc {
 	int base;
 	struct wm831x *wm831x;
 	struct regulator_dev *regulator;
-	int dvs_gpio;
+	struct gpio_desc *dvs_gpiod;
 	int dvs_gpio_state;
 	int on_vsel;
 	int dvs_vsel;
@@ -217,7 +217,7 @@ static int wm831x_buckv_set_dvs(struct regulator_dev *rdev, int state)
 		return 0;
 
 	dcdc->dvs_gpio_state = state;
-	gpio_set_value(dcdc->dvs_gpio, state);
+	gpiod_set_value(dcdc->dvs_gpiod, state);
 
 	/* Should wait for DVS state change to be asserted if we have
 	 * a GPIO for it, for now assume the device is configured
@@ -237,10 +237,10 @@ static int wm831x_buckv_set_voltage_sel(struct regulator_dev *rdev,
 	int ret;
 
 	/* If this value is already set then do a GPIO update if we can */
-	if (dcdc->dvs_gpio && dcdc->on_vsel == vsel)
+	if (dcdc->dvs_gpiod && dcdc->on_vsel == vsel)
 		return wm831x_buckv_set_dvs(rdev, 0);
 
-	if (dcdc->dvs_gpio && dcdc->dvs_vsel == vsel)
+	if (dcdc->dvs_gpiod && dcdc->dvs_vsel == vsel)
 		return wm831x_buckv_set_dvs(rdev, 1);
 
 	/* Always set the ON status to the minimum voltage */
@@ -249,7 +249,7 @@ static int wm831x_buckv_set_voltage_sel(struct regulator_dev *rdev,
 		return ret;
 	dcdc->on_vsel = vsel;
 
-	if (!dcdc->dvs_gpio)
+	if (!dcdc->dvs_gpiod)
 		return ret;
 
 	/* Kick the voltage transition now */
@@ -296,7 +296,7 @@ static int wm831x_buckv_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
 
-	if (dcdc->dvs_gpio && dcdc->dvs_gpio_state)
+	if (dcdc->dvs_gpiod && dcdc->dvs_gpio_state)
 		return dcdc->dvs_vsel;
 	else
 		return dcdc->on_vsel;
@@ -337,7 +337,7 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	int ret;
 	u16 ctrl;
 
-	if (!pdata || !pdata->dvs_gpio)
+	if (!pdata)
 		return;
 
 	/* gpiolib won't let us read the GPIO status so pick the higher
@@ -345,17 +345,14 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	 */
 	dcdc->dvs_gpio_state = pdata->dvs_init_state;
 
-	ret = devm_gpio_request_one(&pdev->dev, pdata->dvs_gpio,
-				    dcdc->dvs_gpio_state ? GPIOF_INIT_HIGH : 0,
-				    "DCDC DVS");
-	if (ret < 0) {
-		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %d\n",
-			dcdc->name, ret);
+	dcdc->dvs_gpiod = devm_gpiod_get(&pdev->dev, "dvs",
+			dcdc->dvs_gpio_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+	if (IS_ERR(dcdc->dvs_gpiod)) {
+		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %ld\n",
+			dcdc->name, PTR_ERR(dcdc->dvs_gpiod));
 		return;
 	}
 
-	dcdc->dvs_gpio = pdata->dvs_gpio;
-
 	switch (pdata->dvs_control_src) {
 	case 1:
 		ctrl = 2 << WM831X_DC1_DVS_SRC_SHIFT;
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index dcc9631b3052..1b8bb36e13b8 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -52,7 +52,6 @@ struct wm831x_battery_pdata {
  * I2C or SPI buses.
  */
 struct wm831x_buckv_pdata {
-	int dvs_gpio;        /** CPU GPIO to use for DVS switching */
 	int dvs_control_src; /** Hardware DVS source to use (1 or 2) */
 	int dvs_init_state;  /** DVS state to expect on startup */
 	int dvs_state_gpio;  /** CPU GPIO to use for monitoring status */
-- 
2.20.1

