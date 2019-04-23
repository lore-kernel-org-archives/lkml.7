Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC57C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dR+SOipB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfDWNvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:21 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:46145
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbfDWNvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE4iH0aau/VCb4WVOIpadNn4xw5403xEnfsZrZV9aks=;
 b=dR+SOipBMW6BV5CV61FdkEEGj0RCKnv/oJQSbXTcEYgeFa5cLwOb2yKDlcF4WUIInY5EyI6lSZ48Lx7CzPVMPsSMj35gexG26qOwlP4ltNJ88bMenyrxdodeG1lEHcrgDzZ1TJzFnM5fAjAeorssXDP8UTzE6hIW1SRqQWxy9l0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:15 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:15 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 08/15] dt-bindings: spi: imx: add i.mx6ul to state errata
 fixed
Thread-Topic: [PATCH v1 08/15] dt-bindings: spi: imx: add i.mx6ul to state
 errata fixed
Thread-Index: AQHU+duexEt2pAc/T0CYpHz/qu3CSw==
Date:   Tue, 23 Apr 2019 13:51:15 +0000
Message-ID: <1556027045-5269-9-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d7ed2ec-5a89-4369-14b8-08d6c7f2c0ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB59012E815D051C8868BFA72089230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ORrqKVkh9fQr7l709whXVaV031rImO37PpQr8cXgcGQXR2mdqaUPUVlHQcAnvfplBhK393ghX1yLhhaTp/KPfOR9nc9mqX7Wiz7mH0EcLtZQamqjPDbcszKLkVbvscA1g79kG7tk47sWt5D4/1lgfrc4As3f8Z3rEVPeyndMc0Scnw3sBKKzoVUOwRFQm+huyMsAvYNfaSbgEs4ghIV/ccGU+f85p0xBZ2ZrwIzRpo++etLQJDSnDPiMJ9TZwAq/6GXlRW6rrwJFBUInb0vnArxaVSRSZBkmmlfvAq+pYoA9KIWS91KsInZH5oHqg+N22lUdFqqv22vU+EjwL2+atZBaZeRrv0gDY/2514iYz2i/x/vr89T6PXI62zzsP2cAvwBox3zKJZzH5Ne6lxH4KcgDw9b6mFRHDzxycMSqqCs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7ed2ec-5a89-4369-14b8-08d6c7f2c0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:15.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
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
