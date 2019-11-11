Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DDA2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="QXdf4tjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKKOHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:07:55 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:34924 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbfKKOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:07:54 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 5E/BE-20077-43B69CD5; Mon, 11 Nov 2019 14:07:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUxbZRTGeXtvby+Dbu9KSV8KmNn4ERkt7YZ
  64zI3s6n1jzGjmc4x1Et719vZD9aPSOe2bHOLY/UDxhBGhDHCCOsgIJAIE9F0yAoRCBV0EjBD
  umVQKhkoMLSdbW+Z+t/vnOd5n3Py5pCYyEdISabQxlhMtEFGrMHZrPgt8uz3+vKUQ1NSamTYz
  aPKJn0E1Tb4MZ9aHDnDo3689gVBFV37jE9N+HOolqUmsJ1UtyycJNQdE3VA3Vk5IVC3uooIdX
  egnlA3t4/i6oXWR14V7OPrTfnmwnf5bOjzCqygP7uwbaQOHAezG8+CNSSAlzH0/Y0qAVf04uj
  yXD3BFW0A/fXJ/WiBQw+G5iruRm0iWMZDpXc6Y8UkQJ8OnwdnQTxJQAqVem5Fn4hhO0AN81d4
  kQKD9wDqGR/kR1xJ8HnUERqPvhDDbai+uw3jeBM6VeQLx5LhgY+jshF7pC2ENBq4ExREWASPo
  c5zv/IiHA9fRL/9fSoaA2A6+uPE1WgMBiVozHcx6kEQorquIYzjZDQ9FeJzfgb1nbwJuH4mGv
  jZF2MZqq7qiXE68l50xngXmqqoFqz6vSvjsXwK1TlP45GVEXwMhdwOrl2A/MODOMdPoK7Fnhi
  noc6yB9EvQXCGj7zdHwqKQVblf9bmOBPVfD1PcLwR1V/yY5XRr1iP+i748BqAuwCVb9HrWJuR
  1hvkKqVSrlJtlj8r30Qp6MPyfAVjl2sYk81Ch0UF/b5VYXUYNQatwsTYWkH44LSHBGkdoPrPg
  MINUkieLFkYbPbkidbmm7UOlray71jsBsbqBmkkKUPCbn1fnmi9hdExhQf0hvDZrsqITJSJhb
  fYsCy0FtBGq17HSf1AThZPV9ViItxkNjFSidAdyYARE2s3PYxYPX4vSJcmCUFcXJwosYCxGPW
  2/+szQEICWZJQHUlJ1JtsDyfNhJfghZf4bqA3soSN/leSHueVEniJxqNinssc26di7znPhIw7
  Jr1O/4nU4llxyW2XVRw8stn+Wv9X1y8Ee45qXtnbqHuQu8c2IwxM7oTb968EstfevLvzhcbUm
  vbgtxtShx71bMvw55p9SmcTW1vVcVjppJ8uFWglJvEPP6W8lSku1y090/3B7wn7k1okrjfJG1
  dEexo3TB/LOae9CgvuL4/1zyjZyq0lH/nX1Qbo8y9le00HX+7Mm0s+vTVh8YBi12j8kaWM3Ob
  qcnPv8m3H+OheXYLffMmxDLMWu3IWG2ab5IOvH51Ob3bJdyjKmYNN/qW33/DOzod+0Xy5LmX3
  IXILP/XJ3dft+U95vxEsNAS0KzLcytKqDMxipf8Bii9/rXcEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-34.tower-239.messagelabs.com!1573481267!385074!1
