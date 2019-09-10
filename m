Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2FC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D079820863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568110030;
	bh=I77/5uA1C2fcp4Z7+VaFfllUZh/CgpQAc1yphu3MTBA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fUL+hQ5r9uInK0ppSM9r0r0WZclkm6/4wbYcvkfre6V+naObBizLm2MPvI+8tLrDA
	 litULBYsXz4gDgv9+4zvm5i1E7Z/Hp8dbmdVK2KmdgxWH/LWy5B1wY0CdGPjLTKhpk
	 aqzH1oe+AeIa+Ghm1RT30DFd5Vf3BvIE2BvCsfos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405701AbfIJKHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:07:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391992AbfIJKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TAVHKaWXI4BEycgQJrIFHO035PWGPpF60zavVSn6Qw4=; b=FX3kfwpO8H3z
        ZvMWbvzSvmJAITPgXUsPv4uK/PJ6gKEYzSGHIKKbESt7CQU5s/bVTeUfjdOy+NZBRkBm+iW1CZUJo
        2AFcAKECVnzGaonfq2Xe03dY3JAg96AlcWIaBkcf+2d0OIvy55fEAVx88CVrS3fQl+LQe/t8B159Y
        twKpA=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7d36-0006j7-Io; Tue, 10 Sep 2019 10:07:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E825CD02D5A; Tue, 10 Sep 2019 11:06:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: uniphier: Add Pro5 USB3 VBUS support" to the regulator tree
In-Reply-To: <1568080304-1572-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190910100659.E825CD02D5A@fitzroy.sirena.org.uk>
Date:   Tue, 10 Sep 2019 11:06:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: Add Pro5 USB3 VBUS support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 3ba5368dc4e5947cb70287754960776c471eb23d Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 10 Sep 2019 10:51:44 +0900
Subject: [PATCH] regulator: uniphier: Add Pro5 USB3 VBUS support

Pro5 SoC has same scheme of USB3 VBUS as Pro4, so the data for Pro5 is
equivalent to Pro4.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1568080304-1572-1-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/uniphier-regulator.txt     | 5 +++--
 drivers/regulator/uniphier-regulator.c                       | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
index c9919f4b92d2..94fd38b0d163 100644
--- a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -13,6 +13,7 @@ this layer. These clocks and resets should be described in each property.
 Required properties:
 - compatible: Should be
     "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pro5-usb3-regulator" - for Pro5 SoC
     "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
     "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
     "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
@@ -20,12 +21,12 @@ Required properties:
 - clocks: A list of phandles to the clock gate for USB3 glue layer.
 	According to the clock-names, appropriate clocks are required.
 - clock-names: Should contain
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoCs
     "link"        - for others
 - resets: A list of phandles to the reset control for USB3 glue layer.
 	According to the reset-names, appropriate resets are required.
 - reset-names: Should contain
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoCs
     "link"        - for others
 
 See Documentation/devicetree/bindings/regulator/regulator.txt
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 9026d5a3e964..2311924c3103 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -185,6 +185,10 @@ static const struct of_device_id uniphier_regulator_match[] = {
 		.compatible = "socionext,uniphier-pro4-usb3-regulator",
 		.data = &uniphier_pro4_usb3_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pro5-usb3-regulator",
+		.data = &uniphier_pro4_usb3_data,
+	},
 	{
 		.compatible = "socionext,uniphier-pxs2-usb3-regulator",
 		.data = &uniphier_pxs2_usb3_data,
-- 
2.20.1

