Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15646FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4429215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfKHUxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:53:13 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:60386 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKHUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:53:13 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ACD2F1C0BEC; Fri,  8 Nov 2019 21:53:11 +0100 (CET)
Date:   Fri, 8 Nov 2019 21:53:11 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
Message-ID: <20191108205311.GD23750@amd>
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-11-08 17:09:00, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>=20
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Pavel Machek <pavel@denx.de>

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXcXVtwAKCRAw5/Bqldv6
8i60AJ9+HnW7KWLQ4Gzd+50rSbaEhAlNzQCgvmtOhTJcKVQRoI00YK/ZOpkBmjg=
=+1yy
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
