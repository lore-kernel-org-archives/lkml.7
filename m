Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C881206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfDDUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:20:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33886 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfDDUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:20:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 39D79802DD; Thu,  4 Apr 2019 22:20:31 +0200 (CEST)
Date:   Thu, 4 Apr 2019 22:20:42 +0200
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
Message-ID: <20190404202042.GF29984@amd>
References: <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd>
 <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd>
 <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd>
 <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-04 13:13:34, Dmitry Torokhov wrote:
> On Thu, Apr 4, 2019 at 1:06 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > > > It is *function* and maybe color that userspace is interested in,=
 and
> > > > > here we have proper standardization in form of "kbd_backlight". D=
evice
> > > > > name is, well, device name. It should uniquely identify the devic=
e led
> > > > > is attached to, but otherwise is rarely interesting. If userspace=
 is
> > > > > really concerned what kind of keyboard backlight it is it should
> > > > > investigate parent device(s) and see what they end up with.
> > > >
> > > > That does not work. Userspace wants to know if it is internal keybo=
ard
> > > > or USB keyboard, not what kind of i2c controller the LED is connect=
ed
> > > > to.
> > >
> > > Why does userspace want to know it?
> >
> > For example to turn off backlight on internal keyboard when the lid is =
closed.
>=20
> Would you not want to turn off external as well?

Not really. If I'm using machine with lid closed, external monitor and
USB keyboard attached, I want to control backlight of USB keyboard,
but backlight of internal keyboard can stay off.

> And what to do if internal keyboard is not platform but USB? Like
> Google "Whiskers"? (I am not sure why you decided to drop my mention
> of internal USB keyboards completely off your reply).

I don't have answers for everything. Even if you have USB keyboard, you'll
likely still have backlight connected to embedded controller. If not,
then maybe you have exception userland needs to know about.

Still better than making everything an exception.

> > > > grep for platform::mic_mute .
> > > >
> > > > (And platform is even pretty good match for how the LED is connected
> > > > in your case).
> > >
> > > Until we get a secondary interface that is also "platform"...
> >
> > How would that happen?
>=20
> It won't happen on Wilco, but you can't imagine that several blocks
> get reused in the same device and they end up clashing?

In the end, there will be just one internal keyboard backlight, right?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlymZxoACgkQMOfwapXb+vLn5QCfSbNvjo91bsUzD0yC/OdKMe60
gKoAnjqsLnPZ538cfiN5/TCl3hIXhsG7
=Dr/v
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
