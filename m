Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266565;
	bh=88WZu1AGyDmpGJE8RA8QwgOKM9QU6nqjfHAzldgei6g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fxbBfEmiEU2Tt4J5QAhFghdugeprMfT67ZppvcR8CsdkXARQyutp7EBlc4Bup+0Oy
	 m8zek5GDw4eUpulBcPuDBZrzXvGUkDAmB+g+X2JCY+PFLUp6+7j+I7Hef+xLx63Qn/
	 SYKf/DEtZIgt2Ns8boBQqqRFuVc8MQJb3G0YXRWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfDCEmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfDCEml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/rjqfJuljJfNtzM8Gz9y1ioTcekoXUKwsE/dT5RqT0o=; b=ZoQ2mygobnGP
        zhg3fpW5WPbbyOAtkuwotSgnk6QVIpcZlRqmRtCrxNPQUT8VrbxpJ0+jMLtGxFxKzeV1xWSxh9gcb
        9CQGIMYUMAb60SX6lG+xAMhIU+XZ8X69JqA6uF+N0Qqsm/GItTMzbzp2ZaS4FdNWLi11l/nsWBzuR
        w2x0g=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjT-000418-IN; Wed, 03 Apr 2019 04:42:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A56CF440082; Wed,  3 Apr 2019 05:42:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Drop unused spi_to_pdata()" to the spi tree
In-Reply-To:  <20190403040133.1459-2-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044236.A56CF440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Drop unused spi_to_pdata()

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

From 4d9f8fed42694016b015cbfe201effe8aff0d1b3 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:22 -0700
Subject: [PATCH] spi: gpio: Drop unused spi_to_pdata()

Spi_to_pdata() is not used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557..675fd65ebf1d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -96,12 +96,6 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	return spi_gpio;
 }
 
-static inline struct spi_gpio_platform_data *__pure
-spi_to_pdata(const struct spi_device *spi)
-{
-	return &spi_to_spi_gpio(spi)->pdata;
-}
-
 /* These helpers are in turn called by the bitbang inlines */
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-- 
2.20.1

