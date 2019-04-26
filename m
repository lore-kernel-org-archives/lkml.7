Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RLAbPPVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZFyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:54:31 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:34319
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfDZFya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J753A1eFc0rMEWB7YCbTffRZjYVdbOO0MrZw/Z2oC50=;
 b=RLAbPPVEL/9XKAQArw4MNpi/BpLiHYyb72GTFqSDwSh9eGv/K9lpZ5xNPgzEpeVpKLcmmONQXo5vy7YcsO85J261j5YFzEdeYD/2uaA2RC3eVLBMWUUEo4C0SNVROATgQ+kqkOwlYP+UXYT0fxI+hN9oMxT771HvPKMlyGENWjc=
Received: from HE1PR0402MB2874.eurprd04.prod.outlook.com (10.175.30.147) by
 HE1PR0402MB3404.eurprd04.prod.outlook.com (10.167.125.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 26 Apr 2019 05:54:26 +0000
Received: from HE1PR0402MB2874.eurprd04.prod.outlook.com
 ([fe80::3925:cd0b:355a:c587]) by HE1PR0402MB2874.eurprd04.prod.outlook.com
 ([fe80::3925:cd0b:355a:c587%2]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 05:54:26 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Index: AQHU+/SBIFirjMEfrESTZvW0Hl61hQ==
Date:   Fri, 26 Apr 2019 05:54:26 +0000
Message-ID: <20190426055558.44544-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To HE1PR0402MB2874.eurprd04.prod.outlook.com
 (2603:10a6:3:d7::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4803c985-17f3-4b9a-5b1d-08d6ca0ba35b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0402MB3404;
x-ms-traffictypediagnostic: HE1PR0402MB3404:
x-microsoft-antispam-prvs: <HE1PR0402MB34046CC26FA7C60A91178F10F13E0@HE1PR0402MB3404.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(86362001)(25786009)(486006)(14454004)(71200400001)(3846002)(5660300002)(6116002)(316002)(2906002)(54906003)(386003)(66556008)(66476007)(66446008)(53936002)(99286004)(64756008)(52116002)(4326008)(68736007)(186003)(73956011)(26005)(6506007)(66946007)(476003)(2616005)(1076003)(102836004)(81156014)(6512007)(71190400001)(81166006)(8936002)(66066001)(36756003)(8676002)(256004)(50226002)(305945005)(6916009)(478600001)(97736004)(7736002)(6486002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB3404;H:HE1PR0402MB2874.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nWnqn/oVX9exdHTg7xG1ULCuwbv6LZtgmR8GkqT/8ZQ1Z8GN5LNwlU8eNH62MMv+tf98gkkAfwLgCipEv6/T2BBq+QjSCRNUClW7KHypD/MHA+3m4FZ6v1IKw5tI95v0dG9dvjcItnw6J6EC/G4p0PY0JVVwsf3+wrY8Mr2P0rIKUi2/blI/NO6kEJ/7dBg5kNesIqbIjA63/ZpWvUznMlXZWuicUN9Qi61hq42kznOh/loGDiND2wy6NP3Wfk5M5v4E1yRJchwkhLFNSdx4ltelE7Q0wZuXTDF80w9oP/GaHfh1KAJ7uDO9xdjN5h5+wo/lPFurD1xsFgiBC5NvPcpCz06lFBf+v96ojVAR6I0EiTBqtJMK+2+99+AuhDaDTyTdcps0m0o8Jdwyu6x2dCK8PI8JITmnTJRv6LV36h4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803c985-17f3-4b9a-5b1d-08d6ca0ba35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 05:54:26.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFVTQiBkdCBub2RlcyBmb3IgTFMxMDI4QS4NCg0KU2lnbmVkLW9mZi1i
eTogUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2MjoNCiAg
LSBSZW5hbWUgbm9kZSBmcm9tIHVzYjNALi4uIHRvIHVzYkAuLi4gdG8gbWVldCBEVFNwZWMNCg0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgfCAgIDIwICsr
KysrKysrKysrKysrKysrKysrDQogMSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMTAyOGEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwMjhhLmR0c2kNCmluZGV4IDhkZDM1MDEuLjE4OGNmYjggMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQorKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQpAQCAtMTQ0LDYgKzE0NCwyNiBA
QA0KIAkJCWNsb2NrcyA9IDwmc3lzY2xrPjsNCiAJCX07DQogDQorCQl1c2IwOnVzYkAzMTAwMDAw
IHsNCisJCQljb21wYXRpYmxlPSAic25wcyxkd2MzIjsNCisJCQlyZWc9IDwweDAgMHgzMTAwMDAw
IDB4MCAweDEwMDAwPjsNCisJCQlpbnRlcnJ1cHRzPSA8MCA4MCAweDQ+Ow0KKwkJCWRyX21vZGU9
ICJob3N0IjsNCisJCQlzbnBzLGRpc19yeGRldF9pbnAzX3F1aXJrOw0KKwkJCXNucHMscXVpcmst
ZnJhbWUtbGVuZ3RoLWFkanVzdG1lbnQgPSA8MHgyMD47DQorCQkJc25wcyxpbmNyLWJ1cnN0LXR5
cGUtYWRqdXN0bWVudCA9IDwxPiwgPDQ+LCA8OD4sIDwxNj47DQorCQl9Ow0KKw0KKwkJdXNiMTp1
c2JAMzExMDAwMCB7DQorCQkJY29tcGF0aWJsZT0gInNucHMsZHdjMyI7DQorCQkJcmVnPSA8MHgw
IDB4MzExMDAwMCAweDAgMHgxMDAwMD47DQorCQkJaW50ZXJydXB0cz0gPDAgODEgMHg0PjsNCisJ
CQlkcl9tb2RlPSAiaG9zdCI7DQorCQkJc25wcyxkaXNfcnhkZXRfaW5wM19xdWlyazsNCisJCQlz
bnBzLHF1aXJrLWZyYW1lLWxlbmd0aC1hZGp1c3RtZW50ID0gPDB4MjA+Ow0KKwkJCXNucHMsaW5j
ci1idXJzdC10eXBlLWFkanVzdG1lbnQgPSA8MT4sIDw0PiwgPDg+LCA8MTY+Ow0KKwkJfTsNCisN
CiAJCWkyYzA6IGkyY0AyMDAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCx2ZjYxMC1pMmMi
Ow0KIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoxLjcuMQ0KDQo=
