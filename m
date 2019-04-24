Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1554DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B0D218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfDXIbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:31:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56319 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfDXIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:31:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7C0028066F; Wed, 24 Apr 2019 10:31:19 +0200 (CEST)
Date:   Wed, 24 Apr 2019 10:31:27 +0200
From:   Pavel Machek <pavel@denx.de>
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
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
Message-ID: <20190424083127.GB6699@amd>
References: <20190423090451.23711-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> This series adds support for max77650 ultra low-power PMIC. It provides
> the core mfd driver and a set of five sub-drivers for the regulator,
> power supply, gpio, leds and input subsystems.
>=20
> Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devic=
es().
> Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
> device.
>=20
> The regulator part is already upstream.

I see v10 in my inbox... and acks from all over the place, but patches
not going in. Who takes these? I don't think I need another 10
versions in my inbox...
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAHt8ACgkQMOfwapXb+vL/mgCeOCQVfRMEFE1+NFcHmsDoDLMo
MjsAoI/6BvVLuAazM6fSVjSB60dlhrmA
=BJ96
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
