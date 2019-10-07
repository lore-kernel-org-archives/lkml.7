Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C43C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F88A21924
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453413;
	bh=kceC5PGJ38aOp+x55yKG39QzkRFu144KNvUGNvqSKuo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IHSirHVJbhMniyHdqDj9kgdhwi8ce/5i12hSdGgku+a9LEMl67n26D2GBUashojHO
	 msp2bs8YGqRhnxNYunoK9qtWsoYM5vF4HtW/mzN2SGW2NPLKD18JC9VMUX558v15t9
	 fz3T3zNt4XArbTTeMO/2o5JVgsYhL3uwNq1IErjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfJGND3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfJGNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nh4dSLiskRPL87hNgxggsPDiGEiHyHHb3/9LCSGv6Yc=; b=QLKvZ1kDPXLp
        x3lHR1EtjBUpatlyVKh1q39xIzOSDMfBR1IjphBBo4UoKSR/j71oovpr2sHvIzDnFP8tH5MK02BWS
        Ifu+U7cy5NUGM66q/n8XaQUXN3R5VSOn5pPOaeRZV7384WfPeSWScanh3uIOBo6jzjrQoUnZfII3h
        O5B7U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfa-0003Sn-H8; Mon, 07 Oct 2019 13:03:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 07E9D274162F; Mon,  7 Oct 2019 14:03:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "gpiolib: introduce fwnode_gpiod_get_index()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20191007130322.07E9D274162F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   gpiolib: introduce fwnode_gpiod_get_index()

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

From 13949fa9daa91a60c7cfef40755f7611cc2cf653 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 12 Sep 2019 20:22:39 -0700
Subject: [PATCH] gpiolib: introduce fwnode_gpiod_get_index()

This introduces fwnode_gpiod_get_index() that iterates through common gpio
suffixes when trying to locate a GPIO within a given firmware node.

We also switch devm_fwnode_gpiod_get_index() to call
fwnode_gpiod_get_index() instead of iterating through GPIO suffixes on
its own.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20190913032240.50333-3-dmitry.torokhov@gmail.com
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-devres.c | 16 +-----------
 drivers/gpio/gpiolib.c        | 48 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h | 13 ++++++++++
 3 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 9a0475c87f95..4421be09b960 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -205,29 +205,15 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 					      enum gpiod_flags flags,
 					      const char *label)
 {
-	char prop_name[32]; /* 32 is max size of property name */
 	struct gpio_desc **dr;
 	struct gpio_desc *desc;
-	unsigned int i;
 
 	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
 			  GFP_KERNEL);
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id)
-			snprintf(prop_name, sizeof(prop_name), "%s-%s",
-					    con_id, gpio_suffixes[i]);
-		else
-			snprintf(prop_name, sizeof(prop_name), "%s",
-					    gpio_suffixes[i]);
-
-		desc = fwnode_get_named_gpiod(fwnode, prop_name, index, flags,
-					      label);
-		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
-			break;
-	}
+	desc = fwnode_gpiod_get_index(fwnode, con_id, index, flags, label);
 	if (IS_ERR(desc)) {
 		devres_free(dr);
 		return desc;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bdbc1649eafa..2342deaace17 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4324,6 +4324,54 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	return count;
 }
 
+/**
+ * fwnode_gpiod_get_index - obtain a GPIO from firmware node
+ * @fwnode:	handle of the firmware node
+ * @con_id:	function within the GPIO consumer
+ * @index:	index of the GPIO to obtain for the consumer
+ * @flags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
+ *
+ * This function can be used for drivers that get their configuration
+ * from opaque firmware.
+ *
+ * The function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * Returns:
+ * On successful request the GPIO pin is configured in accordance with
+ * provided @flags.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
+					 const char *con_id, int index,
+					 enum gpiod_flags flags,
+					 const char *label)
+{
+	struct gpio_desc *desc;
+	char prop_name[32]; /* 32 is max size of property name */
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
+		if (con_id)
+			snprintf(prop_name, sizeof(prop_name), "%s-%s",
+					    con_id, gpio_suffixes[i]);
+		else
+			snprintf(prop_name, sizeof(prop_name), "%s",
+					    gpio_suffixes[i]);
+
+		desc = fwnode_get_named_gpiod(fwnode, prop_name, index, flags,
+					      label);
+		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
+			break;
+	}
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
+
 /**
  * gpiod_count - return the number of GPIOs associated with a device / function
  *		or -ENOENT if no GPIO has been assigned to the requested function
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index dc0ddcd30515..5215fdba6b9a 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -176,6 +176,10 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					 const char *propname, int index,
 					 enum gpiod_flags dflags,
 					 const char *label);
+struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
+					 const char *con_id, int index,
+					 enum gpiod_flags flags,
+					 const char *label);
 struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 					      struct fwnode_handle *child,
 					      const char *con_id, int index,
@@ -531,6 +535,15 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline
+struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
+					 const char *con_id, int index,
+					 enum gpiod_flags flags,
+					 const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline
 struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 					      struct fwnode_handle *fwnode,
-- 
2.20.1

