Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0763C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C421783
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763633;
	bh=nACu6JnOw6YddVeIiWfa5pkV72At1fLYWtArnVehk/A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mUVLMe+vfNzhB4pkDCKgyfwhxngXyGrb/75/iJuOtOItFNR31XOXsY7sEhp52JCF+
	 PpP9uhE7PSotvqXRiCw0c4YGuwdGoe+Tu/RVhpZiFXA9WJ5KxsWHOCw6DwHgoIWMYa
	 tT46UVdk16kWQ831XARwHLYQNPbg0QLu+OewoUJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEBCUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:20:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfEBCTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xrGF478Opil57Whl1eQHJAw/ZeOQ1NM8Qj6NusvyTHs=; b=u36bTq++TXGI
        LqMDoX2k+HyKVz2ff3I5a76amG9nFhdNvRBUZu8QOw/MyisoYn42rY33xOXcYcBWy8hLFiFMKovZL
        bdIOZNnryYulWAqecpj8D67ULNh2waPo/FW4d+w9cMXMrfJjDI8TNeKtTeMxATl7CNfWFWsOK9jgn
        6I6go=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JO-0005vM-K7; Thu, 02 May 2019 02:19:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 40504441D3E; Thu,  2 May 2019 03:18:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@t-platforms.ru>
Subject: Applied "spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select" to the spi tree
In-Reply-To: <20190426103007.29612-1-fancer.lancer@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021859.40504441D3E@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From d61ad23cb3be09ff4956e9b9794134456522817f Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Fri, 26 Apr 2019 13:30:07 +0300
Subject: [PATCH] spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO
 chip-select

When GPIO chip-select is used nothing prevents any available SPI
controllers to work with both CS-high and traditional CS-low modes.
In fact the SPI bus core code already does it, so we don't need to
introduce any modification there. But spi_setup() still fails to
switch the interface settings if CS-high flag is set for the case
of GPIO-driven slave chip-select when the SPI controller doesn't
support the hardwired CS-inversion. Lets fix it by clearing the
SPI_CS_HIGH flag out from bad_bits (unsupported by controller) when
client chip is selected by GPIO.

This feature is useful for slave devices, which in accordance with
communication protocol can work with both active-high and active-low
chip-selects. I am aware of one such device. It is MMC-SPI interface,
when at init sequence the driver needs to perform a read operation with
low and high chip-select sequentially (requirement of 74 clock cycles
with both chipselect, see the mmc_spi driver for details).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2195fa265aef..5e75944ad5d1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2945,6 +2945,11 @@ int spi_setup(struct spi_device *spi)
 	 * so it is ignored here.
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	/* nothing prevents from working with active-high CS in case if it
+	 * is driven by GPIO.
+	 */
+	if (gpio_is_valid(spi->cs_gpio))
+		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
-- 
2.20.1

