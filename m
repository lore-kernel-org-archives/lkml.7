Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3862920C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="ZG4SttHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfB1OBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:01:48 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:62311 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727985AbfB1OBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:01:48 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id BF/21-05904-3C9E77C5; Thu, 28 Feb 2019 14:01:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfWwTZRzH99xbb8tOH7qR/agbIU0woXBlZf5
  x+0sTY3JqSIhDki2TcV2P9kx7G31xw0hg8jLFzBwqoKWDavaSzAnJolktxOlYeFkkjG7BMVmW
  zSbCoA4tGGFTvOsVxP++z+/z/b09eR6WtN5jbKzcGpaDquS3M0WUbz1TzZ+92VJfmd0qZMc1S
  hiJ3SOFu52jlHB4Ns0Ic5lRizA6+C4h/DnxHiGMJ2OM0PvgJCVkF4boF4rEhcn9FvHb6LRFPH
  D/LXGg731GPLI4YRGPxh4iceavs4R4fnKQELMDKzcV1tGK6m5q3Ub7js9oZPMU3RofGab3oDb
  6ICpiKXyKhO86MvqhkLXiDwloSzxjACv+GUFXe4YyAINdcPz2AjJ0KX4RDib3M4aJxAcoONLX
  k8suwR44nPiKNE0yxM6N5BM2wIOj93OawqthTFskDM3hN2D61JIeZ/Vu2+HqxSojXIirIdGxa
  DE0whVwt+3LXEkSl8FU+kQuFTCGrjOXSVMvh5u//EOb/gZoH8pYzPg6uPRTGpnaDj2TUdrUFZ
  A68UE+vhGu7+3P7QJ4CsHlgUHKBA74dOkTygRdxXDyykwe+GHxjsaYuhy6910nTVMvDQ+P/Z2
  /x0a403kpP8ZK6OuYzVcaIyHVPU2Z+6yD+Ok/GA2tiT6xXvQJZOq10PP5LTKau7FlcPGzNBVH
  VB8S3EHF6wsHJMXPuyoreZerin+OF6qd0tu82ylH+EZZDQclHTqllpAztDPQ6Pc4VTk8gPQn6
  NlB1SZQqts7jFawhH05F+ltqbc+5W7y7PRJIV9DMOKXQ8OonGXtwOEbOlsWlL1y63bFr7/jRx
  jYYnspV2VgLtQsBUKK10SjiGe//2K2k7RSapMq28q4bwwTNky+iPq4xKPfkEIVthIOFRQUWIu
  b5WBACf+fz6MyFtlLOEL/NNZiRQ0/7jSvD0HoQ/AzuSHC0n/ItgdpN5SJscSKW67sK7vigxsW
  oOZQ/6urUi8pmw95bLu1htdPx36Le39fvSq+79drT1vn0skl/8Yze33u2h1DsbkLzrqPnT8Sj
  o/eWaMln5W3aBe+fvPa7U1byMJacan+tUAkOfEyanfUb/5BLec8/dt2O2pqjl3dWle6lpl/Pl
  M0vqvFToV8kstBBkPSv4ZqKsAIBAAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-12.tower-239.messagelabs.com!1551362498!1745155!1
X-Originating-IP: [104.47.6.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10908 invoked from network); 28 Feb 2019 14:01:38 -0000
Received: from mail-ve1eur02lp2057.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.57)
  by server-12.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 28 Feb 2019 14:01:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvIWKV5qHkCQWSXtgc+oHaFxSbVqQu4auTYurgNwyEY=;
 b=ZG4SttHi85yH3sPm5b26pVlYPCCD0ol0zaR55u7JeHhPwXBlbaDnSTZ4rJDJFPiYCujhuhRsDrQW5GFSaQZBUiL+Ifo4JNqH5h+6NQlqV7xs/w81voESGS8qx5Csidicgfe14SjT7sYzcZbqpCtd1fgRSYirN6j+mHjcT6NqgxY=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1885.EURPRD10.PROD.OUTLOOK.COM (52.134.26.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 14:01:33 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 14:01:33 +0000
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
Subject: RE: [PATCH 04/11] regulator: da9210: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 04/11] regulator: da9210: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHUz2tN6Y9uDUNvrEu8DESGAa5SjaX1PH1A
Date:   Thu, 28 Feb 2019 14:01:33 +0000
Message-ID: <VI1PR10MB23523A6836299369C6267438FE750@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190228134022.32625-1-axel.lin@ingics.com>
 <20190228134022.32625-5-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-5-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87cebe59-e5a9-49a9-6a9a-08d69d853f60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1885;
