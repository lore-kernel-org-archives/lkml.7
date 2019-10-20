Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2ACCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3D20640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571576308;
	bh=a4cIo6o/+l6MkZI3kV4/Qt6TYtKNFU41pnysG7BhNLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZjuEjprIfJcy57HeVHs/CBRL4ARxoJ40eQEifwMUKrdOSYqISrivCheQzibdfLYe9
	 6inWzxEhS0UZuUA4O/TVnnrcjJ9KQ+v3gmvzuom+NK/hvYizJgnXQZLYmlLN0psCly
	 v406g/BmbK9vxS5PXH9YhsgYXutQEI4D+U9w2JAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfJTM5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfJTM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:57:50 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F33620640;
        Sun, 20 Oct 2019 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571576269;
        bh=a4cIo6o/+l6MkZI3kV4/Qt6TYtKNFU41pnysG7BhNLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v1FjeWn5SBJeVRD2R9oZ/FgQSCB2L8VZ2hrOLgLrKlgCzlkL1k3ELGFGSR36OB15G
         NUQgyUo7xENX9ro6WV+FPiKPFiZBi7VOufshihqPfwBfxDsB7E0H5DukzE6AGNZUf9
         SNvbvbadbi0ruBS5aJ+ss6wglmJI31pweTp4Qr2A=
Received: by earth.universe (Postfix, from userid 1000)
        id CAF6D3C09B1; Sun, 20 Oct 2019 14:57:37 +0200 (CEST)
Date:   Sun, 20 Oct 2019 14:57:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Power: supply: abx500_chargalg.c: Fixed a code
 indentation error
Message-ID: <20191020125737.t4lx6nshoszojbtx@earth.universe>
References: <20191015161341.26868-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlbqmfvintztvz3z"
Content-Disposition: inline
In-Reply-To: <20191015161341.26868-1-madhuparnabhowmik04@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tlbqmfvintztvz3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2019 at 09:43:41PM +0530, madhuparnabhowmik04@gmail.com wro=
te:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>=20
> Fixed Code indentation error caused due to using spaces
> instead of tabs.
> The error reported by checkpatch.pl is:
>  ERROR: code indent should use tabs where possible
> The warning reported by checkpatch.pl is:
>  WARNING: please, no spaces at the start of a line
>=20
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/abx500_chargalg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/suppl=
y/abx500_chargalg.c
> index 23757fb10479..e6e37d4f20e4 100644
> --- a/drivers/power/supply/abx500_chargalg.c
> +++ b/drivers/power/supply/abx500_chargalg.c
> @@ -354,13 +354,13 @@ static int abx500_chargalg_check_charger_enable(str=
uct abx500_chargalg *di)
> =20
>  	if (di->chg_info.charger_type & USB_CHG) {
>  		return di->usb_chg->ops.check_enable(di->usb_chg,
> -                         di->bm->bat_type[di->bm->batt_id].normal_vol_lv=
l,
> -                         di->bm->bat_type[di->bm->batt_id].normal_cur_lv=
l);
> +			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
> +			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
>  	} else if ((di->chg_info.charger_type & AC_CHG) &&
>  		   !(di->ac_chg->external)) {
>  		return di->ac_chg->ops.check_enable(di->ac_chg,
> -                         di->bm->bat_type[di->bm->batt_id].normal_vol_lv=
l,
> -                         di->bm->bat_type[di->bm->batt_id].normal_cur_lv=
l);
> +			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
> +			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
>  	}
>  	return 0;
>  }
> --=20
> 2.17.1
>=20

--tlbqmfvintztvz3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sWb4ACgkQ2O7X88g7
+po7UA/7ByxXHbLl3FPKRDFfRH9tDLdQeF9MUepCzmywVN5jpt4CULuUhoFmkKvz
6uQOQLN52Nm2NlLL2WbvKBtdmuMCuJn4EpiWG0R7er85lpAJJQoP7U0GWB0PDCfe
g7BSrYEWqYCs3S8GV+xPJNVCoefg6gnWDcorBluP0z6PZnp4wJq8KV6nX9O5Pdzw
8qkw5ZVyWvuhwvPpvVpK9vFS+e2NE5T9sCa4dlmJZWgWBzJjoaU6VY/aXspJMZim
K1ZFwriD4SmDKtgu1BvQ1eZuYL1my2dxf1R0QkgweEVBUeCID+SzSFoFCHQEB2of
jfTFJocQL7xA3YYZ9DzcibzXqBWB0AeQpd9RklVoHPLdNL3S79tZVYd8lwZpNU9V
6ZgWGAG/+23ir6flUS+lNK60AnhAN7NIrhIDCZ5+WSxcjIZ8EY+l2jvrRcRPA4yx
/gPoCQqVKckivRyEgQvSWX/3hkh+i4bOXavpZUj6Io5Z2vXwXE8ohq1lN1couO+2
4aZItc0r54y5WdIoCLpDj5TtHclomfSHEX3Z5HYOwnqbwf4GjV572nl0OPd0PkIM
jzQkCZJwc9L1VlwPmNbMMt6LfYs0J9Fp73zEV9XulnBfVlCRrSuYYWI42BpiMMIb
OlbGtE4oF55v9JnttA0YvvCyg1UcBIaBZMcmCLs300nJyfLaIEM=
=ROpJ
-----END PGP SIGNATURE-----

--tlbqmfvintztvz3z--
