Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E50AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461722077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220457;
	bh=9xmlY3DexbugznO8Z4DbRjdBF8cijgJt282o9EzpIQ4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FkP4b5sAX6odt5bvnQm4C+1xbSNW2T0cVe8pwgX1Y+hYtcMxnS6xLRgsP/MyZ/WTO
	 qrILZ4F0eOEMq+s5fySpV8NDUjEJ7HE4W2vXmzH4T6Mv+Xm2KmO9Q79cFexGG4dFZt
	 ZxOmIv7wFMyZo9VffY7XKCUHaHYcP6Asy4UtOvOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfDYT1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:27:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfDYT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7P7Fcdr3Jch6igwZvJGgwCOgS4eSQxwg8yxeVUEu0K8=; b=BEXRYsi1VqNn
        dya9Zx1jvXhKfrqqZMZvIsgdGZbL0AGQWFEq3ESADw4Cmbr3TT5vva7fs8xalQp4+oKYsdoivWstm
        w/OkIdzbzmPfJ1dfTH3ZH91Y4y+1K8KGaZ6oh33J26XboXmdvQVbbpklqMsQ0jQ3WC5YEZLCvuL6r
        nqofo=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk0u-0004d8-Cn; Thu, 25 Apr 2019 19:26:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B6AC3441D3F; Thu, 25 Apr 2019 20:26:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     alsa-devel@alsa-project.org, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, perex@perex.cz, robh+dt@kernel.org,
        tiwai@suse.com, zhang.lyra@gmail.com
Subject: Applied "dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support" to the asoc tree
In-Reply-To: <fd223d1dcf5be1f83863e881fa3db931b5c84601.1555917711.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190425192628.B6AC3441D3F@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From c634d3ffc6b2c3b15ea79ffe0a761ce08b4da71a Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 23 Apr 2019 10:26:21 +0800
Subject: [PATCH] dt-bindings: ASoC: Add Spreadtrum multi-channel data transfer
 support

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sprd-mcdt.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
new file mode 100644
index 000000000000..274ba0acbfd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
@@ -0,0 +1,19 @@
+Spreadtrum Multi-Channel Data Transfer Binding
+
+The Multi-channel data transfer controller is used for sound stream
+transmission between audio subsystem and other AP/CP subsystem. It
+supports 10 DAC channel and 10 ADC channel, and each channel can be
+configured with DMA mode or interrupt mode.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-mcdt".
+- reg: Should contain registers address and length.
+- interrupts: Should contain one interrupt shared by all channel.
+
+Example:
+
+mcdt@41490000 {
+	compatible = "sprd,sc9860-mcdt";
+	reg = <0 0x41490000 0 0x170>;
+	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.20.1

