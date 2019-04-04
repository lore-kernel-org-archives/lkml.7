Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88407206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554357905;
	bh=ku5DaAxKwkGU2UHSZzmJX5tVyy0fLOvQTI/4MXhT5XY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aLhzgEP1gAQmHNfVUgBHQhVgzQa9AC+2pdsz0B2g/9QLkYGRr78/vNzZye/xLo/AP
	 GfB29VILTUu/DMQsyLeXm1HTGTfPlnUi4gf48oMdh/iCrmdipJi0A6oWjoClWQUghk
	 mbOdmTnakBYWLK7338ldiy2t8w9JRxiow6jYI+/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDDGFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:05:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rgi0u9a2TIBbwjeZ4S/mn7UezfmAhymPA3l8R1xqYmc=; b=swh5LAOL4tyk
        U1S/ySpvhaO/rvxu4drIe0LKf6vC2trLDzcgXtqb4g225DjEnzn28OMrasuPlsfYhUNWsXK+bX3h5
        Id8Kwd2PwPhVQl0q7d/Aa3GYG7oUqHhqUQyKxDEhfQpxP0oCvbp7HSRz27q77LopU4arzgnvB1UK2
        uLy/8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBvUc-0004Mm-RZ; Thu, 04 Apr 2019 06:04:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 937F4441D3C; Thu,  4 Apr 2019 13:04:51 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-gpio: Remove spi->controller_data comment" to the spi tree
In-Reply-To:  <20190403144602.8098-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190404060451.937F4441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 13:04:51 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-gpio: Remove spi->controller_data comment

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

From 807195f2103f8662f8c0f9baf71dd7bc1a6b745b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 3 Apr 2019 16:46:02 +0200
Subject: [PATCH] spi: spi-gpio: Remove spi->controller_data comment

The conversion from GPIO numbers to GPIO descriptors removed the use of
spi->controller_data, but forgot to update a comment referring to it.

Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3e98c1a0ba6d..e89348d95817 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -35,7 +35,6 @@
  * platform_device->driver_data ... points to spi_gpio
  *
  * spi->controller_state ... reserved for bitbang framework code
- * spi->controller_data ... holds chipselect GPIO
  *
  * spi->master->dev.driver_data ... points to spi_gpio->bitbang
  */
-- 
2.20.1

