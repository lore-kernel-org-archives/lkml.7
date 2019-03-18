Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D07C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7474A20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="azdehNiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCRN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:56:43 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:1921 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfCRN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:56:42 -0400
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id EE/48-25691-693AF8C5; Mon, 18 Mar 2019 13:56:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRj22zk7O8oWZ1PxdaXVTOji1maU60c
  QRbSoIPqVMdEzd9oWc46dWcv+WFCpkZcfRg2dlyTCS6Fd0EqtVTYVsdRYGKGS/eiiXUyXSNE5
  O7PsxwfP+zzPe/t4SUzRTShJxuNmXA7ariJicOtmYpv68rVyo7ajg9I/rZ7D9FWTU4R+frRYp
  B+5X03sxA2d3rcSw/mFE4b2phLCMNuefAg/KrY5TPmeHLG1d+CuxFmU6nn/eBovQiXJpSiGxK
  lbGNSV9GF8oKAqRNB4cRYvRdFcMI6gs8bMY4LSge/zF8TjOCoFXoW6cD4Bo7oQDPWGxLwQS+V
  CTWiaEExmaKpqjCSkw8zt+jCPU6nQ3DYj4rGMyoL3008izY5B97VzYT6a2g5vLk2EMaKS4MeZ
  ZozHGJUAY1O1YR4oChofDmECjocP736LBX82XOiZlgh8GgwGp5CAVXD9tVcs4CQYrr0Y4Q/CQ
  H+lhF8GqDEEi93fI0U3wvOZSS6B5LAd5v05Ar0KRgL1IsEfEEND6wIhLJALX2sGI42ToenSJC
  6YXmBw73ZIImyQBnUPvhMC3gTX6z9hFWi9d9ly3mU27zKbN/xhcui7OoXXIbwJ6U0um8XqzqN
  tdrVOq1XrdOnqdC3/tBq6UJ2rYQrUJxnWrdZp6JOshj2Vl2s3axyMux1xt2R29gc6UPUNix8l
  kiJVvExeWG5UrDDlm09Zadaa7SqwM6wfrSJJFcg8DZwmdzEWxnPMZucOckkGUqqKkxG8LGOdd
  B5rswhSP1KTjxomazAF7sh3MMoEmZI3UbzJWuD4W2LprIdRkjJWhqKiohRSJ+PKs7n/1z+iBB
  KpYmVr6rkqUpvD/bfTR24IETfETV94CDf9T1IWod4z375UJsa1+NxrM7f8fPLAWhFY3Fu873D
  QWJLiSzEfUFbsaRnFTUqLUtQxwZbJM+n4oldb546Wbtj9eyw04b8zrzP2JJ2uHsxKPZ4WPLLS
  YSwvk65ovVx2Nqdt17lnll/Pdj40tcozzOm1weCVxfGg2P7y7Y79z1f/yM5oy+hep8JZK63bi
  LlY+g+wOcRO0QMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-18.tower-308.messagelabs.com!1552917397!3777750!1
