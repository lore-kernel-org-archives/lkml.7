Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB9C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E31218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406341AbfIGUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:48:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58511 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfIGUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:48:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5D3F9802B9; Sat,  7 Sep 2019 22:47:39 +0200 (CEST)
Date:   Sat, 7 Sep 2019 22:47:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] ARM: dts: mmp2: devicetree updates
Message-ID: <20190907204752.GA7919@amd>
References: <20190828072629.285760-1-lkundrak@v3.sk>
 <20190907194040.GB25459@amd>
 <CAK8P3a0nNEoy31oxFL11Y2VHw-O=m8e8JuuQk+FjiPh94GikoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0nNEoy31oxFL11Y2VHw-O=m8e8JuuQk+FjiPh94GikoA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-09-07 21:57:42, Arnd Bergmann wrote:
> On Sat, Sep 7, 2019 at 9:40 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> >
> > > Here's a couple of updates for the MMP2 SoC devicetree files.
> > > I'm wondering if they could be applied to the armsoc tree?
> > >
> > > Compared to previous submission, the only change is the addition of
> > > Acks from Pavel.
> >
> > Any news here? Having up-to-date dts is kind-of useful....
>=20
> Thanks for adding me to Cc on your reply. I'm doing the merged for 5.4
> and had not noticed this series earlier (I found the mmp3 series by
> accident, but that one looked like it was not meant as a submission
> for inclusion yet).
>=20
> I've added the six patches to the arm/late branch in the soc tree
> now, they will be in 5.4.

That was quick, thank you!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl10F3gACgkQMOfwapXb+vL0iwCeKnLVYDl45xCxTQmr6GfIec3S
/nMAoLneu6hLNmE6/QadQfhQkaNlwULX
=8gHX
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
