Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01B9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572353854;
	bh=L0Itmaavya1mySRDN+CxTsr5XPOuAtTRQ5Cr2WmVB3M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ww3YISRF++8kZmR2J/Azjw0p/7l/Q5PLvB+IfCf3uod8Mkjs66D1d1ZVK9ItPFXxK
	 N4i6BBWlkdKQwRq9ZD/9y9Ds7xYjRFg7/TYw3xaUuwswdxPQrUUmdtrIz1XFhbHAgL
	 NNlR1GGZFlt7PT2fktiKkN/2FNwqTE3FqTybqaM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfJ2M5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:57:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbfJ2M5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Wl+5/Qj/XhSNlZehVwD9qVk1hUUvfQ5iMLqz0DQGd0E=; b=Enb9SgsKSwwH
        4l7KNx3nuvInMfXC5o/09C023lh/1CtRMwg8irjeb2vSpFbbOqYD+Ag/wrCyTSljba7Rlv2UapKx+
        Mflf4De6z8aXfQL+mtEKqFpezAkzVPeLjL215UXSJYv03IcuePxdc9GTQImZKgbRi+oDJtic8qNUk
        BL3pY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPR3U-0002DI-3j; Tue, 29 Oct 2019 12:57:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 98B622742990; Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     alsa-devel@alsa-project.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dgreid@chromium.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org
Subject: Applied "ASoC: rockchip-max98090: Support usage with and without HDMI" to the asoc tree
In-Reply-To: <20191028071930.145899-3-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191029125659.98B622742990@ypsilon.sirena.org.uk>
Date:   Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip-max98090: Support usage with and without HDMI

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

From f03412b78a947857bbd20899e1423482fba55761 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 28 Oct 2019 15:19:26 +0800
Subject: [PATCH] ASoC: rockchip-max98090: Support usage with and without HDMI

Add one optional property "rockchip,hdmi-codec" to let user specify HDMI
device node in DTS so machine driver can find hdmi-codec device node for
HDMI codec DAI.

Use the presence of rockchip,audio-codec and rockchip,hdmi-codec to
specify the use case.

Use max98090 only : specify rockchip,audio-codec.
Use HDMI only: specify rockchip,hdmi-codec.
Use both max98090 and HDMI: specify rockchip,audio-codec and
rockchip,hdmi-codec.

Move these properties to optional because they are not needed for
HDMI-only use case.
"rockchip,audio-codec": The phandle of the MAX98090 audio codec
"rockchip,headset-codec": The phandle of Ext chip for jack detection

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20191028071930.145899-3-cychiang@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/rockchip-max98090.txt      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
index a805aa99ad75..e9c58b204399 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
@@ -5,15 +5,38 @@ Required properties:
 - rockchip,model: The user-visible name of this sound complex
 - rockchip,i2s-controller: The phandle of the Rockchip I2S controller that's
   connected to the CODEC
-- rockchip,audio-codec: The phandle of the MAX98090 audio codec
-- rockchip,headset-codec: The phandle of Ext chip for jack detection
+
+Optional properties:
+- rockchip,audio-codec: The phandle of the MAX98090 audio codec.
+- rockchip,headset-codec: The phandle of Ext chip for jack detection. This is
+                          required if there is rockchip,audio-codec.
+- rockchip,hdmi-codec: The phandle of HDMI device for HDMI codec.
 
 Example:
 
+/* For max98090-only board. */
+sound {
+	compatible = "rockchip,rockchip-audio-max98090";
+	rockchip,model = "ROCKCHIP-I2S";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,audio-codec = <&max98090>;
+	rockchip,headset-codec = <&headsetcodec>;
+};
+
+/* For HDMI-only board. */
+sound {
+	compatible = "rockchip,rockchip-audio-max98090";
+	rockchip,model = "ROCKCHIP-I2S";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,hdmi-codec = <&hdmi>;
+};
+
+/* For max98090 plus HDMI board. */
 sound {
 	compatible = "rockchip,rockchip-audio-max98090";
 	rockchip,model = "ROCKCHIP-I2S";
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&max98090>;
 	rockchip,headset-codec = <&headsetcodec>;
+	rockchip,hdmi-codec = <&hdmi>;
 };
-- 
2.20.1

