Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7ABC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A3F214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="PpMpPSYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfIXI6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:58:41 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:40838 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbfIXI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:58:40 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id C0/6F-26481-9BAD98D5; Tue, 24 Sep 2019 08:58:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0xTZxjHeXsuPVaKhxbhXbMusbplG7SUYPR
  4aVTMYjNnnFsXdwmTUznQaluwp4RizIJuuCHbwHVloylyEbeJMwjqVhC+NK20RtyQq6ybosUE
  kEVACExlO+1Btn37Pc///1zeNw+BSH7DZQRjtzFWC21S4CLUkIqlKz1DpZnqP7uTKedwGKdqf
  DcwqtHZilK3Z/yAmu39TED1tLlx6mFbH0KVdPiEWwltq+t3obalsRTXhvrbcW35U7V2uuWFN7
  H3MaNFn2fPwgz+CQeaX2a3zx2fwYpBIOsEEBGAPIPAX1sbhHxwFYWO+58ifHARwMdfzOORACU
  DnK15IqpIyEoB9HT1AD4IA/jkWhnXYBmBkxR0BO7gEU4g98HO6q5oBRIp/+mrv6ImKfk2vNtb
  gvImHeyaPLdYkAFHLvdGPSj5Ijz5+DwWYTFJQ98nt1F+2iyAvoZRJCIsIzUw9OSXKANSDh8dP
  RdlhEyCQ+EaQYQhScKGdt4DyZVw9N4CxvsZGDw2CPh8CuwaCC+yAp6q9i2yHN6sKVvkXbD+dD
  D6ZEiOcEs0XV8qDtaVYzxTsKGMfxkkZTDQ7efyBMdr4IK3iE/nw8lvjgp5fgn2TfnRCqB2/Wd
  tnlNg7ZUpnOdk+F3dOOKK/kU8DFaF0VqANgJKbzXmGmxm2mhSpqnVyrS0dOV65YZ1KvqwUq9i
  CpT7GYvNSnOiii5kVWyReb8pW2VhbC2Au7PsQ8IsDxhxPVB5wXOEQLFS/LevNFMSp8/LLjLQr
  GGftcDEsF7wPEEooPjALU6LtzK5jD3HaOKu9ZkMiVhFgng3d68SMZtPm1ljLi9dA0qiYrS6Hp
  GgljwLI0sSGyM9yIjJUGBZavHs5m8CuUwqBjExMZLYfMZqNtr+r4+BJAIopOLlkS6xRottadI
  Yt4SAW2L19ugSNvpfSVYsgDsuH7i1Cu3uLFhx8K1vXy93bFmn6RhoPiX9Xpws+qCz+VDiwdSx
  wQSP/+nWG+Y+VSvh+3zuqnHsAbkgU9VVxLnSE7ftaHJ6JjbV79QEOveED6/W6ChkwKe0Xuw8G
  cq+dFbeMVsy/XDB3TOFigRbMi49SpwsjJ0/xoZCxe841144XfvlpqGcoLdtw7AjsGJQQ3k3j2
  8/0rbRVDWvu3Ii82ypu2rzj7ozP6yRn3/53trGnHk4c+f4qv67F5b/kRKTQUpBk45lRdffre3
  5MH7PfaowNPOGvHqb030kB9ub0eGJU1Q6dlLDr0xv7Pe9t1c093Vq0Wvj+o9/dnzUVBlOaXev
  V6CsgU57FbGy9D93su0ibgQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-239.messagelabs.com!1569315512!121292!1
