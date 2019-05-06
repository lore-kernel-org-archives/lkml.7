Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8DC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E98208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNUkiwvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEFJaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:30:13 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:37856
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfEFJaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTG/POUK8UI/L0ujDd/y+Ucvg0OFnOcCmy4xYS9HtZo=;
 b=PNUkiwvx6qPm+5ZXmvD9FEq9Em9iw3DD5aGZW0eEmCoe84xUE8NEsba6BjnWincgQWfAW9Bec5vFMaTjUlEkr5pXsJej4+8nR7FPdYUsqBdhGiHbpIlklhyq53kKbVTBJpLtGERgj1q30nbrvSiYRy/AN2sSxuQEv2ctuNubmXY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 09:30:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:30:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Index: AQHVA+yfLsIhjcoiP0Cce7rahIcrWaZd1FwA
Date:   Mon, 6 May 2019 09:30:08 +0000
Message-ID: <AM0PR04MB42114F9CDDAF2A740FC8E66A80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32b606ce-5565-4421-6141-08d6d2056e34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5139;
x-ms-traffictypediagnostic: AM0PR04MB5139:
x-microsoft-antispam-prvs: <AM0PR04MB5139CD02F6CF645FB3B9F86580300@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(199004)(189003)(2501003)(478600001)(6436002)(64756008)(7696005)(9686003)(66946007)(66476007)(66446008)(66556008)(99286004)(55016002)(76176011)(52536014)(316002)(256004)(3846002)(6116002)(25786009)(229853002)(476003)(8936002)(558084003)(446003)(11346002)(486006)(81166006)(186003)(81156014)(8676002)(7736002)(5660300002)(26005)(305945005)(6246003)(74316002)(33656002)(7416002)(53936002)(102836004)(2906002)(4326008)(44832011)(6506007)(53546011)(110136005)(14454004)(71190400001)(86362001)(71200400001)(2201001)(66066001)(73956011)(76116006)(68736007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +NmZgdY2eKAwLknMbsl8josCsxRZQzY/njRhgc1fDfYeGDMzLzokImT44twz2S8yjqkoHv0LC2zTURqKqecKrc9vxmiq7JNvIUkHssVvY1WGcxub8FhrUEakS1NcD6UBmnne/3TXQj226pIo/4MUEkzQo/NnslYy1tSKJja0/4Z8r/hkv/29xggiRdnHouAYVXk5s5LC9GQUCWJ4gCPK+HChO5DXh7Vsf4kApPwok6rppljFjgd6Pqqwj/xBd+gsT+IEJ/D7Y/DgZaGsfq0ANHLhqJOI4f/ZTMDgFbPK2SvImO7lTxwoW5q4QeVjhljOuyL+RJiZazUxs4hUEk4m2ie1jv1HJCfwmO46AaYXulD+fEBUvNgGKuWFKiIcd3Ct+F2LHnW0P83Ma0uJs+StydIPdr8rHuCpABXurpVDCkg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b606ce-5565-4421-6141-08d6d2056e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:30:08.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDE5IDU6MTggUE0N
Cj4gU3ViamVjdDogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bW06IEFkZCBH
UElPIGNsb2Nrcw0KPiANCj4gQWRkIG1hY3JvIGZvciB0aGUgR1BJTyBjbG9ja3Mgb2YgdGhlIGku
TVg4TU0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
