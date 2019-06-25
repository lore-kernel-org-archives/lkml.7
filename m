Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BEC48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27201213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ylmwq1gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfFYOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:22:04 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:39335
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728252AbfFYOWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyjNARllyvJSmD8LmaYeP4Xkh6ob0o5S2vQ5dg9Y3fk=;
 b=Ylmwq1gSB0exWozTN+z8I7q6cNSPhy2BpVivVl0wPnFGjOmXOvGDcANfiKkcTQ6oobXsI+QEPOt9kqanVL1rsB352GRxnVPwqdOxerLakJgPYiIYhJNUwXbdGiTmRqylpsh03WcRazMd95e5mkhIQsljTYTtygQVQEfiDTknl+E=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB6976.eurprd04.prod.outlook.com (52.133.246.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:22:00 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 14:22:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, Jacky Bai <ping.bai@nxp.com>
CC:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Init rates and parents configs for
 clocks
Thread-Topic: [PATCH] arm64: dts: imx8mq: Init rates and parents configs for
 clocks
Thread-Index: AQHVK1SzBLyg7yu1NUGWmKUxLWsOPA==
Date:   Tue, 25 Jun 2019 14:22:00 +0000
Message-ID: <VI1PR04MB50550ACBAEA73FD7B5A97DD8EEE30@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <1561467081-25701-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9626825-8f06-44b0-7087-08d6f9787cd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6976;
x-ms-traffictypediagnostic: VI1PR04MB6976:
x-microsoft-antispam-prvs: <VI1PR04MB6976E904E8DE81270D21A23EEEE30@VI1PR04MB6976.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(6246003)(52536014)(305945005)(316002)(6436002)(66066001)(6116002)(74316002)(102836004)(25786009)(76176011)(110136005)(55016002)(68736007)(7696005)(54906003)(8936002)(26005)(9686003)(14454004)(4326008)(7416002)(229853002)(256004)(2906002)(86362001)(8676002)(81166006)(53546011)(478600001)(186003)(7736002)(5660300002)(44832011)(81156014)(53936002)(33656002)(6506007)(486006)(73956011)(476003)(71200400001)(71190400001)(99286004)(6636002)(66946007)(64756008)(76116006)(66446008)(446003)(91956017)(66476007)(66556008)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6976;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PIfCXF/oVmzJipsl0N3MIYOBzh0g6iyev9ly/P3+S35VF05jkHe5tPph02rXbps9LMzjxJBXI1tOcgUMo+NpaOG0F58tgGWUPhtvlHu+AVwFkfWpSwjmNWSMne+wDO3Te2xlnCyOqdEsONUgdcnlDVaADv/E51Vq1sysCTofODXS4CzI6pH5zWJmT3cOrxWp//xCHRZN/9Nu2aLESCu/ITfER8l5wcsq+obvH4Vg8OvCF6jOXJY8/WW+PNYK8jcUhfS3fPw+OMvLtEbvNeDBHMkawJaRhAGVj6iRR9SGXoDfKd2w0I+0oxFOJ2Ef7tLBnoa/uHX8Zfpkf87Q8Qi5ztCHJme/cdlSTCXbp58OD4JFabKT2S4p1LtSo0Akytfa6VMGVnn0zAHv4ISeUMeUL3Ohu3cSYgeE/KQg4F+YunU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9626825-8f06-44b0-7087-08d6f9787cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:22:00.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2019 15:51, Abel Vesa wrote:=0A=
> Add the initial configuration for clocks that need default parent and rat=
e=0A=
> setting. This is based on the vendor tree clock provider parents and rate=
s=0A=
> configuration except this is doing the setup in dts rather then using clo=
ck=0A=
> consumer API in a clock provider driver.=0A=
> =0A=
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> ---=0A=
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 34 ++++++++++++++++++++++++=
+++++++=0A=
>   1 file changed, 34 insertions(+)=0A=
> =0A=
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi=0A=
> index d09b808..e0abe02 100644=0A=
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi=0A=
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi=0A=
> @@ -489,6 +489,40 @@=0A=
=0A=
> +					<&clk IMX8MQ_CLK_PCIE1_CTRL>,=0A=
> +					<&clk IMX8MQ_CLK_PCIE1_PHY>,=0A=
> +					<&clk IMX8MQ_CLK_PCIE2_CTRL>,=0A=
> +					<&clk IMX8MQ_CLK_PCIE2_PHY>,=0A=
> +					<&clk IMX8MQ_CLK_CSI1_CORE>,=0A=
> +					<&clk IMX8MQ_CLK_CSI1_PHY_REF>,=0A=
> +					<&clk IMX8MQ_CLK_CSI1_ESC>,=0A=
> +					<&clk IMX8MQ_CLK_CSI2_CORE>,=0A=
> +					<&clk IMX8MQ_CLK_CSI2_PHY_REF>,=0A=
> +					<&clk IMX8MQ_CLK_CSI2_ESC>;=0A=
=0A=
This stuff (and NAND) looks like it would belong to device nodes instead.=
=0A=
=0A=
The rest seem fine though I'm not sure why exactly those clks are =0A=
adjusted in vendor tree.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
