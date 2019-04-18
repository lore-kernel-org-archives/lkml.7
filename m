Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17755C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01232171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555644904;
	bh=ayvsgjKlEhRMoM8stNcsOmczPn82q+OkKDdmlgIQoFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kmEKD9R3YXHd1UVQzft1CIDe8xa5+PRptT1CgHcMrbKZU81K1SY7lNnr8ERTpss86
	 i2rrLhQLl5FkvhrvPdlRkTmiBOYTurQnRPzRnuGW9CRnsfhp0YHiwCJsD5GcPhtt+L
	 Vcvm8DKPO+KH8sPL+HmcIGP0IFas/2UXgoyJI1A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDSDfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfDSDeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:34:50 -0400
Received: from earth.universe (dyndsl-091-248-050-217.ewe-ip-backbone.de [91.248.50.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66182217F9;
        Fri, 19 Apr 2019 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555644888;
        bh=ayvsgjKlEhRMoM8stNcsOmczPn82q+OkKDdmlgIQoFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8aRhyKpnB5sAsyKvn0eyfyKIZ63Yd/YSARccpQZOrMjdLphic70gGBkC6uaJLXYj
         Hbc4pVm41lqB+W/+T1jiCJztKJExzpDW8uWLa3QWfYzSrEx9oqs7W+7q7UG01N8sKW
         rWPTQ/FTghmc0M/Hnb6iOVi+iGJdvQmZg1sD1wes=
Received: by earth.universe (Postfix, from userid 1000)
        id 038763C08D5; Thu, 18 Apr 2019 21:46:42 +0200 (CEST)
Date:   Thu, 18 Apr 2019 21:46:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] power: supply: add Ingenic JZ47xx battery driver.
Message-ID: <20190418194642.5nwofmjq3lotxs3t@earth.universe>
References: <20190418182404.20183-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsac4u2ylfrdrtro"
Content-Disposition: inline
In-Reply-To: <20190418182404.20183-1-contact@artur-rojek.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsac4u2ylfrdrtro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2019 at 08:24:04PM +0200, Artur Rojek wrote:
> Add a driver for battery present on Ingenic JZ47xx SoCs.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Changes:
>=20
> v2: - rework the return logic in ingenic_battery_get_property,
>     - make index offsets point forward in ingenic_battery_set_scale,
>     - fix spacing around scale_raw[best_idx + 1]
>=20
> v3: Add the missing MODULE_LICENSE & Co.
>=20
>  drivers/power/supply/Kconfig           |  11 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/ingenic-battery.c | 184 +++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/power/supply/ingenic-battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index b6a4265bf0ec..81b0c20b24dd 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -169,6 +169,17 @@ config BATTERY_COLLIE
>  	  Say Y to enable support for the battery on the Sharp Zaurus
>  	  SL-5500 (collie) models.
> =20
> +config BATTERY_INGENIC
> +	tristate "Ingenic JZ47xx SoCs battery driver"
> +	depends on MIPS || COMPILE_TEST
> +	depends on INGENIC_ADC
> +	help
> +	  Choose this option if you want to monitor battery status on
> +	  Ingenic JZ47xx SoC based devices.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ingenic-battery.
> +
>  config BATTERY_IPAQ_MICRO
>  	tristate "iPAQ Atmel Micro ASIC battery driver"
>  	depends on MFD_IPAQ_MICRO
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 1cdce3ded839..976dc1698134 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
>  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
>  obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
>  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
> +obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
>  obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
>  obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
>  obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
> diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/suppl=
y/ingenic-battery.c
> new file mode 100644
> index 000000000000..35816d4b3012
> --- /dev/null
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Battery driver for the Ingenic JZ47xx SoCs
> + * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
> + *
> + * based on drivers/power/supply/jz4740-battery.c
> + */
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +
> +struct ingenic_battery {
> +	struct device *dev;
> +	struct iio_channel *channel;
> +	struct power_supply_desc desc;
> +	struct power_supply *battery;
> +	struct power_supply_battery_info info;
> +};
> +
> +static int ingenic_battery_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct ingenic_battery *bat =3D power_supply_get_drvdata(psy);
> +	struct power_supply_battery_info *info =3D &bat->info;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
> +		val->intval *=3D 1000;
> +		if (val->intval < info->voltage_min_design_uv)
> +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> +		else if (val->intval > info->voltage_max_design_uv)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		return ret;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
> +		val->intval *=3D 1000;
> +		return ret;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		val->intval =3D info->voltage_min_design_uv;
> +		return 0;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D info->voltage_max_design_uv;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	};
> +}
> +
> +/* Set the most appropriate IIO channel voltage reference scale
> + * based on the battery's max voltage.
> + */
> +static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> +{
> +	const int *scale_raw;
> +	int scale_len, scale_type, best_idx =3D -1, best_mV, max_raw, i, ret;
> +	u64 max_mV;
> +
> +	ret =3D iio_read_max_channel_raw(bat->channel, &max_raw);
> +	if (ret) {
> +		dev_err(bat->dev, "Unable to read max raw channel value\n");
> +		return ret;
> +	}
> +
> +	ret =3D iio_read_avail_channel_attribute(bat->channel, &scale_raw,
> +					       &scale_type, &scale_len,
> +					       IIO_CHAN_INFO_SCALE);
> +	if (ret < 0) {
> +		dev_err(bat->dev, "Unable to read channel avail scale\n");
> +		return ret;
> +	}
> +	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL_LOG2)
> +		return -EINVAL;
> +
> +	max_mV =3D bat->info.voltage_max_design_uv / 1000;
> +
> +	for (i =3D 0; i < scale_len; i +=3D 2) {
> +		u64 scale_mV =3D (max_raw * scale_raw[i]) >> scale_raw[i + 1];
> +
> +		if (scale_mV < max_mV)
> +			continue;
> +
> +		if (best_idx >=3D 0 && scale_mV > best_mV)
> +			continue;
> +
> +		best_mV =3D scale_mV;
> +		best_idx =3D i;
> +	}
> +
> +	if (best_idx < 0) {
> +		dev_err(bat->dev, "Unable to find matching voltage scale\n");
> +		return -EINVAL;
> +	}
> +
> +	return iio_write_channel_attribute(bat->channel,
> +					   scale_raw[best_idx],
> +					   scale_raw[best_idx + 1],
> +					   IIO_CHAN_INFO_SCALE);
> +}
> +
> +static enum power_supply_property ingenic_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +};
> +
> +static int ingenic_battery_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ingenic_battery *bat;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply_desc *desc;
> +	int ret;
> +
> +	bat =3D devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
> +		return -ENOMEM;
> +
> +	bat->dev =3D dev;
> +	bat->channel =3D devm_iio_channel_get(dev, "battery");
> +	if (IS_ERR(bat->channel))
> +		return PTR_ERR(bat->channel);
> +
> +	desc =3D &bat->desc;
> +	desc->name =3D "jz-battery";
> +	desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	desc->properties =3D ingenic_battery_properties;
> +	desc->num_properties =3D ARRAY_SIZE(ingenic_battery_properties);
> +	desc->get_property =3D ingenic_battery_get_property;
> +	psy_cfg.drv_data =3D bat;
> +	psy_cfg.of_node =3D dev->of_node;
> +
> +	bat->battery =3D devm_power_supply_register(dev, desc, &psy_cfg);
> +	if (IS_ERR(bat->battery)) {
> +		dev_err(dev, "Unable to register battery\n");
> +		return PTR_ERR(bat->battery);
> +	}
> +
> +	ret =3D power_supply_get_battery_info(bat->battery, &bat->info);
> +	if (ret) {
> +		dev_err(dev, "Unable to get battery info: %d\n", ret);
> +		return ret;
> +	}
> +	if (bat->info.voltage_min_design_uv < 0) {
> +		dev_err(dev, "Unable to get voltage min design\n");
> +		return bat->info.voltage_min_design_uv;
> +	}
> +	if (bat->info.voltage_max_design_uv < 0) {
> +		dev_err(dev, "Unable to get voltage max design\n");
> +		return bat->info.voltage_max_design_uv;
> +	}
> +
> +	return ingenic_battery_set_scale(bat);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ingenic_battery_of_match[] =3D {
> +	{ .compatible =3D "ingenic,jz4740-battery", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_battery_of_match);
> +#endif
> +
> +static struct platform_driver ingenic_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "ingenic-battery",
> +		.of_match_table =3D of_match_ptr(ingenic_battery_of_match),
> +	},
> +	.probe =3D ingenic_battery_probe,
> +};
> +module_platform_driver(ingenic_battery_driver);
> +
> +MODULE_DESCRIPTION("Battery driver for Ingenic JZ47xx SoCs");
> +MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.21.0
>=20

