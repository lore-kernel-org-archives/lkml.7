Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827BD2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554471959;
	bh=NKOdgxQGaPufsJZoIxuGITxWwcI9efA+28yFRx0mruM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kKwzudqiElKqZHUR17+aBM4QsLIzvCcfcFnQlg/U77QtcP0M2Qu6T3JbtKIOgdGXx
	 9RyhyyWq3/v9Xc7LKv+ViK22rM+invTGjWMglO4loKS5u7PPZH0+66lbtN2dqrEd0c
	 q4DYNbemRPNqRH7q/YplI/HTeynJDMHXK6yssHB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfDENp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:45:58 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7107C206C0;
        Fri,  5 Apr 2019 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554471956;
        bh=NKOdgxQGaPufsJZoIxuGITxWwcI9efA+28yFRx0mruM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quaXf62SrbcG2o61izc7EiJbAKmy7iZzbsJ+VMfV8Sp4RUzsFqjxbRNeLDgQLdMZZ
         IN5jI4s/3zNzvuhPg8nbZ4msA6Aa1sTjWtjvRBholzs+F8McOWEQm15lED4PyB7SkS
         ZCzTbVilqCATHojDciozrJuUB8nLgRyuesCcDX24=
Received: by earth.universe (Postfix, from userid 1000)
        id C2B2B3C08D5; Fri,  5 Apr 2019 15:45:53 +0200 (CEST)
Date:   Fri, 5 Apr 2019 15:45:53 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 06/10] power: supply: olpc_battery: Move priv data to a
 struct
Message-ID: <20190405134553.ahntfz7aggzg7hdd@earth.universe>
References: <20190310162419.11861-1-lkundrak@v3.sk>
 <20190310162419.11861-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lcxnf65dmsdxorj7"
