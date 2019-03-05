Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F452C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E0E206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="K4XenBsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCEKCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:02:14 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:2096 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfCEKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:02:14 -0500
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id C9/E6-27207-2294E7C5; Tue, 05 Mar 2019 10:02:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSbUhTURj27N7dXc0rp5ntzVRq9af0Lmd/bvW
  joKAFBRH0YdjH1V3dYM6xO3MVSGmWWVkQWs7PSkQs04ZBWZBZQVZSqZlaFtYg/IjKzJKVdO/u
  svp1nvM+z3ne9zm8NKFto6Jpwe0SnHbepqfCSMsy1SpWvyE3JdHfiLn7Fd8IrmTIR3GTPYUqr
  ru1glpDmm56BjWmo1P7TN6G45TpqzduM7lTbbWnZrn3qi0PPr9QOzrU7mcn+8lDqJ8sQmE0iZ
  sIaPrwA8kXLS5Wgbd4JHgZQDBY9YYqQqE0hY1QNfYJyXgOXgtFrQWULCJwJYL60QGVTETiVCg
  8m6dRRGmQ779FKDgJOqdPBDQkXgzesfKAKYN3wZsrfrWMtZiD8oeFAX0oXgFtj38FNAjHwsTh
  y4E6gXUw4KsO+ADGUHv7KaHgKBh+P61W9Hvg2J2PGqWeAJ0vfUjBeqjr86gVHAtd1SeC9U3QW
  FujkcOAnHjszhdSIZaCf+QSqRDnGWhuKQ662iCvrFjqTEs4Bj5NBB93q6HF/yiYJg0+V3YG9X
  HQcGooaPSMAF9ri0qJkwA1t8apM2iJ5590nn8oBcdD3YVRwhP4sdnQUeYjaxDZgLhUpzXD4sr
  krTbWmJjIGo1JbFLg5Az8ATbNIGSzOYLoYo0GPkc0iPsz02xmg11weZG0TWbHw303UGl9Rjua
  R6v0UcxyLjdFG5GaZd5v4UXLHme2TRDbUQxN64HZIHOznUKG4E632qSV/EMDHa6fw8Ssl2hGd
  PCZojVDoR4hlm67OFRJaEl7ll2I1jEJJkmEZZEl2z5j8Wexu1BsdCSDQkJCtOEOwZlpdf3Pjy
  AdjfSRzFO5VbjV7prpNCINoZKG+Np9UB7Cxf+loqUtr2bdXaxh4z3dc7Yut+BJx+pz67x13+f
  uiLt7vdmZ4m6bmtWXcyp/5aW9206vCW1emJy1KMaMqxqjQDfU2z2+9aLn57Hkgpvvtg/3xp7n
  qlZ8PJL4quda+lVYmWwreR2q6b1hjtjy1jE+Xuv5qSuNP3Lo8FFPw/z8Be2TWyNeh+2e1pOih
  TcuJZwi/xuI6yTs0wMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-12.tower-308.messagelabs.com!1551780129!2705161!1
X-Originating-IP: [104.47.2.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24875 invoked from network); 5 Mar 2019 10:02:10 -0000
Received: from mail-db5eur01lp2059.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.59)
  by server-12.tower-308.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 5 Mar 2019 10:02:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ0loCSNY5nE0d7sFNzf0CJ+V5M4udZGI+JWgDcoxSA=;
 b=K4XenBsBEobD1UolX6QOA4wKm+nCCOYFaomGrVG7M0RgCajqfIKf+JbX9QMpa6pxMh05Pi+MpIb962eWKaUdnC+5XGSaF/L23/RCPNmtOOTIzsveEStuKdmrD8iVRrLPyFvc1WPVFgNmRC2PhqY8YCfDCPQ/Rp/0TstTeYJzLp4=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0719.EURPRD10.PROD.OUTLOOK.COM (10.167.203.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 10:02:05 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 10:02:05 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] regulator: da9062: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Topic: [PATCH 1/2] regulator: da9062: Convert to use
 regulator_set/get_current_limit_regmap
