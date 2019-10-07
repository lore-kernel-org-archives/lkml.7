Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7680ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF28221721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453418;
	bh=JbI2SIpQkk1kopRQ8jW8llfUS+aY9nXS3zBJsS4PD4k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nXtonUavmruXVSi4wzXm7W5gqPovke0JBuoymP5Cj2dvty3g4Lnb5UBQvxwVO5vIX
	 dZs9SDxUeLN4UeTYOWynqGgYDc93DFI5Gjio46YOpDvoIM/soigAJB1FhScUBhxn5R
	 yXzVr1p44pLd8m0YZRNkvuu+Y0t2gaCGvPVImZN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfJGNDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfJGNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aWgEWqgOX8lfxgUwmjfcjaxZhFTTqWI3Qo+BIGk677c=; b=DtpUlH5GNKaP
        XeIV9r3sQ0JHgVyRc0qxQxw+ChyUpdsxOzb/1fXjx4XXGS2kGuvB+n6nyDClzB28UuJPDlEjeb4bR
        sMeA5GpHxzlsUmK/23a/HTgvK4CVyXeoCPTOfbG0R06WhWhmryoSSjkqvklbLWKyqPB7XPgekVpsM
        PBVgs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfh-0003TE-Qp; Mon, 07 Oct 2019 13:03:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 47D48274162F; Mon,  7 Oct 2019 14:03:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, <linux-spi@vger.kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "spi: gpio: Look for a device node instead of match" to the spi tree
In-Reply-To: <20191004214334.149976-9-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191007130329.47D48274162F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Look for a device node instead of match

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

From 62217f8b084a05dd2d84781a8ca065098df21ec7 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 4 Oct 2019 14:43:32 -0700
Subject: [PATCH] spi: gpio: Look for a device node instead of match

This driver doesn't do anything with the match for the device node. The
logic is the same as looking to see if a device node exists or not
because this driver wouldn't probe unless there is a device node match
when the device is created from DT. Just test for the presence of the
device node to simplify and avoid referencing a potentially undefined
match table when CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-spi@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191004214334.149976-9-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..42f4d82e9c5a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -362,9 +362,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
-	const struct of_device_id	*of_id;
-
-	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
@@ -374,7 +371,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	if (of_id)
+	if (pdev->dev.of_node)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
 		status = spi_gpio_probe_pdata(pdev, master);
-- 
2.20.1

