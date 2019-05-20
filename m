Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE4C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741520675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BIhkYpEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfETJhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:37:10 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:6430
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727720AbfETJhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo/4lm080txNdB8vZoo7pHmI2Q8NtdG6gVqwj+AIAIY=;
 b=BIhkYpEP7Iy57h06f/4qh2G9Y2wyw6Oygih6uZT/ZYjtA0kXsLUXySPFad8QNAkniOOd4bnzU44BEnX0c+hIO+ETbbFBCZexAq0HQ3z9p9bPxqoo7WYJ+KJfyygbKf+HPK1C1W20mnXAYnsJbNnhueVhetiUKZozkyaDDw+zQQ0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6596.eurprd04.prod.outlook.com (20.179.255.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 09:37:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:37:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Topic: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Index: AQHVDrkIcB6j+hDf/kC51b4HJvSviKZzwQ2A
Date:   Mon, 20 May 2019 09:37:04 +0000
Message-ID: <AM0PR04MB44813D1223FDB9266C9F90D388060@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190520032020.7920-1-peng.fan@nxp.com>
 <AM0PR04MB643466338B440374D97F2805EE060@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB643466338B440374D97F2805EE060@AM0PR04MB6434.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fedb471d-2867-4ce1-f3f5-08d6dd06b839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6596;
x-ms-traffictypediagnostic: AM0PR04MB6596:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB6596AE3A5D9ABD804AA95EFB88060@AM0PR04MB6596.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(305945005)(66476007)(64756008)(76116006)(66446008)(66946007)(66556008)(256004)(14444005)(73956011)(2906002)(186003)(316002)(71200400001)(71190400001)(66066001)(26005)(110136005)(7416002)(5660300002)(7736002)(33656002)(102836004)(11346002)(476003)(54906003)(3846002)(6116002)(99286004)(966005)(74316002)(9686003)(76176011)(44832011)(14454004)(486006)(7696005)(53546011)(6506007)(8936002)(68736007)(81166006)(81156014)(6436002)(6246003)(86362001)(8676002)(2201001)(478600001)(53936002)(6306002)(25786009)(52536014)(55016002)(2501003)(446003)(229853002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6596;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nAoXYNwnOcLA/ASD8hstzYykuYIyuFj4NnwIQYO+kkLv9R0Ja4PVGiDrtU1WK5CVutb4JZOebop3wGgp7Tajo8bkZOyCF7f6n+4awpYga6JSA9aky4mb1p0V25/JtpVmVwjjdsAL4VUP5YdNv6QAGjrgSNQmUBt5i4MiczpcT0qQElX+9+BBAjRU+HOW1ErI5nQF7svudm3wAlsMBjUdrmtawoQEJuYQgGJND+8t6qa/tmLvsnOZap2LWn3eReVduJNhmc7snfNDGbNdgEpnGMbsdSbu9hYzK9J/QM+rzLZMUyC+4HOlDdj5jvk/FaSFIOCCM04Ki1LfaJ+8n/XHhcK1oTKTYADci3Vv0R2QyKPFAvPVmYgR1ZkmaUasUjOp2/ZyMIQYybOa2j04sFcmXSv4X7++oTOeHBXn9glMvqI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb471d-2867-4ce1-f3f5-08d6dd06b839
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:37:04.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
>=20
> On 20.05.2019 06:06, Peng Fan wrote:
> > Introduce fusable-node property for i.MX OCOTP driver.
> > The property will only be used by Firmware(eg. U-Boot) to runtime
> > disable the nodes.
> >
> > Take i.MX6ULL for example, there are several parts that only have
> > limited modules enabled controlled by OCOTP fuse. It is not flexible
> > to provide several dts for the serval parts, instead we could provide
> > one device tree and let Firmware to runtime disable the device tree
> > nodes for those modules that are disable(fused).
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > Currently NXP vendor use U-Boot to set status to disabled for devices
> > that could not function,
> >
> https://source.codeaurora.org/external/imx/uboot-imx/tree/arch/arm/mac
> > h-imx/mx6/module_fuse.c?h=3Dimx_v2018.03_4.14.98_2.0.0_ga#n149
> > But this approach is will not work if kernel dts node path changed.
> >
> > There are two approaches to resolve:
> >
> > 1. This patch is to add a fusable-node property, and Firmware will pars=
e
> >     the property and read fuse to decide whether to disable or keeep
> enable
> >     the nodes.
> >
> > 2. There is another approach is that add nvmem-cells for all nodes that
> >     could be disabled(fused). Then in each linux driver to use nvmem
> >     api to detect fused or not, or in linux driver common code to check
> >     device functionable or not with nvmem API.
> >
> >
> > To make it easy to work, we choose [1] here. Please advise whether it
> > is acceptable, because the property is not used by linux driver in
> > approach [1]. Or you prefer [2] or please advise if any better solution=
.
>=20
> Couldn't firmware parse nvmem-cells? Even without a full nvmem subsystem
> it would be possible for imx-specific code to walk the entire device tree=
, parse
> nvmem-cells and disable nodes which are disabled by fuse.

Firmware could parse nvmem-cells, but there are lots of modules that could
be fused. If using nvmem-cells, that means need to add nvmem property
for all the modules that could be fused. To make is looks cleaner, so intro=
duced
a fusable-node property.

Regards,
Peng.

>=20
> --
> Regards,
> Leonard
