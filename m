Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2423AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8224208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560450940;
	bh=Dfrn+jOO/GVQ/kZOulGVjOD0D5gZPJMPfoYX8P+MZnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pJqhfptTy2Qeu5dtfuR4ZAFrFcGMDfvhEeqUv4Le3FoSWVSOtF5DJslncnn3DGjIk
	 rI4JLm8k3w9l4jm/i84gY69UfgrrTJ0/OzR+8sU9feF3noSgZ/yZDkDzE6ruHe9OdU
	 9C8LIclL6AJCGLbQIhQwL39laBQd+1ZI1NK8+0Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfFMSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:35:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFMSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=48g0tf6U4ay2KOKTKPLydoPCfrHkjjRFohtQ+ZHSeaw=; b=VSeIBpVKtDl5lyrbR935a7a67
        wvFcQSXL0QfrQ2NyUyx1cPjL2YC+KtsBvJIBs9bS+PFChRPmmeiP0l0zMLOPHTNxaFZ9/DpvCS0u2
        KJCXYlxoGPli+zk4UweBsNjE3SA3oBXrIRVV9CEtZy6NMcsPW9QwCy/yOtV+g07/Txz4U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbUYY-0005O3-Cu; Thu, 13 Jun 2019 18:34:38 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id C83F0440046; Thu, 13 Jun 2019 19:34:37 +0100 (BST)
Date:   Thu, 13 Jun 2019 19:34:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ASoC: Add codec driver for ST TDA7802
Message-ID: <20190613183437.GR5316@sirena.org.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-3-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
Content-Disposition: inline
In-Reply-To: <20190611174909.12162-3-thomas.preston@codethink.co.uk>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2019 at 06:49:07PM +0100, Thomas Preston wrote:

> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,580 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802
> + *

Make the entire comment a C++ one so this looks more intentional.

> + * Copyright (C) 2016-2019 Tesla Motors, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.

You've got a SPDX header, you don't also need GPL boilerplate (this
doesn't match your SPDX header either...).

> +enum tda7802_type {
> +	tda7802_base,
> +};
> +
> +#define I2C_BUS				   4
> +
> +#define CHANNELS_PER_AMP		   4
> +#define MAX_NUM_AMPS			   4
> +

These are concerning but also unused.

> +
> +static const u8 IB3_FORMAT[4][4] = {
> +	/* 1x amp, 4 channels */
> +	{ IB3_FORMAT_TDM4 },
> +	/* 2x amp, 8 channels */
> +	{ IB3_FORMAT_TDM8_DEV1,
> +		IB3_FORMAT_TDM8_DEV2 },
> +	/* 3x amp not supported */
> +	{ },
> +	/* 4x amp, 16 channels */
> +	{ IB3_FORMAT_TDM16_DEV1,
> +		IB3_FORMAT_TDM16_DEV2,
> +		IB3_FORMAT_TDM16_DEV3,
> +		IB3_FORMAT_TDM16_DEV4 },
> +};

There are indentation issues here and this is also rather magic
numberish.  I *think* you should be implement set_tdm_slot().

> +#ifdef DEBUG
> +static int tda7802_dump_regs(struct tda7802_priv *tda7802)
> +{

There's already facilities for viewing the register map in regmap, no
need to open code anything.

> +	/* All channels out of tri-state mode, all channels in Standard Class
> +	 * AB mode (not High-efficiency)
> +	 */
> +	data[0] = IB0_CH4_CLASS_AB | IB0_CH3_CLASS_AB | IB0_CH2_CLASS_AB |
> +		IB0_CH1_CLASS_AB;

The AB mode selection should be a user visible control not hard coded.

> +	/* Rear channel load impedance set to 2-Ohm, default diagnostic timing,
> +	 * GV1 gain on all channels (default), no digital gain increase
> +	 */
> +	data[1] = IB1_REAR_IMPEDANCE_2_OHM | IB1_LONG_DIAG_TIMING_x1;
> +	switch (tda7802->gain_ch13) {

The impedance should be a DT property, the gains should be user
controllable.

> +	case 2:
> +		data[1] |= IB1_GAIN_CH13_GV2;
> +		break;
> +	default:
> +		dev_err(dev, "Unknown gain for channel 1,3 %d, setting to 1\n",
> +				tda7802->gain_ch13);
> +	case 1:
> +		data[1] |= IB1_GAIN_CH13_GV1;
> +		break;

It would be more normal to have the default case as the last thing in the
switch statement and the fall through is obviously a bug, if the driver
doesn't know how to handle the configuration it should return an error.

> +	}
> +	switch (tda7802->gain_ch24) {

Blank line please.

> +	/* Mute timing 1.45ms, all channels un-muted, digital mute enabled,
> +	 * 5.3V undervoltage threshold, front-channel load impedance set to
> +	 * 2-Ohms
> +	 */
> +	data[2] = IB2_MUTE_TIME_1_MS | IB2_CH13_UNMUTED | IB2_CH24_UNMUTED |
> +		IB2_AUTOMUTE_THRESHOLD_5V3 | IB2_FRONT_IMPEDANCE_2_OHM;

More stuff that shouldn't be hard coded in the driver.

> +	if (mute) {
> +		/* digital mute */
> +		err = snd_soc_component_update_bits(dai->component, TDA7802_IB2,
> +				IB2_DIGITAL_MUTE_DISABLED,
> +				~IB2_DIGITAL_MUTE_DISABLED);
> +		if (err < 0)
> +			dev_err(dev, "Cannot mute amp %d\n", err);
> +
> +		/* amp off */
> +		err = snd_soc_component_update_bits(dai->component, TDA7802_IB5,
> +				IB5_AMPLIFIER_ON, ~IB5_AMPLIFIER_ON);
> +		if (err < 0)
> +			dev_err(dev, "Cannot amp off %d\n", err);

Turning off the amplifier is clearly power management and should be
handled via DAPM.

> +static int tda7802_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +		unsigned int rx_mask, int slots, int slot_width)
> +{

> +	/* 48kHz sample rate, TDM configuration, 64-bit I2S frame period, PLL
> +	 * clock dither disabled, high-pass filter enabled (blocks DC output)
> +	 */
> +	data = IB3_SAMPLE_RATE_48_KHZ | IB3_FORMAT[width_index][slot_index] |

The sample rate should be set using hw_params(), the high pass filter
should be controllable via a control.

I've stopped reading here, it's fairly clear from what I've seen up to
here that the code is not well integrated with the framework with lots
of hard coding and things scattered around in places where I'd not
expect to find them.  A lot of things should be moved out of hard coding
into ALSA controls, stream configuration should be done via hw_params()
and power management via DAPM - the hardware looks fairly simple so I'd
expect this to all be fairly straightforward to fix.

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0ClzwACgkQJNaLcl1U
h9BtgQf8DNS5KLuTfx8tNHKf3DBEY6J98cBVTbxdBjEHzKG43Ef9yHG4x7REfX9S
2eU1lWSrvrbb6t5UgU8vdAOziNr4Bm1wd1IS47Uys0JGLGMQZjPb4DKz8AswNrof
tc4yS6PyJp3dWfWTBfJUDbyPI0B4xLYjINGO/frdkl4mzMt/awV+rW9r4ijX/dDp
hTq1cnUKc9DMCj+lPFVW3D20V2/yOVMk9Wzk9nq1cd5000MdYNNRWD/GODyPYPz/
b/pDRiY1noNc0X76ftfIy7P45YWcxFmzmaxKq1NdeAPVeCppTU527An12euP/9X+
6rq81oS3Dinzi+6gCSHqGnEl7AqL5A==
=iGaS
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--
