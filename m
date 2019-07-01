Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D6CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12239208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmqZP4N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfGANUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:20:53 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:60671
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGANUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaUAOPXohnVzqkJWmyYjhVRxTzpR9ETGSfw0coirnpU=;
 b=BmqZP4N45I/2fHOuCtgjfLP3ZAJet3nMAo+14RhKTh0uxm5AoT7GLIxlr/ZQjoVTiUH8rMwpb+W/OhXrm0WMY4vhQAub9M6s4qdVqOW1mt9d833ln8iCntkmxgB1nMoT50decNxniXVdZhlUjBM29UCIr/KCeR50Z/itUMNyIZQ=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5133.eurprd04.prod.outlook.com (20.177.50.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 13:20:49 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 13:20:49 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
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
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH V2 1/2] arm64: dts: imx8mm: Correct OPP table according
 to latest datasheet
Thread-Index: AQHVLmXFrcvuT+m33U+Utu0uFxLfsA==
Date:   Mon, 1 Jul 2019 13:20:49 +0000
Message-ID: <VI1PR04MB5055B324BD963A50698A0AA9EEF90@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190629102157.8026-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87341a7a-cb93-4da3-a19e-08d6fe26ef54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5133;
x-ms-traffictypediagnostic: VI1PR04MB5133:
x-microsoft-antispam-prvs: <VI1PR04MB51337C39C1D510A69D7404B6EEF90@VI1PR04MB5133.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(66476007)(66556008)(66446008)(66946007)(64756008)(44832011)(66066001)(446003)(86362001)(81156014)(53936002)(55016002)(8676002)(81166006)(25786009)(6246003)(316002)(73956011)(486006)(52536014)(54906003)(478600001)(14454004)(71190400001)(71200400001)(76116006)(91956017)(476003)(33656002)(9686003)(110136005)(7416002)(76176011)(53546011)(6506007)(102836004)(229853002)(5660300002)(26005)(186003)(2501003)(256004)(4744005)(99286004)(7696005)(6436002)(4326008)(8936002)(305945005)(7736002)(6116002)(3846002)(74316002)(68736007)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5133;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SItNQtVosjwD7wxDstdr9fpgogvf1z9tMFPOFSKY9ie2CqihiE9AQJrVGVrg2Q5g43Q0EVClLvpDmYXyowYupni8sabTO4SMGj+BK+/o37M1p3BGQVOxqHWp6om703LXwHLyV76DsL55eXCsvjB/caWKUpsIkvB176AZISZJyOsEpAhIUnYobAwfw7/z/daSJtLgv1o26ky0pLBw9+dMZKMoquKWiTi8fgjW0rqko+zBb7qGLRlKR6BB92azR8JiULgmsh+vlR40vpjzBKtLlcTTkMX51dWdzlGiD5qIuab36MbR1M7iuWasP+KW/Cv3TvApqrh9C8AuqaNG63hMsf5cdJlGKwgyovDj1UGu8Aw3EBrua+yd41AScq0iN2dZ5nIE4IbWPYpdT61YiGT9/z14yAopUNfl3xilS8no/Uo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87341a7a-cb93-4da3-a19e-08d6fe26ef54
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 13:20:49.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2019 1:31 PM, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> According to latest datasheet (Rev.0.2, 04/2019) from below links,=0A=
> 1.8GHz is ONLY available for consumer part, so the market segment=0A=
> bits for 1.8GHz opp should ONLY available for consumer part accordingly.=
=0A=
>  > Fixes: f403a26c865b (arm64: dts: imx8mm: Add cpu speed grading and =0A=
all OPPs)=0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
For both:=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
The vendor tree goes through a lot of testing so switching to the exact =0A=
speed grading interpretation from there does make sense.=0A=