Thread-Index: AQHU0oyQ8umV1pWkcEGiUS8NTIelz6X8zt5Q
Date:   Tue, 5 Mar 2019 10:02:05 +0000
Message-ID: <VI1PR10MB23522929B1842A0713ACF58CFE720@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190304131603.15730-1-axel.lin@ingics.com>
In-Reply-To: <20190304131603.15730-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e009be7-d634-47b0-2d9f-08d6a1519f3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0719;
x-ms-traffictypediagnostic: VI1PR10MB0719:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB0719;23:0curHUumckqxC1r96yQPVFMflYh5N5mAXkW/Tvvw9?=
 =?us-ascii?Q?+hGTBMl2oyvwLID7sOh1DNHXAiAu2UrhrDF80px/D/eG9aRprbHYbeHi9CP9?=
 =?us-ascii?Q?+6pMirwgBvxNMPI7kfbC2cVIJr7SETg7JXK8YVvK1CgxBFVLv026yuuAOIhN?=
 =?us-ascii?Q?+YkvdsrULFp/Ck5IoxjBOfAnBbTRHjNb30ahaZZMFZc5tE4d+/K7b3/Mr2ye?=
 =?us-ascii?Q?LIjRWbogV4tyNu6euxyA7NkMZy2cpEO3n/Q3JZDTkk71ufR/Oy8zB+8z6xLE?=
 =?us-ascii?Q?GVUtuqG7prYkM9BTP5oNQIvrIMT+PKXA98i6uzZFZGanPnOKNK03hXJrPc/q?=
 =?us-ascii?Q?kKeE50IqIbraOIOVo4PxpcoZa05mgZ9TqVXooSaoGGgX2TkBJR6I+lkD8dvT?=
 =?us-ascii?Q?HBZEJJfsAnZdS4WEakfwJ/SgZv3i2IICsbMxpNDdoi1LroIqL8iMlDveiQKG?=
 =?us-ascii?Q?DCB6h0E454nDC04emfrqOOLzjihyvr5e0ScDIpH4V/3tObc9O/73ZATPyI3l?=
 =?us-ascii?Q?6SlhzIDcTVBGfz3iNXZ05TWWJFBjZux2kVZw2SF1HCkdHWCICqgU+q/h+VqN?=
 =?us-ascii?Q?lKAancsmVjkWwsN3TWZE+GoYEcp4j+y5B6o4ccpYleU5h3SyGC0j2gGQQk/J?=
 =?us-ascii?Q?szK8KNPz4gKY2yt4Yt2buRPQbpPx4BHQIXiDO9+goC3TpVBe2YVrCrvTvpSD?=
 =?us-ascii?Q?ElDgnKdg2VzwlnmndEpXZIhPHsdSFbPprOt7/POXtGcO9reKPi7bFWJNHLQr?=
 =?us-ascii?Q?1EC0lKHyiQKPXawA1qMZTmrUFe5zlIz0I8vAbO4/rXuuWMa+CDsxyzc9YQdI?=
 =?us-ascii?Q?xDpEPFZjP71lthaIpKEyE7BMA0+GUOtNtL5HCujB9u6GcRlrUHzioJktSsaZ?=
 =?us-ascii?Q?htX5Y5V3264L2LNJdDxHcKbVzoKEeiODIO1LmIIvb78ybTh91CPxuNkUahxP?=
 =?us-ascii?Q?Ppd0sS0xL8NGBxG10WNvyST+rpDmvswsfJosUCckbzEga7o2hB2XoHnYBsIB?=
 =?us-ascii?Q?o/ePMkUu8sh9ajwFvOtTTgDisgwgn68YGngMpAZ0SsfiroUz/XvKJ/je88oc?=
 =?us-ascii?Q?lD8oLOHG9k/DUJjYZIRzIKUbMLhYa4BtkzV+ESSpS9Vd61AF7NI7xw2C/uQG?=
 =?us-ascii?Q?tl4VsV6Qs0QMunsTcZmpDdrxgA9MCtBx933Gru8FTLVa9Y5uxsbSgLOgqT7y?=
 =?us-ascii?Q?3R4MZRFkKd+ag5BZNXp0TPYhHCczEwh7hnAJ8W0HSuhKmK8EzJj8J5JE7fsR?=
 =?us-ascii?Q?jlP8yYe0MrYqZalTH8=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB07197C71563512E10EBC9AF8F5720@VI1PR10MB0719.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39850400004)(376002)(189003)(199004)(71190400001)(102836004)(7736002)(5660300002)(54906003)(110136005)(305945005)(25786009)(186003)(105586002)(33656002)(9686003)(11346002)(446003)(66066001)(74316002)(6506007)(53546011)(71200400001)(2906002)(26005)(97736004)(316002)(55016002)(6436002)(76176011)(7696005)(99286004)(81156014)(256004)(8676002)(14444005)(81166006)(106356001)(478600001)(8936002)(86362001)(3846002)(68736007)(53936002)(6246003)(14454004)(6116002)(4326008)(4744005)(486006)(229853002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0719;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2WQBXG7bs1s4rRZ9DQl5bBllou6+ZRndA+vFp16+kVosztX0Al9M/Z+8wrqSGC4BN2dGSK7+r2yhdjfZLzQObCMJw1k/PZEfCpdah2bFUbUIgor8bc8MeZQ0m7/lCXtMuDzD1b90TIrn3P6cm5/jxR2fGmWy1pM71eA3IK6VYF7eUyiJEonEV3amPY96XwsRwINjAlFGA+pgZxFVivf/jhTT5SGZOtpPVNzCwDSs6cFuIxngBZCHFsQaHL3PbyPsPloXSEpa2zoSoKSueCgqRg+JyTY/NX61kKAzp4CZX+8RQeIBga8DgUnEkhGweh95qMQpoONgWzpkYSmTAp+bVrQKAJlSzRcqScbYTZeLrNRFoS/peGtB6VRveELXQoXFIyqIFxHFv2a5nploFLbOvWu1QCxHzaxu8lHo7oGX6nU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e009be7-d634-47b0-2d9f-08d6a1519f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:02:05.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 04 March 2019 13:16, Axel Lin wrote:

> Subject: [PATCH 1/2] regulator: da9062: Convert to use
> regulator_set/get_current_limit_regmap
>=20
> Use regulator_set/get_current_limit_regmap helpers to save some code.

Thanks again,

Acked-by: Steve Twiss <stwiss@opensource.diasemi.com>

Regards,
Steve

ps.

This patch applies to next-20190305.
But doesn't cleanly apply cleanly to v5.0, I guess because there are severa=
l patches
queued up in linux-next, e.g. the reverse search of the limit array in the =
function
da9062_set_current_limit()  ... etc, etc.

Hunk #4 FAILED at 109.
Hunk #20 FAILED at 1044
2 out of 20 hunks FAILED -- saving rejects to file drivers/regulator/da9062=
-regulator.c.rej

