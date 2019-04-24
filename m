Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8100C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3929218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfDXNqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:46:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55410 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfDXNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:46:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ED62E80765; Wed, 24 Apr 2019 15:46:24 +0200 (CEST)
Date:   Wed, 24 Apr 2019 15:46:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 02/26] leds: class: Improve LED and LED flash class
 registration API
Message-ID: <20190424134633.GA14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-3-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-3-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +/**
> + * led_classdev_register_ext - register a new object of LED class with
> + *			       init data
> + * @parent: LED controller device this LED is driven by
> + * @led_cdev: the led_classdev structure for this device
> + * @init_data: the LED class device initialization data
> + *
> + * Returns: 0 on success or negative error value on failure
> + */
> +extern int led_classdev_register_ext(struct device *parent,
> +				     struct led_classdev *led_cdev,
> +				     struct led_init_data *init_data);
> +#define led_classdev_register(parent, led_cdev)			\
> +	led_classdev_register_ext(parent, led_cdev, NULL)
> +extern int devm_led_classdev_register_ext(struct device *parent,
> +					  struct led_classdev *led_cdev,
> +					  struct led_init_data *init_data);
> +#define devm_led_classdev_register(parent, led_cdev)		\
> +	devm_led_classdev_register_ext(parent, led_cdev, NULL)

Static inline (instead of macro) might be preffered. More type safety
and less confusing behaviour in case of errors...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAaLgACgkQMOfwapXb+vKyTgCgsOUBcfIzhs8Dz6QDfiZk6Tyz
xxUAn05DyUMlRjizCI1uRAyr3qr/T+Mw
=H8U1
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