Content-Disposition: inline
In-Reply-To: <20190310162419.11861-7-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lcxnf65dmsdxorj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 10, 2019 at 05:24:15PM +0100, Lubomir Rintel wrote:
> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> ---
> Changes since v4:
> - Bring some more code that was misplaced here.
>=20
> Changes since v2:
> - Bring the allocaton of the priv data structure here
>=20
> Changes since v1:
> - Split out the move to devm_* into a separate patch
>=20
>  drivers/power/supply/olpc_battery.c | 78 ++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 3dcf5e19f329..f7bb9bedd893 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -53,6 +53,12 @@
> =20
>  #define BAT_ADDR_MFR_TYPE	0x5F
> =20
> +struct olpc_battery_data {
> +	struct power_supply *olpc_ac;
> +	struct power_supply *olpc_bat;
> +	char bat_serial[17];
> +};
> +
>  /*********************************************************************
>   *		Power
>   *********************************************************************/
> @@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
>  	.get_property =3D olpc_ac_get_prop,
>  };
> =20
> -static struct power_supply *olpc_ac;
> -
> -static char bat_serial[17]; /* Ick */
> -
> -static int olpc_bat_get_status(union power_supply_propval *val, uint8_t =
ec_byte)
> +static int olpc_bat_get_status(struct olpc_battery_data *data,
> +		union power_supply_propval *val, uint8_t ec_byte)
>  {
>  	if (olpc_platform_info.ecver > 0x44) {
>  		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
> @@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  				 enum power_supply_property psp,
>  				 union power_supply_propval *val)
>  {
> +	struct olpc_battery_data *data =3D power_supply_get_drvdata(psy);
>  	int ret =3D 0;
>  	__be16 ec_word;
>  	uint8_t ec_byte;
> @@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> -		ret =3D olpc_bat_get_status(val, ec_byte);
> +		ret =3D olpc_bat_get_status(data, val, ec_byte);
>  		if (ret)
>  			return ret;
>  		break;
> @@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> -		val->strval =3D bat_serial;
> +		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> +		val->strval =3D data->bat_serial;
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>  		ret =3D olpc_bat_get_voltage_max_design(val);
> @@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc =3D {
>  	.use_for_apm =3D 1,
>  };
> =20
> -static struct power_supply *olpc_bat;
> -
>  static int olpc_battery_suspend(struct platform_device *pdev,
>  				pm_message_t state)
>  {
> -	if (device_may_wakeup(&olpc_ac->dev))
> +	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&data->olpc_ac->dev))
>  		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
>  	else
>  		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
> =20
> -	if (device_may_wakeup(&olpc_bat->dev))
> +	if (device_may_wakeup(&data->olpc_bat->dev))
>  		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
>  				   | EC_SCI_SRC_BATERR);
>  	else
> @@ -601,8 +605,15 @@ static int olpc_battery_suspend(struct platform_devi=
ce *pdev,
> =20
>  static int olpc_battery_probe(struct platform_device *pdev)
>  {
> -	int ret;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct olpc_battery_data *data;
>  	uint8_t status;
> +	int ret;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, data);
> =20
>  	/*
>  	 * We've seen a number of EC protocol changes; this driver requires
> @@ -620,9 +631,13 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
> =20
>  	/* Ignore the status. It doesn't actually matter */
> =20
> -	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
> -	if (IS_ERR(olpc_ac))
> -		return PTR_ERR(olpc_ac);
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D data;
> +
> +	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
> +	if (IS_ERR(data->olpc_ac))
> +		return PTR_ERR(data->olpc_ac);
> +
>  	if (of_device_is_compatible(pdev->dev.of_node, "olpc,xo1.5-battery")) {
>  		/* XO-1.5 */
>  		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
> @@ -633,42 +648,45 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> =20
> -	olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> -	if (IS_ERR(olpc_bat)) {
> -		ret =3D PTR_ERR(olpc_bat);
> +	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
> +	if (IS_ERR(data->olpc_bat)) {
> +		ret =3D PTR_ERR(data->olpc_bat);
>  		goto battery_failed;
>  	}
> =20
> -	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
>  		goto eeprom_failed;
> =20
> -	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;
> =20
>  	if (olpc_ec_wakeup_available()) {
> -		device_set_wakeup_capable(&olpc_ac->dev, true);
> -		device_set_wakeup_capable(&olpc_bat->dev, true);
> +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
>  	}
> =20
>  	return 0;
> =20
>  error_failed:
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  eeprom_failed:
> -	power_supply_unregister(olpc_bat);
> +	power_supply_unregister(data->olpc_bat);
>  battery_failed:
> -	power_supply_unregister(olpc_ac);
> +	power_supply_unregister(data->olpc_ac);
>  	return ret;
>  }
> =20
>  static int olpc_battery_remove(struct platform_device *pdev)
>  {
> -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(olpc_bat);
> -	power_supply_unregister(olpc_ac);
> +	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> +
> +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> +	power_supply_unregister(data->olpc_bat);
> +	power_supply_unregister(data->olpc_ac);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.20.1
>=20

--lcxnf65dmsdxorj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynXAQACgkQ2O7X88g7
+prmTw//WvOnV38fHWbDKo5jQ2UqxNuxuaBiWdFDWc/d4PzNouyCDCoiqc2EOwft
xKLdzg3FOn/MB8Mgl64jCLa22b+swgIspe08DFYFPHburwYtBxBZiukJrMilzt7q
ANVJMrp92pb12lXk+TVjHNl5L15deRFxP6Dq2WTFyfAj5N0qvaCmTWTR03MpvALK
69Dncw02zAAUlEh1hgilRlJO1psB3EoHwdI5rv998Lppb2+donByw2F0Pn4Eq2/j
H0sRI6ky9ni/An68oGGvWW8Z27zdbQaAr7KwBjG/FXaS4Ntc1LQblQCNrJ/ZeRmf
/nXa6zJ2k7Ra+Np5Pta/VIWVgvBD4HHskABq0L7DkTV1kzjdB4P7c5tpEhEsolZg
E8lFvx1r6BP7MXPkcDhoBtu8bE6joMxunYeFUQ7iUw1bo46LLBo5BXl9BsuY0usO
5PvNLiG3KBpRqFROCCPztolqUJueiBdle3HgS/g4zHlEqUK+wB8WW/02G5QAE6X3
JS63y5DRp48LwL1wTNX9Oe2KdIFkns3VDf08K2eXyrwoPiv43PT8KjLpHMM0yhKG
T5+h0x7LiHEl12OkfxBL7dcDbHUPWj758gUJDQBYiepgOsq9H/DhFrZOnelqL8sw
ddx459jyPSnzRbGawgW5lPv8Y0RmQCQHMQL0yPs31JuBZhr7RU4=
=pSCJ
-----END PGP SIGNATURE-----

--lcxnf65dmsdxorj7--
