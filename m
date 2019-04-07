Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFFC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8437020863
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDGWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:18:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46968 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDGWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:18:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9259980365; Mon,  8 Apr 2019 00:18:35 +0200 (CEST)
Date:   Mon, 8 Apr 2019 00:18:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, sjg@google.com,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190407221846.GB6327@amd>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net>
 <20190406084157.GA27043@amd>
 <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > This document also states "The naming scheme above leaves scope
> > > for further attributes should they be needed". It does not permit,
> > > however, to redefine one of the fields to mean "location", much less
> > > the declaration that a devicename of "platform" shall refer to an
> > > "internal" backlight, or that there shall be no more than one
> > > "internal" backlight in a given system.
> >
> > "platform" is as good devicename as "wilco" or "chromeos".
>=20
> No, because "platform" is not a device, it is something that you are
> trying to assign a magic meaning to.

"chromeos" is not a device, either.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyqd0YACgkQMOfwapXb+vLtYwCdGp9/oNzPX4vOhq2Yzpll0S50
mmcAnirJtJ2D5e4gsKwodYatGCp+mInX
=DsRh
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
