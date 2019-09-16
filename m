Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E5C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160C7216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568641212;
	bh=+6uABkaAHYxHqse+rBn2C2cnBjqPFcWuDmywteWQoxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xk8uqgHj0l/wG0NKeJ+1q0Gn0H4qJnxR8RhFbhEoV1QxkNhNueRm/+gYrD7zb/8+H
	 BgWZHdD/tRaz1NkeEjYvCOG9N+MCH1tU3hlI3a/fsdjmSDNXy2X0frHj3NRbivPt1J
	 hPQ3oO+pvFi2/1vFifQ7CI8hp03fzoHupC/VQf9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfIPNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:40:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732992AbfIPNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=87btgVCb+GNfVEk0OH6po0CAGY8zXH/2ckX41PZd76s=; b=LOLgU7t853tqdafCT77YlVrU6
        oqd4QoMQoQey0JlveklEYxIzyXDgRQ2xKTfm5ew4pQkzcq7g91IhmZcFdG340hgDTvKwQwgn6bdFV
        H/ZI1Qeb5CohXaEctrCAFGPYBx6IPUY+kZuJWQJumVsshSRZ366Wgs+YmZoivQNFJoV1g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9rE1-0004aX-Rh; Mon, 16 Sep 2019 13:39:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E138F2741A0D; Mon, 16 Sep 2019 14:39:28 +0100 (BST)
Date:   Mon, 16 Sep 2019 14:39:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH v4] tas2770: Add tas2770 smart PA kernel driver
Message-ID: <20190916133928.GE4352@sirena.co.uk>
References: <1568597881-4093-1-git-send-email-shifu0704@thundersoft.com>
 <1568597881-4093-2-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UEWYo9iD5Le5Jrpm"
Content-Disposition: inline
In-Reply-To: <1568597881-4093-2-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UEWYo9iD5Le5Jrpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 09:38:01AM +0800, shifu0704@thundersoft.com wrote:
> From: Frank Shi <shifu0704@thundersoft.com>
>=20
> Add tas2770 smart PA kernel driver

This is a great improvement, thanks.  There's still some issues though,
including some confusion over the use of bias levels - it seems like
there's fairly poor integration with standard power management, it's not
clear what's going on there.  We do also still have some code that
resets the CODEC which is concerning.

> +#define TAS2770_CHECK_PERIOD	5000	/* 5 second */

We don't need this any more.

> +	case SND_SOC_BIAS_STANDBY:
> +		snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
> +			TAS2770_PWR_CTRL_MASK,
> +			TAS2770_PWR_CTRL_ACTIVE);
> +		tas2770->power_state =3D SND_SOC_BIAS_STANDBY;
> +		break;

We already store the bias level in the component's dapm struct, no need
to duplicate it.

> +	case SND_SOC_BIAS_PREPARE:
> +		snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
> +			TAS2770_PWR_CTRL_MASK,
> +			TAS2770_PWR_CTRL_MUTE);

We shouldn't be muting and unmuting here, leave this to the digital mute
operation.

> +#ifdef CONFIG_PM
> +static int tas2770_codec_suspend(struct snd_soc_component *component)
> +{
> +	int ret;
> +
> +	ret =3D tas2770_set_bias_level(component, SND_SOC_BIAS_OFF);
> +	if (ret)
> +		return -EINVAL;

Pass back error codes you get from functions, however it looks like you
can just set the device as idle_bias_off and have the core do this for
you anyway (plus more at runtime) - there's no appreciable delays I can
see in power on and off.

> +static int tas2770_dac_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =3D
> +			snd_soc_dapm_to_component(w->dapm);
> +	struct tas2770_priv *tas2770 =3D
> +			snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		ret =3D tas2770_set_bias_level(component,
> +			SND_SOC_BIAS_PREPARE);
> +		if (ret)
> +			goto end;

This is very, very bad - DAPM will control the bias level for the CODEC,
you should not be trying to control it from within DAPM callbacks.  This
will only lead to breakage.  What is this intended to do?

> +static int tas2770_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	int ret;
> +
> +	if (mute)
> +		ret =3D tas2770_set_bias_level(component, SND_SOC_BIAS_PREPARE);
> +	else
> +		ret =3D tas2770_set_bias_level(component, SND_SOC_BIAS_STANDBY);
> +
> +	return ret;
> +}

