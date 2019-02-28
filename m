Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EF420C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="uie8X7o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfB1PSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:18:20 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:18817 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfB1PSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:18:14 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 2D/49-11025-3BBF77C5; Thu, 28 Feb 2019 15:18:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTZxjmu7ter9i6s0B4aUBjo8mmXm2JzuM
  fY2JizqiJ/xjNxLjDnrSxFNI71uo2YSqKiIRoFG1A0QnOsmhoIiDbdCrEAWFiJYN1OIYSlrER
  BKQZAm7tffjrv+d9n+f53uf98n0MaZykTYzkUySPW3SZ6XjKsVK/hgtOezOtpZHl/MTjcopvq
  Zwk+RdV7RR/ZmCQ5p+OtGv59sZDBB/pLib4x82VNH/15XWKnxi9o1kXL4z2FmmFW/4nWuHo1G
  dCMHCcFs5Od2uFisr/kND/731CeNDbSAgTwYVbdZ9onO6sXN+nGsdU09cor1Hnu3XzsLYQnWZ
  KUDxDsTdIKGup08QKI1tOwJ/Tlwhc/Iag6VkzWYJ0DM3a4MI/oyiGE9n1UNJcRMdEJHuUgrOB
  Wk2MSGDt0HG3lcAiCRomvqExTodv67tVM8UuhbLiX1RsYHfBUOiR6jWye6HuxjUV69gM6Hk6p
  g5GbBq8+KpOxSSbDOHBi+r5wLJw5fuHJMZJ8NezVxqMV0BnzyDC2Ay1vf65fhqELp6Y62+BSO
  gyii0AbBiB/3YwWjDRYhn0dCq4f84Av06OUdjggtEzrXPDUqHmSB+JRSEN1Pz8gMIb7IHnVZ1
  anHo3HLszosWGhRA4OUBhQxcJt+ufaPA6K6D6u3G6HH3kf2c7/zsUxsuh9tLfpF+9sQXQdn6Q
  qkZUAH2c5XFmO5Qc0enibFYrZ7Olc7aMNVyGRTzAZVmkfM4ryQpns4he2SLvz9njslvckhJE0
  Sdoz2vVNaHZkux7KIUhzEmGh+PeTOP8rFz7focoO3Z78l2SfA+lMowZDB1TUW6BR8qWfHudru
  g7fk0DozcnGhpitEHOE3NkZzam2hHH/Hh5oIo0Uu5ct2RKNthfRkVsTOTId7854vVvCKE0U4I
  BxcXFGfV5kifHqbzPD6NkBpkTcBK90628mTQcDUFEQ3D9aghFfEuZCpFxY8vB0lb9hpSMecwX
  XSZt+uzqmW3pcmkwMVwQ+en4Il/gw7XFCR/kN6yzRj4P951vE7qUvsJ6cUby7lhdaN00v+hUg
  bftypJ9AwVSZsrm2aRt12b6h7+8EPy9TFg8PnazcftIhSW193raH6GOVS5Ll39nsS08dH+ofr
  am6YerQoWZkh2ibRnpkcX/AfBpUAUIBAAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-14.tower-288.messagelabs.com!1551367090!3278129!1
X-Originating-IP: [104.47.12.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22229 invoked from network); 28 Feb 2019 15:18:10 -0000
Received: from mail-db3eur04lp2055.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.55)
  by server-14.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 28 Feb 2019 15:18:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzs5dHS3DMCdD3WC4fziCjnX9Z0/ta8qnFillddMl0s=;
 b=uie8X7o03OX3H0PpKNuqmWIDvLcZ6qaXH//YFSmmkEXnc6ftd8ReDN+uAf+nu72ViIjTue7Lz/lemqgh7S6EpO0fKDWXUpfMxMralMmnV/Mv1TNJDqOJmvxS+AYFse5iIgN1VnFylXzFTU6Jj3AdvJOWQ4hlDsFWfqUCwBmJMUE=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2557.EURPRD10.PROD.OUTLOOK.COM (20.178.120.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 15:18:07 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 15:18:07 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Seong-Won Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/11] regulator: da9055: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 03/11] regulator: da9055: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHUz2tEgK2HfYyuGU+MoH9/47lKmaX1PWXg
