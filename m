Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A9C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F3F22CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567451631;
	bh=OizYxl3lrt9deG3h25f+ho99EA+PCZgsWV1P937PEE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XK+iEnjP/v9Ls9fR1Y4j7gUC0r3EqgA07Vp0/oOGW2eJfbDXIxRx86o3lpBmbi2ND
	 AJLoBqZiv1HmDbKy42Gnz1cecwlezI3qGYJp6OgS3GVr33vmfWyAkjBMdU5luv2nCy
	 pgplsZxDdOFSyUnHLRRfqy0NQGxhmGntK5T8diWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfIBTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfIBTNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:13:50 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9592A21883;
        Mon,  2 Sep 2019 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451629;
        bh=OizYxl3lrt9deG3h25f+ho99EA+PCZgsWV1P937PEE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZ2bX9gdspHW3XE7y1Ovfj8rUdQ7ToRn7IltaFJwLuQo/R8DPE6C4PnUi7OX6Q4Ch
         PJeTF8HrgXGDbFTcAJgn9hXpzgb08x7MwRAEJnt+0Em/yl5GHuEEtOyJE/LLiZLbCH
         m/KBdnAnBQIRaZSQkufgo2QPo1GeqowCUxc4uTrU=
Received: by earth.universe (Postfix, from userid 1000)
        id 5E8D13C0B7F; Mon,  2 Sep 2019 21:13:47 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:13:47 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: isp1704: remove redundant assignment to
 variable ret
Message-ID: <20190902191347.thcbxwo2vm32hozz@earth.universe>
References: <20190705093612.21925-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kuxj64xjg5hlbeip"
Content-Disposition: inline
In-Reply-To: <20190705093612.21925-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kuxj64xjg5hlbeip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 05, 2019 at 10:36:12AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable ret is being assigned with a value that is never
> read and it is being updated later with a new value. The
> assignment is redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/isp1704_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/suppl=
y/isp1704_charger.c
> index b48cb7aba97b..4812ac1ff2df 100644
> --- a/drivers/power/supply/isp1704_charger.c
> +++ b/drivers/power/supply/isp1704_charger.c
> @@ -342,7 +342,7 @@ static inline int isp1704_test_ulpi(struct isp1704_ch=
arger *isp)
>  	int vendor;
>  	int product;
>  	int i;
> -	int ret =3D -ENODEV;
> +	int ret;
> =20
>  	/* Test ULPI interface */
>  	ret =3D isp1704_write(isp, ULPI_SCRATCH, 0xaa);
> --=20
> 2.20.1
>=20

--kuxj64xjg5hlbeip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taesACgkQ2O7X88g7
+pq+wg//cBEGbqz/V0ogRccgqe9hAgyqMIC1Q3A8ThtdLESA24kd5zqxL3j2/k7A
+fr7UPFlqouOuDzMzoQpiplSTsKX+PNnneXAVbbUAvcoEQGq6SB9bCbNKrZWJTgj
6R5Fh6p6ErzCjXIf5+NufZd9Gw8iT2ExnGrcCjocFdKgAQ9VtUE2YFPffnJKhMCK
iG3ovEQgZUUWDsxzdGGZtpRb0UwVK6AxtQHufMveozIwau8kqMw7ZiIkWrPa7zNx
9i8zIOBVVsPAhkeCeZ/kLgGXYwagnRzOdG3qTVMExf8EpJbNVr/XL06dPJ8INpnm
2j2y/bavvMteCWgynOt4h4n08cbLGDUuHvqypRmUw42Qm1jc5FPjofSjRy86tiYM
cx8Q7Yy0fedYHIJTgP5zzvTRPPi3DRlB0A97T3ZhzYW+ntQaiUqHC+QGzOBoDeuu
OtUhoZ9CfyA4x0jMBIT+R953P1U5wfYdpown1F3tqZ5rlK/0FHOQWhZ4PjVA7VsM
5AfkhCfm6Bc6gj8OeU1E7MAAN6SSG6lGVOeE3ITPqRebQ1zUlF3sVgruTEBpmHhF
Wke/WNM7hpsVyiATycD0gKhka5t9r2uynO3Acc9s88k85pqFobBrjoSakYUVmw5R
BUlSnNB6XDV0qiRRZhKyEe2zhcWvHWCfDog/kOx072j1s6WWY3o=
=Y1QI
-----END PGP SIGNATURE-----

--kuxj64xjg5hlbeip--
