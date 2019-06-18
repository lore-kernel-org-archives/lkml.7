Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7226C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FAE20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfFRMC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:02:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50005 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:02:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8058C80329; Tue, 18 Jun 2019 14:02:11 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:02:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
Message-ID: <20190618120221.GA20524@amd>
References: <20190614224533.169881-1-mka@chromium.org>
 <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
 <20190617161625.GR137143@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190617161625.GR137143@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-17 09:16:25, Matthias Kaehlcke wrote:
> Hi Pavel,
>=20
> On Sun, Jun 16, 2019 at 05:41:43PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
> > >=20
> > > According to the commit message the AUO B101EAN01 panel on minnie
> > > requires a PWM delay of 200 ms, however this is not what the
> > > datasheet says. The datasheet mentions a *max* delay of 200 ms
> > > for T2 ("delay from LCDVDD to black video generation") and T3
> > > ("delay from LCDVDD to HPD high"), which aren't related to the
> > > PWM. The backlight power sequence does not specify min/max
> > > constraints for T15 (time from PWM on to BL enable) or T16
> > > (time from BL disable to PWM off).
> > >=20
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Enric, if you think I misinterpreted the datasheet please holler!
> >=20
> > Was this tested?
>=20
> I performed limited manually testing.
>=20
> minnie ships with the Chrome OS 3.14 downstream, which doesn't include
> this delay, to my knowledge there are no open display related bugs for
> minnie. One could argue that a the configuration without the delay was
> widely field tested
>=20
> > Does patch being reverted actually break anything?
>=20
> To my knowledge it doesn't really break anything, however there is a
> short user perceptible delay between switching on the LCD and
> switching on the backlight. It's not the end of the world, but if it's
> not actually needed better avoid it.
>=20
> > If so, cc stable?
>=20
> I guess this is an edge case, were you could go either way. I'm fine
> with respinning and cc-ing stable.

Ok, if it is just a small delay, stable probably does not need to be
involved.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0I0s0ACgkQMOfwapXb+vIDhwCgoXg7BeLdOOaZditUE387gqIo
RsQAn0zNp/RpUuk4d69n9e90MTNfL8OK
=uTEM
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
