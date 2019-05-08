Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B52C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A4214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3ZDAPmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEHC4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:56:22 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:51615
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHC4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOquojHHTCk6l6ZN9FHEMrq4J9v3le8ls5ELNtcdiI0=;
 b=h3ZDAPmRfHyc7jou+GE2+H0JPGs+E/AHU1A676o1ybZOu3n/SFSIs09HmD+D2jPK3Xb4A3A6kTSUM0QfEk03Wi9trUGpNO/giV9r6JXBhV7ZGGU3cVgjEwbrUjtUx+W7QT2VYreDKp1V+d80kIYC+RecQugEdh/HC3ST7U11gsw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5153.eurprd04.prod.outlook.com (20.177.40.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 02:56:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 02:56:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH V2 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH V2 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Index: AQHVBUmbOkjPXU7GU0isU+fOE2filQ==
Date:   Wed, 8 May 2019 02:56:17 +0000
Message-ID: <20190508030927.16668-4-peng.fan@nxp.com>
References: <20190508030927.16668-1-peng.fan@nxp.com>
In-Reply-To: <20190508030927.16668-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 594b9c52-278f-4e3e-1eea-08d6d360bdbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5153;
x-ms-traffictypediagnostic: AM0PR04MB5153:
x-microsoft-antispam-prvs: <AM0PR04MB5153E2D6E5D24D5D534C447F88320@AM0PR04MB5153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(26005)(1076003)(68736007)(66446008)(4744005)(14454004)(2501003)(66946007)(186003)(52116002)(305945005)(102836004)(7736002)(316002)(66556008)(64756008)(66476007)(53936002)(73956011)(25786009)(7416002)(50226002)(8936002)(5660300002)(4326008)(71190400001)(71200400001)(6512007)(478600001)(54906003)(110136005)(6116002)(76176011)(3846002)(2906002)(36756003)(81156014)(81166006)(8676002)(86362001)(2201001)(66066001)(6436002)(6486002)(446003)(11346002)(2616005)(256004)(6506007)(486006)(44832011)(386003)(99286004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5153;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bvGveElthnHN9HHmsH74YFYSwcmLooGqJYvFvRrsqApXMUtFDkXjk0sCbOqt5dLwchwq1l2FXskn34q6EYdusbU9St5wCSR3ksQsbqO4+cbJLTJRezanvTPHHwSsMOb372AHiKfgNdJ8rEFm4rxlOIXzWfq1kyxBV/QXnrF3E05sPxl0uHV6QcJAfsEbRpW0fReh8KebY53hrFzFVHj/4wpU6LHjUii7zkKPH8+BbeeSkOp98RXUFOetPKG5LtbCYMK//9L7sozAPB4INuRaEzcUhwWzVmGEPstUsCjP6YH4p/utENfpHAxGv3SrSYp21uUeMqzAdZtSBPJcrVHnA/t7trAkTIT3595oX2AWbhGKg7pmAumBC+42s7B/Uf7yICqUHBf1eARMthfgKDBlQB6arn+XAnbdkKv++z1p8qg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594b9c52-278f-4e3e-1eea-08d6d360bdbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 02:56:17.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIG9jb3RwIG5vZGUNCg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+DQpDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCkNjOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPg0KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+DQpDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KQ2M6IE5Y
UCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCkNjOiBBaXNoZW5nIERvbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KQ2M6IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
Q2M6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCkNjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQotLS0NCg0KVjI6
DQogbW92ZSBhZGRyZXNzL3NpemUtY2VsbHMgYmVsb3cgY29tcGF0aWJsZSwgYWRkICJzY3UiDQoN
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCA2ICsrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KaW5kZXggMDY4M2VlMmE0OGFlLi43MjVkMzQxZWUxNjAg
MTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kN
CisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KQEAgLTE0
MSw2ICsxNDEsMTIgQEANCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWlvbXV4YyI7DQog
CQl9Ow0KIA0KKwkJb2NvdHA6IGlteDhxeC1vY290cCB7DQorCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14OHF4cC1zY3Utb2NvdHAiOw0KKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJCSNzaXpl
LWNlbGxzID0gPDE+Ow0KKwkJfTsNCisNCiAJCXBkOiBpbXg4cXgtcGQgew0KIAkJCWNvbXBhdGli
bGUgPSAiZnNsLGlteDhxeHAtc2N1LXBkIjsNCiAJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+
Ow0KLS0gDQoyLjE2LjQNCg0K
