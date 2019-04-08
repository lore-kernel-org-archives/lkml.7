Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F1EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E60C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708700;
	bh=l7Ao2365Lzhs/841c3sY+lDFTJgALM4gjEpebkyk78A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SSDP90usvWSKLthq+CHP2e2737rWjO+slVkO+KWX22swSAYT+m8R9B/ecWyaEyF7V
	 ViwJjQI65UkIVQVyoUeY5wzm/1gzQrCK9IswzT8uR7bs3Vi7x9fVnZluU/4Tey0zaN
	 a0dVI6O3jtKYTIEuWrFXmoHEO1FYD92K/gGuJU3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDHHbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:31:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jec93GaIDzGx2zkanrwo2mynowPWrMmVjcDoxFL6bNk=; b=LMJltWpSdz01
        ghBgKQ3fUAIAASrVvtzYsetSlWjAjpLXkCIWKbchxmgGTvf5QX7lBDCgUgwJ/4B/1/vn9dv+xqNb4
        IeN0A5R94pvvrFME9M5JN5qQfJRABCsRvaZaQwKofJ3tOSXzWoR6refvMx/NAfhhWcZCOIJChxjNI
        rMNmA=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOkb-0003wN-Ea; Mon, 08 Apr 2019 07:31:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3BF84441D3B; Mon,  8 Apr 2019 14:31:19 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: document tx/rx clock delay properties" to the spi tree
In-Reply-To:  <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073119.3BF84441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:31:19 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: document tx/rx clock delay properties

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

From 7558f978f9b66a2bc284a0e8c0764b88305bc29f Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:18 -0700
Subject: [PATCH] spi: document tx/rx clock delay properties

Tegra SPI controller has TX and RX trimmers to tuning the delay of
SPI master clock with respect to the data.

TX and RX tap values are based on the platform validation across the
PVT and the trimmer values vary based on the trace lengths to the
corresponding SPI devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/nvidia,tegra114-spi.txt      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 9ba7c5a273b4..db8e0d71c5bc 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -23,6 +23,18 @@ Required properties:
 Recommended properties:
 - spi-max-frequency: Definition as per
                      Documentation/devicetree/bindings/spi/spi-bus.txt
+Optional properties:
+- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
+  with this tap value. This property is used to tune the outgoing data from
+  Tegra SPI master with respect to outgoing Tegra SPI master clock.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
+  with this tap value. This property is used to adjust the Tegra SPI master
+  clock with respect to the data from the SPI slave device.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+
 Example:
 
 spi@7000d600 {
@@ -38,4 +50,12 @@ spi@7000d600 {
 	reset-names = "spi";
 	dmas = <&apbdma 16>, <&apbdma 16>;
 	dma-names = "rx", "tx";
+	<spi-client>@<bus_num> {
+		...
+		...
+		nvidia,rx-clk-tap-delay = <0>;
+		nvidia,tx-clk-tap-delay = <16>;
+		...
+	};
+
 };
-- 
2.20.1

