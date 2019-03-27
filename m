Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D920F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfC0NxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:53:12 -0400
Received: from sauhun.de ([88.99.104.3]:36312 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfC0NxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:53:11 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 279782E35A2;
        Wed, 27 Mar 2019 14:53:09 +0100 (CET)
Date:   Wed, 27 Mar 2019 14:53:08 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Message-ID: <20190327135308.GG5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
 <20190304224856.w7egngqynl3hlabp@ninjato>
 <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> the demux-pinctrl driver... BTW, that driver should forward ->smbus_xf=
er
> >> just like it does for ->master_xfer, no?
> >=20
> > Yes. The idea of having two seperate SMBus controllers in one SoC which
> > would need demuxing is amusing, but still, it exists for I2C and you are
> > right.
>=20
> Right, I didn't actually think all that far... :-)

On second thought, we can add smbus support when we need it.


--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybgEQACgkQFA3kzBSg
KbbCPA//QSEonhMDC7QwEFKO5Xh0XXUqNnENxmBvl4mJVvoblbTN9iT7NRBrSPo3
0XCckebbtKmF/Pykg0zz7f1S7TYdvC39j1gAyomeoUq26O0q1rVIGozgMcdc8l7C
yDm9fF3PUWUhOFOiW0py1A0V4yCPVTKiv2DoXCbajrYoydIV5DxzoK8uMyllRsfc
PyXiLNx60XowckbekCXmsmYl2UDX5WrpEHaOxsUTjWRqjITng6Mh+0f01KsfBAX3
VBVlIz1Yc1EKTTs6uOl8qAlJ2Hcp+NxgsImYqsvvvej9yOM8SZaxOBRFBJbdWKHf
DBMH4KlqyFGHsCR37F7MKt+QJFNJPYFN9plMsmlQWnyuVBcpAmSTqPj1gIy7cMgV
/FZTe4+IztH73mInq3pmPXg1D3UFLoPiiHGCS306RlLt5X/rCGIqapYOllMJVBym
s7cAFtrGQJIPC1S+XdvvHfkDA4hrjdQ65Xi63Q6AF+SRjsDbt3LeW7QWJ5pG2Iza
1HAkNEjY1JC78tmb++2dbHL1SIu/Nbwdxi0ENoj/XKNJueCEvMbtaMbG1Qy6ASZy
Rc31/PCA0wTkDiSDqiLts9XVlWFq87TuMcYSM5D/3UlVnfdXfV5AHe01pZURc+fh
uyDVwx5XDz2fbfCtqvpXfVwvsmj5SEnrn9RO421cKtrd/RJvH9c=
=6fph
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