X-Originating-IP: [104.47.5.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20931 invoked from network); 24 Sep 2019 08:58:32 -0000
Received: from mail-he1eur02lp2051.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.51)
  by server-5.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 24 Sep 2019 08:58:32 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYIeaimwpkFq+C7LgYHKi5PX3giuj1Lux84Jq6ePIC6V7mGqmPxuwoYDUI24kR5g2kuJdCI9pIJ7NzlZxRZ33LY8Ule0f3PHpTVMXu0rlP3Jw6ZC9PlXRuZCrnCG1NEe0ekwlc15xI0MLwrPTeUXmrvqXKmLut+ITkQ4LC/nPdv+U3o5DRxPw5dg/v6vn+M2uhXyjEKr+FvEqRShPZ8uYBro1hWayK7K5Auxy7H2scDwYObDLyG2ZpE79Si57niOISP82S9yNwJsRmKkkxbXfH7bJ8LRZDk2+kyxOoeODccURWHHsbjFcAEd/siqKMdiBXBr3vwGeThvckQuFB0ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIA5OrdLdGjth/jkin8aUsUOT9uuEcR9YjOfFDupCfk=;
 b=UCLrAiTf+XJ/IBUyMtAmSG6Ul2PbxD7nxbR/JWkfYXIR5YZhjZJzZKubXcCLo+vXx9P2Ujg3hcLHWP+ymG2Wn/Sy9usQu52HM+cC1Ui7OxKyXCWjuHJitGa57jja1GtJEhLzJIpwUgcu/T9C5kV4JCDJ5UY5ZgIPr4XeFKbkiu2/OPBh03DxzKzODdcIhDTg96dBr2XEuigRZWNG3sG2iIBcz3t79K83rcMVCAN+fmqNScTDvuCN5EW4BAzWR5vlhU+zO24zCwtv3/ubbIx/ahdIjRnAHOnqlEKuDj/w/houVdpwjb4J3Lq7C8UmbQx2O0VMe0SYnmNc6Wp8OC+xIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIA5OrdLdGjth/jkin8aUsUOT9uuEcR9YjOfFDupCfk=;
 b=PpMpPSYa8HecbEDV3sXilQH7ihPvEtP3f4zutMsCpuxEdDKO+IytQ9xMfWj/c/P5yRaI2r9Cz4JYsQr6s5uTCTwehBtBlb9dlGoq7NDf1/9XcBwAV0Ye9PVh0OXGP2VOZRwo0zFA7WDk01qvTccNxFVj297qkQIHr/ev6bvhqfA=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1058.EURPRD10.PROD.OUTLOOK.COM (10.169.154.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 24 Sep 2019 08:58:30 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.023; Tue, 24 Sep
 2019 08:58:30 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Topic: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Index: AQHVbVV3QWLw5KxYw0mhM4DQgisfYqc5deOwgABkrICAALa60A==
Date:   Tue, 24 Sep 2019 08:58:30 +0000
Message-ID: <AM5PR1001MB09949AE859F5FA8173A361DE80840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-2-m.felsch@pengutronix.de>
 <AM5PR1001MB0994BD2F5D5635085B836A7980850@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190923220239.bcir5hjuqxti5b5e@pengutronix.de>
In-Reply-To: <20190923220239.bcir5hjuqxti5b5e@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45d68ada-94e9-4e64-7068-08d740cd5f52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR1001MB1058;
x-ms-traffictypediagnostic: AM5PR1001MB1058:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB10582575C1E3EC25320E1FEEA7840@AM5PR1001MB1058.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(14454004)(256004)(14444005)(66476007)(229853002)(5660300002)(66946007)(6246003)(55236004)(66556008)(305945005)(52536014)(64756008)(2420400007)(11346002)(8676002)(6506007)(446003)(2906002)(53546011)(81166006)(6436002)(99286004)(476003)(71190400001)(71200400001)(7736002)(66446008)(76116006)(81156014)(30864003)(54906003)(86362001)(76176011)(316002)(186003)(55016002)(26005)(8936002)(478600001)(486006)(74316002)(102836004)(33656002)(15650500001)(7696005)(966005)(25786009)(3846002)(4326008)(6116002)(66066001)(6306002)(110136005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1058;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4m5uuYH5oauanqaX8bkvUmS5z7nKVvOu9kiJITDIVG+L/IFL6ODmymZWHr1mrDHGvhOQA0UHBJXQZOJTs1mVTuvlchEGQI6futpJ9lB10QEHEr4LMBAs6jsP9Gfqpll4RA5iKdNSQrvVH0iWA16aK/fFIV8W3J1EHwuOtUTPjk7SW4/5g87IJoRUL6dHyX5E2k0Rg1N76+mIiXL+rqUfeAhuvs5Tl7lYcOrcO6fW+VSFOQiQ6yKsdSqScP44fWHly27vllQGWVkIx9HuJ74S3VzFoXEB02PuxoXj77agKmskX18W3WYlqLcFfi0zLP4tl+4W/AWk6XCKjGShcmGWT9QtcFs5UO/OF/NsaPZy/1lCLTjeMXDDuLYaX2hO5kLwY7akp9SMBYoOmWk08Nohy2dK/zu86yVN1+Rih1U73FY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d68ada-94e9-4e64-7068-08d740cd5f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:58:30.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsGShUbZq1IFYSHOOBO7wo7QSRiwxAI/vJMi5DSfu6dNjfy4Rc0h5cbaeZM2ZuEcoJ/kuOmrHa9PzIvXkMZoGnoFYw96cKOY6ympvTh3Sjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 September 2019 23:03, Marco Felsch wrote:

> Hi Adam,
>=20
> On 19-09-23 16:03, Adam Thomson wrote:
> > On 17 September 2019 13:43, Marco Felsch wrote:
> >
> > > Currently the suspend reg_field maps to the pmic voltage selection bi=
ts
> > > and is used during suspend_enabe/disable() and during get_mode(). Thi=
s
> > > seems to be wrong for both use cases.
> > >
> > > Use case one (suspend_enabe/disable):
> > > Those callbacks are used to mark a regulator device as enabled/disabl=
ed
> > > during suspend. Marking the regulator enabled during suspend is done =
by
> > > the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT
> > > registers.
> > > Setting this bit tells the DA9062 PMIC state machine to keep the
> > > regulator on in POWERDOWN mode and switch to suspend voltage.
> > >
> > > Use case two (get_mode):
> > > The get_mode callback is used to retrieve the active mode state. Sinc=
e
> > > the regulator-setting-A is used for the active state and
> > > regulator-setting-B for the suspend state there is no need to check
> > > which regulator setting is active.
> > >
> >
> > So I believe you're correct with the above statements. The driver, rath=
er than
> > enabling/disabling a regulator in system suspend, will instead put the =
regulator
> > to a low power state, which is definitely not the desired outcome. Than=
ks for
> > rectifying this.
> >
> > Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>=20
> Thanks a lot for reviewing the patch :) Can you also have a look on the
> other patches within this series?

Yes, I will take a look at those next. :)

