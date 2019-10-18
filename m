Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14618CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DAA222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422094;
	bh=Eki3mHWWB/b2+fIfIm4jIpBykWaxQqrUj4/pSJZ+Dac=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kqZr4OTmCGgO5nRt5dwgsCaoGEGZYME4lPVNNs2kRLTTR46y6J+9Xtpc/VG1qFjR9
	 Qmb93PXlgRMZxwdxf4U1EfvVyyl64ri9fof3sY0SYdmDP/J6L8oXMPS8/5KB+/Ekpr
	 4s92b8QNeVIB18GJ1khLU6S/7c6CcNOsfK7r2Nxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505800AbfJRSIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505766AbfJRSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6OLawQSqK81xzP4HuvY/4eKlvEfofNZTR3ny2vEIaSE=; b=R7V5aLOUCrwT
        iSzdAwE5I/Q1zcSDYocrvBhgoOUp0LB51unN2EIya735X7smxBIscTp+co/GgGwmqm1YJKqlddFxD
        OcjrJxAVxa+KxL5N9fEmEdp73t4uqyFgBuYQdz3cL1o9oFcOkDvzYLIB2CLhS9er5h9NtLiZDRbUP
        Lh+Cg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWea-0004H3-QA; Fri, 18 Oct 2019 18:07:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 500EB2743259; Fri, 18 Oct 2019 19:07:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: atmel: Remove useless private field" to the spi tree
In-Reply-To: <20191017141846.7523-5-gregory.clement@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180708.500EB2743259@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: atmel: Remove useless private field

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 60086e23e64f7b3b60d957471cfd10948e25648e Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:43 +0200
Subject: [PATCH] spi: atmel: Remove useless private field

Since the conversion to GPIO descriptor, the GPIO used as chip select,
can be directly access from the spi_device struct. So there is no need
to keep the field npcs_pin.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-5-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b511df6a4846..19600de40422 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -284,7 +284,6 @@ struct atmel_spi {
 
 /* Controller-specific per-slave state */
 struct atmel_spi_device {
-	struct gpio_desc	*npcs_pin;
 	u32			csr;
 };
 
@@ -347,8 +346,8 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (asd->npcs_pin)
-			gpiod_set_value(asd->npcs_pin, 1);
+		if (spi->cs_gpiod)
+			gpiod_set_value(spi->cs_gpiod, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -364,8 +363,8 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
-		if (asd->npcs_pin && spi->chip_select != 0)
-			gpiod_set_value(asd->npcs_pin, 1);
+		if (spi->cs_gpiod && spi->chip_select != 0)
+			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
 
@@ -374,7 +373,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 {
-	struct atmel_spi_device *asd = spi->controller_state;
 	u32 mr;
 
 	/* only deactivate *this* device; sometimes transfers to
@@ -388,10 +386,10 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "DEactivate NPCS, mr %08x\n", mr);
 
-	if (!asd->npcs_pin)
+	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
 	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
-		gpiod_set_value(asd->npcs_pin, 0);
+		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
 static void atmel_spi_lock(struct atmel_spi *as) __acquires(&as->lock)
@@ -1205,9 +1203,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 		if (!asd)
 			return -ENOMEM;
 
-		if (spi->cs_gpiod)
-			asd->npcs_pin = spi->cs_gpiod;
-
 		spi->controller_state = asd;
 	}
 
-- 
2.20.1

