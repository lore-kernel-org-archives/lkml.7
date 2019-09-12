Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF3C4CECB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646DE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568287079;
	bh=KLs9bbPPbd6y7RXgliI78uy4XAmwtDEcdCcwclC2zeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsQPJZDgKdTk2kEN6zN01/oQZ8xd3CTx5SMJ3CCOQwGYbT5H73Jzy4Ov6JYyrPCXo
	 w1macxa1oHgEWbcLf1nlmkpquROKa5oNCrig4VTtogVg653f4z+Gv2syIQjLvxtM7A
	 LMOgY8Aq0eLnXR/EaX31krzL0Zrulvr8o8BRDxP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfILLR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:17:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nKd2gT68nfyo/XlPwYQzGDJgpJJWANECzlBKS1jgDys=; b=fSTcwOMXPjIemZAht8mJdQeon
        XmDZW12VPp73W7QH+Dfohx5r5i0unsWrw2cXlrplLKUhhkJAiUnEmJ4qW5KuHPxpamV7kUdQFSBhs
        qa/i3yUQR2MtFpHBzCR3hTMPyL7QyQZx5rB779hetPsFtcFZDWxLuueRVV5nTP+cNKhhE=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8N6b-0006av-1J; Thu, 12 Sep 2019 11:17:41 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 657FFD0046D; Thu, 12 Sep 2019 12:17:40 +0100 (BST)
Date:   Thu, 12 Sep 2019 12:17:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shifu0704@thundersoft.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, dmurphy@ti.com, navada@ti.com
Subject: Re: [PATCH v3] tas2770: add tas2770 smart PA kernel driver
Message-ID: <20190912111740.GL2036@sirena.org.uk>
References: <1568253638-14027-1-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3NJww9yp20AXRsxZ"
Content-Disposition: inline
In-Reply-To: <1568253638-14027-1-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3NJww9yp20AXRsxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2019 at 10:00:38AM +0800, shifu0704@thundersoft.com wrote:
> From: Frank Shi <shifu0704@thundersoft.com>
>=20
> add tas2770 smart PA kernel driver
>=20
> Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
> ---
>  sound/soc/codecs/Kconfig   |   5 +
>  sound/soc/codecs/Makefile  |   2 +
>  sound/soc/codecs/tas2770.c | 952 +++++++++++++++++++++++++++++++++++++++=
++++++
>  sound/soc/codecs/tas2770.h | 166 ++++++++

We've lost the device tree binding patch from this version?

> +static int tas2770_regmap_read(struct tas2770_priv *tas2770,
> +			unsigned int reg, unsigned int *value)
> +{
> +	int result =3D 0;
> +	int retry_count =3D TAS2770_I2C_RETRY_COUNT;
> +
> +	while (retry_count--) {
> +		result =3D snd_soc_component_read(tas2770->component, reg,
> +			value);
> +		if (!result)
> +			break;
> +
> +		msleep(20);
> +	}
> +	if (!retry_count)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

It looks like we still have this code for what appears to be
handling the device randomly resetting underneath the driver.
Please, as I've said on both prior versions, split this out into
a separate patch to ease review and explain why this is required.
Start off with a simple driver which looks like normal drivers,
add this stuff later.

--3NJww9yp20AXRsxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16KVMACgkQJNaLcl1U
h9Bktwf+OVENuKKw9SdX4/GhO3RaRXFxZJG8glCsWb0w8tGlZ+e4p0KVnSU9NDtg
pljHEJ6pKKx4xVwexDzy6g2AwDtJOsFxwNP+tSxesvB4pd/hVIAVJhcWYMhdHvw2
bngyLxhrvx2VAM4ZGo3muaaFjEizixzR6jyVTk9mzUbjiKe6uLuyDkMDp6umVIsM
bmwOtNcARlrt3Q44fuV+1iukYLvaV4Y3KAy/jkzHp16IsY/fJ+N47kRqdFPqmEqO
GIIyQN/HCcDPCwvaPQ2RP+9wIO7VywFyZ6lpE3XM9SotBSannMcS6A2EIVF3/kWR
+guG/LKra7Z0076rH9+RBRA1rWvpwA==
=zkA1
-----END PGP SIGNATURE-----

--3NJww9yp20AXRsxZ--
