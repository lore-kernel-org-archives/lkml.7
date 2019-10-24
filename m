Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3661FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CDF21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437905AbfJXHPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:15:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50579 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437885AbfJXHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:15:24 -0400
X-Originating-IP: 93.2.121.143
Received: from uno.localdomain (143.121.2.93.rev.sfr.net [93.2.121.143])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5F255E0015;
        Thu, 24 Oct 2019 07:15:16 +0000 (UTC)
Date:   Thu, 24 Oct 2019 09:17:03 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-ID: <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
 <20191023155941.q563d3cfizre4zvt@holly.lan>
 <20191024064726.GB15843@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wfpai4ndwplq7h5c"
Content-Disposition: inline
In-Reply-To: <20191024064726.GB15843@dell>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wfpai4ndwplq7h5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 24, 2019 at 07:47:26AM +0100, Lee Jones wrote:
> On Wed, 23 Oct 2019, Daniel Thompson wrote:
>
> > On Tue, Oct 22, 2019 at 11:29:54AM +0200, Bartosz Golaszewski wrote:
> > > wt., 22 pa=C5=BA 2019 o 10:36 Bartosz Golaszewski <brgl@bgdev.pl> nap=
isa=C5=82(a):
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > While working on my other series related to gpio-backlight[1] I not=
iced
> > > > that we could simplify the driver if we made the only user of platf=
orm
> > > > data use GPIO lookups and device properties. This series tries to do
> > > > that.
> > > >
> > > > First two patches contain minor fixes. Third patch makes the driver
> > > > explicitly drive the GPIO line. Fourth patch adds all necessary data
> > > > structures to ecovec24. Patch 5/9 unifies much of the code for both
> > > > pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> > > > fields. Last two patches contain additional improvements for the GP=
IO
> > > > backlight driver while we're already modifying it.
> > > >
> > > > I don't have access to this HW but hopefully this works. Only compi=
le
> > > > tested.
> > > >
> > > > [1] https://lkml.org/lkml/2019/6/25/900
> > > >
> > > > v1 -> v2:
> > > > - rebased on top of v5.3-rc1 and adjusted to the recent changes fro=
m Andy
> > > > - added additional two patches with minor improvements
> > > >
> > > > v2 -> v3:
> > > > - in patch 7/7: used initializers to set values for pdata and dev l=
ocal vars
> > > >
> > > > v3 -> v4:
> > > > - rebased on top of v5.4-rc1
> > > > - removed changes that are no longer relevant after commit ec665b75=
6e6f
> > > >   ("backlight: gpio-backlight: Correct initial power state handling=
")
> > > > - added patch 7/7
> > > >
> > > > v4 -> v5:
> > > > - in patch 7/7: added a comment replacing the name of the function =
being
> > > >   pulled into probe()
> > > >
> > > > v5 -> v6:
> > > > - added a patch making the driver explicitly set the direction of t=
he GPIO
> > > >   to output
> > > > - added a patch removing a redundant newline
> > > >
> > > > v6 -> v7:
> > > > - renamed the function calculating the new GPIO value for status up=
date
> > > > - collected more tags
> > > >
> > > > Bartosz Golaszewski (9):
> > > >   backlight: gpio: remove unneeded include
> > > >   backlight: gpio: remove stray newline
> > > >   backlight: gpio: explicitly set the direction of the GPIO
> > > >   sh: ecovec24: add additional properties to the backlight device
> > > >   backlight: gpio: simplify the platform data handling
> > > >   sh: ecovec24: don't set unused fields in platform data
> > > >   backlight: gpio: remove unused fields from platform data
> > > >   backlight: gpio: use a helper variable for &pdev->dev
> > > >   backlight: gpio: pull gpio_backlight_initial_power_state() into p=
robe
> > > >
> > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
> > > >  drivers/video/backlight/gpio_backlight.c     | 128 +++++++--------=
----
> > > >  include/linux/platform_data/gpio_backlight.h |   3 -
> > > >  3 files changed, 69 insertions(+), 95 deletions(-)
> > > >
> > > >
> > >
> > > Lee, Daniel, Jingoo,
> > >
> > > Jacopo is travelling until November 1st and won't be able to test this
> > > again before this date. Do you think you can pick it up and in case
> > > anything's broken on SH, we can fix it after v5.5-rc1, so that it
> > > doesn't miss another merge window?
>
> November 1st (-rc6) will be fine.
>
> I'd rather apply it late-tested than early-non-tested.
>
> Hopefully Jacopo can prioritise testing this on Thursday or Friday,
> since Monday will be -rc7 which is really cutting it fine.

I'll do my best, I'll get home Friday late afternoon :)


>
> > Outside of holidays and other emergencies Lee usually collects up the
> > patches for backlight. I'm not sure when he plans to close things for
> > v5.5.
>
> In special cases such as these I can remain flexible.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--wfpai4ndwplq7h5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl2xT+kACgkQcjQGjxah
VjyWSRAAxMG+doVs6jKDU7YNSv/u74lWN3O4ddF1jNPc3tEP3zjxqXDzGlzX8QeD
LJ8SjmP4xIcU6gTJOEj30PbxQk4w/uCuhVk50LHZxsH8LY6d+NF8F65UaPpJ843X
WFmK4WDdXkIRZ/HxRL83m9hLmpHRZTGtjW71t+4h7W1aFZfJe6AaWDp+uh76/9qi
o2gfkjhELb5+wViBHfLexMgWNIGfY7kMXjSiZPZk1hghTvIkNqKm7thvwm5ecgd1
V0pkF84tBb2qUGV15DC8fYmlsNxiv3iWeh+j8kayiMvGeQSuwPfAQBxW5ihfydau
NRconH89vXqfl85J6QdEQXI8oM3jLh2rr5bs1QCudeX+Q4yZyxgCWDImCTjO6338
BTjm4kNGbeaiNbU/t1vVJnjK+DeHluhaK5ahq4IAcwB16ultNHfe/IggX/xoZHkY
KwSh0NmnVOWcIyokDlOZLvViA16qdD5II0rHx1D75VvwAS3QnyDXBt/A2FF4MYP+
DQMV8jXkSw7YI5U1j55uEWBA1ePpeZMj2sG7wNBu48uyOzGgbUitnYKm1hkihJM9
i5D6B9vBJiUOO1auaGcmaNZXWqjuAzk7chajL2O6hprhB3uNUSqHX6oBpJQFb6Yd
tOpoiYc2px3euAANQVkKw7rOWYBeZlpR7Ic2tvc0lkaeb5agFgA=
=OTLb
-----END PGP SIGNATURE-----

--wfpai4ndwplq7h5c--
