Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D4C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B272077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499144;
	bh=Qe8Q5MrxGKHJw5EnKOmtVj+34AwY6mb9+aOEma2Arf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=L6h8tNkKkrxbmv1l8p+alKu2p37JUkTitdrV7kql+Cdu/17yzH2LA3Oh9L+KoQU6C
	 8u2HE3BU+GIJTihBgDgH7IffdOEN37QDyIvhVWpKu0dXF+80/+o0RKLMfZ+HEpLn5c
	 iquliwb0TpS7wTyf8aq4qSW2YKj5QydTqHADVZzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgAHP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:03 -0500
Received: from foss.arm.com ([217.140.110.172]:46642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbgAHP67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03B4911B3;
        Wed,  8 Jan 2020 07:58:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 827393F534;
        Wed,  8 Jan 2020 07:58:58 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: bindings: add MPS mp8859 voltage regulator" to the regulator tree
In-Reply-To: <20200106211633.2882-5-m.reichl@fivetechno.de>
Message-Id: <applied-20200106211633.2882-5-m.reichl@fivetechno.de>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bindings: add MPS mp8859 voltage regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From 44665f7d082977e8bb1803ec0e596f141cba7196 Mon Sep 17 00:00:00 2001
From: Markus Reichl <m.reichl@fivetechno.de>
Date: Mon, 6 Jan 2020 22:16:27 +0100
Subject: [PATCH] regulator: bindings: add MPS mp8859 voltage regulator

The MP8859 from Monolithic Power Systems is a single output dc/dc converter
with voltage control over i2c.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
Link: https://lore.kernel.org/r/20200106211633.2882-5-m.reichl@fivetechno.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/mp8859.txt  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mp8859.txt

diff --git a/Documentation/devicetree/bindings/regulator/mp8859.txt b/Documentation/devicetree/bindings/regulator/mp8859.txt
new file mode 100644
index 000000000000..74ad69730989
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mp8859.txt
@@ -0,0 +1,22 @@
+Monolithic Power Systems MP8859 voltage regulator
+
+Required properties:
+- compatible: "mps,mp8859";
+- reg: I2C slave address.
+
+Optional subnode for regulator: "mp8859_dcdc", using common regulator
+bindings given in <Documentation/devicetree/bindings/regulator/regulator.txt>.
+
+Example:
+
+	mp8859: regulator@66 {
+		compatible = "mps,mp8859";
+		reg = <0x66>;
+		dc_12v: mp8859_dcdc {
+			regulator-name = "dc_12v";
+			regulator-min-microvolt = <12000000>;
+			regulator-max-microvolt = <12000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
-- 
2.20.1

