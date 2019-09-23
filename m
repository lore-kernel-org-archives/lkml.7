Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B736C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02281217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="kU6or75R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbfIWQEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:04:02 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:47982 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728211AbfIWQEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:04:01 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 57/4D-25862-BECE88D5; Mon, 23 Sep 2019 16:03:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSf0wbZRzGee/a4yDUHIWF7xpYsmZDp7RQ1O3
  2w7hsJtaExc0R1Bl0xzhoY3stbdkKomMjCCsZY86KdkWGG9OUCQSmAg7JOhiMjc3wa2NB6LQY
  KYrjx1SmQ++4MvW/z/d5nnvf5718SVw+RChI1m5jLRxjUBLhEl0itkkV+Lk0PWn88DraecdP0
  NWd16W0x9kqocfvdSH6t8FSjB5ocxP03bYhnC5u7wzdSmpbXd+Faps8Rwjt6PAFQnvsQZJ2rm
  nVTukeqZ7LMNn3SnW/du41l+vtbT3d0kJ09BUHCicRVYvD6UZ3qAOF8cNlCTh8u0SjGcGfRxc
  IwZBQPTg0Xw0VDDn1AQb3C73BwY/A4w5gQoqgaDjR4yMEI5ryYjDmOrk04FQDgvL3vUhIRVG7
  4fvBYonA0VQq9M3UESInQ+1sO+5AJH/fWmhrTBRkGcXA6MgQEmQ5xcHF99IEOYx6BsprAhKxd
  hzMH6rDBcapGLjtr17qAxQFZy7cwEVeAZM/LErFPAtXDt9Cop4AfTf9QVbCx1WdQY6D/uqyIO
  +AgbHTSHgKUBMIhiqKsOWPF5r6CZFpOFMmPIvkeQ0sevNE2QwnJi4GO8TDV8M3MDESC86SsAq
  U6PpPa5ET4NTXs4TIT8DZminctfQjIuHKR37JKSTxIDrDos/W2YyM3qDSJCWpNJonVRtUmg1q
  Jl+VoWZzVftYzmZheFPNHLCqrXnGfYZMNcfamhC/YZk5oZEtyNs5pfailSSmXCGz5ZSmyx/JM
  GXm6Rir7g1LroG1elEsSSpBNvoj70Va2GzWnqU38Hu6bAMZoYyWPT3F2zKrmTFa9dmi1YtUZM
  Vk1Se4XMKZOFYRI9sW4EOUENLlcg+PWN72fhSniJKhkJAQeYSZtRj1tv/7ARRDImWU7JdJ/pQ
  IPWd7eFOAL4HxJap3FAslbMy/lqIQw0DffLx1JNr3XH39hyXVl9iUqGd7s57v7x59rWS1+e2a
  3W8mb5/7++W5hoUi+wvt7JfrjWvY2S8qGjdpE63S86mXA11lBze+VTfitnb351TudIFqXlOrL
  miYn5tmjt9LGefCz6UNDxR7tn6TF9JSv83yR3ret+cOpHye89hBtznffmTztbHyyuSEp/bnTs
  euT8s0/DS92nnNU2TaY3rx0V63kovfMnOoo+CzV30rFy+5nJWDDyay6qfuTF8//87Q2WOgeTc
  2y624n3+T27LuJdOgJn+8fXtqXNf+lFW7fJktv3eM1qpiyjoCAb/j5MzGtX19nxr/6govuPX6
  Xbi9ubinKv5qg1Ji1TGax3GLlfkHnpeQYGgEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-2.tower-239.messagelabs.com!1569254634!341955!1
