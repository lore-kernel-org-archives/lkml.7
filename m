Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B4C2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfCVJ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:59:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33252 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:59:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 829CE802C7; Fri, 22 Mar 2019 10:59:14 +0100 (CET)
Date:   Fri, 22 Mar 2019 10:59:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for
 max77650
Message-ID: <20190322095920.GM27015@amd>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-5-brgl@bgdev.pl>
 <20190322090927.GG27015@amd>
 <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Content-Disposition: inline
In-Reply-To: <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-22 10:55:26, Bartosz Golaszewski wrote:
> pt., 22 mar 2019 o 10:09 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
> >
> > On Mon 2019-03-18 18:42:21, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the DT binding document for the onkey module of max77650.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > > +     onkey {
> > > +             compatible =3D "maxim,max77650-onkey";
> > > +             linux,code =3D <KEY_END>;
> > > +             maxim,onkey-slide;
> > > +     };
> >
> > This is certainly wrong.
> >
> > "End" key is normal key on a keyboard, certainly not some kind of
> > slider.
> >
> > And this controller is likely to be used for power key, not end key,
> > right?
>=20
> But this is just an example of available properties, not a real use-case.

We can have example that makes sense, right?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUsfgACgkQMOfwapXb+vL7oACfXt7TCBzA5aDs0AaHx7sSIh/y
OG4An0Bi8Rmg2n4GKLzXGDB4YzPwb4Gu
=DK14
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
