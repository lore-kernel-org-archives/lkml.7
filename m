Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF1C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3B9205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hi7o1FyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfEFIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:41:06 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:51073
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfEFIlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYAuytaKdTbfFDfpKrRiUutHT3PbAmEELR40NvmdQdg=;
 b=Hi7o1FySJSBXUTlVsXdQaQRdSw0buPJX242mg0WTs7hOVsCuj20kl2OUU7LdrQiUsG+hbiVjKtRSPtWCawXu0sV17aWBaMLZ92d0smBQmnPp3lXXK+c0M3VF9Nq3V2GTJG2R15rODcKJX8G5quU2XX6Sxr0fEgobxBWqdf9PLpM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5523.eurprd04.prod.outlook.com (20.178.113.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Mon, 6 May 2019 08:41:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:41:01 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] ARM: dts: imx6sl: Assign corresponding clocks instead
 of dummy clock
Thread-Topic: [PATCH 1/2] ARM: dts: imx6sl: Assign corresponding clocks
 instead of dummy clock
Thread-Index: AQHVA7uKX2mzfOc840Ke1bKA2KP6TaZdxwNg
Date:   Mon, 6 May 2019 08:41:01 +0000
Message-ID: <AM0PR04MB42117D0A376B84EBFEE7AE9F80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cc6504d-d3fa-4799-7afa-08d6d1fe91ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5523;
x-ms-traffictypediagnostic: AM0PR04MB5523:
x-microsoft-antispam-prvs: <AM0PR04MB55236A421348F4EAE8CFB9AD80300@AM0PR04MB5523.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:204;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(476003)(86362001)(2201001)(486006)(44832011)(4326008)(3846002)(99286004)(6246003)(558084003)(110136005)(6506007)(316002)(66066001)(256004)(25786009)(53936002)(14454004)(5660300002)(186003)(74316002)(71190400001)(71200400001)(8676002)(81156014)(6436002)(2906002)(478600001)(68736007)(7736002)(81166006)(8936002)(33656002)(26005)(52536014)(66476007)(229853002)(64756008)(66556008)(76176011)(66946007)(66446008)(446003)(11346002)(2501003)(7696005)(102836004)(73956011)(305945005)(55016002)(6116002)(9686003)(76116006)(921003)(32563001)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5523;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sm3YZs9i5O7cuwFU6j1F4g1/1WtURtCJH8WuX78cFG1bsNr2/RxDRiPuMXP8XAM6DlVPX9hi7WVuu/qF20src28n/d/u7XXR28fr1+QcqJ3ARAltRN0hi2T6uFqsVwHFm2rKxzuvYmJh1kiNq9Iwfpa3FIzoLrQhoiPZenhUpWr89i2JYFU/rzAhWAl5SWxhI2dpiNMeaw0lHFnI2bRpfDj1R8qpGH4UgqO3uy8S1/KZkXsU21Q/HHjPWqJuiD4PXeYVQ+rLD2f8eOLNoPV6hFgWDQYhGLybdbe/3S0zyIqXDD8jX7qJ7XeKEHUgcdzVBqQDWqJ6k1FMcz2k2gHj+RgBTGoVTgQBQ2qkzkJd8WVXU3nv4KdS2nZ+P0ukuoAM/VB2ADRCUptcu2CCgYP5aYrM2SA9mQndo32kDlHOPA4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc6504d-d3fa-4799-7afa-08d6d1fe91ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:41:01.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDE5IDExOjI3IEFN
DQo+IA0KPiBpLk1YNlNMJ3MgS1BQIGFuZCBXRE9HIHVzZSBJTVg2U0xfQ0xLX0lQRyBhcyBjbG9j
ayByb290LCBhc3NpZ24NCj4gSU1YNlNMX0NMS19JUEcgdG8gdGhlbSBpbnN0ZWFkIG9mIElNWDZT
TF9DTEtfRFVNTVkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
