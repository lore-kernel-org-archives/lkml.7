Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="odEIdpYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfIRMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:41:37 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:56110 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfIRMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:41:37 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 91/3C-11192-9F5228D5; Wed, 18 Sep 2019 12:41:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRWlGSWpSXmKPExsWSoc9qqvtDtSn
  W4PlmLYupD5+wWcw/co7VYtXUnSwW978eZbT4dqWDyeLyrjlsFh92XWW2aN17hN2Bw2PnrLvs
  HptWdbJ53Lm2h82j/6+Bx+dNcgGsUayZeUn5FQmsGc9+d7AXvMio6Fyf1MD4PLyLkYuDUWAps
  8Szi3vZIJxjLBKPDt9jhHA2M0r87v0JlmEROMEs8ebDCWYQR0hgGpPElZPN7BDOY0aJ0wvuMn
  UxcnKwCVhITD7xAKxFRGAqk8TcZY9YQRxmgfWMEn1TDjGCVAkLBEs8utLKAmKLCIRInP24Gqi
  DA8g2kjh7XB8kzCKgKvFkcycbiM0rkChx+sZURpASIYE8iYOTwkDCnAK2En0LX4FNYRSQlfjS
  uJoZxGYWEJe49WQ+2D0SAgISS/acZ4awRSVePv7HClGfKnGy6QYjRFxH4uz1J1C2ksSyG7NYI
  WxZiUvzu6HivhJ7//WwQdh3GCUevDOF6d049QvUfAuJJd0gX3EA2SoS/w5VQoQLJE7+/QA1Uk
  3ixpsOqHIZiXdN85knMOrPQnI1hK0jsWD3JzYIW1ti2cLXzLPAASEocXLmE5YFjCyrGC2TijL
  TM0pyEzNzdA0NDHQNDY11TYGkoV5ilW6SXmqpbnJqXklRIlBWL7G8WK+4Mjc5J0UvL7VkEyMw
  kaUUsubvYHw3843eIUZJDiYlUd7I+42xQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4Lyg1xQoJF
  qWmp1akZeYAkypMWoKDR0mEt0cZKM1bXJCYW5yZDpE6xajLMeHl3EXMQix5+XmpUuK8bsAULS
  QAUpRRmgc3ApbgLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5hUHmcKTmVcCt+kV0BFMQEf
  YRTSCHFGSiJCSamBa8Mc+rZhZ8dirh/uuTfJscXTmz3XVm6w4RWTzTR6GJ7ri4ZOLjqfGrBa3
  +iLM/qznuOuvTr5T7E93sdwq+eDwTjAr/LW299NlrV9zagKlnzwXW+iW1Dn9o5aBf7/Vz++nj
  sfXpqpM3viNdc35Z5l+L/5OLrgvr20x6VXsP5H9V40N/s/ZqNfb+Jp3ArvfuZ9WKhKJUoG3vr
  5VNA70juDak/hzG/P1q6bMf4U3zjWcGb7Ta2qMy4sHdXIWL5JVchtv7eXMKw+zu3VesPtv6im
  e3bLVOUE1TaHy867lvhStd0ksuGzscL7RzWHG7XUt+cbG4hd/8zL+bglO7J51ZLUaT/CZa9Js
  +o7/4rh/OSuxFGckGmoxFxUnAgDvPaZ1awQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-246.messagelabs.com!1568810488!28563!1