Date:   Thu, 28 Feb 2019 15:18:07 +0000
Message-ID: <VI1PR10MB23528759982DFF51AAF475D7FE750@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190228134022.32625-1-axel.lin@ingics.com>
 <20190228134022.32625-4-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-4-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 603e67b4-bd56-4832-d92d-08d69d8ff168
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2557;
x-ms-traffictypediagnostic: VI1PR10MB2557:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2557;23:tu/cW7te76CChgYZc4jFKRidYnIXNJvfD4QikHEeE?=
 =?us-ascii?Q?AcUzcWKTJqFrm81RSW//yORv5vuMu/1vjc4de8c+uZRrKHVuaCTt6Y4kEHw3?=
 =?us-ascii?Q?FFKIAF9HUtJfuFlMmwRieqmmURRzWnf+i9sp5530+kU0fAR41UQiwMhlx+0e?=
 =?us-ascii?Q?+GTQxWdjBbZdU4WfG9a+uPk1acf29yKMvtfMIp/UgTe0ShintKN7feB0sQQ9?=
 =?us-ascii?Q?BQyzqL6aIG8wDEwr2SyvKUNl0QGxg2YcPMHhuk8OUrgNYk+FQU6AqkLib4Gv?=
 =?us-ascii?Q?dpC5nvBxeD4DEBMnHd0FFBjvV4gHawUhyKadQFDJbGtYHJNLGt3vEwlmxYCC?=
 =?us-ascii?Q?yf7E3nq0uXxTbZwsxXIt6S2kGWi3Vuy3tPm4oKHV4fm9kQd1Ipl7fGLVL/wT?=
 =?us-ascii?Q?QN3sH2EHfpBAzWftlbEG6JF7YwHSLr9QCJg9C0SLLj3c1IuAb5yUFQR9S/fa?=
 =?us-ascii?Q?JXWv1SWmem/G0Qbm5PSCy7RwSPutp/8sZeh1Ora+cksyHaG0/lo6BbhBNrmH?=
 =?us-ascii?Q?y9qt3kTCD+VdZc5GYTZEPBLUNFmJfz3huEY0d8o+iP9OtcbzkNR50tjLiKV/?=
 =?us-ascii?Q?Usda/fr1ikSOR/wfG53MCsOgR9BKmy7JfJq+jYAcAZqXhRUTWI5RDgUk9ylG?=
 =?us-ascii?Q?p4i8Ue/hUOni5kcOBN2sffqSxCdmdF5vfBCkFdsz7AKsMSKRBKVfkl61szia?=
 =?us-ascii?Q?HZ0uKEXmclopfCQPxunTiZ2Y3lHntOXfzxmoB9VP7NfikGzxyT4+XCo//5A5?=
 =?us-ascii?Q?SAsNLqcP8y14R+26taFyOpIPysP/+xvV3OxgVkr4f8JAITh8Zgf3VCfU/qRA?=
 =?us-ascii?Q?toHHJWlIa5WnQhhAowQPgctP3w9s5W1ri353md2DAYkEkVLqpJ2x1G715RjI?=
 =?us-ascii?Q?GjQPylUjSrKOOl90bkvH9Mh9Wuwkto8zDiVOchjOG9rixPLdKEvmF4YTiUjA?=
 =?us-ascii?Q?gCdPfl6OzW72BTKvMqYHKQmU1hhzSvw3lbMN93FKWf0z387RlCAMhbXogN2N?=
 =?us-ascii?Q?We4k+M1XWbZ7wLjIwUxWxsd+q1SLpjYBl23tgyRcl0Ni3ZIXZmbCJGsjNnma?=
 =?us-ascii?Q?tiPe+zJmrJriD7xr23l+dMrQt+04cPOpJGT5sWQJ2itFIM8kXy4zuvyg3XLh?=
 =?us-ascii?Q?JIExaDgeba0RgnyRoRd/cLmpa1Dhu/++3vT8+pNwgyoaSrcyANTEQ/8qYFA4?=
 =?us-ascii?Q?48exm/5dHXT+UpAy9W4fnhw35nbDnF1+r1twfgZD+vcO3+GHAo1CKjSIWUd3?=
 =?us-ascii?Q?ohcdJ8OdEwfgA2s3lk=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB25574191EFB9258C7019B90AF5750@VI1PR10MB2557.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(6116002)(81156014)(256004)(8936002)(8676002)(305945005)(7736002)(81166006)(7416002)(5660300002)(26005)(105586002)(186003)(6506007)(6346003)(102836004)(86362001)(14454004)(74316002)(9686003)(14444005)(106356001)(6436002)(229853002)(478600001)(55016002)(3846002)(53936002)(7696005)(316002)(446003)(11346002)(54906003)(2906002)(33656002)(68736007)(486006)(66066001)(99286004)(6246003)(4326008)(25786009)(97736004)(110136005)(76176011)(71200400001)(476003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2557;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pxMAeNpRE4VvjXV89y0Sh+YlETe81Y7Um6EMzlTkqlCuuRn5Igh7M/qBPD9Pf3QYckcEHqXCwL6fdNJMFOqKG2OlNfRzF2R1ivNb6iMiRX3i9sU7Dy5f1yhTss8Bi201UXWxIN7fjfcLf7lQcttKs6SH2bmgU7xWrtl/FhyzPo/gL16q4CFncX/gTE5E87E5PXX9hjhozSjLSXvj6cx+ZQFlHfSDPkeOn0ny3bEMe5WFCDfJ5uCVai/YXH25hz0npRfOAWiuRiDkT7FAciQPcWS0/P0oVTc0ChMLq0RCola+1GnrMUx2eQHmu/QbydN5rdK4xz41mTTM5DlqfGx4Ldqkq72lpaqDOMHOpN0NLAJrSk3zJT+Nh6Lf9RKvJk9q2M4Zc0lPs2rp7TmBPCv72O43U1IyCf80Dp3JK1Xn+Mw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603e67b4-bd56-4832-d92d-08d69d8ff168
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:18:07.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2019 13:40, Axel Lin,

> Subject: [PATCH 03/11] regulator: da9055: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.

[...]

> @@ -329,8 +298,8 @@ static const struct regulator_ops da9055_buck_ops =3D=
 {
>  	.get_mode =3D da9055_buck_get_mode,
>  	.set_mode =3D da9055_buck_set_mode,
>=20
> -	.get_current_limit =3D da9055_buck_get_current_limit,
> -	.set_current_limit =3D da9055_buck_set_current_limit,
> +	.get_current_limit =3D regulator_get_current_limit_regmap,
> +	.set_current_limit =3D regulator_set_current_limit_regmap,
>=20
>  	.get_voltage_sel =3D da9055_regulator_get_voltage_sel,
>  	.set_voltage_sel =3D da9055_regulator_set_voltage_sel,
> @@ -407,6 +376,10 @@ static const struct regulator_ops da9055_ldo_ops =3D=
 {
>  		.uV_step =3D (step) * 1000,\
>  		.linear_min_sel =3D (voffset),\
>  		.owner =3D THIS_MODULE,\
> +		.curr_table =3D da9055_current_limits,\
> +		.n_current_limits =3D ARRAY_SIZE(da9055_current_limits),\
> +		.csel_reg =3D DA9055_REG_BUCK_LIM,\
> +		.csel_mask =3D (mbits),\

Hi Axel,=20

Thanks.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

