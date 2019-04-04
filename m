Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092902075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfDDTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:19:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60463 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:19:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2E9E2802E2; Thu,  4 Apr 2019 21:19:21 +0200 (CEST)
Date:   Thu, 4 Apr 2019 21:19:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
Message-ID: <20190404191931.GA29984@amd>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd>
 <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-04 12:05:39, Dmitry Torokhov wrote:
> On Thu, Apr 4, 2019 at 11:59 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Thu 2019-04-04 11:55:27, Dmitry Torokhov wrote:
> > > On Thu, Apr 4, 2019 at 11:41 AM Nick Crews <ncrews@chromium.org> wrot=
e:
> > > >
> > > > On Thu, Apr 4, 2019 at 11:43 AM Dmitry Torokhov <dtor@google.com> w=
rote:
> > > > >
> > > > > On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com>=
 wrote:
> > > > > >
> > > > > > On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org=
> wrote:
> > > > > > >
> > > > > > > We want all backlights for the system keyboard to
> > > > > > > use a common name, so the name "platform::kbd_backlight"
> > > > > > > would be better than the current "chromeos::kbd_backlight"
> > > > > > > name. Normally this wouldn't be worth changing, but the new
> > > > > > > Wilco keyboard backlight driver uses the "platform" name.
> > > > > > > We want to make it so all Chrome OS devices are consistent,
> > > > > > > so we'll change the name here too.
> > > > > > >
> > > > > >
> > > > > > Wondering - who is the "we" you are talking about ?
> > > >
> > > > You're right, I should have been more precise.
> > > > I was referring to Pavel, Enric, and myself. Pavel had this opinion=
 here:
> > > > https://lkml.org/lkml/2019/4/4/1040. I don't know what Pavel meant =
by "we"
> > > > in that comment, but I would guess that could mean the other LED ma=
intainers
> > > > as well? I talked with Enric 1:1 and he didn't see the problem with=
 changing it,
> > > > though perhaps he was only considering our use of the LED via power=
d,
> > > > and not users in general. I'm guessing Pavel's and Enric's meanings=
 though,
> > > > excuse me if I am misinterpreting.
> > > >
> > > > >
> > > > > This also has a potential of breaking existing setups if somebody=
 did
> > > > > happen to match on entire name instead of suffix. Such changes ha=
ve to
> > > > > be considered very carefully; at this point I am against of doing
> > > > > this.
> > > >
> > > > Would it make sense to keep the old name as is, and only make the n=
ew
> > > > Wilco name begin with "platform:"? What would you think is best?
> > >
> > > Given that we do not have a single instance of platform::kbd_backlight
> > > in kernel at this time I have no idea why Pavel is trying to push this
> > > for Wilco driver.
> >
> > See the documentation in the email I sent few seconds ago. I hope it
> > explains my reasoning, if not, I'll explain it.
>=20
> Yes, I see the doc and I do not think I agree with it. If you look at
> the LED docs you will see:

If you take a look at mailing list archive, this is currently being
worked on. And you might want to take a look at MAINTAINERS file :-)

> LED Device Naming
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Is currently of the form:
>=20
> "devicename:colour:function"
>=20
> It is *function* and maybe color that userspace is interested in, and
> here we have proper standardization in form of "kbd_backlight". Device
> name is, well, device name. It should uniquely identify the device led
> is attached to, but otherwise is rarely interesting. If userspace is
> really concerned what kind of keyboard backlight it is it should
> investigate parent device(s) and see what they end up with.

That does not work. Userspace wants to know if it is internal keyboard
or USB keyboard, not what kind of i2c controller the LED is connected
to.

grep for platform::mic_mute .

(And platform is even pretty good match for how the LED is connected
in your case).
									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymWMMACgkQMOfwapXb+vLtRwCeKg+Mhx+CzBL/yeWW4Zr+ISYg
FVoAoLdptqIt1B4iPr89FDvZ5gcyREgb
=WTI8
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
