Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3180C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B3E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQE8Tjt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEOHyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:54:15 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:22405
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfEOHyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeFKX+lnbRylikJpEHNU/WnUY8Eqh5Z3VPRC5oL+UFU=;
 b=CQE8Tjt94W+wT6Jg0UsaPZcgQ5jy/hIbZI/fDpNKQHKvLbtHEBM57CBo0lS99wkG0sM/i5bfuOlwzL9x8RE9dRT5NGyMQZQ7iVvNVc4cOs8zZ6z0pMVElSsy/qfiRZ+TlRiqf80m+Q77F6fSI+/soVIfMIlw3W1AndSmghyYzpM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4644.eurprd04.prod.outlook.com (52.135.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 07:53:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 07:53:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH V3 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH V3 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Index: AQHVCvNPYlmGlaKrHkKAaUj4uWVjxg==
Date:   Wed, 15 May 2019 07:53:39 +0000
Message-ID: <20190515080703.19147-4-peng.fan@nxp.com>
References: <20190515080703.19147-1-peng.fan@nxp.com>
In-Reply-To: <20190515080703.19147-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb1c1ce3-126d-42cc-d8c8-08d6d90a7161
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4644;
x-ms-traffictypediagnostic: AM0PR04MB4644:
x-microsoft-antispam-prvs: <AM0PR04MB46440C081457AF1A8B1DD15388090@AM0PR04MB4644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(99286004)(54906003)(256004)(110136005)(50226002)(478600001)(8936002)(14454004)(2501003)(66066001)(71190400001)(71200400001)(52116002)(102836004)(53936002)(7736002)(4326008)(305945005)(6506007)(81156014)(386003)(81166006)(25786009)(8676002)(6636002)(66476007)(66446008)(64756008)(76176011)(66946007)(73956011)(66556008)(486006)(3846002)(44832011)(476003)(6512007)(6436002)(2616005)(446003)(11346002)(68736007)(6486002)(186003)(7416002)(2906002)(6116002)(316002)(1076003)(36756003)(26005)(86362001)(5660300002)(2201001)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4644;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNswv+eXCJ+meHP8hE/aRbGhDTHCStrxrSsH/1AZRJ4FIpeTZl/Xeg75UGGi+qxGdfsMaOtaRAbnJolaMan6Ulauxeq8hedzFtsufzD43IaXix2fN/sNNsxbhsLSzvFPz1NzK0Ni2SXyLgVR3TkYLMMhVv+JhI54oF3I0ChoIoYIwMtKBCTpmnctQzoslK9l8LjX3wBK/fSrlFiFYS/WkA2g2tBnFVjU4nAg/j4k8lesuvjIlewuuIDJQQCwACbPa9mw9dFktZMDZb71VyGVGqV+3djN6+753EkH/yBNQmIvLUw+9Ycj8Fva9nL5vOYkukewcH0VsvJ2zJWk+2AfXbOG+KmIPUTZOI4h/F1AVvHJrAjUd4c0BESNQVACwIu2Yj6gaLO48QfftUpRQemBD9qvx791I4a67kgr9KEmNxg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1c1ce3-126d-42cc-d8c8-08d6d90a7161
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 07:53:40.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIG9jb3RwIG5vZGUNCg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+DQpDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCkNjOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPg0KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+DQpDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KQ2M6IE5Y
UCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCkNjOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCkNjOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+
DQpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQot
LS0NCg0KVjM6DQogQWRkIFItYiB0YWcNClYyOg0KIG1vdmUgYWRkcmVzcy9zaXplLWNlbGxzIGJl
bG93IGNvbXBhdGlibGUsIGFkZCAic2N1Ig0KDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC5kdHNpIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCmluZGV4
IDA2ODNlZTJhNDhhZS4uNzI1ZDM0MWVlMTYwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCkBAIC0xNDEsNiArMTQxLDEyIEBADQogCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1pb211eGMiOw0KIAkJfTsNCiANCisJCW9jb3RwOiBpbXg4cXgtb2Nv
dHAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2N1LW9jb3RwIjsNCisJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCisJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCisJCX07DQorDQogCQlw
ZDogaW14OHF4LXBkIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjdS1wZCI7DQog
CQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCi0tIA0KMi4xNi40DQoNCg==
