Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A844420880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDGWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:50:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47685 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:50:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BE14980363; Mon,  8 Apr 2019 00:50:03 +0200 (CEST)
Date:   Mon, 8 Apr 2019 00:50:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh@kernel.org,
        dmurphy@ti.com
Cc:     lee.jones@linaro.org, tony@atomide.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
Message-ID: <20190407225011.GA9120@amd>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
 <20190407221740.GA6327@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190407221740.GA6327@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Changes since v1:
> >=20
> > - synchronized DT label properties in DT bindings with what has been ag=
reed
> >   for the patch "ARM: dts: omap4-droid4: Update backlight dt properties"
> >=20
> > The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa=
231b:
> >=20
> >   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds=
=2Egit tags/lm3532-driver-improvements
> >=20
> > for you to fetch changes up to bc1b8492c764fea940fc66206047e37a7f8d77e1:
> >=20
> >   leds: lm3532: Introduce the lm3532 LED driver (2019-04-07 20:45:49 +0=
200)
> >=20
> > Thanks,
> > Jacek Anaszewski
> >=20
> > ----------------------------------------------------------------
> > LM3532 backlight driver improvements and relocation
> > ----------------------------------------------------------------
> > Dan Murphy (4):
> >       dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
>=20
> Sorry, this one will need more work.
>=20
> When did Rob acknowledge this? I do not remember that mail & quick
> google does not find it.

Aha, found it now:

Date: Fri, 15 Mar 2019 18:35:01 -0500
=46rom: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu=
 doc

 									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyqfqMACgkQMOfwapXb+vIucwCgvmkz7+2wSeCXVuEtUykmBQRb
ro4Anj8KJeLX59qod6qbSgC5rY2SpPwH
=IlHS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
