Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="HD7wbnfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKUVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:15:14 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.70]:61382 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfKUVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:15:14 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-west-1.aws.symcld.net id E3/A2-28136-B5EF6DD5; Thu, 21 Nov 2019 21:15:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRWlGSWpSXmKPExsWSoc9hqhv171q
  swZ2LahZXLh5ispj68AmbxeZzPawW3650MFlc3jWHzaJzVz+rxd3XfhYbvq9ldODw2PC5ic1j
  x90ljB47Z91l99i0qpPNY9/bZWwe67dcZfH4vEkugD2KNTMvKb8igTXj8eKZbAUNlhVtZ14xN
  zBu0+9i5OJgFFjKLDH34W1WCOcYi8T+x4eZIJzNjBK/e3+ygTgsAieYJd5ff8sM4ggJTGOSuH
  97G1APJ5DzkFGi/5k1iM0mYCEx+cQDsA4RgZeMEld3zAAbzCzwkVHiyJ1zYB3CAnYSX5r3M4L
  YIgL2Ep0f37ND2EYS6/6fZwGxWQRUJTadfwZm8wokSpya848NYluNxINrV8FsTgEXic8bjoPN
  YRSQlfjSuJoZxGYWEJe49WQ+E4gtISAgsWTPeWYIW1Ti5eN/rBD1qRInm24wQsR1JM5efwJlK
  0rc2ngZql5W4tL8bqi4r8TUr8fZYeqfPH3NCmFbSCzpbgW6kwPIVpH4d6gSIlwg8XLZFGaIsJ
  rEm22BEGEZiesPj4DDR0LgMatEz+9HjBMY9WchuRrC1pFYsPsTG4StLbFs4WvmWeCQEJQ4OfM
  JywJGllWM5klFmekZJbmJmTm6hgYGuoaGRrqGlha6JiZ6iVW6SXqppbrlqcUluoZ6ieXFesWV
  uck5KXp5qSWbGIHJLaXgmM4Oxmmf3uodYpTkYFIS5Z2qfC1WiC8pP6UyI7E4I76oNCe1+BCjD
  AeHkgTv/hagnGBRanpqRVpmDjDRwqQlOHiURHgfNAGleYsLEnOLM9MhUqcYdTkmvJy7iFmIJS
  8/L1VKnLeqGahIAKQoozQPbgQs6V9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzLBHIJT2Z
  eCdymV0BHMAEdsXHtJZAjShIRUlINTPPNvxqYiczbfjT/3uE1lx+oH51yt31u7/XDNYyWf15N
  E+F7wDD9y5Zt1usL1paVZYoX5xjU2/bG5rdOzwnVOjDHOt5wps/ZpNBy9RtL2g2PJ7xe0O3XG
  L2bOWPbgtOLHI1CZxjMmR7wbMna5dsCky1uGET6uX2UvZ2+9U3827crn/mWbHO6Y69hr/R109
  NXm91fignrGLh6xp/1uG3Jr+VaOm+HRZHaSZ7pVz5MbWDOveEccyzHNj5Kp3P3zcBGy9eGBzL
  azC95dNx6L7PA/dqpLrmXq1cn+fwI21IVYLOkt+gHV23IrPtSP6MY0v3ynU/0TintYVioc+O3
  xoH3f8vXx3EGLHnwyC2ki+3jaSWW4oxEQy3mouJEAI9N69x1BAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-288.messagelabs.com!1574370905!77362!1
