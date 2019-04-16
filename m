Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1054C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EA820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555428303;
	bh=gF5FLlV/fOUbKi8jM9OhllaPkhL0HlvIJMYPVbAT3IA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZEMIwYbwsBiFR1wQBTHTehqm3eidKr38TMTKWDVRnCr7YpP30p++iexVAhJGqiPr
	 OXAw36iJwTuhjzCAbaR+V1HewojEFkavTOqbewu/kqmg6YXNk3pH5WSH3kBjahqUUv
	 SbXxt1Ri6P1CArPe0Nu6bnVZ5CJFDWoWGJjZBcr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfDPPZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:25:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yRsruGFCh8aawEW94Mev7L6wKLXJN6lYMGKgxVyikgw=; b=dirlunrWU6UOy6A1frCoZ/Pj6
        rXoFA1HWDIqMWFGQNk9TDd18Cf3Gv3jBit7qAxqLejvaK5TLZ58Ja0ElMIwOFearbl/uWgf+KtFSO
        dCYIg0YBncuHH+w91WSnZ+p7zvzo/WB+6tNiqt1+E2QMspILIZS4S/SHYGyUR0CYge+zU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGPx4-0007RF-3C; Tue, 16 Apr 2019 15:24:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E37431127BAE; Tue, 16 Apr 2019 16:24:48 +0100 (BST)
Date:   Tue, 16 Apr 2019 16:24:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V1 3/3] regulator: slg51000: add slg51000 regulator driver
Message-ID: <20190416152448.GC4834@sirena.org.uk>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
 <5e4a6a007e45feac6d35203305cafd865be48755.1555389447.git.eric.jeong.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <5e4a6a007e45feac6d35203305cafd865be48755.1555389447.git.eric.jeong.opensource@diasemi.com>
X-Cookie: Who messed with my anti-paranoia shot?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 01:37:27PM +0900, Eric Jeong wrote:

> +static int slg51000_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct slg51000 *chip =3D rdev_get_drvdata(rdev);
> +	int ret, id =3D rdev_get_id(rdev);
> +	unsigned int state;
> +
> +	ret =3D regmap_read(chip->regmap, es_reg[id].sreg, &state);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read status register(%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	if (!(state & SLG51000_STA_ILIM_FLAG_MASK) &&
> +	    (state & SLG51000_STA_VOUT_OK_FLAG_MASK))
> +		return 1;
> +	else
> +		return 0;

This looks like it should be a get_status() operation as it's reading
status bits rather than the command we sent to the device - for that
just use regulator_is_enabled_regmap(). =20

Otherwise this all looks great.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly188AACgkQJNaLcl1U
h9A9kgf/SxzEZiZ5nf8g1+aL08hUyDRPIRQDtAHgEU9JWSsQXFe/aVf4ofnAVIo/
N+oy8hSnaOanH3WXRikr4FqJ61ola2ffeugPM5rT3Tw55CSwgqLPaEOMSn+XzXPd
y37fxJR/x+ebkcYwzzOIM/R6xMcn8LMrCZHH6X4eZGKYnB9+FlmUMzWt1oVxkdVI
9TPDB6Lskkplp8DFTv08A1sCC5giDARen1gBNIGYGueryRjAoU+K2+8ChoEi+IWf
Qq4vPgrqWdiwNQXmHSvW76gtkzWKZWCiPFvXMPZWlzy2l/mmUGl6K+eEcMVMPWpF
ICzk5mRS58a90vDSNOmTgisvnxgvnQ==
=shk/
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
