Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F39620652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386343;
	bh=lamYLT7iJfxQW+awuii+oS5TRPKVNjRisCAKQ6i+MVI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=t/0q2fWdE2pVsttewRD3r5PdcOXckHrGVTq/1P0xA0IYD5QC1CTQzSQETLU1hiZCc
	 eoHh/E74R0swCz9zmY3fP3hjZEQ6TDqY7mzKEp9CchWWfuzgCI+biHEINTw47H5ii0
	 vqPmpPt187tVGn1ypAQp63nNfPcwXP0BhYjizzOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfDDN7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:59:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfDDN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nEKlm3UVbDzMhvkQzGaG9HFvFiaB2L7OlAwha4w+v7U=; b=rYAs3CtaFal2
        gHMmmBCcrDPA3DY/3A7z+iBK0U0oxjhhpjod9rMYOnildZMVPqx5TlHAmCM78VH/5lX6YiEihLLiG
        wh6/26vUUDFR+m1l4x3epqonJiZs7h52YGyiWWu4OlVUSnj/NowQa2GKgdGtU9XDzfbjV8VXkawHv
        iRv7k=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2t0-0006dN-VW; Thu, 04 Apr 2019 13:58:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D3441441D3C; Thu,  4 Apr 2019 20:58:31 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        apatard@mandriva.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dt-bindings: update cs42l51 bindings" to the asoc tree
In-Reply-To:  <1554297817-14154-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135831.D3441441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:31 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: update cs42l51 bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 26bde6ad6d59b2e1347995de6198205ef6138b52 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:31 +0200
Subject: [PATCH] ASoC: dt-bindings: update cs42l51 bindings

Add compatible, reg, regulator, and reset
to Cirrus CS42L51 audio codec bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs42l51.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
index 4b5de33ce377..acbd68ddd2cb 100644
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -1,6 +1,17 @@
 CS42L51 audio CODEC
 
+Required properties:
+
+  - compatible : "cirrus,cs42l51"
+
+  - reg : the I2C address of the device for I2C.
+
 Optional properties:
+  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
+    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
+    deasserted before starting the communication with the codec.
 
   - clocks : a list of phandles + clock-specifiers, one for each entry in
     clock-names
@@ -14,4 +25,9 @@ cs42l51: cs42l51@4a {
 	reg = <0x4a>;
 	clocks = <&mclk_prov>;
 	clock-names = "MCLK";
+	VL-supply = <&reg_audio>;
+	VD-supply = <&reg_audio>;
+	VA-supply = <&reg_audio>;
+	VAHP-supply = <&reg_audio>;
+	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
 };
-- 
2.20.1

