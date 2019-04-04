Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CBBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C52171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfDDTwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:52:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33106 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfDDTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:52:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BD3CD8029F; Thu,  4 Apr 2019 21:51:59 +0200 (CEST)
Date:   Thu, 4 Apr 2019 21:52:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, sjg@google.com, groeck@google.com,
        dtor@google.com
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190404195210.GC29984@amd>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20190404171007.160878-2-ncrews@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-04 11:10:08, Nick Crews wrote:
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/platform::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c
>=20
> Some Wilco devices do not support a keyboard backlight. This
> is checked via wilco_ec_keyboard_leds_exist() in the core driver,
> and a platform_device will only be registered by the core if
> a backlight is supported.
>=20
> After an EC reset the backlight could be in a non-PWM mode.
> Earlier in the boot sequence the BIOS should send a command to
> the EC to set the brightness, so things **should** be set up,
> but we double check in probe() as we query the initial brightness.
> If not set up, then set the brightness to 0.
>=20
> Since the EC will never change the backlight level of its own accord,
> we don't need to implement a brightness_get() method.
=2E..
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymYGoACgkQMOfwapXb+vLYUgCgsPgTBohHm4ztKgBYMtWoJma0
VRkAoI4/89nZFkwhMdJlDvcCK+hHhMyL
=c7Go
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
