Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C732133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="RtY3qydj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfB1Pln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:41:43 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:1258 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727858AbfB1Pln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:41:43 -0500
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id 91/6D-01080-331087C5; Thu, 28 Feb 2019 15:41:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTb0wbZRzue/96kN54d93sbw2Q2GRbmFylGMl
  F+GBiNJfI4uJHghkHvbWXlYK9IsUvblO2wSQSDZurZaDrcOLmtC6hbDNM5v7Asih/IohjjFmN
  YxC2FeemBuz1ujm/Pfk9z/v8nufN+7Ikf5uxs0ooqAT8ss/BZFPep+lSoRiFKovOf+UQk2Ptl
  Phd5A9SXOocpsSO2QQj3lgYNovDfbsI8d74XkIcOxVhxE//+oISk4sD9PPZ0uJks1nqD0+bpd
  0P3pBivS2MtP/vcbN0ILKCpJn75wjp4mQfISVj+VuyKmjVX10XqqK93T/eQPV3V4WOjl+jd6A
  ZSyvKZil8goSe6CG6FWWxPG4nYCC+XSd4/DOCC9NTjE4w2AWH5heRjtfgF6D1VHN6TuJJErqj
  L+nYihW4uu9WyohNabbB8lyZIS+G+Yk+QscUXg8jXR1mHXP4NWjbP2829nrg8J2Dacss/Bzcv
  H42nQfhPFja+TlprLLBVKIr7QMYQ/TM96SB18LNX5Yz+q2wZ2DBbMwL4cpEAhnYAT2TYdrAeT
  DatS8z3wy73utj9L6ApxBE3387nR/wJvisY52h+ZCD+EiZgX0QbXk3czYXjrxzNZNhjIbdKyV
  Glxq43XklkyEfettmKcP/BxKWlw7QRplC6D59l2lHBeHHuoUfowz8FPR8fIsMp+9rNQwdTFDd
  iOpFJdUB1eMN1sqqT3AVFQkuV7FQXOQSnnHKbwo1TqVBaFS0oOByyo2aU2uqrfG5nX4lGEOp1
  +euHyLj6LejnkG0jiUca7nyfxor+VXVde4mr6x5twYafIo2iHJZ1gFcz0qKWx1QPEpom+pLPe
  GHNLAWxxquXac5rV6u1VSPQQ0jgT37yWwnyVP+Or9it3EvmkKVPNZF3gb/I4uHH2EU5dmtHDK
  ZTLylXgnUqsH/83PIxiKHlbv8ILXKovqDjzbNpUIQqRDCTDpEUP6Psu9Azes/2tOy2f7TKwWv
  JvuHLC5/6PoJtc2XE855q3ykwlk+cOfc74lLK03zv5oSFsVaWmLjI9LxnZfctuTLg2VbyBg8M
  f3ln2pB/t5vNsQRDm48fT8ykbvx2VHC9GRprD/nWsXC169f/pa6WDjxQX/VPTF+jO8s297irm
  oLHT95WLY6KM0ruzaRAU3+F7+vu1MDBAAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-308.messagelabs.com!1551368497!2382924!1
