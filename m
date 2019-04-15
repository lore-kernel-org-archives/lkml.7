Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA3BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B520881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318437;
	bh=3WJH4C1tpsAN4QFFWh1v6iF7nP8zJ9Qf+zJh/AZwtvU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EgHdVFZQezWwOC93zIXKVD3VHMhnkd1zp15WSIr4LsQCcoc95El8ULnDJcbCxPB5L
	 H6y3r5+TXS5GCWlFtzGyHm1F8bTyY206HXqr10t/dFh3jM2qYtyeumlx5m2M613cTE
	 VDhltdC+h/ybNu6Xx0GKV8rlWnW9xcSfdMHnOO28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfDOIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:53:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDOIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wBptgvrzAMh9ELb+BdRDByUxGWzc4n6+0yA4/VFTrjQ=; b=QIF1lBN97CDr
        tDFZf1Nt0U3DuiItHaHe+2kfkMHn4Qr0qWuhFNOcEcpSbn0OsBuJ01XBdpDbBUe/9blCEmlu1FWQb
        z9K/Jhw8bNUsaS/XhFoyGtSrgb6fhxw1HwMFlugH9I1eGWEjNsVm3mvZcwrStWtr7hX8Eota7adBh
        hW1iM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMx-0007jO-Fe; Mon, 15 Apr 2019 08:53:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BCF251127B96; Mon, 15 Apr 2019 09:53:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: fix SCR (divisor) calculation" to the spi tree
In-Reply-To: <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
X-Patchwork-Hint: ignore
Message-Id: <20190415085333.BCF251127B96@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: fix SCR (divisor) calculation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From bf0c999f7f0e8934c8db8261fb67a38770fffac2 Mon Sep 17 00:00:00 2001
From: Flavio Suligoi <f.suligoi@asem.it>
Date: Fri, 12 Apr 2019 09:32:19 +0200
Subject: [PATCH] spi: pxa2xx: fix SCR (divisor) calculation

Calculate the divisor for the SCR (Serial Clock Rate), avoiding
that the SSP transmission rate can be greater than the device rate.

When the division between the SSP clock and the device rate generates
a reminder, we have to increment by one the divisor.
In this way the resulting SSP clock will never be greater than the
device SPI max frequency.

For example, with:

 - ssp_clk  = 50 MHz
 - dev freq = 15 MHz

without this patch the SSP clock will be greater than 15 MHz:

 - 25 MHz for PXA25x_SSP and CE4100_SSP
 - 16,56 MHz for the others

Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
so the max rate of the SPI device clock is respected.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d02..d2076f2f468f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -884,10 +884,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 
 	rate = min_t(int, ssp_clk, rate);
 
+	/*
+	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
+	 * that the SSP transmission rate can be greater than the device rate
+	 */
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
-		return (ssp_clk / (2 * rate) - 1) & 0xff;
+		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
 	else
-		return (ssp_clk / rate - 1) & 0xfff;
+		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-- 
2.20.1

