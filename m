Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD62C04E87
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0720644
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfESVZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 17:25:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59661 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbfESVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 17:25:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 715DB80378; Sun, 19 May 2019 23:25:18 +0200 (CEST)
Date:   Sun, 19 May 2019 23:25:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] clk: sifive: restrict Kconfig scope for the FU540
 PRCI driver
Message-ID: <20190519212527.GD31403@amd>
References: <20190513213001.23956-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <20190513213001.23956-1-paul.walmsley@sifive.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-13 14:30:04, Paul Walmsley wrote:
> Restrict Kconfig scope for SiFive clock and reset IP block drivers
> such that they won't appear on most configurations that are unlikely
> to support them.  This is based on a suggestion from Pavel Machek
> <pavel@ucw.cz>.  Ideally this should be dependent on
> CONFIG_ARCH_SIFIVE, but since that Kconfig directive does not yet
> exist, add dependencies on RISCV or COMPILE_TEST for now.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Thanks for doing this.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel

> ---
> This second version incorporates non-functional changes requested
> by Stephen Boyd <sboyd@kernel.org>.
>=20
>  drivers/clk/sifive/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> index 8db4a3eb4782..f3b4eb9cb0f5 100644
> --- a/drivers/clk/sifive/Kconfig
> +++ b/drivers/clk/sifive/Kconfig
> @@ -2,6 +2,7 @@
> =20
>  menuconfig CLK_SIFIVE
>  	bool "SiFive SoC driver support"
> +	depends on RISCV || COMPILE_TEST
>  	help
>  	  SoC drivers for SiFive Linux-capable SoCs.
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzhyccACgkQMOfwapXb+vKL9ACgxM0+9bKh/scPwPJjoynP4CP5
Pz4An3RLsy9e7OUJOOEqqejLViJVsWKX
=v+he
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
