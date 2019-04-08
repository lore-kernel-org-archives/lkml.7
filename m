Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7459E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708768;
	bh=lC3dWGDD4lFBUpGkH6EhfJEsHuTRAeVH5tZx/JxVNRg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lKe7ADbWp34HMEU2T0C9C9Lal7gOz2/bDBcbV+SE+83yrEFw5lW7zlbvTlW6zhigl
	 Flt8t4TgH7UVqeH62fi0l2N9isqtvZRfeAAm84eVFLapGmq+zmSl8dplnhExw1pkgr
	 4zpeCqMAE5SWOMhFIFRLVFGHTk/Iv44NbafGSyZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDHHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:32:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44948 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfDHHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eI9hFs7dZMQYQTyt81bLhoXzyJRp+tV8oHUTASo/jfo=; b=FqWuVPaB9TXq
        uC86jqxkYZgG9EVvtLBMLM43kMwtV2wg44C3X3OFGJ9MQUaQAVGcipRvHi6IzsjiPKmOi2Id/5vTO
        U8NEtLMlaZR6ROw1jAioTdIJf4+TRbMTg5vuMR4OQd5+lEt4cS4+/XqR93Js83QOMpkwMzaMk45Ta
        NjO1I=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOlm-0003ye-Cx; Mon, 08 Apr 2019 07:32:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0EFC6441D3B; Mon,  8 Apr 2019 14:32:33 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Make sure spi_master_put() is called in every error path" to the spi tree
In-Reply-To:  <20190403040133.1459-11-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073233.0EFC6441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:32:33 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Make sure spi_master_put() is called in every error path

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

From 8b797490b4db09492acda4b4a4a4355d2311a614 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:31 -0700
Subject: [PATCH] spi: gpio: Make sure spi_master_put() is called in every
 error path

There's a number of failure paths in spi_gpio_probe() that do not call
spi_master_put() potentially leaking memory. Fix this problem by
registering a cleanup funciont via devm_add_action_or_reset() right
after SPI controller is allocated.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 5ac9ae192ddf..d4a22f22b04c 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -362,6 +362,11 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	return 0;
 }
 
+static void spi_gpio_put(void *data)
+{
+	spi_master_put(data);
+}
+
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
@@ -377,6 +382,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
+	if (status)
+		return status;
+
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
@@ -428,11 +437,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	status = spi_bitbang_start(&spi_gpio->bitbang);
-	if (status)
-		spi_master_put(master);
-
-	return status;
+	return spi_bitbang_start(&spi_gpio->bitbang);
 }
 
 static int spi_gpio_remove(struct platform_device *pdev)
@@ -444,8 +449,6 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	/* stop() unregisters child devices too */
 	spi_bitbang_stop(&spi_gpio->bitbang);
 
-	spi_master_put(spi_gpio->bitbang.master);
-
 	return 0;
 }
 
-- 
2.20.1

