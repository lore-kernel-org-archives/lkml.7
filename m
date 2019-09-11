Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B33C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4BF20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568199134;
	bh=iCVedO/QmNhov1vJqRrQAaYbfDxKK6l653/Reoc/8TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TDyP2p2AIH7dFNI5yktQxvJjdOH/KVpCYPnR+UbdyK4GrlRhBCqya1ocbZTwr/nZU
	 GglsuF3bdbey4nNKlVsm8u1D3loGj5fk9hBzJOTNiq+h5uvAAP5iggleuCHkQb4Vi7
	 GfnbHtTBAJYeGG9/mUrpsJrExv/ZnXm/+5yGdLec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfIKKwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:52:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fb8QmfcM6+bHa12eOMWxQHKCXWAsQRSOTaIAwdUDGXE=; b=dmS8IhYzgJSx2wo+NEVFycnHi
        UlsetVnoOcYmgqf4uRccXocYARHtxRtkKS0Pudu1zhZ5F7Alsrvdss/TTak172MmZznVuzuq5g0id
        hyWWCrMJFPL6/3TG1eT9DX3RTN7oWeqF0nUdyKSCe4GhBmD5Ztp26fJg6AS//5YX/OKFA=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i80Dk-0008Jn-0H; Wed, 11 Sep 2019 10:51:32 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5A1D9D00330; Wed, 11 Sep 2019 11:51:31 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:51:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH v2] tas2770: add tas2770 smart PA kernel driver
Message-ID: <20190911105131.GY2036@sirena.org.uk>
References: <1568197529-4385-1-git-send-email-shifu0704@thundersoft.com>
 <1568197529-4385-2-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H7DA0n3a+SnB4bJ2"
Content-Disposition: inline
In-Reply-To: <1568197529-4385-2-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H7DA0n3a+SnB4bJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 06:25:29PM +0800, shifu0704@thundersoft.com wrote:

> +++ b/sound/soc/codecs/tas2770.c
> @@ -0,0 +1,954 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2770 20-W Digital Input Mono Class-D
> + * Audio Amplifier with Speaker I/V Sense
> + *
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
> + *	Author: Tracy Yi <tracy-yi@ti.com>
> + *	Shi Fu <shifu0704@thundersoft.com>
> + */

This is a C style comment not a C++ style comment.

> +static int tas2770_regmap_read(struct tas2770_priv *tas2770,
> +			unsigned int reg, unsigned int *value)
> +{
> +	int result = 0;
> +	int retry_count = TAS2770_I2C_RETRY_COUNT;
> +
> +	while (retry_count--) {
> +		result = snd_soc_component_read(tas2770->component, reg,
> +			value);
> +		if (!result)
> +			break;
> +
> +		msleep(20);
> +	}
> +	if (!retry_count)
> +		return -ETIMEDOUT;

This appears to be the same as the previous version?  It looks
like we still have code to hande the device randomly resetting
underneath the driver - like I said we really need to understand
why that's being done, I'd strongly suggest splitting that code
out into a separate patch so we can review the base driver and
hopefully merge it while we discuss this reboot support.

--H7DA0n3a+SnB4bJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl140bIACgkQJNaLcl1U
h9DPdAgAg5/Xr71P8Q6mf/bfG1iLz+/TfNsplKMTskvGTVVtUue5zPE1ptG6WZ5L
2fYEJ/CBBqbuGg2faUb8m0hBIGYcS/hTuOG/ZpQ9qJqZKYCYhHf9Vq5vnPEodiTx
83K1JQrBDmNPmkgxMuGs6Bw4Hk+d4Rneyu/kPfRx3bi5FcwbdPYK+cUb0s/I31s9
IWVodTlRPi4yhdEfjemx68QplB2JrQCDTDSLfKTlMRTzzxDJ1qGWxQ5JZji1yYhb
JpfsEMRIZzoErRhlEu52AzJL0Fdb4OCejmlzpBfQ54xiyoBM7ZuLV++9FPWdlSYi
PMt4GcEJZ6gS1UtdPYtizHwco2a1kw==
=mutQ
-----END PGP SIGNATURE-----

--H7DA0n3a+SnB4bJ2--
