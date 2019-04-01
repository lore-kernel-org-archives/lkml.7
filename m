Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E80C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903782084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ej3TR18R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfDAR53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:57:29 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfDAR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554141444; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9/39tyEKRLQ16ZvHx29IYSi8LIN5t3kvRQjnIGUjPU=;
        b=ej3TR18RzHa30Tmxf4ptLDk6tIzIGCM1+nuCbAiRKhRD7AtDNSdb4JBpgvLrRXDUkvOkpF
        Kb/9GUw0OAC+jqFNT3ibgUdgByVW2hD0Qvg3ox5Gx3Mxe1hBJonDjUMG+sr/pSsN6SPfCp
        g7XGizz/VpyQBB5jomjwofRZm7yYn9U=
Date:   Mon, 01 Apr 2019 19:57:19 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Applied "ASoC: es8316: Add support for inverted jack detect" to
 the asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Message-Id: <1554141439.10471.2@crapouillou.net>
In-Reply-To: <20190401085258.20BE0440083@finisterre.ee.mobilebroadband>
References: <20190329215045.6254-1-paul@crapouillou.net>
        <20190401085258.20BE0440083@finisterre.ee.mobilebroadband>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

What about the other two patches? Should I make a new patchset with=20
these?

Thanks,
-Paul


Le lun. 1 avril 2019 =E0 10:52, Mark Brown <broonie@kernel.org> a =E9crit=20
:
> The patch
>=20
>    ASoC: es8316: Add support for inverted jack detect
>=20
> has been applied to the asoc tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>=20
> All being well this means that it will be integrated into the=20
> linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems=20
> and
> send followup patches addressing any issues that are reported if=20
> needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>=20
> Thanks,
> Mark
>=20
> From 0bbcedd6bb41b82b77115fc001441ff34e7c4ea7 Mon Sep 17 00:00:00 2001
> From: Paul Cercueil <paul@crapouillou.net>
> Date: Fri, 29 Mar 2019 22:50:43 +0100
> Subject: [PATCH] ASoC: es8316: Add support for inverted jack detect
>=20
> On some devices (Teclast X98+ II tablet, maybe others), the jack
> detection has been wired backwards, so when the ES8316 reports
> headphones being present it means they are actually not plugged.
>=20
> Use a quirk around this incorrect behaviour, which can be enabled
> through the 'everest,jack-detect-inverted' boolean device property.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/es8316.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
> index 6d4a323f786b..ec2770b3f77d 100644
> --- a/sound/soc/codecs/es8316.c
> +++ b/sound/soc/codecs/es8316.c
> @@ -43,6 +43,7 @@ struct es8316_priv {
>  	unsigned int sysclk;
>  	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
>  	struct snd_pcm_hw_constraint_list sysclk_constraints;
> +	bool jd_inverted;
>  };
>=20
>  /*
> @@ -577,6 +578,9 @@ static irqreturn_t es8316_irq(int irq, void *data)
>  	if (!es8316->jack)
>  		goto out;
>=20
> +	if (es8316->jd_inverted)
> +		flags ^=3D ES8316_GPIO_FLAG_HP_NOT_INSERTED;
> +
>  	dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
>  	if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
>  		/* Jack removed, or spurious IRQ? */
> @@ -592,6 +596,8 @@ static irqreturn_t es8316_irq(int irq, void *data)
>  		/* Jack inserted, determine type */
>  		es8316_enable_micbias_for_mic_gnd_short_detect(comp);
>  		regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
> +		if (es8316->jd_inverted)
> +			flags ^=3D ES8316_GPIO_FLAG_HP_NOT_INSERTED;
>  		dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
>  		if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
>  			/* Jack unplugged underneath us */
> @@ -633,6 +639,14 @@ static void es8316_enable_jack_detect(struct=20
> snd_soc_component *component,
>  {
>  	struct es8316_priv *es8316 =3D=20
> snd_soc_component_get_drvdata(component);
>=20
> +	/*
> +	 * Init es8316->jd_inverted here and not in the probe, as we cannot
> +	 * guarantee that the bytchr-es8316 driver, which might set this
> +	 * property, will probe before us.
> +	 */
> +	es8316->jd_inverted =3D device_property_read_bool(component->dev,
> +							"everest,jack-detect-inverted");
> +
>  	mutex_lock(&es8316->lock);
>=20
>  	es8316->jack =3D jack;
> --
> 2.20.1
>=20

=