X-Originating-IP: [104.47.9.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31261 invoked from network); 11 Nov 2019 14:07:48 -0000
Received: from mail-ve1eur03lp2059.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.59)
  by server-34.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 11 Nov 2019 14:07:48 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnhx5NzjHHHal7cN41x5rtDE/3sJ6IIT9OCjMYx6y9IPO9wMKzQ8QL9MtqNAXLwsCM3+I4JTxuKt/ss/SWTgDNwLlqVNpyFG3LSSzBRS4JO4a0PfU0ogxV9AsMuBHAB6ssloeY1XI/eiimoHHkbLs8UhnURibMUmb+gD1ot0DfesOHUieVXTrk5BRv396rFJiL/qhMj0HYnovKn07TCyVIaitKSD1KsDDxPEbbc/tqv5fQy+RlAhNuVJRFZ5sMTuWgrDxGrgB3KiLAVBbsu2tC9XySin/oObjk7t9fia29Tr0SOq7jieu1tVfr/whlI1A1J9Cz3zfUtMMtJrVLwy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQBp83SZYf3r1AZcG06wDADbUlPBar7WpvVWUYpg4I=;
 b=PUdA+wD/9CEGI0rrk/V46jrUPcrk2V5OfXyiikwn7yGE0LwoURbxNPTToffCiZkqn0oPKFr/w4zZxHqpNtNpEv6ttkbpth48RiF0WNHqpULAubx3EOy0lQx4hOAaPGHlKva5OAE9GmDAGVDJZasO+2xrRZPxAdaueLOCwT8sPIGEhHymXbrabiDyR5meL36U60wUfCwPglnWgkyd/nhzvG1gL9mI1Sm3LUXTqBJyE61k+pG1OHMrf40wQBLxO/nImFG5GvSdUap9fojedcc3pQtp77TlL6GMMAwULNhGPLhC9/XJQX+PZAN5mS8dkP0+8ZtZdxGSoPCCGCdYjZx6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQBp83SZYf3r1AZcG06wDADbUlPBar7WpvVWUYpg4I=;
 b=QXdf4tjlqY6wBOEv0YtPWRKqDrpiPg6VVyn/PlBAApPRrIf83OjBP4gUkDPuSKic9YeqWTJXcIIjh2a22TYRq88nxczfUUTQyy0l4mc8Gc6zI60cegpsCCGVGHWO7PBamsWoYs48zbQTTI9QWLevmpuKAOI5/sDSysJ7yOkzzW0=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1025.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 14:07:47 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df%7]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 14:07:47 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCHv1 1/5] ASoC: da7213: Add regulator support
Thread-Topic: [PATCHv1 1/5] ASoC: da7213: Add regulator support
Thread-Index: AQHVllzP8vWbWmJf+UuFLSeQhWd9YaeGBE5Q
Date:   Mon, 11 Nov 2019 14:07:46 +0000
Message-ID: <AM5PR1001MB09942731970692EE42BE9CB180740@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20191108174843.11227-1-sebastian.reichel@collabora.com>
 <20191108174843.11227-2-sebastian.reichel@collabora.com>
In-Reply-To: <20191108174843.11227-2-sebastian.reichel@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa2ebec-541b-4b69-d30b-08d766b0878d
x-ms-traffictypediagnostic: AM5PR1001MB1025:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB10253B256FAA612ABA83D430A7740@AM5PR1001MB1025.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(54906003)(186003)(8936002)(81156014)(8676002)(81166006)(110136005)(33656002)(6116002)(3846002)(2906002)(7736002)(478600001)(52536014)(316002)(486006)(71200400001)(71190400001)(86362001)(74316002)(14454004)(25786009)(6436002)(305945005)(66946007)(5660300002)(7696005)(76116006)(76176011)(26005)(476003)(4326008)(53546011)(55236004)(229853002)(66066001)(102836004)(6506007)(66556008)(446003)(9686003)(99286004)(64756008)(66446008)(14444005)(256004)(6246003)(11346002)(66476007)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1025;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76hx0mgrlgtTeVo1hgz55Yksc825db+MDZQ0EiJi6Zx/R8/bRsOUVVz/oPlLwlyCPJXMN/R2hMlTox710dt6bGSN0PdBjhdAQkY3erfP0DYprR2W/0q3mWEhRwA9Lc9rrO3vKTjt6W0icIhhWRQGL9vaFyk/kPg/5TAJ6aGTf6OMcx/5UbS/LmYTBa4nZ0GkG0YFgi3a+4SQBt3l5khoC2BrVVcjNNaRbvMxHv8WjnjC/n43ypc8Pyugvr9vyb2QkYiSjL4CLgaBqdtb31myUMYTz3DsQYctApucBT6AweLqR27drUQ/VF7HOd2eTWG+76ylCHyJQbtHWlTlzeVYNp2IF+meKtCpcdZ2mqV2P3Wih0O1GXKpcJJKwdxjbZuX/CvtswEWJw+qZXrEYGvi5s0X/rPhOjbRxLVeyxz+jY9a2OABPFvKuTxMV88fHj4Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa2ebec-541b-4b69-d30b-08d766b0878d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 14:07:46.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJXAzxwfeGq/SDokGJ8HJiVU8wCMlmE3ZMHmiFjHM3ps4rnDNLESEOxClBVJktwkdujo/TfHi9EXWPgNM8h8hGbflRvVG2jmNv2zGfaZwz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 November 2019 17:49, Sebastian Reichel wrote:

