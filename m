Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76622C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4322B217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="VdEYMwE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfC2K6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:58:41 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:52531 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbfC2K6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:58:40 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 92/76-03001-D5AFD9C5; Fri, 29 Mar 2019 10:58:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTHfXZfdjUX12l5MpUYWWFuOSVZURF
  J5hfLoIJiZnfztt3apm2TZl8yI0ItMTK11fIFMbMPxqAXzMhSkyW9kKXlKpmvaJpSVpYQ7e7O
  si8PP87//5z/eR4OhUnbyQiKtVlZs4kxyMggXL+OSJCrfznU8a+LVKpLniFS1f+tA6m6m6+Sq
  ttjn0Wqkuc7thKpzsZCMvV9TwuZOlLThKd+dUan4wcIzqTJth0i9EXtBeIcF25rG6xG+WgGK0
  KBFE43YTAzt4VnKV0qgtMDRwXuRzBcnsszSSvh2sQU4jmM3gcNHYVkEQqiMNqFwNl/DeeFUHo
  b3KxuJQVTMjwYdRMCJ8DrgkdiISwG3n246AuW0Blw7m4J4htJ6Xxv2KlKX0IgnQIXrteJeEZ0
  FMycuum7gNHh0DdU5asDTUNdywtM4CUwNvibEPyZcPbhpFiox8Gz3iEksAzq39oJgaPgVVWxv
  54GN/qmfUMA3Yeg+06FX4iF7vo3/jADdM3Z/WGRMOcuIIQLHwkoez9FCv+lhWnHM39yNDSe9+
  CC6SUGhZXFYuEJcVB9/wsp8Fqor/mElaI19gWvsy+w2RfY7L4vCwHX5SG8GuGNaIPGzOn0ViP
  DGeTK+Hi5UpkoT/KeSQrmhFyjYHPlWtZkNTNeVcEctygseUatIUthYq1O5N2orGOk9R6qva57
  jJZRItkSycCsQy1drMnOytMzFn2mOdfAWh6jSIqSgUT906uFmFkdazvMGbxrOS8DFSwLk+zkZ
  YklhzFaOJ0gPUVyqrXW48CkuCnbxEaESzbz/WnepM81/W0xv9yvUFREqAQFBARIg3NYs5Gz/q
  +Po3AKyUIlP/guwZzJ+jdp3DuEyDvE+Mkr/BBW5p8UkY82NecsNx79lnB1i+dI77vlmXWHj2Q
  d2u4mNq4WN0i1mRUr03Yf7GwLcmlPOGn3LNc6PDoZ1pi3Xrf3+yy30bMjJGV1YmnZsp0V+9WJ
  8XEZYZpdnU9uFZ/p2btoT1qDOyDPtqJ9Eds2YQ9MbxlhmvY35SenpWC9PeWbvx94uzRmlatLh
  lv0jDIWM1uYP46Fz5rXAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-16.tower-246.messagelabs.com!1553857116!674714!1
X-Originating-IP: [104.47.5.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25499 invoked from network); 29 Mar 2019 10:58:36 -0000
Received: from mail-he1eur02lp2050.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.50)
  by server-16.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 10:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJLloaxDqqZ985m18yBvQE6prpkRJPeT5Ybaq9oGlHs=;
 b=VdEYMwE9Cuhta9Qo15h4+Uk0bi69NONkHc6qm6crngT+/SKUVvwOaRd8nh68hgRCpBkMPHcOwzIb12TVcoZan+0QG5y+HPQo/+7A8C+BOWD80KhKl2WOs35zsZE+sG0LO/kWdai+0KlWuMaICHzHnNmKaoWClZBtDkLwspm9RYY=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 10:58:21 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 10:58:21 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     LKMLK <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 3/6] mfd: da9063: remove platform_data support
Thread-Topic: [PATCH 3/6] mfd: da9063: remove platform_data support
Thread-Index: AQHU3aIjpa1TiRsVQ0CBMuD5pvTVD6YifQMg
Date:   Fri, 29 Mar 2019 10:58:21 +0000
Message-ID: <VI1PR10MB2352F9EC5D0D6EC16DAE6EE9FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be3b9d2-4918-49e8-256d-08d6b4357598
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB05123BBD5F3550F3C116B86CF55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(107886003)(256004)(86362001)(68736007)(71190400001)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(4744005)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XitevTwcwp2veYNjNHsOw3fPXKW/y/bdLiwUtWma/Ps8oB++8GY/qCrw+ejyZCk3UbbEP5zPT3lWhcxy/sdUxT/srpGBCqqcbjururFfDt/vdDRbqlpHagQN1NnSnpSdbF6Czm01WAiiFUWIYGJPb00m+rUSshp/5aOersU/gQI3hHDWrLzhxnDorrWZJNgcttcUGAtXgZPvNdemAvIukmpssq/tOkfXtldLKOqH069odGdaU4iyUbvDuDX6K4PeATpSzyaqCCWjR+tmQiI6SFOwfokXRbCQ2BqT7xI4MpV+lcJp9T7s8uvH4fRD2FAuLbg9KLo74wIp+0zaXTSMJjkJdLohig+gX0JyXKTIfu1iOd+hO0wwJD4/aReif6+/tMnFO2JNSUTTdQBE7KERi7Oii92mouhArszA6l9OmpM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be3b9d2-4918-49e8-256d-08d6b4357598
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 10:58:21.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18 March 2019 15:48, Wolfram Sang wrote:
> Subject: [PATCH 3/6] mfd: da9063: remove platform_data support
>=20
> There are no in-kernel users anymore, so remove this outdated interface.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-core.c | 20 ++------------------
>  drivers/mfd/da9063-i2c.c  |  1 -
>  drivers/mfd/da9063-irq.c  |  1 -
>  3 files changed, 2 insertions(+), 20 deletions(-)

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

