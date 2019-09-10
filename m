Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE601C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FB62084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568118845;
	bh=ehtD8dIM21VCa4j9ZKHB27fbWFmZMZ8Ohf/WAUuQR1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ys3gbNfhd9BxzvR/mOzTAhGYc3xTjnKuOgtIvqD879MhhygYFSXLZRDtNhCaNKTWX
	 xW9qsAz6DZb2ra1lm4bM2OKN4rjOxjn9cTflbXaIquibljNewThgoyZKAG2YX6gW2k
	 +soT0dKnTHSufuiSOR8MCiQCOdHM98X/loigBcX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfIJMeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:34:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfIJMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gIBxZajO+zL1zifzKXPLswDGxhDdHsuuFzOqDj1g60c=; b=gqDdVWaHRjfKGbl0cxMl6eQxJ
        BrCPWhkhcMMxqraVNA7fxXVd+/Hn3CixAX+JsXKOVy1TSuh/FpWZkvC5v/w6sok/odID9haikBoUL
        P0t2p6Wtt8UB3jMiRSYSzt4B7Y007+V6ovJ4QVtoPe4kFvj3T2ZLfdEjyE9VZsEeFW+gE=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7fL4-0007Bv-L7; Tue, 10 Sep 2019 12:33:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DE336D02D5A; Tue, 10 Sep 2019 13:33:41 +0100 (BST)
Date:   Tue, 10 Sep 2019 13:33:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH] tas2770: add tas2770 smart PA kernel driver
Message-ID: <20190910123341.GP2036@sirena.org.uk>
References: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
 <1567753564-13699-2-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncX6roZrNNHXnAbh"
Content-Disposition: inline
In-Reply-To: <1567753564-13699-2-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncX6roZrNNHXnAbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2019 at 03:06:04PM +0800, shifu0704@thundersoft.com wrote:

> index 0000000..9fc0c11
> --- /dev/null
> +++ b/sound/soc/codecs/tas2770.c
> @@ -0,0 +1,1103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC Texas Instruments TAS2770 20-W Digital Input Mono Class-D
> + * Audio Amplifier with Speaker I/V Sense

Please make the entire comment block a C++ one so it looks
neater.

> +static void tas2770_hw_reset(struct tas2770_priv *p_tas2770)
> +{
> +	if (p_tas2770->mn_reset_gpio) {
> +		gpiod_set_value_cansleep(p_tas2770->mn_reset_gpio, 0);
> +		msleep(20);
> +		gpiod_set_value_cansleep(p_tas2770->mn_reset_gpio, 1);
> +	}
> +
> +	p_tas2770->mn_current_book = -1;
> +	p_tas2770->mn_current_page = -1;

This is as far as I can tell the only place where these two
struct members are accessed, may as well delete them.  Also
throughout the struct there's odd prefixes on the names of the
members which isn't idiomatic for the kernel.

> +static void tas2770_enable_irq(struct tas2770_priv *p_tas2770, bool enable)
> +{
> +	if (enable) {
> +		if (p_tas2770->mb_irq_enable)
> +			return;
> +
> +		if (gpio_is_valid(p_tas2770->mn_irq))
> +			enable_irq(p_tas2770->mn_irq);
> +		p_tas2770->mb_irq_enable = true;
> +	} else {
> +		if (gpio_is_valid(p_tas2770->mn_irq))
> +			disable_irq_nosync(p_tas2770->mn_irq);
> +		p_tas2770->mb_irq_enable = false;
> +	}
> +}

What's this doing and why is there some interaction with GPIOs?
I see there's something going on to do with powering on the
device and handling interrupts but it's not clear what the intent
is and it looks like it's misusing the interrupt APIs.

> +static int tas2770_runtime_suspend(struct tas2770_priv *p_tas2770)
> +{
> +	p_tas2770->mb_runtime_suspend = true;
> +
> +	return 0;
> +}
> +
> +static int tas2770_runtime_resume(struct tas2770_priv *p_tas2770)
> +{
> +
> +	p_tas2770->mb_runtime_suspend = false;
> +
> +	return 0;
> +}

This isn't doing anything, remove it.  You can query the current
state from the runtime PM API if it's needed.

> +static int tas2770_regmap_write(struct tas2770_priv *p_tas2770,
> +			unsigned int reg, unsigned int value)
> +{
> +	int nResult = 0;

This isn't idiomatic naming for the kernel, there's a lot of this
sort of naming in the code.

> +	int retry_count = TAS2770_I2C_RETRY_COUNT;
> +
> +	while (retry_count--) {
> +		nResult = snd_soc_component_write(p_tas2770->component, reg,
> +			value);
> +		if (!nResult)
> +			break;
> +		msleep(20);
> +	}
> +	if (retry_count == -1)
> +		return ERROR_I2C_FAILED;

This is not a standard kernel error code.

> +	else
> +		return 0;
> +}

This is called regmap, actually wraps the ASoC level function and
looks like it's trying to work around some truly horrific
hardware bug.  Is this *really* needed upstream and not just a
workaround for some very specific board?

> +static int tas2770_codec_suspend(struct snd_soc_component *component)
> +{
> +	struct tas2770_priv *p_tas2770 =
> +			snd_soc_component_get_drvdata(component);
> +
> +	mutex_lock(&p_tas2770->codec_lock);
> +	tas2770_runtime_suspend(p_tas2770);
> +	mutex_unlock(&p_tas2770->codec_lock);
> +
> +	return 0;
> +}
> +
> +static int tas2770_codec_resume(struct snd_soc_component *component)
> +{
> +	struct tas2770_priv *p_tas2770 =
> +			snd_soc_component_get_drvdata(component);
> +
> +	mutex_lock(&p_tas2770->codec_lock);
> +	tas2770_runtime_resume(p_tas2770);
> +	mutex_unlock(&p_tas2770->codec_lock);
> +
> +	return 0;
> +}

These don't actually do anything?

> +static int tas2770_set_power_state(struct tas2770_priv *p_tas2770, int state)
> +{

This is called from multiple places with no kind of reference
counting or anything to ensure that the power is managed
correctly.  I'm very suspicious of what this is doing, my best
guess is that this should be either directly in a DAPM widget or
in set_bias_level() rather than coded outside of DAPM entirely.

There's also no sense in combining the on and off cases into a
single function, they share nothing.

> +static int tas2770_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tas2770_priv *p_tas2770 =
> +			snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	mutex_lock(&p_tas2770->codec_lock);
> +
> +	ret = tas2770_set_bitwidth(p_tas2770, params_format(params));
> +	if (ret < 0)
> +		goto end;
> +
> +
> +	ret = tas2770_set_samplerate(p_tas2770, params_rate(params));
> +
> +end:
> +	mutex_unlock(&p_tas2770->codec_lock);
> +	return ret;
> +}

What's the goal with this locking?  It's not clear what this is
intended to protect.

> +	default:
> +		dev_err(p_tas2770->dev, "ASI format master is not found\n");
> +		ret = -EINVAL;
> +		return ret;
> +	}

