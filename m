Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BCCC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF9208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561736121;
	bh=hsS93llGa74pwP3iTaDdxgzOA6ouLPERwTv8Ckp8yKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0svkkePPse2/MIQ8n/EFcLbGlMTE44B5TxVD39KJOtv2wzOGER1HtusnvDXsbC5i7
	 +4QURKoXWIEi12A5xaESxNFDcVuqt8LkQ5RaveTNuPU4qwKr/yF98G84B3dwJFoIJm
	 gniZutXvkj/hxH4IN7FRZZWqUTJv5nmhUhN9FVis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfF1PfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:35:20 -0400
Received: from earth.universe (dyndsl-091-096-035-018.ewe-ip-backbone.de [91.96.35.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A702064A;
        Fri, 28 Jun 2019 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561736119;
        bh=hsS93llGa74pwP3iTaDdxgzOA6ouLPERwTv8Ckp8yKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJT6Vu+o7jXfi6XyhXuQnNgmA7E9FnokeaBJhelPRj6lYwbLgqEinHCE9r9Z807Ef
         9/mr4SWs1PgpxGGkzBB9v0F8VwBUukP2YpLBke8DmGEen14RFJyzQDg/fZHMqJXhwx
         Nbmig9WdkjWEbvDk+IUdY9xs/sOIT9r9LSkRLS7s=
Received: by earth.universe (Postfix, from userid 1000)
        id 08B013C08D5; Fri, 28 Jun 2019 17:35:17 +0200 (CEST)
Date:   Fri, 28 Jun 2019 17:35:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nick Crews <ncrews@chromium.org>
Subject: Re: linux-next: manual merge of the battery tree with the mfd tree
Message-ID: <20190628153516.zgdeajulrzghot5e@earth.universe>
References: <20190628134545.4b9b8625@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i43rqq5flm3u7kll"
Content-Disposition: inline
In-Reply-To: <20190628134545.4b9b8625@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i43rqq5flm3u7kll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Jun 28, 2019 at 01:45:45PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the battery tree got conflicts in:
>=20
>   drivers/power/supply/Kconfig
>   drivers/power/supply/Makefile
>=20
> between commit:
>=20
>   f8c7f7ddd8ef ("power: supply: Initial support for ROHM BD70528 PMIC cha=
rger block")
>=20
> from the mfd tree and commit:
>=20
>   0736343e4c56 ("power_supply: wilco_ec: Add charging config driver")
>=20
> from the battery tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This one should no longer appear on next tree update, since I
dropped 0736343e4c56.

-- Sebastian

>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/power/supply/Kconfig
> index 4a3cd679295b,4c01598f5ccb..000000000000
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@@ -689,13 -702,13 +703,22 @@@ config CHARGER_UCS100
>   	  Say Y to enable support for Microchip UCS1002 Programmable
>   	  USB Port Power Controller with Charger Emulation.
>  =20
>  +config CHARGER_BD70528
>  +	tristate "ROHM bd70528 charger driver"
>  +	depends on MFD_ROHM_BD70528
>  +	default n
>  +	help
>  +	 Say Y here to enable support for getting battery status
>  +	 information and altering charger configurations from charger
>  +	 block of the ROHM BD70528 Power Management IC.
>  +
> + config CHARGER_WILCO
> + 	tristate "Wilco EC based charger for ChromeOS"
> + 	depends on WILCO_EC
> + 	help
> + 	  Say Y here to enable control of the charging routines performed
> + 	  by the Embedded Controller on the Chromebook named Wilco. Further
> + 	  information can be found in
> + 	  Documentation/ABI/testing/sysfs-class-power-wilco
> +=20
>   endif # POWER_SUPPLY
> diff --cc drivers/power/supply/Makefile
> index 346a8ef5f348,d2263e1e2b6f..000000000000
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@@ -90,4 -91,4 +91,5 @@@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cro
>   obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
>   obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
>  +obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
> + obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o



--i43rqq5flm3u7kll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0WM7QACgkQ2O7X88g7
+pounw/9EqmUID4oeUiAGjAbFp62w5mFxTXa8MrwmXScDqhoxED/KwcaUnx1CYnz
TZUooj/eLbN2+NJEhE6uiGzOwDbQK+ZgljXSg4ckN/3Jc5kWleQMjB4IPhFseDw5
Vu/TNZwVOwGOPVASN9hvu/FV7KzneVYmk17vWKuwjzSXQXMPO+a6Zr5ub8XYMDFx
uDlE6X+uGtYCmR985sATL/dEd8XiQQ7zFNdmBz4A+ko520zljDPldcd4uHNfzkte
zMgCyoT/EMs6JKj3V4IXOpm4hP26F+BwH8qHyHcmfE3eoaTgE+8TGcedYa5KsbJs
oRkD0CJrWlSTvgWeWxGTyzLOMXIPxNSwKqd8rSusc7q7B6TzQzUHRCm/Nioe7EiX
TSczRP+OudVh/VqnVg0D0RxPt4+0kqi5QiR6py9TmEnNGADcZzyqV/5ymy7zrlBl
P4TsXXiAbMIaD3qUVGCTCg7rwNCd63RW/J/hSqXvIQmOS+iQRepYT3CrF4Bcy1fU
2ADtRUAdo8mpyO2peIJMjEEduXWBmB5fNTdK0nmmItoac0XC6ZPyEXBHM9MYSH7m
lKYutmYZH8mhqy5cLDkugseFa/crB/bCyRVEuEFSSjA35ud4QUGOmW4MOB2+tir4
7cfOdX1oGE+oi1XH2fpz6C2U23g3WZKPMdniiEGhxK009JmP6Bk=
=fye5
-----END PGP SIGNATURE-----

--i43rqq5flm3u7kll--
