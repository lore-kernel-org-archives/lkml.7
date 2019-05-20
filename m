Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C885C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798820675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jfFCNwKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfETJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:33:40 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:5302
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730588AbfETJdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC1v7WL/In1X8Bj8Y7sCQQm/Z+fLIAOQv2tt/i/palw=;
 b=jfFCNwKM2i5w/KAF+j2xYcPZCsoPV1LqRQExzjOp8kIvSbWGCG0BtEtG8vSD1BrM/487+fsY4f6SglES/Xk09bc6AjeYdrkD6zG5V9X7+HAXpxM/wR07/lc2iWrxhU0KsA02LEKrbr/QxRpzjuxxSknT/6BShrrlI8PmcxHyhfo=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4225.eurprd04.prod.outlook.com (52.134.91.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 09:33:36 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:33:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Subject: Re: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Topic: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Index: AQHVDrkIcB6j+hDf/kC51b4HJvSviA==
Date:   Mon, 20 May 2019 09:33:36 +0000
Message-ID: <AM0PR04MB643466338B440374D97F2805EE060@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190520032020.7920-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ec81502-04ff-42b7-bbd5-08d6dd063bd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4225;
x-ms-traffictypediagnostic: AM0PR04MB4225:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB4225EF76794F0A4A3CCD3ADFEE060@AM0PR04MB4225.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(316002)(52536014)(7416002)(8936002)(86362001)(81156014)(81166006)(8676002)(446003)(486006)(6306002)(53936002)(6246003)(9686003)(110136005)(44832011)(66066001)(476003)(6436002)(7696005)(26005)(102836004)(99286004)(33656002)(71190400001)(76176011)(54906003)(7736002)(74316002)(71200400001)(186003)(305945005)(66946007)(73956011)(76116006)(91956017)(55016002)(66476007)(66556008)(64756008)(66446008)(4326008)(25786009)(6506007)(53546011)(68736007)(256004)(14444005)(229853002)(478600001)(966005)(5660300002)(2501003)(2201001)(6116002)(3846002)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4225;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xocE+hJKpi6ZmBJ1cS8ppTdyiP3gdUnzjUqU8kFuJFltkZGYmKv+nNRfVc0MkJUDhuP2Qxu3/G+WTjul9uIvTiw6eU/f8CZlsv1rWRNrlOvvWVhLMEcahpRgNsbkpsL+Fxw6fedSUpaFb2Z7N1WLlmEsf6lG/8p4lO7CHeTHgo6w12YnJ4Gp8pOE8PcQXwPqd6V5FNhSN5BDCmHcc9M0+cEf08YtkIaiVA+DtbpeOsJ52klyZhMvQNhed1fp7pmdg7d3NSMGflDmI9wbRsNwCxyTfmi6zUfo/RNH6vLvVRkPwSJaUur8ny9cEVhNuHSQlfVvdcy1g31iP/l61EzBJ2mD8Bo7bjaha/4So3v//QVsFfYOXKTCDKJDZcfX36eS5F2IabednVfTTrMxUTi+ngXXi5nEqzCDzBqCMMY8O4E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec81502-04ff-42b7-bbd5-08d6dd063bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:33:36.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2019 06:06, Peng Fan wrote:=0A=
> Introduce fusable-node property for i.MX OCOTP driver.=0A=
> The property will only be used by Firmware(eg. U-Boot) to=0A=
> runtime disable the nodes.=0A=
> =0A=
> Take i.MX6ULL for example, there are several parts that only=0A=
> have limited modules enabled controlled by OCOTP fuse. It is=0A=
> not flexible to provide several dts for the serval parts, instead=0A=
> we could provide one device tree and let Firmware to runtime disable=0A=
> the device tree nodes for those modules that are disable(fused).=0A=
> =0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> ---=0A=
> =0A=
> Currently NXP vendor use U-Boot to set status to disabled for devices=0A=
> that could not function,=0A=
> https://source.codeaurora.org/external/imx/uboot-imx/tree/arch/arm/mach-i=
mx/mx6/module_fuse.c?h=3Dimx_v2018.03_4.14.98_2.0.0_ga#n149=0A=
> But this approach is will not work if kernel dts node path changed.=0A=
> =0A=
> There are two approaches to resolve:=0A=
> =0A=
> 1. This patch is to add a fusable-node property, and Firmware will parse=
=0A=
>     the property and read fuse to decide whether to disable or keeep enab=
le=0A=
>     the nodes.=0A=
> =0A=
> 2. There is another approach is that add nvmem-cells for all nodes that=
=0A=
>     could be disabled(fused). Then in each linux driver to use nvmem=0A=
>     api to detect fused or not, or in linux driver common code to check=
=0A=
>     device functionable or not with nvmem API.=0A=
> =0A=
> =0A=
> To make it easy to work, we choose [1] here. Please advise whether=0A=
> it is acceptable, because the property is not used by linux driver in=0A=
> approach [1]. Or you prefer [2] or please advise if any better solution.=
=0A=
=0A=
Couldn't firmware parse nvmem-cells? Even without a full nvmem subsystem =
=0A=
it would be possible for imx-specific code to walk the entire device =0A=
tree, parse nvmem-cells and disable nodes which are disabled by fuse.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
