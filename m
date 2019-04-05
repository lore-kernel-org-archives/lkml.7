Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2F217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434835;
	bh=XZe46RCMNCJii9MtzwLLJL/vme2lRgttLGcnWFyjCo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YvSiTVSGnJGLHopHvMQ709IbZlmH1yKrXeAlRFkTspELFssB8QrLICnfT5iqq+OKX
	 VSKIn1DBVWWtOjCYrazDz5t3mOLfkNRDx53b1ssd6xN6mcSwqkzSBTd8tJgRyX1I+w
	 ms0Yhz9use4KqtCIF7TG1WkKoaHbYREoG2+zbHm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDED1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:27:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfDED1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xdSl9JUhngWotCtrT0gu8jVzPA3wB87/bI4tFDht9FY=; b=Lobcdkaf4HRQ
        8GAOVQZdQ3+M/vAgegaorWA26LlgFHNsEjh32RuyBiaFeAwaeme3ox3OoOx6SsMZz1ptQ6yDjQHQl
        P96CrKWt0TmL1XdkmLlLV9/1ZAM4uJgjp5rzWHiBZVNEbjZRgB9adpatIhDH6PLPF5Hu3pZqcP7Fl
        gjFlI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFVQ-0005gq-7f; Fri, 05 Apr 2019 03:27:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 14731441D3C; Fri,  5 Apr 2019 10:27:01 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: de-assert CS before SPI mode change" to the spi tree
In-Reply-To:  <1554423259-26056-3-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032701.14731441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:27:01 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: de-assert CS before SPI mode change

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

From f3e182c33e534f4caeb255a3ab927debc0d222aa Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:02 -0700
Subject: [PATCH] spi: tegra114: de-assert CS before SPI mode change

With SW CS, during the transfer completion CS is de-asserted by writing
default command1 register value to SPI_COMMAND1 register. With this both
mode and CS state are set at the same time and if current transfer mode
is different to default SPI mode and if mode change happens prior to CS
de-assert, clock polarity can change while CS is active before transfer
finishes.

This causes Slave to see spurious clock edges resulting in data mismatch.

This patch fixes this by de-asserting CS before writing SPI_COMMAND1 to
its default value so through out the transfer it will be in same SPI mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 09cfae3abce2..8de002fc6943 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -856,6 +856,19 @@ static void tegra_spi_transfer_delay(int delay)
 	udelay(delay % 1000);
 }
 
+static void tegra_spi_transfer_end(struct spi_device *spi)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
+
+	if (cs_val)
+		tspi->command1_reg |= SPI_CS_SW_VAL;
+	else
+		tspi->command1_reg &= ~SPI_CS_SW_VAL;
+	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -918,8 +931,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 
 complete_xfer:
 		if (ret < 0 || skip) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
@@ -927,13 +939,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
-				tegra_spi_writel(tspi, tspi->def_command1_reg,
-						SPI_COMMAND1);
+				tegra_spi_transfer_end(spi);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
 			}
 		} else if (xfer->cs_change) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 		}
 
-- 
2.20.1

