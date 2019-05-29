Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4436DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CB2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JA5CR2KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE2KZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:25:16 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:61248
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfE2KZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXKIyHYWRL/5yD5Hh+pQ0F4XUIBGy3kBE/ZPXYhtL3g=;
 b=JA5CR2KZNqJa8xUoTAif4joAFRYZLWvtNQEi8UxyXfGdETRR47O8lpwIJPHu9rtz/KyjZtAEoaMC/3YVDwSw4iU/YE1PxMBBLKL18Gh796tdfHOaDOUGZK6mUq9aJgjpmBz3Mh6wciXoHhMPGY0RMIc4pkbbbUxwJPuA/duIJH4=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB3135.eurprd04.prod.outlook.com (10.170.229.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 10:25:10 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 10:25:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Make SW2's voltage fixed
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: Make SW2's voltage fixed
Thread-Index: AQHVFeqgtOd5kX+KPEOTGMPKRjBjKg==
Date:   Wed, 29 May 2019 10:25:10 +0000
Message-ID: <VI1PR04MB505512BC507108ABC7620F4AEE1F0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190529065056.27516-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a87c4d-e2b5-40d9-089b-08d6e41fee09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB3135;
x-ms-traffictypediagnostic: VI1PR04MB3135:
x-microsoft-antispam-prvs: <VI1PR04MB31352E515814F1B1298C48CAEE1F0@VI1PR04MB3135.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(14454004)(8676002)(7696005)(66476007)(66946007)(76176011)(446003)(81166006)(53936002)(6436002)(64756008)(8936002)(66556008)(6506007)(66446008)(33656002)(73956011)(102836004)(91956017)(305945005)(2906002)(81156014)(74316002)(3846002)(99286004)(7736002)(76116006)(110136005)(54906003)(26005)(186003)(316002)(229853002)(6116002)(9686003)(68736007)(71190400001)(476003)(55016002)(53546011)(6246003)(66066001)(52536014)(4744005)(478600001)(44832011)(4326008)(2501003)(25786009)(86362001)(5660300002)(71200400001)(256004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3135;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9OXalPQEc9KOb93PjJhwt30DnSdiZuwA5fgbQjA7mmWcKs2RFOHNV6VL/rcee8Py8hMuXRCJZrwtr/3bgCDubDiGZvrPtNGx1eoy6thqewojsTziptHZqbamBF0fCh3H+zrQgkpGLxzr0ygItMwyprVhS/JQySaMovd+Z4urmrXVdhs41YsgHegCFYCSL2SfVfzsZTZNl532Cm6HGIabID2wNyt5pjvutshmCvhuruMy4lpZpG6XKngTRQ3nvnikUXY6/dh9mw6RIH5uCB7ym7/9NfhOYVclNC/OJkwdLfBPQY8K9r6l+sJzlbU8Wmof41LiDl0GOJR1WjY+u4rEchURZqJGe/ZQMM9LE5TENsiYmlsQJbtgEvZWTzO2HlyqfISrqT+H3g6KLo+rMY1GwzcKxIH+zSNJocuJs3rwq8k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a87c4d-e2b5-40d9-089b-08d6e41fee09
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 10:25:10.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.2019 09:49, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> On i.MX7D SDB board, SW2 supplies a lot of peripheral devices,=0A=
> its voltage should be fixed at 1.8V. The commit 43967d9b5a7c=0A=
> ("ARM: dts: imx7d-sdb: Assign corresponding power supply for LDOs")=0A=
> assigns SW2 as the supplier of vdd1p0d, and when its comsumers=0A=
> pcie-phy/mipi-phy try to set the vdd1p0d to 1.0V, regulator core=0A=
> will also set SW2 to its best(min) voltage to 1.5V, and it will=0A=
> lead to board reset.=0A=
> =0A=
> This patch makes SW2's voltage fixed at 1.8V to avoid this issue.=0A=
> =0A=
> Fixes: 43967d9b5a7c ("ARM: dts: imx7d-sdb: Assign corresponding power sup=
ply for LDOs")=0A=
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
Other boards don't seem to be affected by the original series.=0A=
