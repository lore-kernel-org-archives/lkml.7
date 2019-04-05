Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A920CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF6B217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434845;
	bh=m+fvsVHokxAgcqpBOA5GzLriQAsbc79JT7JFrHqtil4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yihPo+siMBNeSGuPdUiAKq1po99/abZLbyLA0rCzJPang/jEg4F6g/dg2GRePPaMk
	 loqvyTzyM5cgidSyu/sm4vXWy1peeXPt2FqAQbrc3+pwgWDJ/NWS7djLy+wTH4Iq/n
	 JC8NcoHPxU9ymi+gbunWNkuHjR9gxNBezsTaSWDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfDED0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:26:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfDED0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sVELXPNh52TBNLCa3BJmzQyPugW+zpOCA7awgB4QjNc=; b=eYk1hlokv3c9
        e9TSNX8mfxuWzaTo0V1x38Fgdk4g48JdnPJ8BruI/Y3leuQ0KKuQuUzIwb0jR3Bh+GLjLlt9lFlAo
        1eHeUpvRXb7I3X8RRZvFtDLRI/1x8yPUIER7viTyWhBxPbqPQApU/tLKWCgu4O1du0pl4sBfKFIfG
        4Y0I4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFV4-0005g6-DU; Fri, 05 Apr 2019 03:26:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3C438441D3B; Fri,  5 Apr 2019 10:26:39 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Don't call spi_get_gpio_descs() before device name is set" to the spi tree
In-Reply-To:  <20190403040133.1459-8-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032639.3C438441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:26:39 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Don't call spi_get_gpio_descs() before device name is set

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 0a919ae49223d32ac0e8be3494547fcd1e4aa0aa Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:28 -0700
Subject: [PATCH] spi: Don't call spi_get_gpio_descs() before device name is
 set

Move code calling spi_get_gpio_descs() to happen after ctlr->dev's
name is set in order to have proper GPIO consumer names.

Before:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |(null) CS1          ) out lo
 gpio-41  (                    |(null) CS0          ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

After:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |spi0 CS1            ) out lo
 gpio-41  (                    |spi0 CS0            ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2ad20c735b61..a83fcddf1dad 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2281,24 +2281,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	if (!spi_controller_is_slave(ctlr)) {
-		if (ctlr->use_gpio_descriptors) {
-			status = spi_get_gpio_descs(ctlr);
-			if (status)
-				return status;
-			/*
-			 * A controller using GPIO descriptors always
-			 * supports SPI_CS_HIGH if need be.
-			 */
-			ctlr->mode_bits |= SPI_CS_HIGH;
-		} else {
-			/* Legacy code path for GPIOs from DT */
-			status = of_spi_register_master(ctlr);
-			if (status)
-				return status;
-		}
-	}
-
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
 	 */
@@ -2355,6 +2337,25 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * registration fails if the bus ID is in use.
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
+
+	if (!spi_controller_is_slave(ctlr)) {
+		if (ctlr->use_gpio_descriptors) {
+			status = spi_get_gpio_descs(ctlr);
+			if (status)
+				return status;
+			/*
+			 * A controller using GPIO descriptors always
+			 * supports SPI_CS_HIGH if need be.
+			 */
+			ctlr->mode_bits |= SPI_CS_HIGH;
+		} else {
+			/* Legacy code path for GPIOs from DT */
+			status = of_spi_register_master(ctlr);
+			if (status)
+				return status;
+		}
+	}
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1

