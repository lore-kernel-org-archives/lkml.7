Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A075C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE70C2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="vpDsP0EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfB1P0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:18 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:32599 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731953AbfB1P0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:26:10 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 04/2C-30753-E8DF77C5; Thu, 28 Feb 2019 15:26:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJsWRWlGSWpSXmKPExsWSoc9krNv3tzz
  GYM0ULovPlyewWByZ85XZ4svcUywWUx8+YbN49PYUu8Wp7U1MFt+udDBZXN41h81i+a91LBaf
  3+9ndeDyeH+jld1j56y77B5tP8s8Nq3qZPOY9vsKu8f0Of8ZPe7/OMzkcfzGdiaPz5vkAjijW
  DPzkvIrElgzXs17w17wmbvi0bVFbA2Mi7m6GLk4WATWM0u8etLIAuIICUxgkrj56yQjhHObUe
  LChsNMXYycHGwChhLz3rxnBLFFBJwluna1soHYzAI3mCUWLHEDsYUFUiV2LVvEClGTJtH34AM
  ThG0kMW/BP7B6FgFVibZ1S8BsXoFYiQNfbjKD2EJA9R93XwWbzylgKfFp1kywOYwCshJfGlcz
  Q+wSl7j1ZD7YTAkBAYkle84zQ9iiEi8f/4Oqj5do3/+WHSKuI3H2+hNGCFtJYtmNWawQtqzEp
  fndUHFfif9LHzGDPCwhcItR4vGytVALtCQOz5jICJGYwSvReL+fBSKRI3Fy4UGoSTISS1vuQH
  VfZpW4ubmRHeKdZIkPc89CnSEnsar3IQtE0QVmie07brFA/KMjsWD3J7YJjJqzkLw3C0kKwta
  WWLbwNfMscJAJSpyc+YRlASPLKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXSNdI2NLvcQq3US91FLd
  5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmAqTClker+D8X57+iFGSQ4mJVFenz/lMUJ8Sfkpl
  RmJxRnxRaU5qcWHGGU4OJQkeHeC5ASLUtNTK9Iyc4BJGSYtwcGjJMI7AyTNW1yQmFucmQ6ROs
  Woy3Fg0cO5zEIsefl5qVLivNW/gYoEQIoySvPgRsAyxCVGWSlhXkYGBgYhnoLUotzMElT5V4z
  iHIxKwrynfwJN4cnMK4Hb9AroCCagI3Tvgx1RkoiQkmpg3L4g7f2LCa5cMx2vlC5d7v2Ng49n
  os/961dWJ0xhltu6YUFhVvr+/9sUyybsULHfrWd/YaH56V8LROR/r7i7KPwZR+7jpP3TXH0Cr
  n22KeGyOf5C+Pnp+LwzK5+Xxv2c3ll/ZEo9s9+8f2vySiKMJ+9+ZDH1KJ8es9Gm9Amhmnr3jv
  oqeYb7liuxFGckGmoxFxUnAgDz5Sq2CwQAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-18.tower-223.messagelabs.com!1551367565!1673253!1
X-Originating-IP: [104.47.2.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12873 invoked from network); 28 Feb 2019 15:26:06 -0000
Received: from mail-db5eur01lp2051.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.51)
  by server-18.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 28 Feb 2019 15:26:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9eGNpktD4dm01CtuMZJh7uN1hXwDTCAde7copKl+nc=;
 b=vpDsP0EQjYJL9gAOb2D6z7tVUl3AUDSbkGfS3/faWpubCAf3rZ+rq1tPqqkcJzjx6jV4PNYCbIbwTsv7XBYO+Bu7y/7IHvJ019kEx6Qz5wZTTyJORTVT7ebP8GYXeROFQO1FbDONR7ytOnedw8hSTtx2dYFuOMS7KL7O3F9Cc3s=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1551.EURPRD10.PROD.OUTLOOK.COM (10.165.191.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:26:03 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 15:26:03 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     James Seong-Won Ban <James.Ban.opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/11] regulator: pv88060: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 08/11] regulator: pv88060: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHUz2tSh39R8f1YZEyKtgRcj/8/GqX1PpxA