>=20
> Regards,
>   Marco
>=20
> > > Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/regulator/da9062-regulator.c | 118 +++++++++++--------------=
--
> > >  1 file changed, 47 insertions(+), 71 deletions(-)
> > >
> > > diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator=
/da9062-
> > > regulator.c
> > > index 2ffc64622451..9b2ca472f70c 100644
> > > --- a/drivers/regulator/da9062-regulator.c
> > > +++ b/drivers/regulator/da9062-regulator.c
> > > @@ -136,7 +136,6 @@ static int da9062_buck_set_mode(struct
> regulator_dev
> > > *rdev, unsigned mode)
> > >  static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
> > >  {
> > >  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> > > -	struct regmap_field *field;
> > >  	unsigned int val, mode =3D 0;
> > >  	int ret;
> > >
> > > @@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct
> > > regulator_dev *rdev)
> > >  		return REGULATOR_MODE_NORMAL;
> > >  	}
> > >
> > > -	/* Detect current regulator state */
> > > -	ret =3D regmap_field_read(regl->suspend, &val);
> > > -	if (ret < 0)
> > > -		return 0;
> > > -
> > > -	/* Read regulator mode from proper register, depending on state */
> > > -	if (val)
> > > -		field =3D regl->suspend_sleep;
> > > -	else
> > > -		field =3D regl->sleep;
> > > -
> > > -	ret =3D regmap_field_read(field, &val);
> > > +	ret =3D regmap_field_read(regl->sleep, &val);
> > >  	if (ret < 0)
> > >  		return 0;
> > >
> > > @@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_=
dev
> > > *rdev, unsigned mode)
> > >  static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
> > >  {
> > >  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> > > -	struct regmap_field *field;
> > >  	int ret, val;
> > >
> > > -	/* Detect current regulator state */
> > > -	ret =3D regmap_field_read(regl->suspend, &val);
> > > -	if (ret < 0)
> > > -		return 0;
> > > -
> > > -	/* Read regulator mode from proper register, depending on state */
> > > -	if (val)
> > > -		field =3D regl->suspend_sleep;
> > > -	else
> > > -		field =3D regl->sleep;
> > > -
> > > -	ret =3D regmap_field_read(field, &val);
> > > +	ret =3D regmap_field_read(regl->sleep, &val);
> > >  	if (ret < 0)
> > >  		return 0;
> > >
> > > @@ -408,10 +384,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9061_ID_BUCK2,
> > > @@ -444,10 +420,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9061_ID_BUCK3,
> > > @@ -480,10 +456,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9061_ID_LDO1,
> > > @@ -509,10 +485,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO1_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO1_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -542,10 +518,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO2_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO2_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -575,10 +551,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO3_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO3_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -608,10 +584,10 @@ static const struct da9062_regulator_info
> > > local_da9061_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO4_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO4_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -652,10 +628,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK1_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9062_ID_BUCK2,
> > > @@ -688,10 +664,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK2_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK2_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK2_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9062_ID_BUCK3,
> > > @@ -724,10 +700,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK3_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9062_ID_BUCK4,
> > > @@ -760,10 +736,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_BUCK4_CONT,
> > > +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> > >  	},
> > >  	{
> > >  		.desc.id =3D DA9062_ID_LDO1,
> > > @@ -789,10 +765,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO1_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO1_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -822,10 +798,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO2_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO2_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -855,10 +831,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO3_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO3_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > @@ -888,10 +864,10 @@ static const struct da9062_regulator_info
> > > local_da9062_regulator_info[] =3D {
> > >  			sizeof(unsigned int) * 8 -
> > >  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
> > >  		.suspend_vsel_reg =3D DA9062AA_VLDO4_B,
> > > -		.suspend =3D REG_FIELD(DA9062AA_DVC_1,
> > > -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> > > +		.suspend =3D REG_FIELD(DA9062AA_LDO4_CONT,
> > > +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> > > +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> > >  		.oc_event =3D REG_FIELD(DA9062AA_STATUS_D,
> > >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> > >  			sizeof(unsigned int) * 8 -
> > > --
> > > 2.20.1
> >
> >
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
