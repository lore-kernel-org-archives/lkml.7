Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B76E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="c99/TytD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbfB1PrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:47:12 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:31202 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfB1PrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:47:11 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 1E/AC-04122-C72087C5; Thu, 28 Feb 2019 15:47:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRWlGSWpSXmKPExsWSoc9oplvNVBF
  j0HRX2+Lz5QksFkfmfGW2+DL3FIvF1IdP2CwevT3FbnFqexOTxbcrHUwWl3fNYbNY/msdi8Xn
  9/tZHbg83t9oZffYOesuu0fbzzKPTas62Tym/b7C7jF9zn9Gj/s/DjN5HL+xncnj8ya5AM4o1
  sy8pPyKBNaMfdOXsxYs4ak4ue8sYwPjRa4uRi4OFoH1zBKtsz+zgjhCAn1MEs0fVrJBOLcZJV
  Zd/Q/kcHKwCRhKzHvznhHEFhFwluja1QoWZxa4wSyxYIkbiC0skCqx/cEBFoiaNInvT45C1Rt
  J/N9/CyzOIqAqcfhLB9A2Dg5egViJrbuyQcJCAukSp48uBxvJKWAl8fTtcbBWRgFZiS+Nq5kh
  VolL3HoynwnElhAQkFiy5zwzhC0q8fLxP1YIW0fi7PUnjBC2ksSyG7Og4rISl+Z3Q8V9JZ52f
  GSBsG8xSmw4VQNha0lM/bueHeR3CYFVvBKvHi5kh0jkSDw7shaqWUZiacsdZoiiO6wSKyY/Yo
  P4IFniw9yz7BBXx0u0738L1Swnsar3IQvIwxICF5gl1spAPKMjsWD3J7YJjJqzkPw2C0kKwta
  WWLbwNTOIzSsgKHFy5hOWBYwsqxjNk4oy0zNKchMzc3QNDQx0DQ2NdA0tjXVNjPUSq3QT9VJL
  dctTi0t0DfUSy4v1iitzk3NS9PJSSzYxAtNfSsFB7R2MT5anH2KU5GBSEuX1+VMeI8SXlJ9Sm
  ZFYnBFfVJqTWnyIUYaDQ0mCl52xIkZIsCg1PbUiLTMHmIhh0hIcPEoivO8YgNK8xQWJucWZ6R
  CpU4y6HAcWPZzLLMSSl5+XKiXOOx9khgBIUUZpHtwIWFa4xCgrJczLyMDAIMRTkFqUm1mCKv+
  KUZyDUUmY9/RPoCt5MvNK4Da9AjqCCegI3fvlIEeUJCKkpBoYTSKLi3+8W8FZmd9/epv/+2kT
  3dZvneMYZCctZaU2wUsn//lC9Qs952dMPZJx8srUfxMe815wFbm76XaBd5hp66UpTK8qwgUdP
  mgr3avO1jf3Xiwdy2Z+JsqJt2DD0cVf2+9a7qvbbda8/kPyhz2S/gx79uVsTt/08l6N2iRP7Z
  en0xk9vbX/KbEUZyQaajEXFScCACzfquYFBAAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-13.tower-262.messagelabs.com!1551368827!2084191!1
X-Originating-IP: [104.47.1.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30686 invoked from network); 28 Feb 2019 15:47:07 -0000
Received: from mail-ve1eur01lp2054.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.54)
  by server-13.tower-262.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 28 Feb 2019 15:47:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMXeBpMRZeYJeGuLPvS9gDU6ayralDBU53B4r3Ki3Ak=;
 b=c99/TytDxJmy2x/OdElxNln+s/HKkH1AM2kpaKO37tnkeir03K99MMlmdPo5USsq+RWpB7R2aiRKdqk4VitUUPFZoYihRrGXb+IsSSrOz9qAMZOJNMvkOWKh5hX+CoKaqpRrheBHhe+sH8gaauYv1vszM30+jAAZKjmbsmwFXno=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2080.EURPRD10.PROD.OUTLOOK.COM (52.134.29.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 15:47:02 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 15:47:02 +0000
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
Subject: RE: [PATCH 10/11] regulator: pv88090: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 10/11] regulator: pv88090: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHUz2tXZlP2bQh/P02OdILaHOUfh6X1P8dg
Date:   Thu, 28 Feb 2019 15:47:02 +0000
Message-ID: <VI1PR10MB2352F9511D9C37177FCF634DFE750@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190228134022.32625-1-axel.lin@ingics.com>
 <20190228134022.32625-11-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-11-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdf7664d-c16e-46d1-13e2-08d69d93fbc1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2080;
