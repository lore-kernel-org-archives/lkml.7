Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E420684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCHWNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:13:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56909 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:13:10 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8CC3B80213; Fri,  8 Mar 2019 23:13:00 +0100 (CET)
Date:   Fri, 8 Mar 2019 23:13:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs
 support
Message-ID: <20190308221307.GB16125@amd>
References: <20190308203801.57920-1-ncrews@chromium.org>
 <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch is meant to be applied on top of the for-next
> > branch of the platform/chrome repository, as it uses some of
> > the code staged there.
> >
> > The EC is in charge of controlling the keyboard backlight on
> > the Wilco platform. We expose a standard LED class device at
> > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > after the standard Chrome OS keyboard backlight driver at
> > drivers/platform/chrome/cros_kbd_led_backlight.c
> >
> > Some Wilco devices do not support a keyboard backlight. This
> > is checked in probe(), and in this case the sysfs entry will
> > not appear, and everything will behave normally.
>=20
> It would be even better if we did not register platform device if EC
> does not support backlight.
>=20
> > +       data->led.brightness_set =3D keyboard_led_set_brightness;
> > +       data->led.brightness_get =3D keyboard_led_get_brightness;
>=20
> wilco_ec_mailbox() may sleep, so you need to assign it to
> led.brightness_set_blocking.

Hmm. Seeing get method there... can the EC change the brightness
without command from kernel?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyC6PIACgkQMOfwapXb+vJgYACfaU3yqM27r6b74FhCd4n08Tgc
PasAoKN1IIyZGfLN4wpS9meOEMoVtC9G
=zU94
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
