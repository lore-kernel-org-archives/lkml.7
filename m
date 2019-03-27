Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3165BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1AB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfC0Nrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:47:55 -0400
Received: from sauhun.de ([88.99.104.3]:36172 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfC0Nry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:47:54 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id DBEDC2E35A2;
        Wed, 27 Mar 2019 14:47:51 +0100 (CET)
Date:   Wed, 27 Mar 2019 14:47:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Simon Horman <horms@verge.net.au>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Phil Reid <preid@electromag.com.au>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/7] i2c: core: introduce callbacks for atomic
 transfers
Message-ID: <20190327134751.GD5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
 <20190315122320.34yibpfhv2b6ptwl@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <20190315122320.34yibpfhv2b6ptwl@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

please delete unrelated text. I nearly missed the typo fix later.

> > -	if (in_atomic() || irqs_disabled())
> > +	if (in_atomic() || irqs_disabled()) {
> > +		WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atom=
ic,
> > +		     "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->de=
v));
>=20
> 		Is WARN_ONCE more appropriate here?

Why? It could be multiple adapters or clients causing this?

> > + * The return codes from the @master_xfer{_atomic} field should indica=
te the
>=20
> I think "field" should be "fields" in the new text.

Fixed, thanks!

Regards,

   Wolfram


--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybfwMACgkQFA3kzBSg
Kbbsbg/4y3tgFpT1GwWWe4sp9B/CF2VqdLI5kdtk1IvoIFLvlbaEZQ2xJBiLRVxN
yYoNi490tWqKZWKWxzGPNpqbDc4NKozLFCayPFYrHQJRweT8V0TV0ucuUsT09Xd+
QldzPU3QGmBSzTJnnkC8frDW74DqL5ohx7zXMpDhaJvh/ZdWf9Pn3bVfSuZ6mXGG
aK7ayUnbeaIZU9sVoyzn19+UvORDgJtS4lyqGaQiQ0kVDHE8B7MsrlOYs9xoSktJ
mz65br2NbKwX24EKC+K7Zq2fQtRUOrPIADHs4Z5nonK7K1XE+us2hYg/v4RdG5jv
7qnhZ3ExyBjE3kDLqQX1/iWSI/oXyGmSm31tG6TOSjCMI1f6Su17T8+9cXRc6b6+
T7WMnmQA7pQCUHHhBdZiyxwoJHiYLTPC8sf5HTiWYSo0s5x5FxMxmBHC+E2KnUUW
CU/Dq7WNpNzyCbpqxQqG8lbkCQ9swpunpgmCcVpYheOGqKCId5wIwPsLdQQsQrHx
7NlrhBvobACx2AR2D2JCjkv/yVLKznPCsgcN0+oSjbdX9PIvL/l6c9Ms9y7x1YOl
0nDc1fv4M0w5XytcMPLQwHkNawVPXJ8O/uOtpe/2lMCHgUHK1bffuACNzwU0/k9r
ztbvtZ5HQ40UBXvOuuexJNLnNivuCGKFhUTYvohyoNcwAD56mQ==
=gB5/
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
