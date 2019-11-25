Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27665C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfKYK2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:28:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:47692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfKYK2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:28:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2586BAEAF;
        Mon, 25 Nov 2019 10:28:14 +0000 (UTC)
Message-ID: <9df5fcd121b4456f1e2bd3c512c44cfb71b6b17b.camel@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Make Nicolas Saenz Julienne the new
 bcm2835 maintainer
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Nov 2019 11:28:11 +0100
In-Reply-To: <1574617733-18151-1-git-send-email-wahrenst@gmx.net>
References: <1574617733-18151-1-git-send-email-wahrenst@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IH2jLMLLi1bcBKZvzpHe"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IH2jLMLLi1bcBKZvzpHe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-11-24 at 18:48 +0100, Stefan Wahren wrote:
> Eric isn't active any more and i don't have the necessary free time.
> Nicolas already made contributions to bcm2835 and is pleased to take
> over the maintainership. My thanks go to both of them.
>=20
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 512e527..4285190 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3224,8 +3224,7 @@ N:	kona
>  F:	arch/arm/mach-bcm/
>=20
>  BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> -M:	Eric Anholt <eric@anholt.net>
> -M:	Stefan Wahren <wahrenst@gmx.net>
> +M:	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>  L:	bcm-kernel-feedback-list@broadcom.com
>  L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

I'm glad to take over.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-IH2jLMLLi1bcBKZvzpHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3brLsACgkQlfZmHno8
x/78VwgAj4t67sNDmGa4Xs0pVoFgM5JUfmLuhKi4G9oztgQbyuHvdE7OP/Wav8F0
gzjmcxZABrSchcYbnV4QdgFIPh5RDMltNfyjx4MO/H0lstc6h3xaMX8eJMMkzXhm
M1PcLxgHxLFyKWWXRPzNgW9Gf8Bfrq4AfhGTi8H98aUN6aUDbFRlIm7Iz6DK/Ch7
okBTcnrm2tkc4TKo2/WtCvyOar7/ugRdbpBQqj4lmiqEJXCzUVpP4XDmojRM89/9
KjqEyrwqXnRpFFHJ6yGqItOXCDSElpvr8clo+eqspz70jyh5ZlfJiktny7R6WAPS
kuHjJPJ/azbWnfOoCeNEY36tociRHQ==
=/FYc
-----END PGP SIGNATURE-----

--=-IH2jLMLLi1bcBKZvzpHe--