Date:   Thu, 28 Feb 2019 15:26:03 +0000
Message-ID: <VI1PR10MB235291A7A4492A8481213045FE750@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190228134022.32625-1-axel.lin@ingics.com>
 <20190228134022.32625-9-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-9-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510fda0a-9b37-4ad7-9777-08d69d910d30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1551;
x-ms-traffictypediagnostic: VI1PR10MB1551:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB1551;23:reeFYA5yj+S/fsr4mzDfEZD5V4XZGt6AQ/rKRNqxO?=
 =?us-ascii?Q?TOU8w9fZpcGjDdFiPVTm9/LYfAn+saGDGMm6jPwGfGjxCjxrAKjSmkqJfeXg?=
 =?us-ascii?Q?WUVEWVsgwgRevheVEMo68x6ZSMuMRLMFpWwaR6SBbR0i1xSanGFIgAzsrwuX?=
 =?us-ascii?Q?0xcBCE4gfRr4v63DvZNapKLz1ZdFhxY4fXZxEw4iCacD8FNjp9eOpYRiO1X+?=
 =?us-ascii?Q?ONwBMS/DOtOmjukItpIkic5DQN9odJf5FOYbxAfBRhj/FygmviVlvwUsD3pS?=
 =?us-ascii?Q?5gZDwxzMKL53ZnI+X0rq1RZ1OuMaFNXVJxMZzqALnRJrH40NaBZAyNKWT4xo?=
 =?us-ascii?Q?xeh2Gkt2UNE3ZCevMs/n53QFiAP2yRpjaEO+PuY34saDIe47VhBV5K7DUXb0?=
 =?us-ascii?Q?qd7LEEzAaZOpB/859qjcJtcIbW/nhq0Iiswlpbxf75t7ZZwK4jhWIK4Qtp+e?=
 =?us-ascii?Q?lJdbE8S3REGjZIYpFkKZ9fdh2nExInbXQn+IWxYzAL5Fs5qoOBFq8y8AAPAO?=
 =?us-ascii?Q?88VigmEDDQnxrqDnKHYEeN3iEI2cWiC5X6xMQCOi8YEa0cwyDN6md0E6Kaem?=
 =?us-ascii?Q?HTvflYK5rWeM7QUWq0XOOHwG8kMqTiSq0N8R9xRN4wlVkLARLqPnl03V5Op6?=
 =?us-ascii?Q?jUmz6VzxB2cAKcVgYDdSXukKxGqq3Ykh0PGuTnYn6PMm6JxWqhMxpLa8Wibv?=
 =?us-ascii?Q?QZGyaq98I600HzAYC+lT0Om61xCTCgxBwiLAlF0H371Wc2ffwq8R2X1D5YdM?=
 =?us-ascii?Q?ntJT3CbCzgcRLYKF6HwHwssEuIu6OwGzlnhSLSFKlMB5A2qXOZX4WM+iV5Fx?=
 =?us-ascii?Q?HnpPVpD5el2rm/IgEKTEq27GbsFb4DR2j6DH7yGCW/ucR5KCZxe/eUWiqPMm?=
 =?us-ascii?Q?9sksXJecoHTWeEYUIOPuRlVH5WPE4V+SB7NF3L6NFNE3VoXfnBsbl9v7rvxZ?=
 =?us-ascii?Q?I/1Bkoc4kzk3WpjNs4Ih2kqW9FsTHjUzguOgOcRpO8qd5TveowvLJPZ6CCX2?=
 =?us-ascii?Q?0erQ3h/VQCadbKi+trdZSlB3pHCh6TbcNyiaXNfr0+YoACcHt/L8PXtpU2iw?=
 =?us-ascii?Q?KczXNysDPLQtqi1kSTk2cqL81dCfctYXPxnMaRklWR0pFi/KyjrSK75+MQrh?=
 =?us-ascii?Q?tPL1fdvX7GdSY/hLn9fHSI/vjGtHh5f4It0WUQOWDfZe5zfYi8BLLhOO4qgx?=
 =?us-ascii?Q?DRxl4WonBDMnO7X+eFSUyaa+qPgzXE64Rgek55fBPUXPQuqGWJMtNvJs8ZMF?=
 =?us-ascii?Q?Qspd2fxjIQ+dN7qydk=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB15512CBE25EF09B43E5B2BE4F5750@VI1PR10MB1551.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39850400004)(199004)(189003)(316002)(6116002)(2906002)(3846002)(33656002)(478600001)(25786009)(99286004)(76176011)(4326008)(9686003)(8936002)(186003)(53936002)(53546011)(6506007)(102836004)(55016002)(14454004)(6246003)(54906003)(256004)(110136005)(14444005)(6436002)(7416002)(11346002)(7736002)(66066001)(81166006)(5660300002)(97736004)(229853002)(71190400001)(106356001)(486006)(7696005)(71200400001)(74316002)(446003)(476003)(26005)(8676002)(305945005)(68736007)(86362001)(81156014)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1551;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yDX2Qdyz4C8y/akTnmxzMeyRZOv/oi63ELM/PqWohMOHhnqzx+TceG0Ne+I5JPP0UxQwFw15Qc60F0XEHrIOBr5dWuo0k7A4MG686BTX1E/y18z2xfKmyqV9zQHiyzZtIZk2+TOdHEbN8coO8fCM8LcqFj2u5k2QjKUN4KybySF7BWJRxD+4CWUCKS5z7SXhTBAVzd7+U0gTVtXYfQhcWWL5zhvtW9QZGUL8kt8TcWXiMi2hEFjemM9iaVnB6XiMkAaAsEbx58V31k37FeBELvhANx51VB8AeCQ6BmkaJYVcN4xxWf/f8eYRlUR+tZvziFnvyf64fuWv/zo1Jl8cMWeUqlvaKw4gZ1MpNSQNjkpPrh25lPh1PSKV0lnWFQtPSDQQKMq0KYkZxYxpqk1tMF5yQ8F3JLBSNNNTMEDWyMI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510fda0a-9b37-4ad7-9777-08d69d910d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:26:03.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2019 13:40, Axel Lin wrote:

> Subject: [PATCH 08/11] regulator: pv88060: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.

[...]

Hi Axel,

Looks good to me. Thanks again.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

> @@ -171,8 +133,8 @@ static const struct regulator_ops pv88060_buck_ops =
=3D {
>  	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>  	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>  	.list_voltage =3D regulator_list_voltage_linear,
> -	.set_current_limit =3D pv88060_set_current_limit,
> -	.get_current_limit =3D pv88060_get_current_limit,
> +	.set_current_limit =3D regulator_set_current_limit_regmap,
> +	.get_current_limit =3D regulator_get_current_limit_regmap,
>  };
>=20
>  static const struct regulator_ops pv88060_ldo_ops =3D {
> @@ -207,10 +169,11 @@ static const struct regulator_ops pv88060_sw_ops =
=3D {
>  		.enable_mask =3D PV88060_BUCK_EN, \
>  		.vsel_reg =3D PV88060_REG_##regl_name##_CONF0,\
>  		.vsel_mask =3D PV88060_VBUCK_MASK,\
> +		.curr_table =3D limits_array,\
> +		.n_current_limits =3D ARRAY_SIZE(limits_array),\
> +		.csel_reg =3D PV88060_REG_##regl_name##_CONF1,\
> +		.csel_mask =3D PV88060_BUCK_ILIM_MASK,\
>  	},\
> -	.current_limits =3D limits_array,\
> -	.n_current_limits =3D ARRAY_SIZE(limits_array),\
> -	.limit_mask =3D PV88060_BUCK_ILIM_MASK, \
>  	.conf =3D PV88060_REG_##regl_name##_CONF1,\
>  }
>=20
> --
> 2.17.1