x-ms-traffictypediagnostic: VI1PR10MB1885:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB1885;23:ds3PMewExkjxtP9Q01jwHLERn3ZOQoS7Wz/iUWjS8?=
 =?us-ascii?Q?eUVpsYYDcjgKJkOi4H7/RFiVqi1ANDGHEdfHWRtVSlSPLFwQV6ZfgTRxR2/h?=
 =?us-ascii?Q?xYfePy8RXo5nvP5uhnqfBgsylTAm84KRBBfljrCLdP9NuQxCSWZzUjHsN+Le?=
 =?us-ascii?Q?33mymJcgmBNZ1EWkAF1zxzhKgpq6sgfrACLzBpl4+1SF9VVxPdi7GEcU+6zX?=
 =?us-ascii?Q?1wccc3N7jsavf0cNsxAkIFehB2N6U1YcIb5SzcRQA2ECBLasIIj9Jr2JczoV?=
 =?us-ascii?Q?p3YTmaEGg7oX1FSTcWZQhIbeLV+iQ2YLD7nfwUr3wY59DzaVneh3WWmU+huj?=
 =?us-ascii?Q?Iiju+BA8+rCwewCI5/9Kth9VDPJ18J4JjjD2T5wtqgALZ0NlFnD/9IRtCqeB?=
 =?us-ascii?Q?PJEfxq5cbVAPWm08K89XmbzKciSdUqtLVjk+O/WnNpg1SDUH/ij2tlPRZXGy?=
 =?us-ascii?Q?+f9Q2aiSrvarStcoOFg2UHEi6KjO7337yeIfeqIh09lDc7+M2sgLMxuZx0Jz?=
 =?us-ascii?Q?EiKuQA8wvDwv34lkSMz3amNmbqLa8ibUbXsfKIybk+vSEicMSx7ai/Xg+35j?=
 =?us-ascii?Q?xH7YVxx7WHOrOX+jPXFvJfgZGuQJOzxkhKOgpjbs37cYBR6xV5mi/+mAVB75?=
 =?us-ascii?Q?tTpwDQPumf4jPXi9hmrNzVr3lUwuNqrwTaoMgEYtVxFrac4Rmllcx20Gww/n?=
 =?us-ascii?Q?MfiPf9iDTeW4xZ+PMTSpsQ/R+hAjIHMkzgNs6Ois5GhvdQEFEGSX+qBFURk3?=
 =?us-ascii?Q?USGN80hF57BIkPZcjnm3JgfWqJBW2jD3zZvIzt6kzqEcUxL9gVWJF9Zx5Igg?=
 =?us-ascii?Q?a1GaibgBKJ53x7XcC9iX3cUgPpISHhAZwzCKk6oFKGkUEpe9MSthEruWylMJ?=
 =?us-ascii?Q?ucxU/FP26TxVxzii+/oPehZis4eC/war0ax7qKMjii8gCjdKHDcmuoYrxfuR?=
 =?us-ascii?Q?9ZJ6BMfyfC35+ukxohZm2MPDhoQNBWV3tyOiQWoZJRfeGOR+Fk29qJd2St6F?=
 =?us-ascii?Q?lUGjYMqCCIbm6TFbKmy19A7GeSYRpOYOCk21x3zfHnbeltxQ+xsqUyDcAkPN?=
 =?us-ascii?Q?GWemG/JrYs4mO2p+S5+c/yrgcXkY1gqY2I/6GYtStIrmcS5gf6rAD4GFaFzs?=
 =?us-ascii?Q?UnehVMjt/rhpkM2LNOblQaCVXEk3AKbmwqJN2xmtwZlO1cVBwSh0A=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB1885A9B58700786729EA53A6F5750@VI1PR10MB1885.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(6116002)(99286004)(5660300002)(2906002)(53936002)(76176011)(71200400001)(71190400001)(9686003)(6246003)(7696005)(498600001)(3846002)(66066001)(7736002)(97736004)(186003)(4744005)(305945005)(81166006)(81156014)(4326008)(25786009)(8676002)(14454004)(54906003)(256004)(106356001)(105586002)(14444005)(53546011)(7416002)(26005)(229853002)(74316002)(8936002)(86362001)(55016002)(476003)(486006)(33656002)(68736007)(6436002)(110136005)(11346002)(102836004)(6506007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1885;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:3;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I4rwaJR1+VGhaYD+314S0MmgtXRWl7fCgrsKcYRtzKTrtEpZbSCe3n5GdYZvzUX9N/dvesdpB2M2MO17UmKmaKzxzD6QVi+MMuwzEjaHox1SSAOPZOQ6is5WCTvyVIgqTculnPgq7OwmriwtoUrrKTuI1/KvsZnhD7QeOYXrYrBX06RAyq8t8j1wE3P1P8Mk2QLVqCIz7pMRJFIQfZY+6XiCNkMGPoFMWzZfNWNQQsvhWFRCaIXzmSPcslXNyz1izwXApNmLhxWcyrE0L7hPdowWHy/jrKhnr1LmhRsOKCBdaq2toMLggq7q6f+35RaP9PWisnvp1NPJe/sD61C4z2fZQzqLNN/4AyvAu3HDsUaynyV7Fl2RfM+f4fhLaMq9kaOIwxZSUYTxmsMqfWzsSLnyZCtJU2PK/Sb7ypQgItI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cebe59-e5a9-49a9-6a9a-08d69d853f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 14:01:33.7897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 February 2019 13:40, Axel Lin wrote:

> Subject: [PATCH 04/11] regulator: da9210: Convert to use
> regulator_set/get_current_limit_regmap

[...]

> @@ -52,8 +48,8 @@ static const struct regulator_ops da9210_buck_ops =3D {
>  	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>  	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>  	.list_voltage =3D regulator_list_voltage_linear,
> -	.set_current_limit =3D da9210_set_current_limit,
> -	.get_current_limit =3D da9210_get_current_limit,
> +	.set_current_limit =3D regulator_set_current_limit_regmap,
> +	.get_current_limit =3D regulator_get_current_limit_regmap,
>  };

Hi Axel,=20
Thanks,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

