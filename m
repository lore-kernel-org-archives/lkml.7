Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8732C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891D920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708751;
	bh=IPev5wO5UUfssHnrHb1W/Xg47YDFJ+UylPef1BgH9FE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZqW5yfbdho25ErwCyZGWYETtTdmteZkK0yC8uRPv/sQpKMbjy+mRn5MMALemPJR/i
	 6wCXoE5Qd/QJao0J7fRRVpWlNPBc0J6Z3JT+fP6+y5TAydJCugUYAqLpoVBcsFO+DI
	 qQw/cLmgeCmBEYIHtTipYPP2P+Z01o6pNMDQJpiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDHHca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:32:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1HHBuqUJMg6qfY4FJ7Z0UW+CokHoLrU1408RpkEN+pg=; b=iV150W642i7r
        xtVPI4F10S/WHNNVmYWWVgBe4CpauHW2G9k0dSUR5b12LitkWjvSZX6rLTuiqRLuKGreF1FjiDra7
        nOzskc7JbgwRTsRKAow0tX3EgfJ3p7wkuDn7QLHhcs9V6aUdi639AASU9pQPI5oMhcDhO+clnV9ZS
        SJcgk=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOlV-0003y5-BP; Mon, 08 Apr 2019 07:32:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 70AD5441D3B; Mon,  8 Apr 2019 14:32:15 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Use devm_spi_register_master()" to the spi tree
In-Reply-To:  <20190403040133.1459-13-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073215.70AD5441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:32:15 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Use devm_spi_register_master()

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

From 79567c1a321e7396e734135d56950311dde07db2 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:33 -0700
Subject: [PATCH] spi: gpio: Use devm_spi_register_master()

Replace spi_bitbang_start() with a combination of spi_bitbang_init()
and devm_spi_register_master() and drop all of the explicit
cleanup-related code that's no longer necessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index d4a22f22b04c..487ee55d26f7 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -396,8 +396,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	platform_set_drvdata(pdev, spi_gpio);
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
@@ -437,19 +435,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	return spi_bitbang_start(&spi_gpio->bitbang);
-}
-
-static int spi_gpio_remove(struct platform_device *pdev)
-{
-	struct spi_gpio			*spi_gpio;
-
-	spi_gpio = platform_get_drvdata(pdev);
-
-	/* stop() unregisters child devices too */
-	spi_bitbang_stop(&spi_gpio->bitbang);
+	status = spi_bitbang_init(&spi_gpio->bitbang);
+	if (status)
+		return status;
 
-	return 0;
+	return devm_spi_register_master(&pdev->dev, spi_master_get(master));
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -460,7 +450,6 @@ static struct platform_driver spi_gpio_driver = {
 		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
 	},
 	.probe		= spi_gpio_probe,
-	.remove		= spi_gpio_remove,
 };
 module_platform_driver(spi_gpio_driver);
 
-- 
2.20.1

