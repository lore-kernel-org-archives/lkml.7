Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F061520825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555357449;
	bh=6lW6ykUoQp/n4gUTrMVw2ocv9lDh94UgruEDQewhLno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bB6TNTzVZ0J5/RKjZJuZY5GFB22b7d4oYcH3bIefY9KfgrUD19eWXw4/Q97OU4qJ+
	 goFC2k6UZaMCXxkZMG4dLx+nf2crfgDnJUJ1BMKu/TieVJlWdzb9Psjt6PmGyFmWwh
	 EP4wB8NF5Zr3GYJQ06UO8kasvmwsanc85c1GVxUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfDOToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfDOToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:44:07 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C6F20825;
        Mon, 15 Apr 2019 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555357446;
        bh=6lW6ykUoQp/n4gUTrMVw2ocv9lDh94UgruEDQewhLno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mpt/N8PVP01/vfAXWVMa9xOMwxpBhUiEaz90s1oram7xQ1YquavinnEVQSBKPtlo5
         vdylQpSCKj0pJxD1PZJGrs2XTUoricfN5NCLYbTK0/Adj/xC8U9BEMotJM2l5rFcCL
         3+md8z19BcN1/oDEqr0tzjOZcz2SCgGvnhoVB70M=
Received: by earth.universe (Postfix, from userid 1000)
        id 72DF53C08D5; Mon, 15 Apr 2019 21:44:03 +0200 (CEST)
Date:   Mon, 15 Apr 2019 21:44:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: fix typo in function to get current
 charge control limit
Message-ID: <20190415194403.hj23wvbw7brb7qkv@earth.universe>
References: <20190415142918.4383-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fg2cu7rwq4kf52ih"
Content-Disposition: inline
In-Reply-To: <20190415142918.4383-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fg2cu7rwq4kf52ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 15, 2019 at 04:29:18PM +0200, Enric Balletbo i Serra wrote:
> There is a spelling mistake in ps_get_cur_charge_cntl_limit function so
> replace 'chrage' for 'charge'.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>=20
>  drivers/power/supply/power_supply_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index c917a8b43b2b..ef2aecfe2cd2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -899,7 +899,7 @@ static int ps_get_max_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
>  	return ret;
>  }
> =20
> -static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *t=
cd,
> +static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *t=
cd,
>  					unsigned long *state)
>  {
>  	struct power_supply *psy;
> @@ -934,7 +934,7 @@ static int ps_set_cur_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
> =20
>  static const struct thermal_cooling_device_ops psy_tcd_ops =3D {
>  	.get_max_state =3D ps_get_max_charge_cntl_limit,
> -	.get_cur_state =3D ps_get_cur_chrage_cntl_limit,
> +	.get_cur_state =3D ps_get_cur_charge_cntl_limit,
>  	.set_cur_state =3D ps_set_cur_charge_cntl_limit,
>  };
> =20
> --=20
> 2.20.1
>=20

--fg2cu7rwq4kf52ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly03wMACgkQ2O7X88g7
+poyMg/7BnuoQ9N1OqyZiZUWLhmzxNOLKnkFon4ANsgpqbmPCR2MiS5eCwcrAbjY
9MMqxRsSFODTtppsKPpBGJVltJzOk0jpViRBtMo5PwKSap3hasJ9GM19cdIJEPlb
SW/Blm/WSL2vhEItFtC02iST++9RThJmxAVIkQHwUsPKZ46kw/sFqRy8kRkfQue2
pbspFiMENO2rvdwt/aQjKsx4nNkempTLaZC+Rb2OZgRbyxVpo5AxMQeVPkEBVRqR
z2ntaM/pf783Ec0mXXTvxGV1Q3LZpPJZvy1ETzU47CvF+GdcH82hZhHGjzaJVH5W
RcShIrIm7hXPEcHsuOY3sox0ImcoY6+XiHCL8V97TngkB51bw+qac0lojVFtHyAq
+QSl+whSr8MUGGW+D3w0S9gyplkJWWOYZ7vY6DJBOi5by8GZLMw0IYOhgEYpFoiR
/Ls3gyV4/vZ6NgSW3EjRmD8H1amGJdWJV9WM/TgFR/1iz+CH8phVouwR1Kvk/0mK
QWwvRiZLdh0+Ft1Sv91YDU05MGrg+x2BHiMNtzB6lpvilEk84wLy+3pSNzTga4jD
l0MuRVAAk15ZCUzqpEdvRDynyBC5dPl5OHcH8pp8D7uIzrzxUoqH6aKIUJj0FDwM
JgTD/hg4yCh8n8meuDI1Wf70Y22uO/rhc/CmgFeTegjIT0n4Cyc=
=Zq+n
-----END PGP SIGNATURE-----

--fg2cu7rwq4kf52ih--
