Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F4521881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567533630;
	bh=q2tpp8gPRoDhIszlCPj5TA4tisYBJdwc+9JF2shZ08k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Um7gJztlBGIIgZwThDHGV8ggAcnt3hl4BjC0Cv8PKE3XCGX376H9ueJqIgSCufRRz
	 AEFdM2I2bx+jYiDBWTmpVjeVRm45LK9DqFWKAYjM6TF2BgD0Pz9QVnbR5AeIQVgfIo
	 ttFXRBm12xGRU/un4VEV0iTveYm33rYSrjGWiVbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfICSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:00:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z1/6KbixvXgzeLN5YqOSqKmNDnkEfTxK979SrcIDgOw=; b=aJ8OyIbO9+OM
        GENRjF/rGpQ/B6FMenV8d7b2xrnJqRJwcgDGyGH8w5enynE+WyAOmDUjXhG2gQrRxAkkCX+XL23pS
        Xqj9y2GYy8QrO4INslmwvVDbccEwT4GN0tp3xlbcQs9lYS72wwatBaS/Rwg6bCbKMweQy8vB9Uf5J
        5ntMs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5D6J-0000zX-4Y; Tue, 03 Sep 2019 18:00:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8E9D62740FDC; Tue,  3 Sep 2019 19:00:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: add DT-bindings" to the asoc tree
In-Reply-To: <20190903165322.20791-4-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190903180018.8E9D62740FDC@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 19:00:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8316: add DT-bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 3a3edd6ffe671115c4b3d715f08ed0cf4e927ce1 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Wed, 4 Sep 2019 01:53:22 +0900
Subject: [PATCH] ASoC: es8316: add DT-bindings

This patch adds missing DT-bindings document for Everest ES8316.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190903165322.20791-4-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/everest,es8316.txt         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
new file mode 100644
index 000000000000..aefcff9c48a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.txt
@@ -0,0 +1,20 @@
+Everest ES8316 audio CODEC
+
+This device supports both I2C and SPI.
+
+Required properties:
+
+  - compatible  : should be "everest,es8316"
+  - reg : the I2C address of the device for I2C
+  - clocks : a list of phandle, should contain entries for clock-names
+  - clock-names : should include as follows:
+         "mclk" : master clock (MCLK) of the device
+
+Example:
+
+es8316: codec@11 {
+	compatible = "everest,es8316";
+	reg = <0x11>;
+	clocks = <&clks 10>;
+	clock-names = "mclk";
+};
-- 
2.20.1

