Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A32C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F040E213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554655965;
	bh=IJmJoDa1J0nWesO/O9mKe3Z+3BwQb6aTQZtctC6cTM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tClV6y49FplLdEQTVwIlzqfRuqhqQUyTFwcPojKxeetAs8QZMdHBBJMvZw9mFttu0
	 t7xOX2+zjPR4RJkPUS9pZBMEK1FViR57S/LV3NKALdgxAbYxhOKfwd0XSErSJXD/+i
	 0TiaxLyG5NIdfJ5oSUSmi0G57Q6GWAMKKcGOMYuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDGQwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 12:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfDGQwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 12:52:40 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B52920879;
        Sun,  7 Apr 2019 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554655958;
        bh=IJmJoDa1J0nWesO/O9mKe3Z+3BwQb6aTQZtctC6cTM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9MMrOyv+4TbEKjhwS4adkMRBlHP7oIORWl86I+peicn2bddb9nphCW5/lC8qtRIF
         RPwzzHoLySOmQ6s12R8ZdVwN2HdnK+KMoyk3bJnH+wmn+iZAV5voAy35gZckROINpD
         7YxdqINIAaQUVlUk4U+ZgG8yqFvi9xYW2e/JPTYY=
Received: by earth.universe (Postfix, from userid 1000)
        id D440E3C08D7; Sun,  7 Apr 2019 18:52:34 +0200 (CEST)
Date:   Sun, 7 Apr 2019 18:52:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
Message-ID: <20190407165234.is66vmnjfc35jnho@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-4-contact@artur-rojek.eu>
 <20190324153137.04857cdf@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vryyie2p7z4xzk3"
Content-Disposition: inline
In-Reply-To: <20190324153137.04857cdf@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vryyie2p7z4xzk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2019 at 03:31:37PM +0000, Jonathan Cameron wrote:
> On Sat, 23 Mar 2019 18:28:09 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
> > Add a driver for battery present on Ingenic JZ47xx SoCs.
> >=20
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> The IIO parts look fine to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Sebastian, assuming you are happy with this version,

The driver itself looks ok. I'm a bit unhappy, that we already have
jz4740-battery. This driver is much cleaner, but does not yet seem
to be ready to replace it. Artur Rojek what are your plans regarding
to the existing driver? Is there currently work going on migrating
JZ47xx to DT?

> do you have any preference for how we handle this series?
>=20
> Probably needs one of us to do an immutable branch with just this
> in it.  I'm happy to do so once all the relevant Acks etc are in
> place, but don't mind if you want to!

I suppose you could provide an immutable branch with just the first
two patches in it. Then I can pull it and apply the power-supply
patches on top.

-- Sebastian