X-Originating-IP: [104.47.2.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22696 invoked from network); 23 Sep 2019 16:03:54 -0000
Received: from mail-db5eur01lp2058.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.58)
  by server-2.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 23 Sep 2019 16:03:54 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK+GXQBQaCsMiFDfkS+mlXb3hSB74IrkFnfqGm/WtiIt4mDzgZOJgfPV/dPMZLO8tK6E8UIaOAIjv7aOyvWJvoZucyE9BIvaEJeTx+O7jhUeVgDWlkMQ0dC+rzPfocjUi2C7tCYgNXloywWu/ksygdWTJz3Osaq0zJb0cxGa1VySeJZd5kbbFm+H6+TlPRjtI5VVTTw5a4FkwrbpF29hZUPRtfuY6wxGsxVJSvwhIFkNY9w+4w7/pOhFZmvhS2r/dOCHNIK/d6SYB1oUi0rKfvorH2c0XZbvDon+e7gOkMZRCVjnqBiuftvkn8bkS0XW0WgzhbtRhHvqnInGkfYNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgaFl2kjSHE8nk3NeJddzP9Nkvv8/c90Uq2+nJDUat0=;
 b=d2TNqcBbbEwYy2nuCpcr18zmhkRgZ+NSFKKupQqnA1PLHCiRg2W9EiNbkQ4Png52SZfpyfC1yHCP1ePGo76a7wl/3jDf9dBBcYP9fSBPSIJ0wTeCmPaQYRwB7lx3DpqXHOueKbvMpm8SS1mdj7b186P0l/iVnWMlgoO6/SI7P6LYd3+1j34oGTBHZE67iTx0LwybFiTwGm4UrVVp61IUAJBd20jT7choFmrba7LHGGQG5Hp/RbzjkSyABi+EQfIiUZ/UxEW/qRTq0yV+lr87SNhjf8zSNsm9UruCswEem7rpswAz9f5Y3gIzepdwbytEhppmUdpwlw+L1uCIv/uuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgaFl2kjSHE8nk3NeJddzP9Nkvv8/c90Uq2+nJDUat0=;
 b=kU6or75R3kGckrM+QuucGs/k59+yurWHMmGJ0pscIVLJzHVGJSS7mP5spUmfVKX0HZo0+mwmwwM722QZk+IiKYjqV8eHT4j9wqROJ1oLt8wuE4NtYZNttB0YDGrS/FDVxTJiwlTvnEcYKro/0bzRQdGOuZ7F+XJkZcbZwXiiwu8=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1107.EURPRD10.PROD.OUTLOOK.COM (10.169.154.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Mon, 23 Sep 2019 16:03:39 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.023; Mon, 23 Sep
 2019 16:03:39 +0000
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
Subject: RE: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Topic: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Thread-Index: AQHVbVV3QWLw5KxYw0mhM4DQgisfYqc5deOw
Date:   Mon, 23 Sep 2019 16:03:39 +0000
Message-ID: <AM5PR1001MB0994BD2F5D5635085B836A7980850@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-2-m.felsch@pengutronix.de>
In-Reply-To: <20190917124246.11732-2-m.felsch@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79118081-98f9-4b2e-22e6-08d7403f994e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR1001MB1107;
x-ms-traffictypediagnostic: AM5PR1001MB1107:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1107541E6A9DC327B80F70EFA7850@AM5PR1001MB1107.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(66556008)(66446008)(64756008)(76176011)(11346002)(8676002)(3846002)(446003)(6246003)(305945005)(7736002)(54906003)(76116006)(6636002)(33656002)(52536014)(81156014)(4326008)(15650500001)(25786009)(81166006)(66946007)(9686003)(66476007)(8936002)(110136005)(53546011)(6506007)(7696005)(476003)(486006)(26005)(71200400001)(55236004)(102836004)(2906002)(186003)(71190400001)(478600001)(229853002)(74316002)(66066001)(14454004)(99286004)(5660300002)(30864003)(6436002)(6116002)(55016002)(86362001)(2501003)(14444005)(256004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1107;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WQ3RhxQm6zB+VDr4Nq8QFEVIVNbzcti5kHXgHPytUO6hksLjMsiefv1bhJXxvDvGpPo5v2VdDpjD7XW5OQ/P445Wh9ACWaLaiRMjqUiRQWMJL0PkhpsCpWTpdVEYqV5wWp+OVfvRjWRG1hSPumLUOh00WzvyHpMddtQx4RN1txbVba+5pU04E0v0QEl4w4Pcip7+g2AM04S8cbRMxDGL0VQFLMMhaiw0GzqfuO+54Kr8Wlefzi0wYe1UST1/20wwh/LNICNPj0zET1C1PkvME0ZpxJtfxEQpux6Q8FducUt08fFGjyxgMWX3HFYwmkjrEr24NfS+o9Hp5ArlIT1KZRhckAq5FtLjHaETu1BZiTt5PqWHQphfiQwhqmxsK8fFGJZTjiq0e8Myp2x06t4pe+tZYpQp2T4zQHwtk7V4WmI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79118081-98f9-4b2e-22e6-08d7403f994e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 16:03:39.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8ciHFSPi2olw9kmD5KsUXLmOwPwiDf1Fon0JdsM04FPJyN6CS6C1YcbWo63uLppLS6e3LZtPRRaPjuZ29CFw437dJqgxKKx/z8N50pWidA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2019 13:43, Marco Felsch wrote:

> Currently the suspend reg_field maps to the pmic voltage selection bits
> and is used during suspend_enabe/disable() and during get_mode(). This
> seems to be wrong for both use cases.
>
> Use case one (suspend_enabe/disable):
> Those callbacks are used to mark a regulator device as enabled/disabled
> during suspend. Marking the regulator enabled during suspend is done by
> the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT
> registers.
> Setting this bit tells the DA9062 PMIC state machine to keep the
> regulator on in POWERDOWN mode and switch to suspend voltage.
>
> Use case two (get_mode):
> The get_mode callback is used to retrieve the active mode state. Since
> the regulator-setting-A is used for the active state and
> regulator-setting-B for the suspend state there is no need to check
> which regulator setting is active.
>

So I believe you're correct with the above statements. The driver, rather t=
han
enabling/disabling a regulator in system suspend, will instead put the regu=
lator
to a low power state, which is definitely not the desired outcome. Thanks f=
or
rectifying this.

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/regulator/da9062-regulator.c | 118 +++++++++++----------------
>  1 file changed, 47 insertions(+), 71 deletions(-)
>
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
>
> @@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct
> regulator_dev *rdev)
>  		return REGULATOR_MODE_NORMAL;
>  	}
>
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
>
> @@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_dev
> *rdev, unsigned mode)
>  static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
>  {
>  	struct da9062_regulator *regl =3D rdev_get_drvdata(rdev);
> -	struct regmap_field *field;
>  	int ret, val;
>
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
>
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

