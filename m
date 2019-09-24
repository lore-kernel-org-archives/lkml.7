Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381B4214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="WI3MpiYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504361AbfIXJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:48:52 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:54008 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392592AbfIXJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:48:51 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 1B/72-25862-B76E98D5; Tue, 24 Sep 2019 09:48:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSf0wbZRjH+/au14NQchQIrwRm0ikaR0vbmXh
  oZhanS1mmA13mMBnsGCc9015rW7LiEn4MiHRAJSKwdY6WFdShA4czsglk1kJguillMrKwSUNH
  HWwLdmykQcH2Dqb+9/k+3+/7vM/75sER6TSWitNWC21iKZ0Mi0W1WbFb5UfmbAeUV1dxssUfw
  Ein96qI7G65gJK/PxwG5KNrdUJy4uKnGLl48TeErB30irfjmguOm2JNX7cN00xPDmCaj/5Wah
  70bcoVvSNi2CKD9aBI21L5MTB+3gCsPSNz4kqwZj4GYnFAdCHQVzMIeDGCQl/9hxgvvgFwpTH
  MCZQYReBq8IEoKqREixD65scQXgQAPHPWFnFicIwgYfPoDHckifAI4S3HSU4gRC+A9k88IJpK
  JN6AYf8XHCcRuTAU7kF4VkPv4HVhlFHiaRgcP45FWUJQsLd1hWMpwcLzbUscxxDb4NGGMMeAS
  IdLVV9yfRAiBd4IOLk+kCBg58AvCM/J8M7sqojP03Ds6BTg65nwyvXAOstg+ynvOqdDn7N+nV
  +HVXY3Gn0MJG4DOH7ta2TjcI1tcJ1J2FlfGwnhEX4KrnrK+LIReqd/QvhyBmx0s3w5DZ4bXhY
  1gSzHf6bmORO6vg9hPG+Bn3UsIA7uJxLg2IkA6gJoN8guMjElWoueYnRylVIpV6m2yl+Qq59X
  K6gP5EUKulR+iGYtJiriKqjDZoW5TH9IV6xgaUsfiCxa8fviUD+YctxVeMATuFCWLFnz2g5I4
  4sMxWVayqwtNJXqaLMHpOG4DEpuByJegokuoa3vMrrIum7YEI+TJUkuRW2J2UjpzUwJb10Gcr
  zpzqnTiBRlDSydmiJZnI2EiGhIW8o+brGx9D6QnpooAQKBQBpnpE16xvJ/fx6k4ECWKPFHr4p
  jWMvjm+YjQwgjQ2zewQ1hof61UiuF5c8gy8YFV9tk+ST28MUR19743JSdI+Nf5ZnqOu0N8bv3
  qVoKg8kxv768f+LKjmx2aNFAP5o9Ya9ojg2cz74/PTG6982ddcbQsxWv/nA3v3c5f9yaG1fwt
  jth6rVwwF26XXuMLbiRc/hS8vC9TfvF6dveCua80m8YCrkrmbH7PnVdf1tIqQ6+pOjNmNlDky
  fL1e+l/SjIO7Kruaewy5XjqL4s6LlXPX/T32SfE63sXpzrSKrEMp6sZbq+RfPzzhRMopKF7OD
  Emv2cc0+X8laFv3rXd8mJM07PaUNsR0PrkujPAb3O5V5Afs5s7T7415ahs5uZ+fas+CpBI/XH
  8Zp22z4ZatZSqucQk5n6B6LcIRlvBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-19.tower-246.messagelabs.com!1569318522!131308!1
