Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2036FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15F7218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZHj2rcAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfCAHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:35:24 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:58948
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732081AbfCAHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAN1xW4qhddjp1atXK3zEGsqPHX8MTz/4NzjSC5UuN8=;
 b=ZHj2rcATvcPoWUp7EG0wCIy6laGphyg96EFcsLVVqBejTjZDv4wdkRPmcpSTwDchldE6OmZDVjw0emiohVBvGkfL2ELbsS1IBYasXZVKSaW9++ryl4tIr3SA4jA4pbddBuo8unuAIlu5iolFybMijanEepGOVOmWQkzjblKoKEg=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (10.171.182.161) by
 VI1PR04MB5966.eurprd04.prod.outlook.com (20.178.123.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 07:35:20 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c08b:b438:76b7:d47b]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c08b:b438:76b7:d47b%6]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 07:35:20 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: ls1028a: Add Audio DT nodes
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: Add Audio DT nodes
Thread-Index: AQHUyPlkY9LgOd8RWUqBQj6Qddk5kKX2Hn8AgABRvCA=
Date:   Fri, 1 Mar 2019 07:35:20 +0000
Message-ID: <VI1PR04MB4062B92CC89BA1DC4591426EF4760@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20190220084457.31357-1-alison.wang@nxp.com>
 <20190301024107.GN26041@dragon>