X-Originating-IP: [104.47.5.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14515 invoked from network); 28 Feb 2019 15:41:38 -0000
Received: from mail-he1eur02lp2059.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.59)
  by server-20.tower-308.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 28 Feb 2019 15:41:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBMCTpqyauMlmTDlwXQqV2PyI+MosIj4i0W2V1HQAY4=;
 b=RtY3qydj23t6BtrbzE2u6l8g3m9DNVK+v875J655QPyzcJ9PS3e/EnqLi/v/1b9LMk2l+5cuedvZvYpqOU38bA4VLZdr80LGZzXLIQ0rxv8uxNaW5sI0YreWfd0oklbgTifYIdyVJdeTlbFLXMD1mAmxndbnpfn5oIsiPiuYARw=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2750.EURPRD10.PROD.OUTLOOK.COM (20.178.127.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 15:41:27 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 15:41:27 +0000
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
Subject: RE: [PATCH 09/11] regulator: pv88080: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 09/11] regulator: pv88080: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHUz2tTsxnBcshZF0Kcd/8f9CT21qX1Pxug
Date:   Thu, 28 Feb 2019 15:41:27 +0000
Message-ID: <VI1PR10MB2352E636D2F84B09511B4D9AFE750@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190228134022.32625-1-axel.lin@ingics.com>
 <20190228134022.32625-10-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-10-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e78e493b-f8d0-4c72-52b7-08d69d933419
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2750;
x-ms-traffictypediagnostic: VI1PR10MB2750:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2750;23:e0cJwyT08HO+g8Iy4tykUTx/oZc2Z2Sa8BIo1MHUY?=
 =?us-ascii?Q?3jPDOr2uO0m0OIqYSlaR66B4187XUmBAiE6b1NIiKhvfn1FNgXJzPaSfMLbr?=
 =?us-ascii?Q?Kkxm2iGsCySYCliMDPNjyUqWyvYH1oIunFLA08QOYRmH6DvY+smMvUC/aQvA?=
 =?us-ascii?Q?2VCztKBZ4g+7/BCxad2FWLVJGQe4KA/quVwqCyInIon2gC5N4YNug+crxCcY?=
 =?us-ascii?Q?kbxPpI2Zh6KESBTeI7FrhlIp0Fi4PK6vYszZB+iOcmWoTodbHtOH/kB6BpZU?=
 =?us-ascii?Q?ofHKSyKhwslYf68QbrvEdpnUi65ttRpkCYPH6Fsia+BqYAwjQrYuZmQ6dvlf?=
 =?us-ascii?Q?ybVkemPAqOrhqzt9jMAFzz2jivYyXPqsTMqiPlXeqdjxvcQwk+B9nknbp8At?=
 =?us-ascii?Q?kPmOlaJAb6nYawn1lU+g/b9MerwSgcUT1myYyWeb7PEEXIoIUOVjJn3ezoQK?=
 =?us-ascii?Q?qV9hvasEN59PSQ4DgxiVuFYaAu063ji59nGB6sAAIwcMPiisdD99oudjzIpH?=
 =?us-ascii?Q?FQ7o1e04luCawoVuHd9Bb1jW43wz5CrUruoUCU6AKxgdpHx/qb3+8teNEuG+?=
 =?us-ascii?Q?05N1SKXYqngH+QNKKk6KGSAkDQAF+HwjNGDFM/mH4eyPWPk8QcbukyHk+apc?=
 =?us-ascii?Q?W5SAxzqGmTsDGTdse3yNemZWZgHePnJxEpyqRZysJjInzmz40haYIjn7E2ec?=
 =?us-ascii?Q?WsmRHsiii9Ofs8R9DpbBdlkMe7NyrxnwcEnjhqsSrxJWv4nb1CpcXflYw5ww?=
 =?us-ascii?Q?y1SLx//3/xwEIpsAQprthLKHzw2FyGj1rdhkQpdyB24SLpMEP1DC/b/Dkxk1?=
 =?us-ascii?Q?5xvHvx2UJfRNXbLsGKA2z0v8mI4bqq6naZhKv7zqjcXONLMWCYQS6PhHt9sP?=
 =?us-ascii?Q?YFZEKDnOXI3IbwU/DmbcNaE91HgNyupTRtJF9MO/jkwmwLB7nCtS9cGiLY06?=
 =?us-ascii?Q?1IBGCBTl29qiOmsZcs6P+xibIr7Q2cYcEIf4fYquvO8m52165Vb9DEZsix6R?=
 =?us-ascii?Q?c4jVn3fxUHubLlJzwu3YIOWDPXAuh54f0KjzbmcblfR/w1dCpcMbOYHJFn9L?=
 =?us-ascii?Q?KZcH8d/3P8Whgz+KrimwI0ZVA6ixRm4l6m3DNaULM08qJmWzrIwIdvPD8JQd?=
 =?us-ascii?Q?kK4/whY/kPfkAulLbMfDhm9mTAAuY1F9uxL/6mHkPFUWJrC+jQEq0t0w+azd?=
 =?us-ascii?Q?09fvPIfXdEoPKjt+jItJo3Hnqw/2LywfLKCnGZkRQV3vR00lMjvvSEaKCwFf?=
 =?us-ascii?Q?q/baTlet77SSRdHkIQ=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB275091066836D667053A24E8F5750@VI1PR10MB2750.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39850400004)(189003)(199004)(8936002)(7736002)(5660300002)(26005)(68736007)(305945005)(8676002)(81156014)(81166006)(66066001)(53936002)(186003)(6436002)(99286004)(229853002)(102836004)(33656002)(74316002)(76176011)(316002)(6506007)(53546011)(97736004)(54906003)(110136005)(71200400001)(71190400001)(478600001)(6246003)(7416002)(446003)(106356001)(105586002)(3846002)(11346002)(6116002)(2906002)(14444005)(86362001)(9686003)(55016002)(7696005)(4326008)(14454004)(476003)(486006)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2750;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bEUaUYkDNf/UXWjUzHxDXdAHtioXwNIrfi2fHuvOoJRiXrEJ0QJHPcAsNS2s2yX3xpoSlh3vWlbVnLXRBUuFmzdRHCQ4bNTaamc2q7BZWpIsWKPy+YtovMmo16IK23ObvHCCKJSVwS63P1LfevnYnnSybY4B0Qg5GHWWPRNfY8sQvw9dBupTriuziDzA/v8uwmqQRRudfJlX0aw7+SWqX9M+x0NURTv03gAsp3XJAH1ZfQxU0oVpDm1WI87rDCI+oRozuMis9Yfd5sBe0M6KdXGR+sfMWl+4u0lHraqWDeh+rwwLGrWBjP95HopuOH2EX+mC7FmEJ39PXtGJRkT/NZ3Rxhxdb681LuRvIzDQR45yo/2L/WSCBxcJ6nNJjPlSduzgDRncunKQf9wAPIJnnppbv+0TPGr+gFNJopUfvCI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e493b-f8d0-4c72-52b7-08d69d933419
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:41:27.8591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2019 13:40, Axel Lin wrote:

