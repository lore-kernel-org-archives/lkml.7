Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55290C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C0721530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557303204;
	bh=jG8xXaqP+5GBL/P4uDY4+dbfWR+/Tkhev3V5y8GU3yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wYH9LofKUnx6H5hiNo3nL7o+QM4savPWw6Laeh/aN+zdW5JbmbpyaxAp46BkZWTVx
	 xAOcn0ijEmJO/IX+jYL47oMW3D95wKz7evGVQxaI7Hnl+LvQxyZNb0kFjcB3u4xeLi
	 he/XiCJwAa70mkLBQZpiDC7HB0GXzF8iD5IqM01c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfEHINX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:13:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48244 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pkLrRM8WwERKArH5Dv/+tMtKVp5mCK9iWIXDavXWmDQ=; b=hE7eLT+9OnW9jXDsqOAzlbnaq
        UxB75RtNBP5JXBawrzP51jpflo7rSj2vVrhYlBF3OQZVoQ3UulYCHI/qAgA0TEaF0dvLk+AAMZKr9
        WICI1mezyowfhM6Bwwaj6my6T8djibMVhareRgZ1LKmY45IvORgSOt4fj9n2ZLBSoUBWc=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHh1-0007RG-IF; Wed, 08 May 2019 08:12:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6ECD7440034; Wed,  8 May 2019 09:12:40 +0100 (BST)
Date:   Wed, 8 May 2019 17:12:40 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Message-ID: <20190508081240.GA14916@sirena.org.uk>
References: <1556534756-15630-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H6fQM4Loq/u8aogQ"
Content-Disposition: inline
In-Reply-To: <1556534756-15630-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H6fQM4Loq/u8aogQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 10:46:03AM +0000, S.j. Wang wrote:

> +	cs42xx8->gpio_reset =3D of_get_named_gpio(dev->of_node, "gpio-reset", 0=
);
> +	if (gpio_is_valid(cs42xx8->gpio_reset)) {
> +		ret =3D devm_gpio_request_one(dev, cs42xx8->gpio_reset,
> +				GPIOF_OUT_INIT_LOW, "cs42xx8 reset");

You should just be able to request the GPIO by name without going
through of_get_named_gpio() using devm_gpio_get().

> @@ -559,6 +577,7 @@ static int cs42xx8_runtime_resume(struct device *dev)
> =20
>  	regcache_cache_only(cs42xx8->regmap, false);
> =20
> +	regcache_mark_dirty(cs42xx8->regmap);
>  	ret =3D regcache_sync(cs42xx8->regmap);
>  	if (ret) {
>  		dev_err(dev, "failed to sync regmap: %d\n", ret);

This looks like an unrelated bugfix.

--H6fQM4Loq/u8aogQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSj3cACgkQJNaLcl1U
h9DXlAf+NZvbXIKXu1i3ZnsLWQy9duLtWvd5Tqm52AG4yzPuCM4MW7+jUxPLDQz/
TX/C3cXHNDXdERXQbOBIUli6xRFu/4Nom56dXbLPbWiA77RNwAC5LuX+BEJJc5xa
mEUtDpoXFU3/+V5y9iSYRTwWW0JVq06LI/lFfhC0DfB8aHVzBJAVzWGMMt4uh1fA
IZxiKXGNU53fqM9SMtb1FJ8t5lZHwqRK1Ra/2fe0yivHq3+m71ZQXkCfy5DYDlnX
m3iew6+A0bDr+z0cdJmA8jgIAGyy6Po/+iYIASerYPGH3kJoFMytubH+fB+uVieP
QZCtbRlG+JJtBuBBHjivJk2UQvyWlQ==
=nWb3
-----END PGP SIGNATURE-----

--H6fQM4Loq/u8aogQ--
