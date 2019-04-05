Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD6921738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554472176;
	bh=bUAg6EAurqjHSyc4YImb/XTHcFPiojfgfAa23OOiarI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X4bPQezGXCE2y6gfa90IrljnzwV4chgQJto+Qq6tlOPEB0Y6k2fy/sEIQLs9GVuCb
	 jTIVBQsPDghdhie9jAE5L6hco1MLni/6z9d0YLsGkXwD5RSUltGoVql1n7pyogFawQ
	 Ra87Ecpu/BP2met7+VM2ZBVsEZn8rEzJWEIGeELE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfDENte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:49:34 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554682186A;
        Fri,  5 Apr 2019 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554472172;
        bh=bUAg6EAurqjHSyc4YImb/XTHcFPiojfgfAa23OOiarI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ4wKu+XAsyDH+lRmMqnm6r8SD+aIIJrwtzBcEsqpyNErHc+iR6AyoUy5vLzEfhNY
         O3n7TbZC/VohEkTUngSpnXPBT1kzDhjWZXpMdJYuQNhN0D0L4FtHKZWbu6TsMxbCsk
         Mn1OgJXCzxPEdipP9/P/fWnLdRMuIKP8EQY9BFPg=
Received: by earth.universe (Postfix, from userid 1000)
        id 59FB23C08D5; Fri,  5 Apr 2019 15:49:30 +0200 (CEST)
Date:   Fri, 5 Apr 2019 15:49:30 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] power: supply: olpc_battery: Have the framework
 register sysfs files for us
Message-ID: <20190405134930.acntvwnep3ne6uol@earth.universe>
References: <20190310162419.11861-1-lkundrak@v3.sk>
 <20190310162419.11861-11-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unphcry5q6yu32bu"
