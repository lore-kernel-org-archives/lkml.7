Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FEC282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D3620880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHJlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:41:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59577 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:41:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2F56C80477; Mon,  8 Apr 2019 11:41:02 +0200 (CEST)
Date:   Mon, 8 Apr 2019 11:41:13 +0200
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
Subject: Keyboard backlight LED naming was Re: [PATCH v5 2/3]
 platform/chrome: Add Wilco EC keyboard backlight LEDs support
Message-ID: <20190408094113.GB30958@amd>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net>
 <20190406084157.GA27043@amd>
 <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com>
 <20190407221846.GB6327@amd>
 <CAE_wzQ_5Ha6hNt28_+j-pF3mAdXXifv9CuotDCeXff8KC1DNmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_5Ha6hNt28_+j-pF3mAdXXifv9CuotDCeXff8KC1DNmA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > This document also states "The naming scheme above leaves scope
> > > > > for further attributes should they be needed". It does not permit,
> > > > > however, to redefine one of the fields to mean "location", much l=
ess
> > > > > the declaration that a devicename of "platform" shall refer to an
> > > > > "internal" backlight, or that there shall be no more than one
> > > > > "internal" backlight in a given system.
> > > >
> > > > "platform" is as good devicename as "wilco" or "chromeos".
> > >
> > > No, because "platform" is not a device, it is something that you are
> > > trying to assign a magic meaning to.
> >
> > "chromeos" is not a device, either.
>=20
> I agree, it is not a device name. We do not assign any specific
> meaning to it though. We could change it to "cros_ec" if so desired
> and nothing should break.

Yes. And you can also change it to "platform" and nothing will break
:-). Can we end the discussion here?

If not, lets take a look at existing names:

=2E/drivers/platform/x86/asus-laptop.c:		cdev->name =3D "asus::kbd_backligh=
t";
=2E/drivers/platform/x86/samsung-laptop.c:		samsung->kbd_led.name =3D "sams=
ung::kbd_backlight";
=2E/drivers/platform/x86/thinkpad_acpi.c:		.name		=3D "tpacpi::kbd_backligh=
t",
=2E/drivers/platform/x86/toshiba_acpi.c:		dev->kbd_led.name =3D "toshiba::k=
bd_backlight";
=2E/drivers/platform/x86/asus-wmi.c:		asus->kbd_led.name =3D "asus::kbd_bac=
klight";
=2E/drivers/platform/x86/dell-laptop.c:	.name           =3D "dell::kbd_back=
light",
=2E/drivers/platform/chrome/cros_kbd_led_backlight.c:	cdev->name =3D "chrom=
eos::kbd_backlight";
=2E/drivers/hwmon/applesmc.c:	.name			=3D "smc::kbd_backlight",
=2E/drivers/hid/hid-asus.c:	drvdata->kbd_backlight->cdev.name =3D "asus::kb=
d_backlight";
=2E/drivers/hid/hid-google-hammer.c:	kbd_backlight->cdev.name =3D "hammer::=
kbd_backlight";
=2E/drivers/input/misc/ims-pcu.c:		 "pcu%d::kbd_backlight", pcu->device_no);

asus, samsung, toshiba, asus, dell, chromeos... Those are really not
device names, either. But in these cases, LED is probably controlled
by EC, or by ACPI BIOS talking to the EC. People usually call such
devices "platform devices".

(Linux Platform Device Driver - CodeProject
=EF=BF=BChttps://www.codeproject.com/tips/1080177/linux-platform-device-dri=
ver
A platform device is one which is hardwired on the board and hence not
hot-pluggable. )

You can take a look at discussion around micmute LED.

Thus "platform" is quite suitable name in your case, and incidentaly,
it will be more useful for userspace than "cros_ec".

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrFzkACgkQMOfwapXb+vJlgwCguCID6XvkjcM8i9lF5T/C4qOa
CNQAn1xrrUlWgNG+JX2gh9qDIDpJ0ckJ
=oyOJ
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