> Subject: [PATCH 09/11] regulator: pv88080: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.

[...]

Hi Axel,

Looks good to me. Thanks again.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

[...]

> @@ -315,8 +276,8 @@ static const struct regulator_ops pv88080_buck_ops =
=3D {
>  	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>  	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>  	.list_voltage =3D regulator_list_voltage_linear,
> -	.set_current_limit =3D pv88080_set_current_limit,
> -	.get_current_limit =3D pv88080_get_current_limit,
> +	.set_current_limit =3D regulator_set_current_limit_regmap,
> +	.get_current_limit =3D regulator_get_current_limit_regmap,
>  };

[...]

>=20
>  static const struct regulator_ops pv88080_hvbuck_ops =3D {
> @@ -341,9 +302,9 @@ static const struct regulator_ops pv88080_hvbuck_ops =
=3D {
>  		.min_uV =3D min, \
>  		.uV_step =3D step, \
>  		.n_voltages =3D ((max) - (min))/(step) + 1, \
> +		.curr_table =3D limits_array, \
> +		.n_current_limits =3D ARRAY_SIZE(limits_array), \
>  	},\
> -	.current_limits =3D limits_array, \
> -	.n_current_limits =3D ARRAY_SIZE(limits_array), \
>  }
>=20
>  #define PV88080_HVBUCK(chip, regl_name, min, step, max) \
> @@ -521,9 +482,9 @@ static int pv88080_i2c_probe(struct i2c_client *i2c,
>  		if (init_data)
>  			config.init_data =3D &init_data[i];
>=20
> -		pv88080_regulator_info[i].limit_reg
> +		pv88080_regulator_info[i].desc.csel_reg
>  			=3D regmap_config->buck_regmap[i].buck_limit_reg;
> -		pv88080_regulator_info[i].limit_mask
> +		pv88080_regulator_info[i].desc.csel_mask
>  			=3D regmap_config->buck_regmap[i].buck_limit_mask;
>  		pv88080_regulator_info[i].mode_reg
>  			=3D regmap_config->buck_regmap[i].buck_mode_reg;
> --
> 2.17.1