x-ms-traffictypediagnostic: VI1PR10MB2080:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2080;23:leDqwCsbd6XiJNXM3AehX3hd2NcPBTqTPx/gC9j6x?=
 =?us-ascii?Q?Lrja3BhFaCgcPz9RhUeP/jebNDHxcx5hjZPmZVAx0mrsxL/AeqW98SwWVfwc?=
 =?us-ascii?Q?b2Ozugyn2m8DQnAOsj4kWo9yb32qsxVUM2wEj/LYbc3v0ZKf1S7pk3BSYYYi?=
 =?us-ascii?Q?IFwKFaXZhWTkMf7e7QFqZs4v6ELX+qBwiKjS9I4X8eZe/b/n/0sSVmnNoyLt?=
 =?us-ascii?Q?DDAYNnnhv0wRqahRImzZD4Eg9UDSd97RsZaQ9aDg6+ZsMwbUB1v1OqJXfreH?=
 =?us-ascii?Q?rvTBWX5pKqxEcmfzPzGXzO4cVJpfEkG8pAZaYgyFETs1pQmqa0c7BY+LyWXC?=
 =?us-ascii?Q?HqQ7Joo0EhuD2+fpVxE0brIkyZg+josUEKoL3NmLaeo0w6XSgfhdQpxw2rWS?=
 =?us-ascii?Q?WkpWEUhZM8Yn91SCBH3DWabpThbRfOX37VPMtNu7Wy4DKduT4ZlghSKn1WvE?=
 =?us-ascii?Q?6JJk6w8Yt/DhY6o91WZsMyYGN2rwQrCdVx+v4LfHXcOl9VEhjZDr3SFaKt0K?=
 =?us-ascii?Q?Peih/Sn8vQwymacTqZ2Xg4NrDPBX7vzu35RciZwgIaU4VkFv13qTJx3mwvyl?=
 =?us-ascii?Q?Ns5YTZsY0SFv4yOJ2pqf0j+cK62pldCvfe4MD3iHtoZkjOfEUOZf1RmrZG93?=
 =?us-ascii?Q?eE8yZ6AKeFs2JCvJiCpjOm50FaE0EcIuUdMyFYaOs+m64Y5QIlUI6CosRyxp?=
 =?us-ascii?Q?tBtxzr/O2F+L99zppGl2cxrsTjHPjzSw0DBGcb7u0I7MenxVhx1yT9sie80Q?=
 =?us-ascii?Q?+XO1TlhmCowJO13t3s0YyAEqxBcdokaNYLxaaGVoGX+PQER3yDDTKDsZwYLe?=
 =?us-ascii?Q?JbhkYgvndQrywxnPyLdh0HbN5nUJd3R4V9SuRnLaLe3XSTlRWQeyQP6FvQ1W?=
 =?us-ascii?Q?PGPfrri/U2vZ4I6dI/Pj4Vf5BVJWr2KwQvqPcE7q3LjewOgdzzsF95vxXvwq?=
 =?us-ascii?Q?Cuq/1XVbidfOYznFEIbZGjstmH9iRLmwthZNhifS1XqRWyFJAxCPHXbWiBrN?=
 =?us-ascii?Q?qYppC+dpIP6gFzsgFyYuW9cdPUuGTT7y5H5HfjHBpRAz9C9i0GACsGjgnlu0?=
 =?us-ascii?Q?2cw7jpwTiA+u2DLFsx36g9JgC7ypXwsQOsfPAGPjB5NoDqTTUHaSdTfQLUap?=
 =?us-ascii?Q?pfm6WcUldrxX2XY03NbjrzqfDtqlQefs7LV2fDUH0pA0OrmpU4KoM91dOYWx?=
 =?us-ascii?Q?uuw5rjDRLLt5FSQsgjRWvp5gBqalY3xOlCGF3UcyPmCHEu5TB0eJaTmHglea?=
 =?us-ascii?Q?RIzdmA+NTdYG/6ro9y3dXLPzyJ8VlZO+13YygtB?=