X-Originating-IP: [104.47.6.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12072 invoked from network); 18 Mar 2019 13:56:38 -0000
Received: from mail-ve1eur02lp2054.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.54)
  by server-18.tower-308.messagelabs.com with AES256-SHA256 encrypted SMTP; 18 Mar 2019 13:56:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHPa/bwGL836C4yHC2Ko+s7REsbbkbCR4tRZQV7+nIw=;
 b=azdehNiElABC995HMkAPRvJ0ZYKwHnB7Ybe9Z+xJ5A6HH2UHJZ3d8uaNla/wOlZYKHnNw76O7HbipMX/xKzveRuCwq3A7WBqlPmNagVmYJt4fFixf52iahslqeDa+HSngdT1QcO51wMKgDAwjHWOuTYX44zoXup88T6PuyUxfsI=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0573.EURPRD10.PROD.OUTLOOK.COM (10.167.201.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 13:56:22 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 13:56:22 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Axel Lin <axel.lin@ingics.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: da9055: Convert to regulator core's
 simplified DT parsing code
Thread-Topic: [PATCH 2/2] regulator: da9055: Convert to regulator core's
 simplified DT parsing code
Thread-Index: AQHU2OsIeQpVIQODOk6u4KOId1z+9aYRUQ8w
Date:   Mon, 18 Mar 2019 13:56:21 +0000
Message-ID: <VI1PR10MB2352F3E21A79E28D0F0EDA85FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190312154759.13774-1-axel.lin@ingics.com>
 <20190312154759.13774-2-axel.lin@ingics.com>
In-Reply-To: <20190312154759.13774-2-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 175c7943-22f5-414b-cf64-08d6aba980f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0573;
x-ms-traffictypediagnostic: VI1PR10MB0573:
x-microsoft-antispam-prvs: <VI1PR10MB0573F9E92A274A2BE8D0DED2F5470@VI1PR10MB0573.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(346002)(136003)(376002)(396003)(189003)(199004)(97736004)(14454004)(8676002)(8936002)(81156014)(81166006)(256004)(446003)(486006)(6116002)(3846002)(53936002)(9686003)(55016002)(7696005)(76176011)(86362001)(26005)(74316002)(7736002)(6916009)(4326008)(476003)(11346002)(305945005)(53546011)(316002)(6506007)(54906003)(102836004)(25786009)(6436002)(229853002)(99286004)(478600001)(186003)(66066001)(33656002)(6246003)(68736007)(71190400001)(71200400001)(106356001)(5660300002)(105586002)(2906002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0573;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iObxuBThUrRkFLhDaEJzO3sZzG8SU1kF0vviwq2sMOdr0r6pxG6c2I4bdmZpjoRVWj7+rM9yKe9ZJ7xS2LIiZnCtuu3Nla1BSkjpwTLmVVcQXSxW1c4YPGifWaWxMmFldziDVOL8V1mNJxrQyfxqlCd0SwrxYQBVtrPPnocjZq0nKQe0Ik0DzPGQaOtPAatgv7dNYir2J9s5QrfAwxCP0/YUDmkAlBB1ZDuuJyxhYbG4nwHlVdpyYyfmltqS/BAQ6bTQF9BPIlv0tVxbwsbBetJAxpWDoMcbMf90vNuMFQgMBo5osbXCvK1tBX2gGo6cqmsLW9/WgDorJMDQPAcWY2I19hhFqYjBZeHb27IejL8mwLENWD6yQE/0NBhVYG6iA66UJ+EV+2vJegwdcJ8gZ6hL8CEsWbY183pnPSmoEfM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175c7943-22f5-414b-cf64-08d6aba980f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 13:56:22.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

For the DA9055, I have spoken with the management here. Dialog Semiconducto=
r are
"no longer building the DA9055"; the device doesn't appear on the support p=
ortal
or website and; I have been told, "you can remove [it] from your list of
supported products".

But, as always: I realise that the Linux community will have different aims=
 and
I would like to support those as much as I can.

There are many reasons to keep supporting the drivers, and not least becaus=
e of
your comments from way-back, in 2014:

On Fri, 14 Feb 2014 14:56:43, Mark Brown wrote:
> We do fairly often see problems with people still using old boards for va=
rious
> reasons [and it] does not mean that the old silicon has been retired by u=
sers
> (even if [it is] just [used] for comparison purposes [...] - "that worked=
 on
> the rev A boards, did we break the software?").

But it does seem that around 97% of this driver has not has not changed sin=
ce
2014, so we are happy here at Dialog to remove our support from this DA9055
device.

Is there a Linux device driver retirement plan for obsoleted products? :)

Regards,
Steve

On 12 March 2019 15:48, Axel Lin wrote:

> To: Mark Brown <broonie@kernel.org>
> Subject: [PATCH 2/2] regulator: da9055: Convert to regulator core's simpl=
ified DT
> parsing code
>=20
> Use regulator core's simplified DT parsing code to simply the driver
> implementation.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/da9055-regulator.c | 67 +++-------------------------
>  1 file changed, 6 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9=
055-
> regulator.c
> index 3c6fac793658..b7b4dddf5509 100644
> --- a/drivers/regulator/da9055-regulator.c
> +++ b/drivers/regulator/da9055-regulator.c
> @@ -338,6 +338,8 @@ static const struct regulator_ops da9055_ldo_ops =3D =
{
>  {\
>  	.reg_desc =3D {\
>  		.name =3D #_id,\
> +		.of_match =3D of_match_ptr(#_id),\
> +		.regulators_node =3D of_match_ptr("regulators"),\
>  		.ops =3D &da9055_ldo_ops,\
>  		.type =3D REGULATOR_VOLTAGE,\
>  		.id =3D DA9055_ID_##_id,\
> @@ -366,6 +368,8 @@ static const struct regulator_ops da9055_ldo_ops =3D =
{
>  {\
>  	.reg_desc =3D {\
>  		.name =3D #_id,\
> +		.of_match =3D of_match_ptr(#_id),\
> +		.regulators_node =3D of_match_ptr("regulators"),\
>  		.ops =3D &da9055_buck_ops,\
>  		.type =3D REGULATOR_VOLTAGE,\
>  		.id =3D DA9055_ID_##_id,\
> @@ -507,59 +511,6 @@ static inline struct da9055_regulator_info
> *find_regulator_info(int id)
>  	return NULL;
>  }
>=20
> -#ifdef CONFIG_OF
> -static struct of_regulator_match da9055_reg_matches[] =3D {
> -	{ .name =3D "BUCK1", },
> -	{ .name =3D "BUCK2", },
> -	{ .name =3D "LDO1", },
> -	{ .name =3D "LDO2", },
> -	{ .name =3D "LDO3", },
> -	{ .name =3D "LDO4", },
> -	{ .name =3D "LDO5", },
> -	{ .name =3D "LDO6", },
> -};
> -
> -static int da9055_regulator_dt_init(struct platform_device *pdev,
> -				    struct da9055_regulator *regulator,
> -				    struct regulator_config *config,
> -				    int regid)
> -{
> -	struct device_node *nproot, *np;
> -	int ret;
> -
> -	nproot =3D of_node_get(pdev->dev.parent->of_node);
> -	if (!nproot)
> -		return -ENODEV;
> -
> -	np =3D of_get_child_by_name(nproot, "regulators");
> -	if (!np)
> -		return -ENODEV;
> -
> -	ret =3D of_regulator_match(&pdev->dev, np,
> &da9055_reg_matches[regid], 1);
> -	of_node_put(nproot);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Error matching regulator: %d\n", ret);
> -		return ret;
> -	}
> -
> -	config->init_data =3D da9055_reg_matches[regid].init_data;
> -	config->of_node =3D da9055_reg_matches[regid].of_node;
> -
> -	if (!config->of_node)
> -		return -ENODEV;
> -
> -	return 0;
> -}
> -#else
> -static inline int da9055_regulator_dt_init(struct platform_device *pdev,
> -				       struct da9055_regulator *regulator,
> -				       struct regulator_config *config,
> -				       int regid)
> -{
> -	return -ENODEV;
> -}
> -#endif /* CONFIG_OF */
> -
>  static int da9055_regulator_probe(struct platform_device *pdev)
>  {
>  	struct regulator_config config =3D { };
> @@ -580,18 +531,12 @@ static int da9055_regulator_probe(struct
> platform_device *pdev)
>  	}
>=20
>  	regulator->da9055 =3D da9055;
> -	config.dev =3D &pdev->dev;
> +	config.dev =3D da9055->dev;
>  	config.driver_data =3D regulator;
>  	config.regmap =3D da9055->regmap;
>=20
> -	if (pdata) {
> +	if (pdata)
>  		config.init_data =3D pdata->regulators[pdev->id];
> -	} else {
> -		ret =3D da9055_regulator_dt_init(pdev, regulator, &config,
> -					       pdev->id);
> -		if (ret < 0)
> -			return ret;
> -	}
>=20
>  	ret =3D da9055_gpio_init(regulator, &config, pdata, pdev->id);
>  	if (ret < 0)
> --
> 2.17.1