> Thanks,
>=20
> Jonathan
>=20
> > ---
> >=20
> > Changes:
> >=20
> > v2: - rework the return logic in ingenic_battery_get_property,
> >     - make index offsets point forward in ingenic_battery_set_scale,
> >     - fix spacing around scale_raw[best_idx + 1]
> >=20
> >  drivers/power/supply/Kconfig           |  11 ++
> >  drivers/power/supply/Makefile          |   1 +
> >  drivers/power/supply/ingenic-battery.c | 180 +++++++++++++++++++++++++
> >  3 files changed, 192 insertions(+)
> >  create mode 100644 drivers/power/supply/ingenic-battery.c
> >=20
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index e901b9879e7e..9bfb1637ec28 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -169,6 +169,17 @@ config BATTERY_COLLIE
> >  	  Say Y to enable support for the battery on the Sharp Zaurus
> >  	  SL-5500 (collie) models.
> > =20
> > +config BATTERY_INGENIC
> > +	tristate "Ingenic JZ47xx SoCs battery driver"
> > +	depends on MIPS || COMPILE_TEST
> > +	depends on INGENIC_ADC
> > +	help
> > +	  Choose this option if you want to monitor battery status on
> > +	  Ingenic JZ47xx SoC based devices.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called ingenic-battery.
> > +
> >  config BATTERY_IPAQ_MICRO
> >  	tristate "iPAQ Atmel Micro ASIC battery driver"
> >  	depends on MFD_IPAQ_MICRO
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index b731c2a9b695..9e2c481d0187 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
> >  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
> >  obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
> >  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
> > +obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
> >  obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
> >  obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
> >  obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
> > diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/sup=
ply/ingenic-battery.c
> > new file mode 100644
> > index 000000000000..822aee1c7b64
> > --- /dev/null
> > +++ b/drivers/power/supply/ingenic-battery.c
> > @@ -0,0 +1,180 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Battery driver for the Ingenic JZ47xx SoCs
> > + * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
> > + *
> > + * based on drivers/power/supply/jz4740-battery.c
> > + */
> > +
> > +#include <linux/iio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/property.h>
> > +
> > +struct ingenic_battery {
> > +	struct device *dev;
> > +	struct iio_channel *channel;
> > +	struct power_supply_desc desc;
> > +	struct power_supply *battery;
> > +	struct power_supply_battery_info info;
> > +};
> > +
> > +static int ingenic_battery_get_property(struct power_supply *psy,
> > +					enum power_supply_property psp,
> > +					union power_supply_propval *val)
> > +{
> > +	struct ingenic_battery *bat =3D power_supply_get_drvdata(psy);
> > +	struct power_supply_battery_info *info =3D &bat->info;
> > +	int ret;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_HEALTH:
> > +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
> > +		val->intval *=3D 1000;
> > +		if (val->intval < info->voltage_min_design_uv)
> > +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> > +		else if (val->intval > info->voltage_max_design_uv)
> > +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> > +		else
> > +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> > +		return ret;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		ret =3D iio_read_channel_processed(bat->channel, &val->intval);
> > +		val->intval *=3D 1000;
> > +		return ret;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > +		val->intval =3D info->voltage_min_design_uv;
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +		val->intval =3D info->voltage_max_design_uv;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	};
> > +}
> > +
> > +/* Set the most appropriate IIO channel voltage reference scale
> > + * based on the battery's max voltage.
> > + */
> > +static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> > +{
> > +	const int *scale_raw;
> > +	int scale_len, scale_type, best_idx =3D -1, best_mV, max_raw, i, ret;
> > +	u64 max_mV;
> > +
> > +	ret =3D iio_read_max_channel_raw(bat->channel, &max_raw);
> > +	if (ret) {
> > +		dev_err(bat->dev, "Unable to read max raw channel value\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D iio_read_avail_channel_attribute(bat->channel, &scale_raw,
> > +					       &scale_type, &scale_len,
> > +					       IIO_CHAN_INFO_SCALE);
> > +	if (ret < 0) {
> > +		dev_err(bat->dev, "Unable to read channel avail scale\n");
> > +		return ret;
> > +	}
> > +	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL_LOG=
2)
> > +		return -EINVAL;
> > +
> > +	max_mV =3D bat->info.voltage_max_design_uv / 1000;
> > +
> > +	for (i =3D 0; i < scale_len; i +=3D 2) {
> > +		u64 scale_mV =3D (max_raw * scale_raw[i]) >> scale_raw[i + 1];
> > +
> > +		if (scale_mV < max_mV)
> > +			continue;
> > +
> > +		if (best_idx >=3D 0 && scale_mV > best_mV)
> > +			continue;
> > +
> > +		best_mV =3D scale_mV;
> > +		best_idx =3D i;
> > +	}
> > +
> > +	if (best_idx < 0) {
> > +		dev_err(bat->dev, "Unable to find matching voltage scale\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return iio_write_channel_attribute(bat->channel,
> > +					   scale_raw[best_idx],
> > +					   scale_raw[best_idx + 1],
> > +					   IIO_CHAN_INFO_SCALE);
> > +}
> > +
> > +static enum power_supply_property ingenic_battery_properties[] =3D {
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> > +};
> > +
> > +static int ingenic_battery_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct ingenic_battery *bat;
> > +	struct power_supply_config psy_cfg =3D {};
> > +	struct power_supply_desc *desc;
> > +	int ret;
> > +
> > +	bat =3D devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
> > +	if (!bat)
> > +		return -ENOMEM;
> > +
> > +	bat->dev =3D dev;
> > +	bat->channel =3D devm_iio_channel_get(dev, "battery");
> > +	if (IS_ERR(bat->channel))
> > +		return PTR_ERR(bat->channel);
> > +
> > +	desc =3D &bat->desc;
> > +	desc->name =3D "jz-battery";
> > +	desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> > +	desc->properties =3D ingenic_battery_properties;
> > +	desc->num_properties =3D ARRAY_SIZE(ingenic_battery_properties);
> > +	desc->get_property =3D ingenic_battery_get_property;
> > +	psy_cfg.drv_data =3D bat;
> > +	psy_cfg.of_node =3D dev->of_node;
> > +
> > +	bat->battery =3D devm_power_supply_register(dev, desc, &psy_cfg);
> > +	if (IS_ERR(bat->battery)) {
> > +		dev_err(dev, "Unable to register battery\n");
> > +		return PTR_ERR(bat->battery);
> > +	}
> > +
> > +	ret =3D power_supply_get_battery_info(bat->battery, &bat->info);
> > +	if (ret) {
> > +		dev_err(dev, "Unable to get battery info: %d\n", ret);
> > +		return ret;
> > +	}
> > +	if (bat->info.voltage_min_design_uv < 0) {
> > +		dev_err(dev, "Unable to get voltage min design\n");
> > +		return bat->info.voltage_min_design_uv;
> > +	}
> > +	if (bat->info.voltage_max_design_uv < 0) {
> > +		dev_err(dev, "Unable to get voltage max design\n");
> > +		return bat->info.voltage_max_design_uv;
> > +	}
> > +
> > +	return ingenic_battery_set_scale(bat);
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id ingenic_battery_of_match[] =3D {
> > +	{ .compatible =3D "ingenic,jz4740-battery", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ingenic_battery_of_match);
> > +#endif
> > +
> > +static struct platform_driver ingenic_battery_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ingenic-battery",
> > +		.of_match_table =3D of_match_ptr(ingenic_battery_of_match),
>=20
> I guess we can be fairly sure no one will even user this with ACPI
> (magic DT) bindings?  That would make this a rare case where the
> of_match_pr protection and ifdef fun is still fine.
>=20
>=20
> > +	},
> > +	.probe =3D ingenic_battery_probe,
> > +};
> > +module_platform_driver(ingenic_battery_driver);
>=20

