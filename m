Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E73216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qupj+JSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEHGqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:46:42 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:1270
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbfEHGql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cVPJcI2IgvX2PoXud+kBc5+l8GJkxzTteT26e1rjc8=;
 b=qupj+JSfIz0kDf3jmazSwkzXRYI++Sau6epxDbo+z3S8CNdZR1ZVda7h06e5S84bOqWNTV2/zQjK2uxYWqKBF8aM1+WV1grIC/qHh7Q87YsjUgRFErmpUb0VuNBD5tXSOkERmWXHUu4y0WENwllMwBtEAsihq78PFwVvvTqfgfc=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2900.eurprd04.prod.outlook.com (10.175.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 06:46:38 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:46:38 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3] arm64: dts: ls1028a: Add USB dt nodes
Thread-Topic: [PATCH v3] arm64: dts: ls1028a: Add USB dt nodes
Thread-Index: AQHVBWnJ2RizrGxsQECLN0zEf7YLpQ==
Date:   Wed, 8 May 2019 06:46:37 +0000
Message-ID: <20190508064814.14223-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:9e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45e70ce-f88a-40f9-1c82-08d6d380eb51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2900;
x-ms-traffictypediagnostic: AM5PR0402MB2900:
x-microsoft-antispam-prvs: <AM5PR0402MB29005C3E2DBE026C446D6A1DF1320@AM5PR0402MB2900.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(66066001)(476003)(2906002)(99286004)(256004)(305945005)(71200400001)(71190400001)(81156014)(81166006)(386003)(54906003)(36756003)(26005)(52116002)(14454004)(8676002)(478600001)(25786009)(1076003)(102836004)(4326008)(6506007)(2616005)(7736002)(316002)(73956011)(66446008)(66476007)(66556008)(64756008)(66946007)(6916009)(186003)(86362001)(53936002)(6512007)(6116002)(3846002)(8936002)(486006)(50226002)(5660300002)(6486002)(6436002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2900;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9WKGI0FGiCGeha4Qf1sgmNz23pOJcJQnhL6MO0g91v63KJ76V9biR3ETitJgtq2fZNsr7QT+zhsHLbpIe5jz5+bWpe7ioeV/MLNDcicsyhpReAkUGV1uoquVT5wrMoCt/eSc0PDpjznqQqH7Fv6j6gvysw3+KYA4dskrVsygtm+skjaX28HneOsV9VwYpDAH+FvUCmVmdjLrBQY9KA0HV+3u/YoKuSAiO9MvZMsrzz+J+qLMwTOzEiUdvqPJttDNgLg3PiMgVh8lK3VaWNX0ChbBOG9cNwW/GAZU8mDAg5kDrODOsg0SUhnA41fW96SKIVh9H539ToDjtRNJUe7n2EIudOd1uxB5F+7NVJ4wzwD4PARcEY0s+Vau4f8mlqSfxUVPXPhksBAqb0pbVOjIwlzyhrurnYz2C0rZovZPOvA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45e70ce-f88a-40f9-1c82-08d6d380eb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:46:38.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFVTQiBkdCBub2RlcyBmb3IgTFMxMDI4QS4NCg0KU2lnbmVkLW9mZi1i
eTogUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2MzoNCiAg
LSBBZGQgc3BhY2UgYmV0d2VlbiBsYWJlbCBhbmQgbm9kZSBuYW1lLg0KICAtIEFkZCBzcGNhZSB3
aXRoIHByb3BlcnRpZXMgYW5kICc9Jy4NCiAgLSBBZGQgU29DIHNwZWNpZmljIGNvbXBhdGlibGUu
DQoNCkNoYW5nZXMgaW4gdjI6DQogIC0gUmVuYW1lIG5vZGUgZnJvbSB1c2IzQC4uLiB0byB1c2JA
Li4uIHRvIG1lZXQgRFRTcGVjDQoNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDI4YS5kdHNpIHwgICAyMCArKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQppbmRleCA4ZGQzNTAxLi4xOTUxOWRm
IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEu
ZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRz
aQ0KQEAgLTE0NCw2ICsxNDQsMjYgQEANCiAJCQljbG9ja3MgPSA8JnN5c2Nsaz47DQogCQl9Ow0K
IA0KKwkJdXNiMDogdXNiQDMxMDAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGxzMTAyOGEt
ZHdjMyIsICJzbnBzLGR3YzMiOw0KKwkJCXJlZyA9IDwweDAgMHgzMTAwMDAwIDB4MCAweDEwMDAw
PjsNCisJCQlpbnRlcnJ1cHRzID0gPDAgODAgMHg0PjsNCisJCQlkcl9tb2RlID0gImhvc3QiOw0K
KwkJCXNucHMsZGlzX3J4ZGV0X2lucDNfcXVpcms7DQorCQkJc25wcyxxdWlyay1mcmFtZS1sZW5n
dGgtYWRqdXN0bWVudCA9IDwweDIwPjsNCisJCQlzbnBzLGluY3ItYnVyc3QtdHlwZS1hZGp1c3Rt
ZW50ID0gPDE+LCA8ND4sIDw4PiwgPDE2PjsNCisJCX07DQorDQorCQl1c2IxOiB1c2JAMzExMDAw
MCB7DQorCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1kd2MzIiwgInNucHMsZHdjMyI7DQor
CQkJcmVnID0gPDB4MCAweDMxMTAwMDAgMHgwIDB4MTAwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8
MCA4MSAweDQ+Ow0KKwkJCWRyX21vZGUgPSAiaG9zdCI7DQorCQkJc25wcyxkaXNfcnhkZXRfaW5w
M19xdWlyazsNCisJCQlzbnBzLHF1aXJrLWZyYW1lLWxlbmd0aC1hZGp1c3RtZW50ID0gPDB4MjA+
Ow0KKwkJCXNucHMsaW5jci1idXJzdC10eXBlLWFkanVzdG1lbnQgPSA8MT4sIDw0PiwgPDg+LCA8
MTY+Ow0KKwkJfTsNCisNCiAJCWkyYzA6IGkyY0AyMDAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0g
ImZzbCx2ZjYxMC1pMmMiOw0KIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoxLjcuMQ0K
DQo=