> This adds support for most regulators of da7212 for improved
> power management. The only thing skipped was the speaker supply,
> which has some undocumented dependencies. It's supposed to be
> either always-enabled or always-disabled.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/sound/da7213.txt      |  4 ++
>  sound/soc/codecs/da7213.c                     | 72 +++++++++++++++++++
>  sound/soc/codecs/da7213.h                     |  2 +
>  3 files changed, 78 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/da7213.txt
> b/Documentation/devicetree/bindings/sound/da7213.txt
> index 759bb04e0283..cc8200b7d748 100644
> --- a/Documentation/devicetree/bindings/sound/da7213.txt
> +++ b/Documentation/devicetree/bindings/sound/da7213.txt
> @@ -21,6 +21,10 @@ Optional properties:
>  - dlg,dmic-clkrate : DMIC clock frequency (Hz).
>  	[<1500000>, <3000000>]
>=20
> + - VDDA-supply : Regulator phandle for Analogue power supply
> + - VDDMIC-supply : Regulator phandle for Mic Bias
> + - VDDIO-supply : Regulator phandle for I/O power supply
> +
>  =3D=3D=3D=3D=3D=3D
>=20
>  Example:
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index aff306bb58df..36e5a7c9ac33 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> +#include <linux/pm_runtime.h>
>  #include <sound/soc.h>
>  #include <sound/initval.h>
>  #include <sound/tlv.h>
> @@ -806,6 +807,12 @@ static int da7213_dai_event(struct
> snd_soc_dapm_widget *w,
>   */
>=20
>  static const struct snd_soc_dapm_widget da7213_dapm_widgets[] =3D {
> +	/*
> +	 * Power Supply
> +	 */
> +	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDA", 0, 0),

Having spoken with our HW team, this will cause a POR in the device so we c=
an't
just enable/disable VDD_A supply. Needs to present at all times. How are yo=
u
verifying this?

> +	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDMIC", 0, 0),
> +
>  	/*
>  	 * Input & Output
>  	 */
> @@ -931,7 +938,16 @@ static const struct snd_soc_dapm_widget
> da7213_dapm_widgets[] =3D {
>  static const struct snd_soc_dapm_route da7213_audio_map[] =3D {
>  	/* Dest       Connecting Widget    source */
>=20
> +	/* Main Power Supply */
> +	{"DAC Left", NULL, "VDDA"},
> +	{"DAC Right", NULL, "VDDA"},
> +	{"ADC Left", NULL, "VDDA"},
> +	{"ADC Right", NULL, "VDDA"},
> +
>  	/* Input path */
> +	{"Mic Bias 1", NULL, "VDDMIC"},
> +	{"Mic Bias 2", NULL, "VDDMIC"},
> +
>  	{"MIC1", NULL, "Mic Bias 1"},
>  	{"MIC2", NULL, "Mic Bias 2"},
>=20
> @@ -1691,6 +1707,8 @@ static int da7213_probe(struct snd_soc_component
> *component)
>  {
>  	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
>=20
> +	pm_runtime_get_sync(component->dev);
> +
>  	/* Default to using ALC auto offset calibration mode. */
>  	snd_soc_component_update_bits(component, DA7213_ALC_CTRL1,
>  			    DA7213_ALC_CALIB_MODE_MAN, 0);
> @@ -1811,6 +1829,8 @@ static int da7213_probe(struct snd_soc_component
> *component)
>  				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
>  	}
>=20
> +	pm_runtime_put_sync(component->dev);
> +
>  	/* Check if MCLK provided */
>  	da7213->mclk =3D devm_clk_get(component->dev, "mclk");
>  	if (IS_ERR(da7213->mclk)) {
> @@ -1848,6 +1868,12 @@ static const struct regmap_config
> da7213_regmap_config =3D {
>  	.cache_type =3D REGCACHE_RBTREE,
>  };
>=20
> +static void da7213_power_off(void *data)
> +{
> +	struct da7213_priv *da7213 =3D data;
> +	regulator_disable(da7213->vddio);
> +}
> +
>  static int da7213_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
> @@ -1860,6 +1886,18 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>=20
>  	i2c_set_clientdata(i2c, da7213);
>=20
> +	da7213->vddio =3D devm_regulator_get(&i2c->dev, "VDDIO");
> +	if (IS_ERR(da7213->vddio))
> +		return PTR_ERR(da7213->vddio);
> +
> +	ret =3D regulator_enable(da7213->vddio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&i2c->dev, da7213_power_off,
> da7213);
> +	if (ret < 0)
> +		return ret;

We're seemingly leaving the VDDIO regulator enabled on failure, unless I'm
missing some magic somewhere?

> +
>  	da7213->regmap =3D devm_regmap_init_i2c(i2c, &da7213_regmap_config);
>  	if (IS_ERR(da7213->regmap)) {
>  		ret =3D PTR_ERR(da7213->regmap);
> @@ -1867,6 +1905,11 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>  		return ret;
>  	}
>=20
> +	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
> +	pm_runtime_use_autosuspend(&i2c->dev);
> +	pm_runtime_set_active(&i2c->dev);
> +	pm_runtime_enable(&i2c->dev);
> +
>  	ret =3D devm_snd_soc_register_component(&i2c->dev,
>  			&soc_component_dev_da7213, &da7213_dai, 1);
>  	if (ret < 0) {
> @@ -1876,6 +1919,34 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>  	return ret;
>  }
>=20
> +static int __maybe_unused da7213_runtime_suspend(struct device *dev)
> +{
> +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +
> +	regcache_cache_only(da7213->regmap, true);
> +	regcache_mark_dirty(da7213->regmap);
> +	regulator_disable(da7213->vddio);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused da7213_runtime_resume(struct device *dev)
> +{
> +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D regulator_enable(da7213->vddio);
> +	if (ret < 0)
> +		return ret;
> +	regcache_cache_only(da7213->regmap, false);
> +	regcache_sync(da7213->regmap);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops da7213_pm =3D {
> +	SET_RUNTIME_PM_OPS(da7213_runtime_suspend,
> da7213_runtime_resume, NULL)
> +};
> +
>  static const struct i2c_device_id da7213_i2c_id[] =3D {
>  	{ "da7213", 0 },
>  	{ }
> @@ -1888,6 +1959,7 @@ static struct i2c_driver da7213_i2c_driver =3D {
>  		.name =3D "da7213",
>  		.of_match_table =3D of_match_ptr(da7213_of_match),
>  		.acpi_match_table =3D ACPI_PTR(da7213_acpi_match),
> +		.pm =3D &da7213_pm,
>  	},
>  	.probe		=3D da7213_i2c_probe,
>  	.id_table	=3D da7213_i2c_id,
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 3250a3821fcc..97a250ea39e6 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -12,6 +12,7 @@
>=20
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <sound/da7213.h>
>=20
>  /*
> @@ -524,6 +525,7 @@ enum da7213_sys_clk {
>  /* Codec private data */
>  struct da7213_priv {
>  	struct regmap *regmap;
> +	struct regulator *vddio;
>  	struct clk *mclk;
>  	unsigned int mclk_rate;
>  	int clk_src;
> --
> 2.24.0.rc1

