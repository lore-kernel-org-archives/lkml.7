Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B75C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0121479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bFvUA0zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfEJNAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:00:22 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:14404
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJNAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRml9qHeUybwjVvDkrkmE4+yRQEMwTXvfEj3NpjvetQ=;
 b=bFvUA0zUwC+T2Hdszdr2rEqaFgFlvcXrMTyw5PgP1JgOLArbpdcuyKg7I48CMHPUY9zHEnFUFAyOL9B14o7h8ytPudvXB3TDPBTjlQn6a0fzac41yYWlP6VJaUYUqWfDHMcAz/kjuyE95JDz/TuDTDLhs4zRQNhDWg6CtM1zPgU=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6229.eurprd04.prod.outlook.com (20.179.7.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 13:00:17 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.016; Fri, 10 May 2019
 13:00:17 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH v2 1/3] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Thread-Index: AQHVBzBQyKO0W8hcaUmvSLfUo3GWlw==
Date:   Fri, 10 May 2019 13:00:17 +0000
Message-ID: <20190510130207.14330-2-pramod.kumar_1@nxp.com>
References: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc116f59-11ea-4d49-bb2c-08d6d54772f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6229;
x-ms-traffictypediagnostic: AM6PR04MB6229:
x-microsoft-antispam-prvs: <AM6PR04MB62296054D9D2C8A3A8FC2345F60C0@AM6PR04MB6229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(11346002)(2501003)(476003)(446003)(73956011)(66556008)(2906002)(66946007)(66476007)(64756008)(25786009)(50226002)(2616005)(486006)(14454004)(8936002)(478600001)(68736007)(66446008)(186003)(52116002)(76176011)(99286004)(5660300002)(6636002)(26005)(102836004)(386003)(6506007)(6486002)(6436002)(4326008)(3846002)(6116002)(2201001)(305945005)(66066001)(256004)(6512007)(71190400001)(53936002)(71200400001)(110136005)(86362001)(54906003)(36756003)(7736002)(316002)(81156014)(8676002)(4744005)(81166006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6229;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ti+zAgeFPtkjma4+L/joNcolr0f0cOgs+khJfBkRuS9MZ8Q/Sa8cF6L+ONNsuI74AU5fr9ESzWfV+f30luTxCnokQrT18one8PFqisa4bWW8UOMawu0pNigcRdoGDf5phjxDn42uDsWA7B5NC5niJ4T12VqncxBNPf1u+AabNYWAfqpwN+bh2AdCvIkZTB2X0Bjt8hWjspv+R6uKdQ7IMJMP7eO8KvpLJWtKA60iC70NBaJrVOXm9T//BHCvdWbTevaSqOh59wjqnXT8+5TIPYy8hjr7rF3ohzlWMVNU63loE0H3o9COHCRr1hL0QvmY06hzaZRm1gDaTMMW/SVxLTomieog2CR/7uau/XNfCTwGkn/ibTaA1VtJkjfvrNLxsQ79EN1S+oWaeKyI7ejEhsx1o89WSWIzGge35P9g+/k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc116f59-11ea-4d49-bb2c-08d6d54772f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:00:17.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJmc2wsbHMxMDQ2YS1mcnd5IiBiaW5kaW5ncyBmb3IgbHMxMDQ2YWZyd3kgYm9hcmQgYmFz
ZWQgb24gbHMxMDQ2YSBTb0MNCg0KU2lnbmVkLW9mZi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2
LnNoYXJtYUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3Vt
YXJfMUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KaW5kZXggN2UyY2Q2YWQyNmJkLi44
NzM5OTliZjRhNDMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZzbC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sDQpAQCAtMjA1LDYgKzIwNSw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgICAg
IC0gZW51bToNCiAgICAgICAgICAgICAgIC0gZnNsLGxzMTA0NmEtcWRzDQogICAgICAgICAgICAg
ICAtIGZzbCxsczEwNDZhLXJkYg0KKyAgICAgICAgICAgICAgLSBmc2wsbHMxMDQ2YS1mcnd5DQog
ICAgICAgICAgIC0gY29uc3Q6IGZzbCxsczEwNDZhDQogDQogICAgICAgLSBkZXNjcmlwdGlvbjog
TFMxMDg4QSBiYXNlZCBCb2FyZHMNCi0tIA0KMi4xNy4xDQoNCg==