x-microsoft-antispam-prvs: <VI1PR10MB20802FA656E50DB887A59863F5750@VI1PR10MB2080.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39850400004)(136003)(346002)(199004)(189003)(71190400001)(53936002)(97736004)(5660300002)(99286004)(7736002)(4326008)(110136005)(68736007)(26005)(186003)(6346003)(6116002)(3846002)(102836004)(305945005)(54906003)(478600001)(256004)(33656002)(53546011)(14444005)(486006)(7416002)(6436002)(71200400001)(81156014)(229853002)(9686003)(66066001)(8676002)(55016002)(81166006)(106356001)(105586002)(25786009)(2906002)(7696005)(6506007)(8936002)(76176011)(446003)(11346002)(74316002)(316002)(14454004)(476003)(6246003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2080;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nwY8i90U3q6nO95fxX0qTr49jyi88tKLNltS0q7zjczi6uDs4QPlXcOM15eZyrGQGxQzn5j03ammdc1xQAQLlmEbh9sxcAHz8Y/OKiGaoHgrlD69dskcQyj+9lAgeDdxfyy26R8tXV4rN535AB3lC3VWkf4VPesMbkUSsuwBkC+K1fsw8e1Jl/0YaqtqfNtPkI/mEsh7Lp6qE0OWYk+OEOPaTjTvr8f/dRN9S9QsfJA57oxiQ0HLGfscluLNZgQt42kHn4Dww5e1eoQUQRwCZxXLisyGnUWUpV9/1SjIQI3jHLSki/tZJQiAAex2SBwQ/GvpwyvMOsKuME15cT1lSVNSuJX+CJ/JDJHax94Y3GM2Mqi4IQ29VE7o7sg5E8WW0/jPVkzT5kY5CpbYg7erCfLBq1jRLAt1f7b6I9P6h1E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf7664d-c16e-46d1-13e2-08d69d93fbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:47:02.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2019 13:40, Axel Lin wrote:

Hi Axel,

> Subject: [PATCH 10/11] regulator: pv88090: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.

[...]

> @@ -193,8 +155,8 @@ static const struct regulator_ops pv88090_buck_ops =
=3D {
>  	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>  	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>  	.list_voltage =3D regulator_list_voltage_linear,
> -	.set_current_limit =3D pv88090_set_current_limit,
> -	.get_current_limit =3D pv88090_get_current_limit,
> +	.set_current_limit =3D regulator_set_current_limit_regmap,
> +	.get_current_limit =3D regulator_get_current_limit_regmap,
>  };
>=20
>  static const struct regulator_ops pv88090_ldo_ops =3D {
> @@ -223,10 +185,11 @@ static const struct regulator_ops pv88090_ldo_ops =
=3D {
>  		.enable_mask =3D PV88090_##regl_name##_EN, \
>  		.vsel_reg =3D PV88090_REG_##regl_name##_CONF0, \
>  		.vsel_mask =3D PV88090_V##regl_name##_MASK, \
> +		.curr_table =3D limits_array, \
> +		.n_current_limits =3D ARRAY_SIZE(limits_array), \
> +		.csel_reg =3D PV88090_REG_##regl_name##_CONF1, \
> +		.csel_mask =3D PV88090_##regl_name##_ILIM_MASK, \
>  	},\
> -	.current_limits =3D limits_array, \
> -	.n_current_limits =3D ARRAY_SIZE(limits_array), \
> -	.limit_mask =3D PV88090_##regl_name##_ILIM_MASK, \
>  	.conf =3D PV88090_REG_##regl_name##_CONF1, \
>  	.conf2 =3D PV88090_REG_##regl_name##_CONF2, \

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>;

Thanks,
Regards,
Steve


