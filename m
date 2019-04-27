Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA862C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A660E20693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385260;
	bh=JMwrocMwjO0EmW7TGauD0P1+sGvC2hVvXERtCgOBNzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QTnGnqSuDp+NDTPt/QYazFik9i2kkWePSy4VEZJB8IpsvPUt4dTSNNiEPOD7CQrmc
	 bAVLXkrNwIi0sfcADzWhtuPfXh5kmLGjXikov+J27s+0GQvd7yh0mXVe+tylE4PEZj
	 dZhPyNc5qroComz+TX6ZOnXbB/IbGvzA2apxLdkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfD0ROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:14:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33992 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0ROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JMwrocMwjO0EmW7TGauD0P1+sGvC2hVvXERtCgOBNzA=; b=Ilhhtg4UI2hLrnFIVllE55a+8
        HOipMnHa6YV/J16WL4ZMPxkrgGY/t3TXinAdbLSULY9dcOfouvSFQroe2+oPdLnhta7/wXq7NiSlO
        4Mek5hptKM9rO29qkRjokngyFbz5K1myhpQhTdtKzVn2kRU+w6cLtb33UlG4qZ+zkEhPI=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKQty-0004Tm-NJ; Sat, 27 Apr 2019 17:14:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 94B85441D3B; Sat, 27 Apr 2019 18:14:10 +0100 (BST)
Date:   Sat, 27 Apr 2019 18:14:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH AUTOSEL 5.0 03/79] ASoC: ab8500: Mark expected switch
 fall-through
Message-ID: <20190427171410.GE14916@sirena.org.uk>
References: <20190427013838.6596-1-sashal@kernel.org>
 <20190427013838.6596-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20190427013838.6596-3-sashal@kernel.org>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 09:37:22PM -0400, Sasha Levin wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>=20
> [ Upstream commit 102cefc8e879b707be0024fdc7bce1deeb359a5f ]
>=20
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.

Are we *realy* going to enable -Wimplicit-fallthrough in stable kernels
and both backport all the fixes and add new fixes for the issues which
don't have backportable fixes?

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjd4ACgkQJNaLcl1U
h9DSgAf/XU7GUyQulo2xAYUjpLLCpFQfd/FUdBJTSiGIXU+VXQ4Glf4E/iUj3kr7
lD92Jmalb5e5ZgE3t6+d0NCofGg04+x2N4D2JVWhfknzGR9fUg+tH+lMqbwmRWoz
wdWsF1TbKKGtvpjFLa+xDdxRj98ZgT30NDmSB60hph/DvBX+SLeRkVnPQAMT/TZB
B1aSA0nYuXCxGqgQDshdH2OxFhaJJ/fXlxyWzr3EedVCv5HJEe1Y1Lab8bPKx4BD
37O2PlUMIyxO2O2w0cX6hpLxD9+H0GeYscDWfuR9iyLgnZ/gHp7hziSbMfpHYqbE
4pe4hY4PQ0aj01iRqNuwrPlTmx/ejg==
=iTRd
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