Just write the return statement directly, no need for the
assignment.

> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case (SND_SOC_DAIFMT_I2S):
> +		tdm_rx_start_slot = 1;
> +		break;
> +	case (SND_SOC_DAIFMT_DSP_A):
> +	case (SND_SOC_DAIFMT_DSP_B):
> +		tdm_rx_start_slot = 1;
> +		break;
> +	case (SND_SOC_DAIFMT_LEFT_J):
> +		tdm_rx_start_slot = 0;
> +		break;

The two DSP modes should not be identical.

> +static int tas2770_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tas2770_priv *p_tas2770 =
> +			snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	mutex_lock(&p_tas2770->codec_lock);
> +
> +	ret = tas2770_set_fmt(p_tas2770, fmt);
> +
> +	mutex_unlock(&p_tas2770->codec_lock);
> +	return ret;
> +}

Just inline set_fmt(), there's no need for the extra function
wrapping.  The same issue applies to a lot of other operations.

> +static void tas2770_codec_remove(struct snd_soc_component *component)
> +{
> +	pm_runtime_put(component->dev);
> +}

This is buggy, there's no matching get and you shouldn't be
holding runtime PM on for the entire time the driver is
registered.

> +static const struct snd_kcontrol_new tas2770_snd_controls[] = {
> +	SOC_SINGLE_TLV("Amp Output Level", TAS2770_PLAY_CFG_REG0,
> +		0, 0x14, 0,
> +		tas2770_digital_tlv),

All volume controls should end in Volume so userspace knows how
to handle them.

> +	n_result = tas2770_regmap_write(p_tas2770, TAS2770_INT_MASK_REG0,
> +				TAS2770_INT_MASK_REG0_DISABLE);
> +	if (n_result)
> +		goto reload;
> +	n_result = tas2770_regmap_write(p_tas2770, TAS2770_INT_MASK_REG1,
> +				TAS2770_INT_MASK_REG1_DISABLE);
> +	if (n_result)
> +		goto reload;
> +
> +	n_result = tas2770_regmap_read(p_tas2770,
> +			TAS2770_LAT_INT_REG0, &nDevInt1Status);
> +	if (n_result >= 0)
> +		n_result = tas2770_regmap_read(p_tas2770,
> +			TAS2770_LAT_INT_REG1, &nDevInt2Status);
> +	else
> +		goto reload;

So this looks like we've got code for the device randomly
resetting underneath us?  That seems very bad and is really
confusing the code.  If this is needed I would suggest writing
the driver first for the case where the device doesn't randomly
reset and then try to add handling for this separately, that will
make it a lot easier and clearer.

> +#if defined(CONFIG_OF)
> +		.of_match_table = of_match_ptr(tas2770_of_match),
> +#endif

of_match_ptr() means you don't need the ifdef.

--ncX6roZrNNHXnAbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl13mCUACgkQJNaLcl1U
h9C8+Af/WEbvTDfubpTdMAZVmTae7zKYr+Ubd+J3X+6ybx7+aUsVEnQCT7eOQYT1
VgB5H/2FP8Sd+ALHAsa5W4hoqpq3DikwkBb2RlgJCgmiaOJpEeZ+s7idLrysAeHU
wqwTY5W4Zr80WKnovGRbdTVMvybSmp1sGKnADhZFC8BzV1qc+haA18q1xF8ZHyws
HP/YIaeHWxD74cPJrpLIlTxp11TQw/Zk8p32wX/mXdAgb0a/6dxOiM8tlrr89cVr
o12WwFI6PThuvMRl/huGVAChJr1e6z5SmmN/1DoxNL2XFz/NvJBb0Whe1tUi5Mu4
XoWNUWwJW/odXbtHGzBOKZM69HACZw==
=aNyK
-----END PGP SIGNATURE-----

--ncX6roZrNNHXnAbh--