X-Originating-IP: [104.47.8.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13215 invoked from network); 21 Nov 2019 21:15:06 -0000
Received: from mail-am5eur03lp2053.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.53)
  by server-18.tower-288.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Nov 2019 21:15:06 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE9mKvc2RW6B2VdTg4WFyRtraATDZ9jb2bHqvQBkolUNyzd9o4YlrEHZDlXdcClAx2SIBzlb2eFcSEh0ZsRdolj2h8lPN27MQbp6Z1If5ALQnV9XEaVoFRWet0BSRnFl5n4mI2NJrQ8cf7gtaxeoEgSUMX4ghLCDQl8gR+hpLsnHAslEf20DRgPCBCBtPX2HWZq4OYKPMEv+eF3V2Ui40TmI38wKzF/WxYhYop2LeI992u4sFohOS0RAfPj5Bnc3SEg9BfQ6IPcAOIK/E2HkaaDFNHic+V+tTT38ifOxZqNagMZ9JLKhfYgQ6z4lRxwtqvz3rkD1hvYSkZdAnp7LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K42ig1GLZFloucKTm6mm8TPOsu77UUpru2ZPxWslpu0=;
 b=d0GKKSfdjkddPgJfAzL4Do1OKZ1JqZpDV4fplV9U0Pfz/usRxsn1qajSGz3RyZgStI1hDesoLuBA19b1pSBlfL9SiC9ExNm/bJStSSNfrrlwuyjzwPASaGKonx2qI0OeozexDzk6+3rSJ9OsgXMOVOASN4Lw2H2y22UlgJNQCIF71l1bouDv+ChaOS1ANWE7R4ECzMxLZ1FJ/rFO50+8Htj0E+doi0bRZhsiBFAcAfLCCpqGDLJo6UbS73eZAgP0QGqRbZkDO8LFaq7G7Ea4gif3twXZ5u8DNQKpvpK+EnktVLJnzn1fZyexjBykyA2SMKpGQcbUZKqf1wwP2wvjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K42ig1GLZFloucKTm6mm8TPOsu77UUpru2ZPxWslpu0=;
 b=HD7wbnfaeJVJgSEj/2eq1lVl7ki/F8MwXQZne317BXNTi8ou50Qjn3bQO758kNj2lKL/Qx0iYT503MaCfTLw+kVh6fWmlMLojbzbMoWsQdK1RjkdxFo/lO1ifmxzLRI76fpNbpJZUq/InxEF2lpMG5fASTpddOLArSQNujPE6P8=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB0964.EURPRD10.PROD.OUTLOOK.COM (10.169.154.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 21:15:03 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df%7]) with mapi id 15.20.2474.021; Thu, 21 Nov 2019
 21:15:02 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCHv2 2/6] ASoC: da7213: Add regulator support
Thread-Topic: [PATCHv2 2/6] ASoC: da7213: Add regulator support
Thread-Index: AQHVn7aUUebhVdnv70SSWjcAgccCf6eWEA7Q
Date:   Thu, 21 Nov 2019 21:15:02 +0000
Message-ID: <AM5PR1001MB09945AE319B4ED33C193ABE9804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-3-sebastian.reichel@collabora.com>
In-Reply-To: <20191120152406.2744-3-sebastian.reichel@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bf5af0b-21a5-4582-55b2-08d76ec7dfe2
x-ms-traffictypediagnostic: AM5PR1001MB0964:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB09648E790028350AED78BA80A74E0@AM5PR1001MB0964.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39850400004)(346002)(376002)(366004)(189003)(199004)(9686003)(71190400001)(11346002)(256004)(14444005)(446003)(305945005)(81166006)(81156014)(99286004)(102836004)(26005)(316002)(110136005)(8676002)(8936002)(74316002)(66066001)(33656002)(7696005)(229853002)(7736002)(55236004)(6246003)(76176011)(6436002)(55016002)(71200400001)(66476007)(66556008)(64756008)(66446008)(25786009)(66946007)(86362001)(3846002)(6116002)(14454004)(4326008)(6506007)(53546011)(186003)(478600001)(52536014)(76116006)(5660300002)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0964;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGW+Ajk65czJGPm3vpPgropACtrM/RcIJTTLFW5AKgArk7lW3jeQlX7tRgx2aJ8cxP11Wzm+Ooo559imOvCqqGnbfflAv0UywJ9w38zo6/j9DgMDylbLxJzv02CtSE4XEvc86A8uGWCYLs5vG1buZyyTtp9HVEOjdL54gOSIe8aEZwdx95i28dIuhpLZxD+rlPWevDn7kuuiUzFuPVnNxvaoa88OoX6Y23XV6mTUo8JyQh6nc4AB0HsazMYyeu90IUhrQ3pqRxFVnsG4USQlGVwiyUBjQJEE35Uuxhs0FgGURBQyIajN/sb65dA4b5d3RLjZz7DmvDhEECLuUJy9BEQTy1ezAMRmJ5VaM9dVRpag0VsBmah65AQqYrN+z+68aoae2T6k/n+KFYtxs3JWZTXOULfdGns61MRZoD6/hdVigCD8cHOSXHWCa08B2C4Y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf5af0b-21a5-4582-55b2-08d76ec7dfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 21:15:02.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snE6p4UGpowsQSXo/ZliIZVWbo4wv7yifF+LnpS3ECwzFVmhoBqq1dp15YII5nWpAonHyYSD3DLfz7g6Quswwvcv+6N59tAL9Rox8W8JXcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 November 2019 15:24, Sebastian Reichel wrote:

> This adds support for most regulators of da7212 for improved
> power management. The only thing skipped was the speaker supply,
> which has some undocumented dependencies. It's supposed to be
> either always-enabled or always-disabled.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/sound/da7213.txt      |  4 +
>  sound/soc/codecs/da7213.c                     | 79 ++++++++++++++++++-
>  sound/soc/codecs/da7213.h                     |  9 +++
>  3 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/da7213.txt
> b/Documentation/devicetree/bindings/sound/da7213.txt
> index 759bb04e0283..cc8200b7d748 100644
> --- a/Documentation/devicetree/bindings/sound/da7213.txt
> +++ b/Documentation/devicetree/bindings/sound/da7213.txt
> @@ -21,6 +21,10 @@ Optional properties:
>  - dlg,dmic-clkrate : DMIC clock frequency (Hz).
>  	[<1500000>, <3000000>]
>
> + - VDDA-supply : Regulator phandle for Analogue power supply
> + - VDDMIC-supply : Regulator phandle for Mic Bias
> + - VDDIO-supply : Regulator phandle for I/O power supply
> +
>  =3D=3D=3D=3D=3D=3D
>
>  Example:
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index aff306bb58df..0359249118d0 100644
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
> @@ -806,6 +807,11 @@ static int da7213_dai_event(struct
> snd_soc_dapm_widget *w,
>   */
>
>  static const struct snd_soc_dapm_widget da7213_dapm_widgets[] =3D {
> +	/*
> +	 * Power Supply
> +	 */
> +	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDMIC", 0, 0),
> +
>  	/*
>  	 * Input & Output
>  	 */
> @@ -932,6 +938,9 @@ static const struct snd_soc_dapm_route
> da7213_audio_map[] =3D {
>  	/* Dest       Connecting Widget    source */
>
>  	/* Input path */
> +	{"Mic Bias 1", NULL, "VDDMIC"},
> +	{"Mic Bias 2", NULL, "VDDMIC"},
> +
>  	{"MIC1", NULL, "Mic Bias 1"},
>  	{"MIC2", NULL, "Mic Bias 2"},
>
> @@ -1691,6 +1700,8 @@ static int da7213_probe(struct snd_soc_component
> *component)
>  {
>  	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
>
> +	pm_runtime_get_sync(component->dev);

It seems that this function can return errors, although I do see lots of
instances of this being called where the return value isn't checked. Not ha=
d
time to walk the code fully but are we sure no errors are going to happen h=
ere?

> +
>  	/* Default to using ALC auto offset calibration mode. */
>  	snd_soc_component_update_bits(component, DA7213_ALC_CTRL1,
>  			    DA7213_ALC_CALIB_MODE_MAN, 0);
> @@ -1811,6 +1822,8 @@ static int da7213_probe(struct snd_soc_component
> *component)
>  				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
>  	}
>
> +	pm_runtime_put_sync(component->dev);

Same question here.

> +
>  	/* Check if MCLK provided */
>  	da7213->mclk =3D devm_clk_get(component->dev, "mclk");
>  	if (IS_ERR(da7213->mclk)) {
> @@ -1848,11 +1861,22 @@ static const struct regmap_config
> da7213_regmap_config =3D {
>  	.cache_type =3D REGCACHE_RBTREE,
>  };
>
> +static void da7213_power_off(void *data)
> +{
> +	struct da7213_priv *da7213 =3D data;
> +	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
> +}
> +
> +static const char *da7213_supply_names[DA7213_NUM_SUPPLIES] =3D {
> +	[DA7213_SUPPLY_VDDA] =3D "VDDA",
> +	[DA7213_SUPPLY_VDDIO] =3D "VDDIO",
> +};
> +
>  static int da7213_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
>  	struct da7213_priv *da7213;
> -	int ret;
> +	int i, ret;
>
>  	da7213 =3D devm_kzalloc(&i2c->dev, sizeof(*da7213), GFP_KERNEL);
>  	if (!da7213)
> @@ -1860,6 +1884,25 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>
>  	i2c_set_clientdata(i2c, da7213);
>
> +	/* Get required supplies */
> +	for (i =3D 0; i < DA7213_NUM_SUPPLIES; ++i)
> +		da7213->supplies[i].supply =3D da7213_supply_names[i];
> +
> +	ret =3D devm_regulator_bulk_get(&i2c->dev, DA7213_NUM_SUPPLIES,
> +				      da7213->supplies);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to get supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213-
> >supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&i2c->dev, da7213_power_off,
> da7213);
> +	if (ret < 0)
> +		return ret;
> +
>  	da7213->regmap =3D devm_regmap_init_i2c(i2c, &da7213_regmap_config);
>  	if (IS_ERR(da7213->regmap)) {
>  		ret =3D PTR_ERR(da7213->regmap);
> @@ -1867,6 +1910,11 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>  		return ret;
>  	}
>
> +	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
> +	pm_runtime_use_autosuspend(&i2c->dev);
> +	pm_runtime_set_active(&i2c->dev);

Again this can return an error. Are we certain this won't fail?

> +	pm_runtime_enable(&i2c->dev);
> +
>  	ret =3D devm_snd_soc_register_component(&i2c->dev,
>  			&soc_component_dev_da7213, &da7213_dai, 1);
>  	if (ret < 0) {
> @@ -1876,6 +1924,34 @@ static int da7213_i2c_probe(struct i2c_client *i2c=
,
>  	return ret;
>  }
>
> +static int __maybe_unused da7213_runtime_suspend(struct device *dev)
> +{
> +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +
> +	regcache_cache_only(da7213->regmap, true);
> +	regcache_mark_dirty(da7213->regmap);
> +	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused da7213_runtime_resume(struct device *dev)
> +{
> +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213-
> >supplies);
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
> @@ -1888,6 +1964,7 @@ static struct i2c_driver da7213_i2c_driver =3D {
>  		.name =3D "da7213",
>  		.of_match_table =3D of_match_ptr(da7213_of_match),
>  		.acpi_match_table =3D ACPI_PTR(da7213_acpi_match),
> +		.pm =3D &da7213_pm,
>  	},
>  	.probe		=3D da7213_i2c_probe,
>  	.id_table	=3D da7213_i2c_id,
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 3250a3821fcc..3890829dfb6e 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -12,6 +12,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <sound/da7213.h>
>
>  /*
> @@ -521,9 +522,17 @@ enum da7213_sys_clk {
>  	DA7213_SYSCLK_PLL_32KHZ
>  };
>
> +/* Regulators */
> +enum da7213_supplies {
> +	DA7213_SUPPLY_VDDA =3D 0,
> +	DA7213_SUPPLY_VDDIO,
> +	DA7213_NUM_SUPPLIES,
> +};
> +
>  /* Codec private data */
>  struct da7213_priv {
>  	struct regmap *regmap;
> +	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
>  	struct clk *mclk;
>  	unsigned int mclk_rate;
>  	int clk_src;
> --
> 2.24.0