In-Reply-To: <20190301024107.GN26041@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd468d91-e348-4889-c66e-08d69e187550
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5966;
x-ms-traffictypediagnostic: VI1PR04MB5966:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5966;23:2XQvt5fY9rDylTePQI7AkoDWxxjF8r+NP5F+u5B2n?=
 =?us-ascii?Q?sDQyk3Ivha5jBSfsiug+ekUaI+2aRu+XRfzeJgtXxzZhDaSEIYIDEz+NVsFY?=
 =?us-ascii?Q?aONmswGGose4AFVYlK0EZXlZu6YPu5n0hcRPoq7DikW75uihShiZHAOrbwcr?=
 =?us-ascii?Q?g4dw0oRWIuY5pqI9zgfzQgh/f39+ywV0CCjkQTXSYb1nXqcbn3itsROwtBmw?=
 =?us-ascii?Q?7/s6k/e8RzXk+30U7fKaALIhdEn57gec2glYWE/Seq4j7CV7l3z2OqlO3LUr?=
 =?us-ascii?Q?zEsh8F4htV63P9UQF8f+lAfx664nPMpmYzb5ZN66rKsL20bwtFwBpgSv7X/H?=
 =?us-ascii?Q?Gahc+dckj4l4qgMorttO9JdjAbMi5/xh0Y6FYQRY/1Af3ENwexO+zPXGPQG2?=
 =?us-ascii?Q?B50qgEw6MtHUzmrVZO+C///SeDy/ENBvoc6qyUxOxSVwrKYFfcQTUTZY+0Fi?=
 =?us-ascii?Q?e/CExbDylAV2x9byIqfkaRe732R5OOm7XLl/b+kZiZ+81AgBnbCgPrHqvFgy?=
 =?us-ascii?Q?C49pqJUQvuhIzpwVsiZZgc0rqF0AjP2SaZnEu8Xz/Z021hAmbj4NQbr6DulO?=
 =?us-ascii?Q?m2U0Yxep+Ath/f8ohljEenOJUgoN8AZ4qi32kH+7wyANtud6mIl3l65PwHRf?=
 =?us-ascii?Q?iMUSmGoVNJdCaAyh64bP6wwJd8sAmayMaAWhAIwoZHTm3WzF91hOM2bvjhzI?=
 =?us-ascii?Q?GeBwOr9DQlHqrWtEXMAx0LLBLDHfj96Ziro5oxjk7Hxt28bNerhszsMYLcc7?=
 =?us-ascii?Q?2iuOkKGS/DoyOSOXOfXh88jOcBL2ziWkZ5p/xyG/QJYdphBAtOu4rKsfd9Vb?=
 =?us-ascii?Q?pm7qtSuqg182YvyOX6MpuXNwy4Lvu4MSQqdtMKpH69QdjF0ZBsZj409vU1kS?=
 =?us-ascii?Q?2mK17+AAio94XxH8T8meOyidRN6jqPO7st892gMQ5Oc9nujPZHxsyqS3f7Xt?=
 =?us-ascii?Q?YZm20Jh7sGValBDWYqsAKz/zGAGelGpuHhqKDWXLzgYW5GieumuiqmGIK9s8?=
 =?us-ascii?Q?DX9kg3cTa6FeFVv697CIjsVw+tWjhl4cXJF9Fgbm3fPUcUqyOFez13/KUy7S?=
 =?us-ascii?Q?PugI3Onzl80ifx8W7U2fR5sPc/k0AodfpOjFllTasMhESqY/DxBbNdzja9cm?=
 =?us-ascii?Q?Z2gXCUBtJ58xTSHDQdCbkwzps2VjD8VOSXe9LZf/mqeV8JvdT/07ooALyrUl?=
 =?us-ascii?Q?37cRUTa784wzvb9TfDGuxSrHqEcMQ69kCHY8B4i4d8o7aChMs33+6hyUqDqF?=
 =?us-ascii?Q?28Qh+JYamPVvAam//Y=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5966FC411AF63387C112A751F4760@VI1PR04MB5966.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(6506007)(53936002)(478600001)(7696005)(25786009)(6116002)(76176011)(316002)(3846002)(33656002)(99286004)(14454004)(55016002)(4326008)(8936002)(2906002)(6916009)(54906003)(14444005)(102836004)(9686003)(6246003)(6436002)(256004)(186003)(7736002)(66066001)(74316002)(229853002)(44832011)(26005)(71190400001)(106356001)(71200400001)(97736004)(446003)(305945005)(105586002)(476003)(8676002)(68736007)(11346002)(86362001)(81156014)(486006)(5660300002)(52536013)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5966;H:VI1PR04MB4062.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gafi4uIWagIGx516WSXgCMVyeVBLO7kIXwq/Ihyn6Xckg2CFdfTnLNszWWL8RCQYcC89pOSBpx3ZA4JJ3kasM6V0/HzKm/ODbr0BMcNPoOrXP/WYpZEkuuZiMojKGp4nxLeQmq4fM1VUaKljYY07fhFIvsi2x577GrOT0LEMRPktRkdIK/3Dz5juRCbJOrfTHEuUIoI+O1CgJEakBR4CqIDFAdDVo48qh9soTCyqr5KoBZFn/gvzg0/9hDTRk4/l4NcgqDNkoXxO62TmNe+sVyhbERck8TQH3hdVxBkmGY8W71HlZAKBLmANFXp/N0kJwSk9S3yFZYKzVUTDV0kVw9oPis80UZ1ICg5gsbBzB7U7320ANYEZFyAUGUFbknZ5lyL2B8zstCh8jjL3OTPOO7H31Qbyr6VS4vjlwIhQzVk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd468d91-e348-4889-c66e-08d69e187550
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 07:35:20.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 20, 2019 at 04:44:57PM +0800, Alison Wang wrote:
> > This patch adds Audio DT nodes for LS1028ARDB and LS1028AQDS boards.
> >
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > ---
> > Changes in v2:
> >  - Modify some nodes' names.
> >  - Use GIC_SPI and IRQ_TYPE_LEVEL_HIGH.
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |   62
> ++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   63
> +++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   57
> +++++++++++++++++++
> >  3 files changed, 182 insertions(+), 0 deletions(-)
> >  <snip>
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index a8cf92a..de590ec 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -335,5 +335,62 @@
> >  				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207
> IRQ_TYPE_LEVEL_HIGH>,
> >  				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209
> IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> > +
> > +		edma0: dma-controller@22c0000 {
>=20
> Please sort the node in unit-address.
>=20
[Alison] Ok, I will update it in v3. Thanks.


Best Regards,
Alison Wang

