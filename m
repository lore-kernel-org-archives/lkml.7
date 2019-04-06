Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2190C282DD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710FD2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDFIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:41:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43764 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDFIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:41:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0FB82807F5; Sat,  6 Apr 2019 10:41:45 +0200 (CEST)
Date:   Sat, 6 Apr 2019 10:41:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        bleung@chromium.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190406084157.GA27043@amd>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20190405201534.GA4426@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-04-05 13:15:34, Guenter Roeck wrote:
> On Thu, Apr 04, 2019 at 11:10:08AM -0600, Nick Crews wrote:
> > The EC is in charge of controlling the keyboard backlight on
> > the Wilco platform. We expose a standard LED class device at
> > /sys/class/leds/platform::kbd_backlight. This driver is modeled
> > after the standard Chrome OS keyboard backlight driver at
> > drivers/platform/chrome/cros_kbd_led_backlight.c
> >=20
> > Some Wilco devices do not support a keyboard backlight. This
> > is checked via wilco_ec_keyboard_leds_exist() in the core driver,
> > and a platform_device will only be registered by the core if
> > a backlight is supported.
> >=20
> > After an EC reset the backlight could be in a non-PWM mode.
> > Earlier in the boot sequence the BIOS should send a command to
> > the EC to set the brightness, so things **should** be set up,
> > but we double check in probe() as we query the initial brightness.
> > If not set up, then set the brightness to 0.
> >=20
> > Since the EC will never change the backlight level of its own accord,
> > we don't need to implement a brightness_get() method.
> >=20
> > v5 changes:
> > -Rename the LED device to "platform::kbd_backlight", to
> > denote that this is the built-in system keyboard.
> >=20
>=20
> NACK.

Please keep it as it is, it is okay.

> Per Documentation/leds/leds-class.txt, LED devices are named
> 	"devicename:colour:function"

You failed to follow threads explaining this is being changed, even
when I pointed you at them. What you are doing here is not helpful.

> This document also states "The naming scheme above leaves scope
> for further attributes should they be needed". It does not permit,
> however, to redefine one of the fields to mean "location", much less
> the declaration that a devicename of "platform" shall refer to an
> "internal" backlight, or that there shall be no more than one
> "internal" backlight in a given system.

"platform" is as good devicename as "wilco" or "chromeos".
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyoZlUACgkQMOfwapXb+vIzTgCdGkShC0MeKZrta+HxTkQUi6AB
H04AnRnwkj3XaficTFJiKbidp2+kFc+i
=ui1D
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
