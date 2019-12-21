Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E4AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85042206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfLUVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:04:14 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52586 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLUVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 16:04:14 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 183EC1C24A9; Sat, 21 Dec 2019 22:04:12 +0100 (CET)
Date:   Sat, 21 Dec 2019 22:04:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 22/25] leds: tm1826: Add combined glyph support
Message-ID: <20191221210406.GA13125@amd>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-23-afaerber@suse.de>
 <20191221202755.GN32732@amd>
 <506d0697-1820-7811-1b38-910355812948@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <506d0697-1820-7811-1b38-910355812948@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>Allow to squeeze the text "HEllO" into a 4-digit display,
> >>as seen on MeLE V9 TV box.
> >>
> >>Enable this combining mode only if the text would overflow.
> >
> >"HEll,nO"!
> >
> >:-)
> >
> >Ok, it is kind of cool, but... Can you take a look at
> >drivers/auxdisplay/charlcd.c ? It seems to support some kind of text
> >displays...
>=20
> Why don't you look at it before making such a suggestion? ;) It is in no =
way
> useful, as I pointed out in my cover letter. The only thing related today,
> as Geert pointed out, is in the input subsystem.

Okay, so maybe we should get

AUXILIARY DISPLAY DRIVERS
M:      Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>

on the Cc: list? What you really have is a display, not a bunch of LEDs.

> If you don't want this in leds, you'll have to help make leds subsystem m=
ore
> useful to external users - the latest function refactoring has been anyth=
ing
> but helpful here, as you've seen with the indicators, and we're completely
> lacking any indexing or bulk operations on the LED controller level, since
> you treat each LED as a standalone device. That's precisely why this code=
 is
> here in leds although - as I pointed out - it shouldn't belong here.

Well, your introduction mail was kind of long :-).

If someone wants to do heartbeat on

 --
|  | <- this segment
 --
|  |
 --

they are probably crazy. We may not want to support that. What about
doing it as auxdisplay driver, and then exporting the indicators
around that as LEDs?

Having USB activity trigger on 'USB' icon makes sense, on the other
hand. That would still be supported.

Hmm?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+iMYACgkQMOfwapXb+vLZQgCghm+4BSW3+dMlaHTM2YeWiyDT
cAAAoKpPCbi0WzsihqRnnB2sB8k3SOLa
=w2fT
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