Content-Disposition: inline
In-Reply-To: <20190310162419.11861-11-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unphcry5q6yu32bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 10, 2019 at 05:24:19PM +0100, Lubomir Rintel wrote:
> The power framework gained ability to register groups of sysfs
> attributes in commit cef8fe6a382c ("power: supply: core: add support for
> custom sysfs attributes").
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Suggested-by: Sebastian Reichel <sre@kernel.org>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v5:
> - Added this patch
>=20
>  drivers/power/supply/olpc_battery.c | 64 ++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 0d67158c13d6..c628d3a47e14 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -551,7 +551,7 @@ static ssize_t olpc_bat_eeprom_read(struct file *filp=
, struct kobject *kobj,
>  	return count;
>  }
> =20
> -static const struct bin_attribute olpc_bat_eeprom =3D {
> +static struct bin_attribute olpc_bat_eeprom =3D {
>  	.attr =3D {
>  		.name =3D "eeprom",
>  		.mode =3D S_IRUGO,
> @@ -575,7 +575,7 @@ static ssize_t olpc_bat_error_read(struct device *dev,
>  	return sprintf(buf, "%d\n", ec_byte);
>  }
> =20
> -static const struct device_attribute olpc_bat_error =3D {
> +static struct device_attribute olpc_bat_error =3D {
>  	.attr =3D {
>  		.name =3D "error",
>  		.mode =3D S_IRUGO,
> @@ -583,6 +583,27 @@ static const struct device_attribute olpc_bat_error =
=3D {
>  	.show =3D olpc_bat_error_read,
>  };
> =20
> +static struct attribute *olpc_bat_sysfs_attrs[] =3D {
> +	&olpc_bat_error.attr,
> +	NULL
> +};
> +
> +static struct bin_attribute *olpc_bat_sysfs_bin_attrs[] =3D {
> +	&olpc_bat_eeprom,
> +	NULL
> +};
> +
> +static const struct attribute_group olpc_bat_sysfs_group =3D {
> +	.attrs =3D olpc_bat_sysfs_attrs,
> +	.bin_attrs =3D olpc_bat_sysfs_bin_attrs,
> +
> +};
> +
> +static const struct attribute_group *olpc_bat_sysfs_groups[] =3D {
> +	&olpc_bat_sysfs_group,
> +	NULL
> +};
> +
>  /*********************************************************************
>   *		Initialisation
>   *********************************************************************/
> @@ -615,7 +636,8 @@ static int olpc_battery_suspend(struct platform_devic=
e *pdev,
> =20
>  static int olpc_battery_probe(struct platform_device *pdev)
>  {
> -	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply_config bat_psy_cfg =3D {};
> +	struct power_supply_config ac_psy_cfg =3D {};
>  	struct olpc_battery_data *data;
>  	uint8_t status;
>  	uint8_t ecver;
> @@ -654,10 +676,11 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
> =20
>  	/* Ignore the status. It doesn't actually matter */
> =20
> -	psy_cfg.of_node =3D pdev->dev.of_node;
> -	psy_cfg.drv_data =3D data;
> +	ac_psy_cfg.of_node =3D pdev->dev.of_node;
> +	ac_psy_cfg.drv_data =3D data;
> =20
> -	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
> +	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,
> +								&ac_psy_cfg);
>  	if (IS_ERR(data->olpc_ac))
>  		return PTR_ERR(data->olpc_ac);
> =20
> @@ -671,37 +694,21 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> =20
> -	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
> +	bat_psy_cfg.of_node =3D pdev->dev.of_node;
> +	bat_psy_cfg.drv_data =3D data;
> +	bat_psy_cfg.attr_grp =3D olpc_bat_sysfs_groups;
> +
> +	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c,
> +								&bat_psy_cfg);
>  	if (IS_ERR(data->olpc_bat))
>  		return PTR_ERR(data->olpc_bat);
> =20
> -	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
> -	if (ret)
> -		goto error_failed;
> -
>  	if (olpc_ec_wakeup_available()) {
>  		device_set_wakeup_capable(&data->olpc_ac->dev, true);
>  		device_set_wakeup_capable(&data->olpc_bat->dev, true);
>  	}
> =20
>  	return 0;
> -
> -error_failed:
> -	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -	return ret;
> -}
> -
> -static int olpc_battery_remove(struct platform_device *pdev)
> -{
> -	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> -
> -	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> -	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -	return 0;
>  }
> =20
>  static const struct of_device_id olpc_battery_ids[] =3D {
> @@ -717,7 +724,6 @@ static struct platform_driver olpc_battery_driver =3D=
 {
>  		.of_match_table =3D olpc_battery_ids,
>  	},
>  	.probe =3D olpc_battery_probe,
> -	.remove =3D olpc_battery_remove,
>  	.suspend =3D olpc_battery_suspend,
>  };
> =20
> --=20
> 2.20.1
>=20

--unphcry5q6yu32bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynXOoACgkQ2O7X88g7
+po67Q/+JS2eQ+iEKpeTffBWTUvRYiV+Fpj+B6N7E5rO1DOK5TnhWXyobmNpfz69
AaNMYf1e+c4w5555zZxRZ/itZesLirJmJ205XeUPWDpfr5y1mGNiCpDq+7BBSyRk
0pNitWKWjaae9gIPfXz1iOBz1s35HFquIM34OPqxRZ2TsuLyfeJ+OJgVKiaETTSe
kJJ78Xe1F7rKNlXf0I6pkO+8FipBuTadlBXcn3sC90aFx5ewnGyCs5AhvnjYnIJV
iJ+jeIS5c0EVeUMD9X7DEk4wPQGJEIHbUUx2DJ0hZkr26Nx1xCxYVWGltSBCVtfr
woEv2A7d+GL9zIkznZz6FAuGPxT1WKM9F8lFlkiq+8bQ6vZpFmNtscVrvnIkue6N
+v/EF9E2/zNfsP8e7dBo6DuVmBq255uMkL6IZlu5DiucpKWQhre3AjKC/RuZqq1w
yavx/Ga81EvoKt2uCPJwgqAJSoYVlAaVog56Qa5Sa2HWmRPL7vPhGBi2TG56vtbU
T7vmAKHW6yt88uHr7zgQ8EJULeGgmNJhJGaMrP5846Vp6cvwTk6YozNCrXQ4CShs
avrpOBjJQ6iukLBEWDxozfBF1TM/2FRZUeDYadUuQVJuEBgHkUunb0WPmwMmQOMW
Cl78VeVF5iLctfjEStiOPalgZhIvjWo5RGQyUP05Si8pABkvft4=
=LZl8
-----END PGP SIGNATURE-----

--unphcry5q6yu32bu--