X-Originating-IP: [104.47.5.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3327 invoked from network); 18 Sep 2019 12:41:28 -0000
Received: from mail-he1eur02lp2053.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.53)
  by server-13.tower-246.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Sep 2019 12:41:28 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBNWsSzPkZVufrKI0TBNSvjIfEwCV+zeuUa5RuDWumdG6/gjmLMoM0vJi5QjpwJS6ECt8hEU2luz8+PV2T6ia1ytJGT9/vYrHCOSLA0N9QlL14d3Xml0bf2lcMHVLQN/y5gTylPHBlDD8V/lRxex7WboHpm+hcL5bQr5jiiRvIBHUIAoriw4Spge+5RNZpO+9p0eWrZzD0N/kn0WQ+m80yvQWUsXwsZRV9lCXKwarcYi3uz63Rha6mhdLdozmaJweR4xatZ7xdcLMOYRjesydTzR2gGHOo/r7opfOJvqXKmPc2KObn00f7ypG4zfj+W1dZajpOHoRiVngFAm7b4YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYTEgDRdSUaaBfbgGNbVg/7LKh3CxH3eSbRtDLXDGaA=;
 b=LQObdpZuzTQOXVOs9qm6hnmxe0HjRQauIogFhD1rUGqWvHnVOdWcxy7/9k6eZW3+vSWH5+/Jv/4hZXy/KEQPVfk2HbX1nB84fWfkXN8CDKlBY+Arl2lZBIj9OwWWmJe88xb1zpBx3hAPfokkS5zKxtwpl7v3mwr2OjgYmePqakbE0LRkTbS2hhzECQ2VdN0tO0WrWmGUqe6IypG6372u25EuQ7QUMakWJF50S/ORjo8cZmIfcXvjJtkJAwwBUg9iCHnUjVuKmf9DKE1fkFfBHztWkZOk+YyXqahFZnuP7CEphNe99g5/wzW+Lf8pfSb2QGd+Dy7UUrLXU4av2OG3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYTEgDRdSUaaBfbgGNbVg/7LKh3CxH3eSbRtDLXDGaA=;
 b=odEIdpYY0N/Beic/LFSPhBB5g/bmVsl0v9vxW5wdsdBe6Dc/tzzTFpVXhahE8JW2lMnsd7AvcivIftkCEDTlDFjOIDTMYtLcE1mjg/8TV+x4RiLdOqZAONgdB7Jej37is4QawUKjoROmq+EAp9Bs9q4tIu+bTreRXoqHk9z9Z7E=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB0979.EURPRD10.PROD.OUTLOOK.COM (10.169.155.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 12:41:25 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e974:b4ff:cb7d:4230]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e974:b4ff:cb7d:4230%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 12:41:25 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Topic: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Index: AQHVbVV3QWLw5KxYw0mhM4DQgisfYqcxX6cw
