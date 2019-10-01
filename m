Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F20C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BFF21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930066;
	bh=W5EcmPM/bJo0JDzbbLUBbLq6kHKKPjVhhfgINoU5apo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NNt5jPOt3i2A9BxeuEN8fG//v/IYKqjeU0RK+oFFWzNXy9LoPjUNx3bFaDMAxWjZq
	 SsL4lVmW/3ydVkJE2sxAMa3YzBHtkEgtOJFzZRCF8TWxORf/+kYTeRv6muFxgE/j96
	 4c86o8JXOK+YAEyOkcv0dSzbqfzJd3hDL30bNHF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfJALlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbfJALlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VNyirlbo32jI74Gnx32OywMdUtsIIVh9GP/R2nfj/v4=; b=Frr2ZOaaFUYE
        74AZiv+7tXVoVcLD8SeKaeizv+IwZT9V8NkQbKn9ZhuZdIbgv8afh5XkVA691S0QcK/UyhFYZWl7V
        /gqm+ZR1ERucCEYN02wfVo/BfigXg+PNU0MuxySHuBf94VWF+oUgTnZVlFfy3Q4r08hhJFTt/y/NY
        iJALc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWO-0004TJ-O0; Tue, 01 Oct 2019 11:40:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3491227429C0; Tue,  1 Oct 2019 12:40:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Frank Shi <shifu0704@thundersoft.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, dmurphy@ti.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, perex@perex.cz,
        robh+dt@kernel.org, tiwai@suse.com
Subject: Applied "dt-bindings: ASoC: Add tas2770 smart PA dt bindings" to the asoc tree
In-Reply-To: <1568962709-19185-1-git-send-email-shifu0704@thundersoft.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114048.3491227429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: ASoC: Add tas2770 smart PA dt bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 4b7151dadfd450b837b6b28073ad9f19f4a7547c Mon Sep 17 00:00:00 2001
From: Frank Shi <shifu0704@thundersoft.com>
Date: Fri, 20 Sep 2019 14:58:28 +0800
Subject: [PATCH] dt-bindings: ASoC: Add tas2770 smart PA dt bindings

Add tas2770 smart PA dt bindings

Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
Link: https://lore.kernel.org/r/1568962709-19185-1-git-send-email-shifu0704@thundersoft.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tas2770.txt     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
new file mode 100644
index 000000000000..ede6bb3d9637
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2770.txt
@@ -0,0 +1,37 @@
+Texas Instruments TAS2770 Smart PA
+
+The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+
+ - compatible:	   - Should contain "ti,tas2770".
+ - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot.
+
+Optional properties:
+
+- interrupt-parent: the phandle to the interrupt controller which provides
+                     the interrupt.
+- interrupts: interrupt specification for data-ready.
+
+Examples:
+
+    tas2770@4c {
+                compatible = "ti,tas2770";
+                reg = <0x4c>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupt-parent = <&msm_gpio>;
+                interrupts = <97 0>;
+                ti,asi-format = <0>;
+                ti,imon-slot-no = <0>;
+                ti,vmon-slot-no = <2>;
+        };
+
-- 
2.20.1