--5vryyie2p7z4xzk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlyqKssACgkQ2O7X88g7
+pq82xAAh6eq3ErCCBRF0TQSvjlbSgsQegWDd531AMAmtuXCAQXjm+VLD2HzRlxF
yN4IUKjHFQScy0udkC7CLJ5bwE7uke8k9d5Xw44YvU791KSSmOp5yaSyhsqbfEjK
Hw6eQlLySMcXxwXLzQyIb9eTXbYnz55GvVuNltd0W1rQIlIw1bRttl+Ljr8tS51r
hAu+hOfGHqAB+hfWP0b0VpiuYLZMyKzAZsrVgXJvUhMN661pV+O1FCmk0H8Qtr4a
amDHlrGouCRB/VNYo+hcAwYAcmGYVC6P+O656eg2Bn6wRdwgpLZSwrSoYFqXRzA9
1sPSzLTwpfDCH8SHbLSQvDmxcdQTFUqYiid7EeqmVse0duCG2P9EKY4HNTnBTdaV
ToqDxEH1NOsZ6XmdkAJYxMWYQR258B8f4PVPLCpVqDhzP7J+8ImiAeswswvEvhqH
vSyHb7PtKwusX/pfGWKmBTzQ8ogKNnHv+CW9ZvpSboZDCDmS4l+OnJm5SMT13tzy
uc3uIdeWbPoNsQlqpAikxBgFkGXvmrNTwIjztb9Oj9C6P2kRs5aCvZGZ+mN3r+sp
TV/CX3xkv/ZVdLdglLsKUpxqKR/05nlozmIX85exxFKU0/BBGBk5RSWzwAg3ZwQ0
HvepVKwTkXOqUf1wY26uOWfnslUlSCUZ6l5Mws+VwShSRCoG9aA=
=407O
-----END PGP SIGNATURE-----

--5vryyie2p7z4xzk3--