Date:   Wed, 18 Sep 2019 12:41:25 +0000
Message-ID: <AM5PR1001MB0994E4B24181AEFCA0C26CF2808E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-2-m.felsch@pengutronix.de>
In-Reply-To: <20190917124246.11732-2-m.felsch@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3a7d520-fd46-449e-2ad5-08d73c3584bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB0979;
x-ms-traffictypediagnostic: AM5PR1001MB0979:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB097927F1BB502F7A4A96992CA78E0@AM5PR1001MB0979.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(15650500001)(52536014)(86362001)(316002)(486006)(76116006)(66946007)(66446008)(2906002)(6246003)(66476007)(76176011)(99286004)(7696005)(55016002)(71190400001)(71200400001)(9686003)(6436002)(6506007)(66556008)(64756008)(229853002)(2501003)(53546011)(14444005)(256004)(14454004)(74316002)(305945005)(25786009)(4326008)(7736002)(66066001)(11346002)(446003)(33656002)(5660300002)(3846002)(8676002)(6116002)(186003)(102836004)(478600001)(54906003)(81156014)(81166006)(8936002)(30864003)(26005)(476003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0979;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JzIO9crKMxCxvn8WiGGoMvtdjFcGO/kaoIVlNCr5Usxh8aWaf7fJdqPI+3TZs2ZMuogZbKVqVpo1CoRdOcOdoiPO7ql32Gt991EtARSsgaSy/h7BsPFar+yEIRQs5f9mBJswWSsMDRFjD0J4fvqAVhhRseWq7W7iaIBt998l5pyL+UMdpaaD5+QLlsexVTn37onydIeVAf5DeN712rd6LYgYw/9dcf77bMoelFWLPPzn+LjWavahXD6zFe84udjeO4QNurd2MP6XSi+L9HXiuVIqxHrX5pVV4y97mBq+PflZh3mFPBPaM4b+Kcl3YoXKEWSFW0rcCzJzVFuXso8221fxy7jiCYbnM0wEFeOzPU2qmRl27kKpY+Zys65iKhAov3WQOG9zQ8Nd6u73aZA0M8JhVRaCnWtL7N/08BoqWZA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a7d520-fd46-449e-2ad5-08d73c3584bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 12:41:25.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71+o0kw7Fv5GPff3Ryv+DyrT8X18KTK6IKWT0039vRgcPDPuCLo9FrrJ3dzhdaFd9111w/zJc6OfuzfaPVOQ+d+AXmI73zfKpli4Iyv9kLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2019 13:43, Marco Felsch wrote:

> Currently the suspend reg_field maps to the pmic voltage selection bits
> and is used during suspend_enabe/disable() and during get_mode(). This
> seems to be wrong for both use cases.

Hi Marco,

I'd be very surprised if what was in place was wrong as I know Stephen test=
ed
this driver thoroughly over its lifetime. Regardless, I'll need some time t=
o review
your proposed updates to make sure this aligns with our expectation of oper=
ation.

>=20
> Use case one (suspend_enabe/disable):
> Those callbacks are used to mark a regulator device as enabled/disabled
> during suspend. Marking the regulator enabled during suspend is done by
> the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT
> registers.
> Setting this bit tells the DA9062 PMIC state machine to keep the
> regulator on in POWERDOWN mode and switch to suspend voltage.
>=20
> Use case two (get_mode):
> The get_mode callback is used to retrieve the active mode state. Since
> the regulator-setting-A is used for the active state and
> regulator-setting-B for the suspend state there is no need to check
> which regulator setting is active.
>=20
> Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/regulator/da9062-regulator.c | 118 +++++++++++----------------
>  1 file changed, 47 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9=
062-
> regulator.c
> index 2ffc64622451..9b2ca472f70c 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -136,7 +136,6 @@ static int da9062_buck_set_mode(struct regulator_dev
> *rdev, unsigned mode)
>  static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> -	struct regmap_field *field;
>  	unsigned int val, mode =3D 0;
>  	int ret;
>=20
> @@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct
> regulator_dev *rdev)
>  		return REGULATOR_MODE_NORMAL;
>  	}
>=20
> -	/* Detect current regulator state */
> -	ret =3D regmap_field_read(regl->suspend, &val);
> -	if (ret < 0)
> -		return 0;
> -
> -	/* Read regulator mode from proper register, depending on state */
> -	if (val)
> -		field =3D regl->suspend_sleep;
> -	else
> -		field =3D regl->sleep;
> -
> -	ret =3D regmap_field_read(field, &val);
> +	ret =3D regmap_field_read(regl->sleep, &val);
>  	if (ret < 0)
>  		return 0;
>=20
> @@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_dev
> *rdev, unsigned mode)
>  static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> -	struct regmap_field *field;
>  	int ret, val;
>=20
> -	/* Detect current regulator state */
> -	ret =3D regmap_field_read(regl->suspend, &val);
> -	if (ret < 0)
> -		return 0;
> -
> -	/* Read regulator mode from proper register, depending on state */
> -	if (val)
> -		field =3D regl->suspend_sleep;
> -	else
> -		field =3D regl->sleep;
> -
> -	ret =3D regmap_field_read(field, &val);
> +	ret =3D regmap_field_read(regl->sleep, &val);
>  	if (ret < 0)
>  		return 0;
>=20
> @@ -408,10 +384,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_BUCK2,
> @@ -444,10 +420,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_BUCK3,
> @@ -480,10 +456,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9061_ID_LDO1,
> @@ -509,10 +485,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO1_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO1_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -542,10 +518,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO2_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO2_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -575,10 +551,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO3_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO3_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -608,10 +584,10 @@ static const struct da9062_regulator_info
> local_da9061_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO4_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO4_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -652,10 +628,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK2,
> @@ -688,10 +664,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK2_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK2_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK2_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK3,
> @@ -724,10 +700,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_BUCK4,
> @@ -760,10 +736,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
>  	},
>  	{
>  		.desc.id =3D DA9062_ID_LDO1,
> @@ -789,10 +765,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO1_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO1_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -822,10 +798,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO2_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO2_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -855,10 +831,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO3_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO3_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> @@ -888,10 +864,10 @@ static const struct da9062_regulator_info
> local_da9062_regulator_info[] =3D {
>  			sizeof(unsigned int) * 8 -
>  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
>  		.suspend_vsel_reg =3D DA9062AA_VLDO4_B,
> -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> +		.suspend =3D REG_FIELD(DA9062AA_LDO4_CONT,
> +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
>  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
>  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
>  			sizeof(unsigned int) * 8 -
> --
> 2.20.1