--gsac4u2ylfrdrtro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly41BsACgkQ2O7X88g7
+powZg//S3/3ycl3W9H8Jhtu06Arp7IFG36SGG8W4zcKHs4p8F02MogX/JENjMYy
28ZTjIP+cxLV2z7RozPaPVIjk35MWm6YSGw8cYXIjTtCO78RahBImfS6wSpTQUbc
twkGJz0PYvjjMh26kQt0AmmRgKkwyHJ1Z3q0kogfO/ZGfB7tQVLv4UM0TAjONRjZ
MfVA/XKsQSrLwDdueTiqjO4ibT6vBZORtfn/IuecsP11oEBIUu4kpcdzqp78SS+w
9QladWJ4ufS97xbcxaZN9j9hQOotxQgNf/JXTRXUowB2Qu8iejGxlVuPrV/qypHz
vXmqYWYSqGtF5q0WcuUCKFnOjuHek8dRDz4QDr5SZO49Sz/Pkw1tWiqTKo7r64ed
iXMF5i0X4e4T7yUH1kN1hbi2FM3LtWATn68Pvlx6ms73p1bsWif45SpTuRN4Gc0k
pSvUt4TuCnAZkKAUuhqITauD08brT2BqooMq0s7UK1wbOejUE7KjqkUakvTl2onM
BWyELBQA9l/LtRApkzoAySNF65bqY9TXRTSAjOja5VJF/OuayC35MSq3n9pFRYWi
tcS5wkK/3u3nCtWoH21JhiMj2eU4VuVMX7qmD4P/C2OaTOWXcGpY0KzDhdo4GRyk
vyEx5RNnLNOZ1GShhKf5zb4LXV8uuvOmiYplGEKe8i1mPhtD/uo=
=VYq4
-----END PGP SIGNATURE-----

--gsac4u2ylfrdrtro--