X-Originating-IP: [104.47.10.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26100 invoked from network); 24 Sep 2019 09:48:43 -0000
Received: from mail-db5eur03lp2051.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.51)
  by server-19.tower-246.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Sep 2019 09:48:43 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwYOppx4HoD4KwwtEdyUtSMs4kpQbATvpwMMYXZigYz+IkqUTsJrv1s0tfIW5O4sl448/Gb6de7ZSR2XV0RK8ibnmsEnPIj19Bemg0fDo+R0XiVdvsYFgSaxB9hIcDWKnX08KZ4+iT9aU4gHDfYBHEC96QXdGwqzsrIfVw1pcaHziCcwBTQBI5zUlNVsfh6Z1vG9Hv7ZdQVDtBhCVyRpVtOtAisySY1V2WanbBpIShgXeYIERoY4K00TNgF7NhPsKvxGqdelwBdz79HIP0e5Tirbu5zz9aIimJLkl/4wMK4FM7opAELLUwk0BZc8v4wsT7LsfzBMOuY0218IGYBIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6JMEMpLHqpYZ1YfjuxnkY20KWvovaYOokyCGXDhAqU=;
 b=SI/I1YVxXpYMXFAtfAZUMkiy7PM6xghBxSjAYoFeT/PXInSlrefx8f9qXVm6fbJ4D2oV11LiDSmruaP5yOj4+0Z3nnj0CrocjbEf78orreEjUmJ4OpsbfQiZFCyBr1mUJ4xvmSRiUwS1/qCeYje7LPKyQciFK9ffHRLkFY1JE7ks+nwVI/U6a3ctjpLzpFWkdzSrWWf7dzLg0AhERqq8Q6Fdzs2BItCh7JNeOi/g0Pu2n5yda0HFuqq2IiNPSgQ1tvYAlrJpZHjprHJ23vuPDLdYPEY+VHaWvOJg12pdI1Xq78pqrA2elw1iNPAJIG4I1uyg4iDP0zkqP9ynLUmrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6JMEMpLHqpYZ1YfjuxnkY20KWvovaYOokyCGXDhAqU=;
 b=WI3MpiYr1JV6J0k3bpl5BdXL1vgo4SmrLJuHFTtIDsIpSTm4qLV3xq0o/lPeXrP3NBy1OZOWegzKxeuiDstzC+w+JAetqz04lMMzJL6TgyFVNUtPE8hJTPGq8Y2Yzv/j0Iq0qXNEZj2RXJUQKF97oh2QgJIqJ/G91naQcK2xYSg=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1041.EURPRD10.PROD.OUTLOOK.COM (10.169.155.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 09:48:41 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.023; Tue, 24 Sep
 2019 09:48:41 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/5] regulator: da9062: add voltage selection gpio support
Thread-Topic: [PATCH 3/5] regulator: da9062: add voltage selection gpio
 support
Thread-Index: AQHVbVV5b5NAUSiX10OK40SnYhU/rac6n6rQ
Date:   Tue, 24 Sep 2019 09:48:41 +0000
Message-ID: <AM5PR1001MB099431ECB45A103A22646CB680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-4-m.felsch@pengutronix.de>
In-Reply-To: <20190917124246.11732-4-m.felsch@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a44a3c3-a695-4db2-f6de-08d740d461b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB1041;
x-ms-traffictypediagnostic: AM5PR1001MB1041:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1041907C952E5FD1637672BFA7840@AM5PR1001MB1041.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(74316002)(305945005)(52536014)(76116006)(6436002)(66476007)(7736002)(229853002)(64756008)(6116002)(3846002)(86362001)(2906002)(66446008)(33656002)(66946007)(110136005)(478600001)(5660300002)(25786009)(256004)(14454004)(14444005)(30864003)(66066001)(4326008)(476003)(446003)(71190400001)(55016002)(71200400001)(316002)(8936002)(99286004)(486006)(11346002)(9686003)(54906003)(55236004)(6246003)(2501003)(6506007)(6636002)(53546011)(66556008)(81166006)(186003)(102836004)(76176011)(8676002)(81156014)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1041;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LxkMpKJFQ7DRob4paNhhoybhU9UWtOntx1tsAXp1vRLG8/dMSWTBflvw6qW1puomn7KfYBRXp4W3ThjRhj60Kp33vSULL5nq9Z2JwhwzR5h33uQCKrMqi8j351mgvOWJBJsUBZikddvH/WXW30nRVn63PahZFlDWVCV4bfJH7eKgz4uyFzAAtBkuKF24KqxklxWAEfMFMsnM2RKqQigtVE+OzaYsY+xHM3jcwdKk5nzVHAN4VRbC0elzTMTfVSixMBwJHK16QynJoHMSViOo8L/0gyYiQKdquLuAt71ULy7Vqkn30CigT37berrircmdzHiHK3DGwGNoHK1zxiOCQEwJxxoVvjOe94NjXXLvudc2B6saV1h5tOO9Mw6wTSTt6xjSZ0Zq1hPa6VCS92Fkj5E1Z/qTVz6a+oFlm9HFLW0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a44a3c3-a695-4db2-f6de-08d740d461b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:48:41.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv9Na81eGH0pFKJhNkJOLzdHaF1VKfqD0x9S70tZIf+99x/s3TttloFnNVfKHGjTo6CGSy0SawPndNnQdh8YpJ8DSbHlRyy7RrumMlelNyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2019 13:43, Marco Felsch wrote:

