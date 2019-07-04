Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D09C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536662133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNlvGOO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDHtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:49:12 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:45390
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfGDHtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg3YVZyZix9ibFcYWOAmR1P6Nh6H6haGJXEGrezCKN0=;
 b=MNlvGOO1bE3gwqoiyFfMX5odP8T+TWf78MbA83x0OAD/GJt9aK4yiMkabyBGFRCZ1Wtv4OHc0r4HwAg6lsU+phZs4bX5n99clwnjuGwiMzfMaoQboWr9WzKV0rsyRHrFoy/bzsEU0+ModE6TGHFKOzC1r7FX4uiD3tYO2ipyPfU=
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com (20.176.234.223) by
 DB7PR04MB4185.eurprd04.prod.outlook.com (52.134.111.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Thu, 4 Jul 2019 07:49:07 +0000
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc]) by DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 07:49:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend opp
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend
 opp
Thread-Index: AQHVMjEDVn995bhE70i5OsdReRFRhA==
Date:   Thu, 4 Jul 2019 07:49:07 +0000
Message-ID: <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f05be104-3873-4909-9548-08d700541803
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4185;
x-ms-traffictypediagnostic: DB7PR04MB4185:
x-microsoft-antispam-prvs: <DB7PR04MB41851512C4255B5A3548A931EEFA0@DB7PR04MB4185.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(33656002)(9686003)(71190400001)(81156014)(81166006)(102836004)(26005)(229853002)(446003)(55016002)(53936002)(6116002)(8936002)(316002)(54906003)(71200400001)(186003)(110136005)(476003)(44832011)(486006)(3846002)(91956017)(6436002)(7416002)(478600001)(68736007)(76116006)(73956011)(6506007)(15650500001)(6246003)(4744005)(7736002)(66946007)(305945005)(64756008)(66446008)(66556008)(66476007)(86362001)(14444005)(256004)(5660300002)(4326008)(2501003)(99286004)(53546011)(52536014)(76176011)(66066001)(74316002)(25786009)(7696005)(14454004)(8676002)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4185;H:DB7PR04MB5051.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PRJDAL7OvTH5whHzKkeF/40C9fZaeEpPHcI9fzXDbyWGVTmzg8YmFbx9mWBlwatAcZFEn9dpR6rdKRucH83HyO0+3kgnGgKWgdA8UThJaaPeLQC46dIcAAxA5wmYxgS/Y7N4sMlXg1h2avH58VK0EA91JNC5ZVIarVFqwCR84jep+WVFoEdU5x+1+9iKgih0U6rpSYtyPRA9SSH2A1H8kwjvGqFDrSgdx81wCfqWUGKbQO4DdR+h5/ngmOMgqQ/AW7k8+pMxXc1sC5LVg5XyjTtrZKTJ9pNVh8M3M6B8980hKuu9HcE93utaqZvKIoy9hCpHEf3tbc6S4sg28Rx1F3ktv6e4ukziKdAHWxjFpU/X2XzjdikA6H9sc8pJyhyOUeBpnxS/2oDiNvdyVXQzuvxq8eUgOIElCuqHotIz4jk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05be104-3873-4909-9548-08d700541803
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 07:49:07.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2019 9:23 AM, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> Assign highest OPP as suspend OPP to reduce suspend/resume=0A=
> latency on i.MX8MM.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
> ---=0A=
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mm.dtsi=0A=
> index b11fc5e..3a62407 100644=0A=
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi=0A=
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi=0A=
> @@ -136,6 +136,7 @@=0A=
>   			opp-microvolt =3D <1000000>;=0A=
>   			opp-supported-hw =3D <0x8>, <0x3>;=0A=
>   			clock-latency-ns =3D <150000>;=0A=
> +			opp-suspend;=0A=
>   		};=0A=
>   	};=0A=
=0A=
What if the highest OPP is unavailable due to speed grading? Ideally we =0A=
should find a way to suspend at the highest *supported* OPP.=0A=
=0A=
Maybe the opp-suspend marking could be assigned from imx-cpufreq-dt =0A=
driver code?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
=0A=
