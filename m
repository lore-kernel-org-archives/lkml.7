Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66697C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3734820848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005246;
	bh=umJwimOE3RS8SF4/ckTtSrnDGiqORUt9kU+yEmJXju0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wa4zWnbZAk/+LBgspjuK3MF2fuJACezuGjUhbywtQs1DMsA8z1Uh+wTH/GGEPee0M
	 yJzYH25uWvXrWyPuPRjjlH6Cg3d0ObO+Cbu/yKXeAeZZF6galnMUaze6ihmvVjNIwq
	 8ON4nhcVDCAqUez1W6Z7nQp7lVg9ePyOmGPy6Y4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEPLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:14:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfEPLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=37loz0j4/OZ5il819QfI9xzcVbzdXjCr6lBxULO4KQU=; b=buIQ0JjHLY0E
        8DfILar/uGpDIyQoIxTmvvTZRzXylL6XAk+JVEopDmE4CFMJXrIK7vSia+un0vZC/s1nK7rSmgRWU
        CGYpnl9/Sfowa/qK8/372m/BqzoTc/F+7NHQKtkIgPaJ/64oXlJuhdvWRD2L65I5TDFjb1Czobb+J
        BWWTw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREKj-00066j-FX; Thu, 16 May 2019 11:13:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3D1DD1126D47; Thu, 16 May 2019 12:13:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Applied "ASoC: meson: add tohdmitx DT bindings" to the asoc tree
In-Reply-To: <20190515131858.32130-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516111354.3D1DD1126D47@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 12:13:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add tohdmitx DT bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From e35f5ad6a965de5d301ca5957a1c48c53fe366fb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 15 May 2019 15:18:56 +0200
Subject: [PATCH] ASoC: meson: add tohdmitx DT bindings

Add the bindings and the related documentation for the audio hdmitx
control glue of the Amlogic g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  | 55 +++++++++++++++++++
 .../dt-bindings/sound/meson-g12a-tohdmitx.h   | 13 +++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
new file mode 100644
index 000000000000..aa6c35570d31
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
@@ -0,0 +1,55 @@
+* Amlogic HDMI Tx control glue
+
+Required properties:
+- compatible: "amlogic,g12a-tohdmitx"
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- #sound-dai-cells: should be 1.
+
+Example on the S905X2 SoC:
+
+tohdmitx: audio-controller@744 {
+	compatible = "amlogic,g12a-tohdmitx";
+	reg = <0x0 0x744 0x0 0x4>;
+	#sound-dai-cells = <1>;
+};
+
+Example of an 'amlogic,axg-sound-card':
+
+sound {
+	compatible = "amlogic,axg-sound-card";
+
+[...]
+
+	dai-link-x {
+		sound-dai = <&tdmif_a>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-0 = <1 1>;
+
+		codec-0 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+		};
+
+		codec-1 {
+			sound-dai = <&external_dac>;
+		};
+	};
+
+	dai-link-y {
+		sound-dai = <&tdmif_c>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-0 = <1 1>;
+
+		codec {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
+		};
+	};
+
+	dai-link-z {
+		sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+		codec {
+			sound-dai = <&hdmi_tx>;
+		};
+	};
+};
diff --git a/include/dt-bindings/sound/meson-g12a-tohdmitx.h b/include/dt-bindings/sound/meson-g12a-tohdmitx.h
new file mode 100644
index 000000000000..c5e1f48d30d0
--- /dev/null
+++ b/include/dt-bindings/sound/meson-g12a-tohdmitx.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_MESON_G12A_TOHDMITX_H
+#define __DT_MESON_G12A_TOHDMITX_H
+
+#define TOHDMITX_I2S_IN_A	0
+#define TOHDMITX_I2S_IN_B	1
+#define TOHDMITX_I2S_IN_C	2
+#define TOHDMITX_I2S_OUT	3
+#define TOHDMITX_SPDIF_IN_A	4
+#define TOHDMITX_SPDIF_IN_B	5
+#define TOHDMITX_SPDIF_OUT	6
+
+#endif /* __DT_MESON_G12A_TOHDMITX_H */
-- 
2.20.1