> The DA9062/1 devices can switch their regulator voltages between
> voltage-A (active) and voltage-B (suspend) settings. Switching the
> voltages can be controlled by ther internal state-machine or by a gpio
> input signal and can be configured for each individual regulator. This
> commit adds the gpio-based voltage switching support.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/regulator/da9062-regulator.c | 149 +++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index 9b2ca472f70c..9d6eb7625948 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -15,6 +16,7 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
>  #include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/gpio.h>
>  #include <linux/mfd/da9062/registers.h>
>=20
>  /* Regulator IDs */
> @@ -50,6 +52,7 @@ struct da9062_regulator_info {
>  	struct reg_field sleep;
>  	struct reg_field suspend_sleep;
>  	unsigned int suspend_vsel_reg;
> +	struct reg_field vsel_gpi;
>  	/* Event detection bit */
>  	struct reg_field oc_event;
>  };
> @@ -65,6 +68,7 @@ struct da9062_regulator {
>  	struct regmap_field			*suspend;
>  	struct regmap_field			*sleep;
>  	struct regmap_field			*suspend_sleep;
> +	struct regmap_field			*vsel_gpi;
>  };
>=20
>  /* Encapsulates all information for the regulators driver */
> @@ -351,6 +355,65 @@ static const struct regulator_ops da9062_ldo_ops =3D=
 {
>  	.set_suspend_mode	=3D da9062_ldo_set_suspend_mode,
>  };
>=20
> +static int da9062_config_gpi(struct device_node *np,
> +			     const struct regulator_desc *desc,
> +			     struct regulator_config *cfg, const char *gpi_id)
> +{
> +	struct da9062_regulator *regl =3D cfg->driver_data;
> +	struct gpio_desc *gpi;
> +	unsigned int nr;
> +	int ret;
> +	char *prop, *label;
> +
> +	prop =3D kasprintf(GFP_KERNEL, "dlg,%s-sense-gpios", gpi_id);
> +	if (!prop)
> +		return -ENOMEM;
> +	label =3D kasprintf(GFP_KERNEL, "%s-%s-gpi", desc->name, gpi_id);
> +	if (!label) {
> +		ret =3D -ENOMEM;
> +		goto free;

If we use the generic bindings names then the above will change I guess.

> +	}
> +
> +	/*
> +	 * We only must ensure that the gpio device is probed before the
> +	 * regulator driver so no need to store the reference global. Luckily
> +	 * devm_* releases the gpio upon a unbound action.
> +	 */
> +	gpi =3D devm_gpiod_get_from_of_node(cfg->dev, np, prop, 0, GPIOD_IN |
> +					  GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> label);
> +	if (IS_ERR(gpi)) {
> +		ret =3D PTR_ERR(gpi);
> +		goto free;
> +	}
> +
> +	if (!gpi) {
> +		ret =3D 0;
> +		goto free;
> +	}
> +
> +	/* We need the local number */
> +	nr =3D da9062_gpio_get_hwgpio(gpi);
> +	if (nr < 1 || nr > 3) {
> +		ret =3D -EINVAL;
> +		goto free;
> +	}
> +
> +	ret =3D regmap_field_write(regl->vsel_gpi, nr);

Actually thinking about this some more, should we really be setting alterna=
te
functions of the GPIO here? Would this not be done through GPIO/Pinmux
frameworks? That way the GPIO would be blocked off from other's requesting =
it.
This seems a little unsafe, unless I'm mistaken.

> +
> +free:
> +	kfree(prop);
> +	kfree(label);
> +
> +	return ret;
> +}
> +
> +static int da9062_parse_dt(struct device_node *np,
> +			   const struct regulator_desc *desc,
> +			   struct regulator_config *cfg)
> +{
> +	return da9062_config_gpi(np, desc, cfg, "vsel");
> +}
> +
>  /* DA9061 Regulator information */
>  static const struct da9062_regulator_info local_da9061_regulator_info[] =
=3D {
>  	{
> @@ -358,6 +421,7 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  		.desc.name =3D "DA9061 BUCK1",
>  		.desc.of_match =3D of_match_ptr("buck1"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (300) * 1000,
>  		.desc.uV_step =3D (10) * 1000,
> @@ -388,12 +452,17 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_BUCK2,
>  		.desc.name =3D "DA9061 BUCK2",
>  		.desc.of_match =3D of_match_ptr("buck2"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (800) * 1000,
>  		.desc.uV_step =3D (20) * 1000,
> @@ -424,12 +493,17 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_BUCK3,
>  		.desc.name =3D "DA9061 BUCK3",
>  		.desc.of_match =3D of_match_ptr("buck3"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (530) * 1000,
>  		.desc.uV_step =3D (10) * 1000,
> @@ -460,12 +534,17 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_LDO1,
>  		.desc.name =3D "DA9061 LDO1",
>  		.desc.of_match =3D of_match_ptr("ldo1"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -489,6 +568,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO1_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -499,6 +582,7 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  		.desc.name =3D "DA9061 LDO2",
>  		.desc.of_match =3D of_match_ptr("ldo2"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -522,6 +606,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO2_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -532,6 +620,7 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  		.desc.name =3D "DA9061 LDO3",
>  		.desc.of_match =3D of_match_ptr("ldo3"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -555,6 +644,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO3_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -565,6 +658,7 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  		.desc.name =3D "DA9061 LDO4",
>  		.desc.of_match =3D of_match_ptr("ldo4"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -588,6 +682,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO4_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -602,6 +700,7 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  		.desc.name =3D "DA9062 BUCK1",
>  		.desc.of_match =3D of_match_ptr("buck1"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (300) * 1000,
>  		.desc.uV_step =3D (10) * 1000,
> @@ -632,12 +731,17 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK2,
>  		.desc.name =3D "DA9062 BUCK2",
>  		.desc.of_match =3D of_match_ptr("buck2"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (300) * 1000,
>  		.desc.uV_step =3D (10) * 1000,
> @@ -668,12 +772,17 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK2_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK2_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK2_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK3,
>  		.desc.name =3D "DA9062 BUCK3",
>  		.desc.of_match =3D of_match_ptr("buck3"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (800) * 1000,
>  		.desc.uV_step =3D (20) * 1000,
> @@ -704,12 +813,17 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK4,
>  		.desc.name =3D "DA9062 BUCK4",
>  		.desc.of_match =3D of_match_ptr("buck4"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_buck_ops,
>  		.desc.min_uV =3D (530) * 1000,
>  		.desc.uV_step =3D (10) * 1000,
> @@ -740,12 +854,17 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> +			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_LDO1,
>  		.desc.name =3D "DA9062 LDO1",
>  		.desc.of_match =3D of_match_ptr("ldo1"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -769,6 +888,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO1_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -779,6 +902,7 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  		.desc.name =3D "DA9062 LDO2",
>  		.desc.of_match =3D of_match_ptr("ldo2"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -802,6 +926,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO2_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -812,6 +940,7 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  		.desc.name =3D "DA9062 LDO3",
>  		.desc.of_match =3D of_match_ptr("ldo3"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -835,6 +964,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO3_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -845,6 +978,7 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  		.desc.name =3D "DA9062 LDO4",
>  		.desc.of_match =3D of_match_ptr("ldo4"),
>  		.desc.regulators_node =3D of_match_ptr("regulators"),
> +		.desc.of_parse_cb =3D da9062_parse_dt,
>  		.desc.ops =3D &da9062_ldo_ops,
>  		.desc.min_uV =3D (900) * 1000,
>  		.desc.uV_step =3D (50) * 1000,
> @@ -868,6 +1002,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> +		.vsel_gpi =3D REG_FIELD(DA9062AA_LDO4_CONT,
> +			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
> +			sizeof(unsigned int) * 8 -
> +			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -988,6 +1126,15 @@ static int da9062_regulator_probe(struct
> platform_device *pdev)
>  				return PTR_ERR(regl->suspend_sleep);
>  		}
>=20
> +		if (regl->info->vsel_gpi.reg) {
> +			regl->vsel_gpi =3D devm_regmap_field_alloc(
> +					&pdev->dev,
> +					chip->regmap,
> +					regl->info->vsel_gpi);
> +			if (IS_ERR(regl->vsel_gpi))
> +				return PTR_ERR(regl->vsel_gpi);
> +		}
> +
>  		/* Register regulator */
>  		memset(&config, 0, sizeof(config));
>  		config.dev =3D chip->dev;
> @@ -997,6 +1144,8 @@ static int da9062_regulator_probe(struct
> platform_device *pdev)
>  		regl->rdev =3D devm_regulator_register(&pdev->dev, &regl->desc,
>  						     &config);
>  		if (IS_ERR(regl->rdev)) {
> +			if (PTR_ERR(regl->rdev) =3D=3D -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
>  			dev_err(&pdev->dev,
>  				"Failed to register %s regulator\n",
>  				regl->desc.name);
> --
> 2.20.1

