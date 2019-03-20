Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B987C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08A6218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103006;
	bh=fnYmP+5AVb9WuIxi1SpEgJcWN/lQ+7e/1IqnLBgAF+s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IJbz1awvWcHQLzH0VjzLNIjuvTFFgpZ5tRNBRzMtAuDKDKTP5bGwgcAf59RGzVkGD
	 hRYPeAk6QCoCrjh95nTvvelg19NEMCzV4ik6gjgkMtquQSPGqglHBN5MtY3JLwwwpq
	 x0Ti67m2rMXnCwxEZq7wHoehpdSc+K6sTRK95al0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCTRaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44210 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfCTR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+OEx9YeAxPnGppiGBXPW7dN02Mh41WHNKlOf7E50Plw=; b=UXeo/8hxkZ2O
        VjmHpWQxbsPDTRrQcNU/Ym31epBSUO8v4vcpTVZ2oRm3IQER/4ll6DrnPNJfEGdIxr3D2kDMQ+TNj
        YKDVIXrsI7YkZ5odkA9vty3ocHFhfa6WoPYa1GrXILleCtvqMYqiFR7o1+TB7TtEegwgNSBjTH3os
        1OTjU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2C-00019D-Cd; Wed, 20 Mar 2019 17:29:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C6E0B1126E4C; Wed, 20 Mar 2019 17:29:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     Harald Geyer <harald@ccbib.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Reword the binding document" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190320172947.C6E0B1126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Reword the binding document

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 80c94557e94f25df5df00fd94e2a58bf31230fce Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@gmail.com>
Date: Sat, 16 Mar 2019 21:25:51 +0100
Subject: [PATCH] regulator: gpio: Reword the binding document

Reword the binding document to make it clear how the propeties work
and which properties affect which other properties.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Harald Geyer <harald@ccbib.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org
To: devicetree@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/gpio-regulator.txt     | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 1f496159e2bb..dd25e73b5d79 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -4,16 +4,30 @@ Required properties:
 - compatible		: Must be "regulator-gpio".
 - regulator-name	: Defined in regulator.txt as optional, but required
 			  here.
-- states		: Selection of available voltages and GPIO configs.
-                          if there are no states, then use a fixed regulator
+- gpios			: Array of one or more GPIO pins used to select the
+			  regulator voltage/current listed in "states".
+- states		: Selection of available voltages/currents provided by
+			  this regulator and matching GPIO configurations to
+			  achieve them. If there are no states in the "states"
+			  array, use a fixed regulator instead.
 
 Optional properties:
-- enable-gpio		: GPIO to use to enable/disable the regulator.
-- gpios			: GPIO group used to control voltage.
-- gpios-states		: gpios pin's initial states array. 0: LOW, 1: HIGH.
-			  defualt is LOW if nothing is specified.
+- enable-gpios		: GPIO used to enable/disable the regulator.
+			  Warning, the GPIO phandle flags are ignored and the
+			  GPIO polarity is controlled solely by the presence
+			  of "enable-active-high" DT property. This is due to
+			  compatibility with old DTs.
+- enable-active-high	: Polarity of "enable-gpio" GPIO is active HIGH.
+			  Default is active LOW.
+- gpios-states		: On operating systems, that don't support reading back
+			  gpio values in output mode (most notably linux), this
+			  array provides the state of GPIO pins set when
+			  requesting them from the gpio controller. Systems,
+			  that are capable of preserving state when requesting
+			  the lines, are free to ignore this property.
+			  0: LOW, 1: HIGH. Default is LOW if nothing else
+			  is specified.
 - startup-delay-us	: Startup time in microseconds.
-- enable-active-high	: Polarity of GPIO is active high (default is low).
 - regulator-type	: Specifies what is being regulated, must be either
 			  "voltage" or "current", defaults to voltage.
 
@@ -30,7 +44,7 @@ Example:
 		regulator-max-microvolt = <2600000>;
 		regulator-boot-on;
 
-		enable-gpio = <&gpio0 23 0x4>;
+		enable-gpios = <&gpio0 23 0x4>;
 		gpios = <&gpio0 24 0x4
 			 &gpio0 25 0x4>;
 		states = <1800000 0x3
-- 
2.20.1

