Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B7D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfDPHOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:14:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35597 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDPHOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:14:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A23BE80349; Tue, 16 Apr 2019 09:14:12 +0200 (CEST)
Date:   Tue, 16 Apr 2019 09:14:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED
 support is disabled
Message-ID: <20190416071420.GA14538@amd>
References: <20190415233732.3612-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20190415233732.3612-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-16 02:37:32, Aaro Koskinen wrote:
> When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
> gpio_led_register_device() will return a NULL pointer and we try
> to dereference it. Fix by checking also for a NULL pointer.
>=20
> Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table fo=
r LED device")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1gMwACgkQMOfwapXb+vLNiACgtHM3J/eHilRjovPi/HsUecPJ
3sgAnAnEyk1CZ+d8gZTBslnBFEdng6lt
=fEhN
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
