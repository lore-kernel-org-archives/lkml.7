Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3976C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A719120B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oMOR7NZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfFNBT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:19:27 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:65470
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfFNBT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXTU5iglnJrpZWNNHbPsjDUZTOhk1/ltTjfbfExQW8g=;
 b=oMOR7NZmLMjo2HsJztty7b0BdAkGpIPqRuqTLF8092vPXRgsz6t924jpziA59MlPLo9muThqQFLqA3qQJoZ/k6VHDTO09AcVBJKDnu9HN3Crn+Ci9Q7Cz2ICaytT/a3JqIy7H1z5ZCJKjc6gEK/V9LOsNF3N9aVo+BU5eviAToY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6210.eurprd04.prod.outlook.com (20.179.33.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 01:19:23 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015%3]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 01:19:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Topic: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Index: AQHVDrkIcB6j+hDf/kC51b4HJvSviKaaWkOAgAAkkhA=
Date:   Fri, 14 Jun 2019 01:19:22 +0000
Message-ID: <AM0PR04MB4481288D0D1B8DA704FEF82B88EE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190520032020.7920-1-peng.fan@nxp.com>
 <20190613230055.GA19296@bogus>
In-Reply-To: <20190613230055.GA19296@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761aecd4-e36c-4c9c-f86b-08d6f066557b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6210;
x-ms-traffictypediagnostic: AM0PR04MB6210:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB621072CB798FE86C7CC558AC88EE0@AM0PR04MB6210.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(68736007)(74316002)(6436002)(229853002)(55016002)(446003)(102836004)(14444005)(6306002)(26005)(6506007)(11346002)(476003)(86362001)(2906002)(486006)(44832011)(66066001)(6916009)(4326008)(9686003)(76176011)(305945005)(25786009)(53936002)(7736002)(8936002)(256004)(478600001)(76116006)(73956011)(33656002)(316002)(52536014)(7416002)(14454004)(6246003)(6116002)(8676002)(54906003)(71190400001)(71200400001)(966005)(81166006)(186003)(81156014)(3846002)(66556008)(66446008)(66946007)(7696005)(66476007)(45080400002)(64756008)(99286004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6210;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pmwpbjBoOhWhGzNz/tNnbxtffYrouy9B/70hn0lgZPXN+FEXJ46/jhDQZbQxuVyfn3ytT15osbhBICM6LvvBhC1FWceZZaGyacH3bDRVe64Wyx6EEbR75mouM8/XoG5W0Jq2N2zEdpmafTiGdDEPjgSPqKTxvpKrAn4vBqGSvpeKJlckk/hwHWhWbIcZEUdhlJFpk3wBZSAPbofvfDSKxzFSCupGw17aPOSJuq4pVAjvnTA4D7ig+LN1O8/ggeui6xQdl/dmHedlNw6MrfAYANRNLQDIg7zBvQo022ktF/MSBoMCNfxdAJt1wITkYewCd3hth9JSL8I7xeUN26dfF4qTJDYqdIBsj9BlMX4D4GTC4IiSdsoAIz84K9djZMJwak7OGKcrEDriYXGIvMwkWwayKu0KDPYXsTUqyuexf0g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761aecd4-e36c-4c9c-f86b-08d6f066557b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 01:19:22.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
>=20
> On Mon, May 20, 2019 at 03:06:35AM +0000, Peng Fan wrote:
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
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
r
> >
> ce.codeaurora.org%2Fexternal%2Fimx%2Fuboot-imx%2Ftree%2Farch%2Far
> m%2Fm
> >
> ach-imx%2Fmx6%2Fmodule_fuse.c%3Fh%3Dimx_v2018.03_4.14.98_2.0.0_g
> a%23n1
> >
> 49&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Ceb74876c943c4471d7f
> f08d6f05
> >
> 2fffb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63696063660
> 6051306&
> >
> amp;sdata=3DMrjCP0ufBu3uTb1ehTEu2g5eSQuYcho4UxuR9KUFEOA%3D&amp;
> reserved=3D
> > 0 But this approach is will not work if kernel dts node path changed.
>=20
> Why would the path change? The DT should be stable.

It changes sometimes, such as
efb9adb27475 ("ARM: dts: imx6ul: Remove leading zeroes from unit addresses"=
),

in bootloader, we are using node path, so if the node name changes, the boo=
tloader
will fail to disable the node.

Thanks,
Peng.

>=20
> Rob
