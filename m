Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BDC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA062053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568903414;
	bh=BEkK8V7MM2GuLIHQFEfe8tGlORHZyOkL581EWxej1pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AEcnD9zPcCnHkv4aoSca8QkbA6FAs3KQyxJ+M1EXmF86s56rAz7KGkjGBRRk6F3rq
	 RZLDGVusAioBK9X3yIBL7LdVEQ0HBEiKtz0YpaQY42gpzMnBwmxtnwiANqCkC4ibiT
	 KgNSdIYPmgQVoJ0ruulxocmu4x1lIWMC6ZQpjNF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbfISOaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:30:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfISOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=60aUHeX8mO9KTgOD4svjuL7vvceba9UxujX1I109rhY=; b=miE0ZDQ7yp0Dtd0fgwRLzdcPS
        os0Jfe2JB85oTZ2f0J1f/B2dAfmbC8CI4IHKLoZ8y3/0NDULOLEfBfpe96IlPR6catSRvKB6gCii0
        Jw5DzmTWwyq7N3FHtS0Ctqb7UbVBTohcOtkf4BfdnPwE+3Och2emc4r8AId4ThyESefjE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAxRE-00041a-3K; Thu, 19 Sep 2019 14:29:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 311892742939; Thu, 19 Sep 2019 15:29:39 +0100 (BST)
Date:   Thu, 19 Sep 2019 15:29:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH v6] tas2770: add tas2770 smart PA kernel driver
Message-ID: <20190919142939.GL3642@sirena.co.uk>
References: <1568795293-19697-1-git-send-email-shifu0704@thundersoft.com>
 <1568795293-19697-2-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <1568795293-19697-2-git-send-email-shifu0704@thundersoft.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 04:28:13PM +0800, shifu0704@thundersoft.com wrote:

> +static int tas2770_codec_suspend(struct snd_soc_component *component)
> +{
> +	int ret;
> +
> +	ret =3D snd_soc_component_update_bits(component,
> +		TAS2770_PWR_CTRL,
> +		TAS2770_PWR_CTRL_MASK,
> +		TAS2770_PWR_CTRL_SHUTDOWN);
> +	if (ret) {
> +		snd_soc_component_update_bits(component,
> +			TAS2770_PWR_CTRL,
> +			TAS2770_PWR_CTRL_MASK,
> +			TAS2770_PWR_CTRL_ACTIVE);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

This error handling is a bit weird, if the write failed usually it's
best to leave things as they are rather than retrying the write.  You
should also pass back the error code you got from the I/O rather than
overwriting it with -EINVAL since that helps people diagnose problems.

> +static int tas2770_set_samplerate(struct tas2770_priv *tas2770,
> +								int samplerate)

The indentation on the second line here is really weird, it's not
aligned with anything.

> +	switch (slot_width) {
> +	case 16:
> +		ret =3D snd_soc_component_update_bits(component,
> +			TAS2770_TDM_CFG_REG2,
> +			TAS2770_TDM_CFG_REG2_RXS_MASK,
> +			TAS2770_TDM_CFG_REG2_RXS_16BITS);
> +	break;

The indentation of the break statements here is still off.

> +static const struct snd_kcontrol_new tas2770_snd_controls[] =3D {
> +	SOC_SINGLE_TLV("Playback Volume", TAS2770_PLAY_CFG_REG2,
> +		0, TAS2770_PLAY_CFG_REG2_VMAX, 1,
> +		tas2770_playback_volume),
> +	SOC_SINGLE_TLV("Amp Output Gain", TAS2770_PLAY_CFG_REG0,
> +		0, 0x14, 0,
> +		tas2770_digital_tlv),

Volume controls should still have names endinf in Volume as covered in
control-names.rst. =20

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DkNIACgkQJNaLcl1U
h9CGNwf/X4VEOSe8TuEc947oSwTEktjg8zk5ASLNtashM8cHpqAQeKz4v9XmrMTM
SRjzP4M2FTUcL6XlLEDr8dBqxvGUWFV4t5Kg8NVO+9Wma1YInvh4Gg1LdyjIw7Cm
A20++f0dB1k+13bPeM953Vvvm0KiO5S8aBj3BTCibUn8qE3wM3I8Pl/S+FfL0WbY
Nrj1sV6ZY+3ILflnLVZ6eLlLGTRyCtoR7TQASxVNktQC+lf877VzrVtYzmxVLrL1
uPEYgDB/AQNnBmt8MOCr0ofqrryOtE5vMejd+q89i4gxr1n6sUpNxeC1RNMNKqjw
EuuOX/DK0oFwcuqxSSGP9CfydV3c0Q==
=Ncv4
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
