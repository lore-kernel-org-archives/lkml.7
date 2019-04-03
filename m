Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7885C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CFB20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266563;
	bh=GMzd+wpP8MVT1rtCzrFZWAp0q2Td2I3S68np2npNgE4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=u5Zvok7edrHsZnY3+J7yUOGWcOUBvg8nl4mqrr9ELj4apNrX1S5KzUAJXJSzVlIls
	 KPye0ILTCO64yfYBkGLmLe7jN2M8iMUvL2ypdHTMcTfhu5K/w8bMAZ/dPF/ePUWJju
	 R43dxJgTECPgJG8ORReYoCbqpY4ddQ/3ezJyh4WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfDCEml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40888 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfDCEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TLvp4yG0sVtdB0ARJWwEDlQ1b0alpngymSXvOtzUmP0=; b=kBx93Nsh6dRE
        tIo1aJfUr9NNHkjw7ppU0NeYgYc4ftUo1+6ym84EpUBhbpuDlhyQrpDp1DcEn+GgQ6XhVSAZuIvsd
        hhb9uzZ0eqFqQmRh3YR6vTgx1g/OlI/lurNh2SFsqHyo5QNvgQv6+KMBz7VF7A8NLBQKvVQuw6FTs
        TZ4Pc=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjQ-000411-C6; Wed, 03 Apr 2019 04:42:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7DEDF440083; Wed,  3 Apr 2019 05:42:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Add local struct device pointer in spi_gpio_probe()" to the spi tree
In-Reply-To:  <20190403040133.1459-3-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044233.7DEDF440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Add local struct device pointer in spi_gpio_probe()

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

From 96cad6d78f7f8feac456002020971cba6073bff9 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:23 -0700
Subject: [PATCH] spi: gpio: Add local struct device pointer in
 spi_gpio_probe()

Use a local "struct device *dev" in spi_gpio_probe() for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 675fd65ebf1d..2869af5ff936 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -379,6 +379,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	struct device			*dev = &pdev->dev;
 	u16 master_flags = 0;
 	bool use_of = 0;
 
@@ -388,19 +389,19 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status > 0)
 		use_of = 1;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 #ifdef GENERIC_BITBANG
 	if (!pdata || (!use_of && !pdata->num_chipselect))
 		return -ENODEV;
 #endif
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio));
+	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	spi_gpio->cs_gpios = devm_kcalloc(&pdev->dev,
+	spi_gpio->cs_gpios = devm_kcalloc(dev,
 				pdata->num_chipselect,
 				sizeof(*spi_gpio->cs_gpios),
 				GFP_KERNEL);
@@ -416,7 +417,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
-	status = spi_gpio_request(&pdev->dev, spi_gpio,
+	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
 	if (status)
 		return status;
@@ -431,7 +432,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
 #ifdef CONFIG_OF
-	master->dev.of_node = pdev->dev.of_node;
+	master->dev.of_node = dev->of_node;
 #endif
 
 	spi_gpio->bitbang.master = master;
-- 
2.20.1

