Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B253C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C0AY1sSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfDZIF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:58 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:13875
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfDZIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE4iH0aau/VCb4WVOIpadNn4xw5403xEnfsZrZV9aks=;
 b=C0AY1sSed06NDzC6uxtBhn1RHBqRHWz86PNgNi6ql6gnJAoY9innGsNRDlKB5Dl065e+ilMgw21IIykgivU0xDkbdoGF/WN4v1VBCgnduZDDS/qqA/gWz8fJ0hxG7Dp/kx1R6/d/Wo9DUey6IFSEfVJkHeqIVi4yptnvtaa7lGk=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:52 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to state errata
 fixed
Thread-Topic: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to state
 errata fixed
Thread-Index: AQHU/AbdFQmcRuAKXkaLI1VIJjs4JA==
Date:   Fri, 26 Apr 2019 08:05:51 +0000
Message-ID: <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f63ae4d9-0d1e-4b8f-9d1c-08d6ca1dffb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB61090715465A9E9296C234F2893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(6306002)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bo/IJWcnnUWbPBPJ4P1Aciiz2IybcsnjMEKI8+mLUApj4Cd2IB29jLzTfAzc1IRoWI+QGa2n6spOEgWBJ4RiG7wV+LZFsCFsZK4j1C/+IVrPIKYaRs4zgYUsNSf9HcAtyjAXHvJTdvHSfTxfny7zLah6m3PmtELV7SPUPtxAjGY85LJpj0wKUqeTBjSRVwkSZtT3Cwnk2HcwD5DdEjPpmfnn7JcApAAHe+AFRL353nBk1qLb0ayQNXWPAAqG1PhRWMZv2qaHn/f1oe92jhEdXv8mPGtEYTKtX9fP1iapuyGE7toIuMA+euKXmq7U1k0I90cx2Kp1hSvfZengO2SL8a0s+pIvDMsU5sf0T82i0UgfLSG5zt2BOBcjmRLwmz19CkltP7F9aCWqBDhePoN3Yr695LY7eAPesTr8I53gCu8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ae4d9-0d1e-4b8f-9d1c-08d6ca1dffb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:51.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0IHRvIHNob3cgdGhlIGVycmF0YSBm
aXhlZC4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
LS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGku
dHh0IHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4
dA0KaW5kZXggMmQzMjY0MS4uMzJjNDI2M2QgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dA0KQEAgLTEwLDYgKzEw
LDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAgIC0gImZzbCxpbXgzNS1jc3BpIiBmb3IgU1BJ
IGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDM1DQogICAtICJmc2ws
aW14NTEtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdyYXRlZCBv
biBpLk1YNTENCiAgIC0gImZzbCxpbXg1My1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdpdGgg
dGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg1MyBhbmQgbGF0ZXIgU29jDQorICAtICJmc2wsaW14
NnVsLWVjc3BpIiBFUlIwMDkxNjUgZml4ZWQgb24gaS5NWDZVTCBhbmQgbGF0ZXIgU29jDQorICAg
IChodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZEUUNFLnBkZikNCiAgIC0g
ImZzbCxpbXg4bXEtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdy
YXRlZCBvbiBpLk1YOE0NCiAtIHJlZyA6IE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3Rl
ciBzZXQgZm9yIHRoZSBkZXZpY2UNCiAtIGludGVycnVwdHMgOiBTaG91bGQgY29udGFpbiBDU1BJ
L2VDU1BJIGludGVycnVwdA0KLS0gDQoyLjcuNA0KDQo=
