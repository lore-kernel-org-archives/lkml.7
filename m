Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59614C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E040206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641721;
	bh=WkhdNaWxd3a73BO4Ua8knvtZh2HAZ0i2yMLwb1p3hqg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YsYmDq7IfSORylhWi64+chzKl5hCo3d1rl5OVCvCArQ3cxGm6nyuRglkpd946Y3vq
	 F4loY4R1b/nOOuvLvV23jxQr7i4WQ48SYGuQi50wxTDzepcNns1fADi2TJIE21l0a6
	 H5hhCfX5H+sYiT9y6VvsgRQyaayTka8oiwk8AYcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfJIRV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:21:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DhO1lhFWMD157dxNth9KK8xifPRfFHFsba37Wl3UBJ0=; b=Xyzbpa1PLU2+
        r7JWoQveHm0Ugw4QDoPeaqS7JOzp5enjB+wkuHDY+4QoovdMMzYeo1MwQVUe3ls44KR+9ASXrzGfN
        d/394yMOfyAH9aVa8fR3CTNa/WIVpTcV1TVa/IvUoxwtmzx3JNmZ0JGV85djkbuAX5ZxM1AnLoaB5
        wNnIU=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFer-0005Jr-J9; Wed, 09 Oct 2019 17:21:55 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 96BEFD03ED6; Wed,  9 Oct 2019 18:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Applied "ASoC: msm8916-wcd-digital: add missing MIX2 path for RX1/2" to the asoc tree
In-Reply-To: <20191009111944.28069-1-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191009172148.96BEFD03ED6@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:21:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: msm8916-wcd-digital: add missing MIX2 path for RX1/2

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

From bcab05880f9306e94531b0009c627421db110a74 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 Oct 2019 12:19:44 +0100
Subject: [PATCH] ASoC: msm8916-wcd-digital: add missing MIX2 path for RX1/2

This patch adds missing MIX2 path on RX1/2 which take IIR1 and
IIR2 as inputs.

Without this patch sound card fails to intialize with below warning:

 ASoC: no sink widget found for RX1 MIX2 INP1
 ASoC: Failed to add route IIR1 -> IIR1 -> RX1 MIX2 INP1
 ASoC: no sink widget found for RX2 MIX2 INP1
 ASoC: Failed to add route IIR1 -> IIR1 -> RX2 MIX2 INP1
 ASoC: no sink widget found for RX1 MIX2 INP1
 ASoC: Failed to add route IIR2 -> IIR2 -> RX1 MIX2 INP1
 ASoC: no sink widget found for RX2 MIX2 INP1
 ASoC: Failed to add route IIR2 -> IIR2 -> RX2 MIX2 INP1

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20191009111944.28069-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 9fa5d44fdc79..58b2468fb2a7 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -243,6 +243,10 @@ static const char *const rx_mix1_text[] = {
 	"ZERO", "IIR1", "IIR2", "RX1", "RX2", "RX3"
 };
 
+static const char * const rx_mix2_text[] = {
+	"ZERO", "IIR1", "IIR2"
+};
+
 static const char *const dec_mux_text[] = {
 	"ZERO", "ADC1", "ADC2", "ADC3", "DMIC1", "DMIC2"
 };
@@ -270,6 +274,16 @@ static const struct soc_enum rx3_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B2_CTL, 0, 6, rx_mix1_text),
 };
 
+/* RX1 MIX2 */
+static const struct soc_enum rx_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B3_CTL,
+		0, 3, rx_mix2_text);
+
+/* RX2 MIX2 */
+static const struct soc_enum rx2_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B3_CTL,
+		0, 3, rx_mix2_text);
+
 /* DEC */
 static const struct soc_enum dec1_mux_enum = SOC_ENUM_SINGLE(
 				LPASS_CDC_CONN_TX_B1_CTL, 0, 6, dec_mux_text);
@@ -309,6 +323,10 @@ static const struct snd_kcontrol_new rx3_mix1_inp2_mux = SOC_DAPM_ENUM(
 				"RX3 MIX1 INP2 Mux", rx3_mix1_inp_enum[1]);
 static const struct snd_kcontrol_new rx3_mix1_inp3_mux = SOC_DAPM_ENUM(
 				"RX3 MIX1 INP3 Mux", rx3_mix1_inp_enum[2]);
+static const struct snd_kcontrol_new rx1_mix2_inp1_mux = SOC_DAPM_ENUM(
+				"RX1 MIX2 INP1 Mux", rx_mix2_inp1_chain_enum);
+static const struct snd_kcontrol_new rx2_mix2_inp1_mux = SOC_DAPM_ENUM(
+				"RX2 MIX2 INP1 Mux", rx2_mix2_inp1_chain_enum);
 
 /* Digital Gain control -38.4 dB to +38.4 dB in 0.3 dB steps */
 static const DECLARE_TLV_DB_SCALE(digital_gain, -3840, 30, 0);
@@ -740,6 +758,10 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 			 &rx3_mix1_inp2_mux),
 	SND_SOC_DAPM_MUX("RX3 MIX1 INP3", SND_SOC_NOPM, 0, 0,
 			 &rx3_mix1_inp3_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx1_mix2_inp1_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx2_mix2_inp1_mux),
 
 	SND_SOC_DAPM_MUX("CIC1 MUX", SND_SOC_NOPM, 0, 0, &cic1_mux),
 	SND_SOC_DAPM_MUX("CIC2 MUX", SND_SOC_NOPM, 0, 0, &cic2_mux),
-- 
2.20.1

