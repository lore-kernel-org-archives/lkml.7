Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC5DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CDE205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfDDUeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:34:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34166 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfDDUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:34:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5E3F3802EC; Thu,  4 Apr 2019 22:33:57 +0200 (CEST)
Date:   Thu, 4 Apr 2019 22:34:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs
 support
Message-ID: <20190404203408.GG29984@amd>
References: <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
 <20190404112415.GB18653@amd>
 <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
 <20190404190326.GC27340@amd>
 <CAE_wzQ8mr1OMKB+ASfsCdGcs70YrzEMN4Htfg1+O51=ByhXchw@mail.gmail.com>
 <20190404192331.GB29984@amd>
 <CAE_wzQ_4Jb+4dDTFGQ7+sbQ-M8Qm8U_k7ug2DoZKKjTbf6pPTQ@mail.gmail.com>
 <20190404201103.GE29984@amd>
 <CAE_wzQ-iOkM08u42Q3v0wcJhS_bo1UY-vt1qMwyvm4W7kSXQ9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ-iOkM08u42Q3v0wcJhS_bo1UY-vt1qMwyvm4W7kSXQ9A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Because I need to understand why you believe that device name for
> > > kbd_backlight matters, and having wilco::kbd_backlight is a bad idea,
> > > but, for example, having max77650::kbd_backlight is perfectly fine if
> > > somebody decided to wire it in this way.
> >
> > max77650::kbd_backlight is not fine and we'll try to prevent that in
> > future.
>=20
> You do not control DTS for systems though.

Actually we usually do. [And the name can still be fixed up in the driver.]

> > We want one name for internal keyboard backlight. What exactly that
> > name is is not _that_ important, but platform::kbd_backlight seems
> > like reasonable choice.
>=20
> And I am trying to show that depending on device and product (as in
> entire computing device) the same driver could be used in multitude of
> ways and expecting that all devices that can be internal will always
> have "platform::" prefix is not realistic. It will also fail if you
> have multiples of devices, as you need unique names, and that is what
> <device> component in name provides you with.

I don't see what you are saying.

We know that wilco::kbd_backlight is always internal keyboard
backlight, so we name it platform::kbd_backlight. We do the same for
similar drivers in future. I don't see any downsides.

> You need smarter userspace to implement policy that is best suited for
> your product. Maybe you can help it by adding additional properties to
> LED devices, like we have connection_type in USB ports, to tell
> whether device is internal or not, but I'd leave the naming alone.

We may need smarter userspace, but it does not mean naming needs to
make it harder than it already is.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymakAACgkQMOfwapXb+vKhtQCePUyb8436Nu7yGSsfiLH6gQpK
1rkAniD3KdsbtLE8fdfyKmG2Q32Opn4B
=SWjM
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