This is more bias level misuse, you are independently setting the bias
level in multiple different ways from many different call sites.  This
can only need to problems, I am surprised this works well for you as
things stand. =20

If the device doesn't have a mute operation it is fine to not have one.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case (SND_SOC_DAIFMT_I2S):
> +		tdm_rx_start_slot =3D 1;

These brackets around the case statements are not the normal Linux
coding style (this isn't an issue in the rest of the driver...).

> +	case 0:
> +	/* Do not change slot width */
> +		ret =3D 0;
> +	break;

Please align the breaks and comments with the rest of the code inside
the case.

> +static const struct snd_kcontrol_new tas2770_snd_controls[] =3D {
> +	SOC_SINGLE_TLV("Amp Output Gain", TAS2770_PLAY_CFG_REG0,
> +		0, 0x14, 0,
> +		tas2770_digital_tlv),

Volume controls should end in Volume - see control-names.rst

> +static irqreturn_t tas2770_irq_handler(int irq, void *dev_id)
> +{
> +	struct tas2770_priv *tas2770 =3D (struct tas2770_priv *)dev_id;
> +	struct snd_soc_component *component =3D tas2770->component;
> +	unsigned int device_status_1 =3D 0, device_status_2 =3D 0;
> +	int result;
> +
> +	if (tas2770->runtime_suspend)
> +		goto end;
> +
> +	if (tas2770->power_state =3D=3D TAS2770_POWER_SHUTDOWN)
> +		goto end;
> +
> +	result =3D snd_soc_component_write(component, TAS2770_INT_MASK_REG0,
> +				TAS2770_INT_MASK_REG0_DISABLE);
> +	if (result)
> +		goto reload;
> +	result =3D snd_soc_component_write(component, TAS2770_INT_MASK_REG1,
> +				TAS2770_INT_MASK_REG1_DISABLE);
> +	if (result)
> +		goto reload;

The interrupt handler appears to be masking interrupts?  Why?

> +	result =3D snd_soc_component_read(tas2770->component,
> +			TAS2770_LAT_INT_REG0, &device_status_1);
> +	if (!result && (device_status_1 & 0x3)) {

If we fail to do I/O with the device we should report an error.

> +reload:
> +	/* hardware reset and reload */
> +	tas2770_load_config(tas2770);

Why are we doing a hardware reset in the interrupt handler, and how is
this coordinated with anything else that's going on.

> +end:
> +	return IRQ_HANDLED;
> +}

This unconditionally reports the interrupt as handled, this prevents the
interrupt line being shared and stops the interrupt core from doing
error handling if anything goes wrong.

> +	tas2770->dev =3D &client->dev;
> +	tas2770->irq_gpio =3D client->irq;

This isn't a GPIO, it's an interrupt - calling this irq_gpio is very
confusing.

--UEWYo9iD5Le5Jrpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/kI8ACgkQJNaLcl1U
h9Btagf/XNf6O/+q/nPwRlfWTROZAyQVmGEjivDA6SEEvGHDqZ4zrVRRjPAVtk+S
GUmNb8XZd+Tc+9YRGW7rtAopeAZDNi0fmHC3RSDW5g7if5V+E0EYG6ApU5KxxvCh
i8PeWaYKZ+aGmxjo5zNACGe/QlCdEwGjSCorXcc9JaNOSNGGfHMZe22KjaWA1O93
1hXnc+9C+XJZFFGp0NwdbxjKUir4/PmeB4UcQgpBlG+NPRRryBGCCosAhzwjM05q
P6pmDUDIABUJVJNmfFI9sRsk54hc7517U6+YzgbtqnJU0AsT74dwryj3wTgP0Fc/
R7vWoZj9PMTUBlI/V4gKeGGLIb4iPQ==
=Jrkx
-----END PGP SIGNATURE-----

--UEWYo9iD5Le5Jrpm--
