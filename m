Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4922CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfH2UA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:00:58 -0400
Received: from sauhun.de ([88.99.104.3]:42934 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2UA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:00:57 -0400
Received: from localhost (p54B33070.dip0.t-ipconnect.de [84.179.48.112])
        by pokefinder.org (Postfix) with ESMTPSA id 72AE22C001C;
        Thu, 29 Aug 2019 22:00:56 +0200 (CEST)
Date:   Thu, 29 Aug 2019 22:00:56 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: i2c mv64xxx: Update documentation path
Message-ID: <20190829200055.GJ3740@ninjato>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813060913.14722-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <20190813060913.14722-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 09:09:13AM +0300, Denis Efremov wrote:
> Update MAINTAINERS record to reflect the file move
> from i2c-mv64xxx.txt to marvell,mv64xxx-i2c.yaml.
>=20
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: linux-i2c@vger.kernel.org
> Fixes: f8bbde72ef44 ("dt-bindings: i2c: mv64xxx: Add YAML schemas")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Looks OK to me, Gregory or Maxime?

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87ac0378186c..590dcebe627f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7505,7 +7505,7 @@ I2C MV64XXX MARVELL AND ALLWINNER DRIVER
>  M:	Gregory CLEMENT <gregory.clement@bootlin.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +F:	Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
>  F:	drivers/i2c/busses/i2c-mv64xxx.c
> =20
>  I2C OVER PARALLEL PORT
> --=20
> 2.21.0
>=20

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1oLvQACgkQFA3kzBSg
KbbKHQ//Ytf/8lxAuBjEaG7YHrhOJwV+vAWR+ZlFudbv7vvuahzfrsdM/Ed9kzqB
7cbE6rTyGY79rCdvlQKQJywZTkvHCjSbvFGjoglcAzKqQWVt9x8+dp3VACnvC4ry
TdCVoAaVS6vAV0zKH9aD7ovzf0nqaIwdA/JJLLUfqT6bqctLkw9v1i/44IeCWc4D
+xOPAkP4aHtaLT/XUOuNFuthE1ex76sjpELEffxWbTTLHdlN9gmzr0+ku21vbUE+
O68EJrKiLAkzYPAlHOf6oKR3DPx9ikwBPo/QK4Otyq5jNBHm8/5QcE0yaQhSyHkr
50viZXe7yLxvb6IvAH0b++y6PxntE7ILgEWO8UmLiWQ53AVSzxxN1Cubm2IOmZ7u
L56XMyRm2opFeS585V768A1T3g9apBn8Ws3borfGWp9CG3/4kVI7PxmB8wOa+w6G
dYRoNMj+RN8PyNk3R5sOdmRoK5GtTrcoknXEJ/mMCRehvUMappoICOwjFWXuxCs8
93cN5VgHS82pJivQ3jpD/0KPtYyZp6q+QIPVPbEGYY1nDr4wXGgGooZ9p+sLZifM
EBAo7zg9IOLjb45V1tvQxEdJ4dkz1M5DRLU1z+mEi69b0/JOuPOVQlIUfmI8C81t
KATNgVXICYfHhUpO75s0ZAkl1jWR2E3zurboJfJF19oFxnfe7Lk=
=yb1K
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
