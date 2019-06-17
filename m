Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48517C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BF9208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfFQP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:56:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50434 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfFQP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:56:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B1BF80276; Mon, 17 Jun 2019 17:56:33 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:56:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Shawn Landden <shawn@git.icu>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
Message-ID: <20190617155643.GA32544@amd>
References: <20190316033841.7659-1-shawn@git.icu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20190316033841.7659-1-shawn@git.icu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-=
Wimplicit-fallthrough
> + *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallth=
rough-in-gcc-7/
> + */
> +#if __has_attribute(__fallthrough__)
> +# define __fallthrough                    __attribute__((__fallthrough__=
))
> +#else
> +# define __fallthrough
> +#endif

Is it good idea to add the __'s ? They look kind of ugly.=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0HuDsACgkQMOfwapXb+vLxuACguH4PoAow3Kt+DR2IqNag4udH
jQIAn2cmzMyr8cjjeZcc4mdyVrRmKi3e
=Z71h
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
