Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D2DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982920873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALcdt6qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDKGt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:49:27 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:17793
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfDKGtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/9EcqfVbs1druarHyGnViAYuPQjQvniKVcbzxhfRl0=;
 b=ALcdt6qcZcb4PA+m73YefLGHMyR+BVmvA+cRzTYEPaH0fUrutzQs7m3LUqsDLw8fRQhyObZi11F6nGyYusXBJ6OsKVIWUwk2zGubhEvEarYpT5Y5p7EZuqpQgXiEInVzk6u94L/dLNNP8vcoTPXawwc0TuiMwIcj/BKvJmtLlVo=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Thu, 11 Apr 2019 06:49:19 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd%4]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 06:49:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        Andy Gross <andy.gross@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] defconfig: arm64: add i.MX system controller SoC support
Thread-Topic: [PATCH 2/2] defconfig: arm64: add i.MX system controller SoC
 support
Thread-Index: AQHU8DKwiHA+HSYiyUecNpaZnzYwsg==
Date:   Thu, 11 Apr 2019 06:49:19 +0000
Message-ID: <1554965048-19450-2-git-send-email-Anson.Huang@nxp.com>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b957307e-05c0-4df6-5372-08d6be49d233
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3910AE93FB3003FE62448D3BF52F0@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(105586002)(2501003)(97736004)(6116002)(53936002)(5660300002)(508600001)(71190400001)(7736002)(3846002)(6436002)(25786009)(2906002)(14454004)(6486002)(305945005)(4326008)(6512007)(81156014)(186003)(446003)(11346002)(52116002)(486006)(102836004)(476003)(386003)(50226002)(8676002)(2616005)(36756003)(6506007)(8936002)(256004)(71200400001)(316002)(4744005)(86362001)(99286004)(2201001)(81166006)(106356001)(66066001)(110136005)(68736007)(7416002)(26005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TixmYIl1AiNXaOi02W+N8Bx4RQPArk1CjKa1+9NnrVYPdvfMFjN+ctsCFaPjSTbcmuDOwj6jPOUfsAwjhuzVMcqmNNfxLk9ioEFMrbyZC3EstD2fox9+oVQ4BIetY+Myi/DR+sQigeQzaLUKX62YfiO20Krfm2P2FYrKdqguj6pVpXntwOQ5Wkv6LhmwWNcbgOgImmkumbjQM11WpH7O2kKHLYNTXcTnat8+4RvnP1mgzkC/sBObqqdtZ7yL2hVyS8Dy0Ng2e+VStdvo0QEs/APOwHAxC8Iex8Q1aTcMQ20m9lTfzJAg7oZaSSczr/XOPI+b4oHRA2gqk1aCA1XgogIBVj4xsZTkdhtf2nC7MIK72RoJQwbTjeWAujUBjR8fA49DJUfGbjJbbtEHYoFTejRVHvKg8D69Ye+4Mftzt/U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b957307e-05c0-4df6-5372-08d6be49d233
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 06:49:19.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIENPTkZJR19JTVhfU0NfU09DIGFzIG1vZHVsZS4NCg0KU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBhcmNoL2Fy
bTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9h
cm02NC9jb25maWdzL2RlZmNvbmZpZw0KaW5kZXggZDRjNDA0YS4uYjYxY2M1MyAxMDA2NDQNCi0t
LSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCisrKyBiL2FyY2gvYXJtNjQvY29uZmln
cy9kZWZjb25maWcNCkBAIC02ODMsNiArNjgzLDcgQEAgQ09ORklHX1JQTVNHX1FDT01fR0xJTktf
U01FTT1tDQogQ09ORklHX1JQTVNHX1FDT01fU01EPXkNCiBDT05GSUdfUkFTUEJFUlJZUElfUE9X
RVI9eQ0KIENPTkZJR19JTVhfR1BDVjJfUE1fRE9NQUlOUz15DQorQ09ORklHX0lNWF9TQ19TT0M9
bQ0KIENPTkZJR19RQ09NX0NPTU1BTkRfREI9eQ0KIENPTkZJR19RQ09NX0dFTklfU0U9eQ0KIENP
TkZJR19RQ09NX0dMSU5LX1NTUj1tDQotLSANCjIuNy40DQoNCg==
