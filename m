Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C4D208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708728;
	bh=FQVRIvwDpoTA7KWVKylzFAKinu6dUc3l5Tgnd6HRoqI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yzKgnsHcFuZ9b0CJvAXqiGqBV78qcZyGEHjzmSNS80JMg6HvJK7b8H7hscGFyMBQb
	 HCTP70sVoifSItc7nCc3n6kuCnfeMcKUUXb7x7+vsp51bb9Qcbo0r5eSEJUJxIgEhR
	 86o3IE62F5uYCdzT3C99nB4AGxMedQGNCmR8oPbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDHHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:32:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jX8MfHGCihgSwnrs9/cmOfM1mzV8eHAPE92hnX16Qrg=; b=GHnAXCsf+lLl
        BTY4ngOZw0XiXaoPtkU0RxV7YpmGj9FHj7bQst7xFcADpK9pac26bocT93LXk5fs8Vxrik+60Vmao
        df7374lTj7jKfl4He/XCczWH0naeiCeFNcWKZaW0r47MfF4/Y6EEkyeXujUgBBmO5MXm90SYPQr/d
        manFA=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOl0-0003wt-RM; Mon, 08 Apr 2019 07:31:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B4C2C441D3B; Mon,  8 Apr 2019 14:31:39 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi-summary: document set_cs_timing" to the spi tree
In-Reply-To:  <1554423259-26056-16-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073139.B4C2C441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:31:39 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi-summary: document set_cs_timing

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

From 24496da6927fa7399f7f60ab31b4cea27ec3ed00 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:15 -0700
Subject: [PATCH] spi-summary: document set_cs_timing

This patch documents set_cs_timing SPI master method.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/spi/spi-summary | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 1721c1b570c3..1a63194b74d7 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -572,6 +572,12 @@ SPI MASTER METHODS
 	0: transfer is finished
 	1: transfer is still in progress
 
+    master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles)
+	This method allows SPI client drivers to request SPI master controller
+	for configuring device specific CS setup, hold and inactive timing
+	requirements.
+
     DEPRECATED METHODS
 
     master->transfer(struct spi_device *spi, struct spi_message *message)
-- 
2.20.1

