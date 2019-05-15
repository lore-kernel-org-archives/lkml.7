Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61F8216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cK8aSljN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfEOLKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:10:11 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:15311
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729255AbfEOLKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuKaf0YLQKzzPf65tVXQwoD4oJ9AU/hYa0gu93qoVA8=;
 b=cK8aSljNR7iceTUeeXE4r4wwtTxpnocmcudv7RbSlsEscSpcO3L7KqLdQety8Hgxm8REtQZPcLKJegcFUi3gOBtc+9jvPodJF3gcp2om2aHKQCf1/UslsUa2t//I2kEAm1kovWVsFo77JFJrkCC2Ivy492uabuxdH6jbVWLEc7g=
Received: from VI1PR04MB3310.eurprd04.prod.outlook.com (10.170.231.148) by
 VI1PR04MB5792.eurprd04.prod.outlook.com (20.178.204.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 11:09:25 +0000
Received: from VI1PR04MB3310.eurprd04.prod.outlook.com
 ([fe80::8c6f:6261:7877:9de8]) by VI1PR04MB3310.eurprd04.prod.outlook.com
 ([fe80::8c6f:6261:7877:9de8%4]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 11:09:25 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Thread-Topic: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Thread-Index: AQHVCw6ogMFRF8ssNEKztKIHvtwUnw==
Date:   Wed, 15 May 2019 11:09:25 +0000
Message-ID: <20190515110924.13726-1-xiaowei.bao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To VI1PR04MB3310.eurprd04.prod.outlook.com
 (2603:10a6:802:f::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b8a44bf-5f21-4a2d-a1c4-08d6d925ca5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5792;
x-ms-traffictypediagnostic: VI1PR04MB5792:
x-microsoft-antispam-prvs: <VI1PR04MB5792ABDC2F6BAFB7F6268689F5090@VI1PR04MB5792.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(64756008)(66556008)(66066001)(66946007)(25786009)(256004)(66476007)(2906002)(6436002)(73956011)(66446008)(2201001)(305945005)(86362001)(36756003)(6512007)(316002)(2501003)(102836004)(6506007)(386003)(53936002)(8676002)(50226002)(1076003)(486006)(44832011)(3846002)(6116002)(81156014)(186003)(110136005)(26005)(2616005)(476003)(52116002)(99286004)(5660300002)(68736007)(6486002)(71190400001)(71200400001)(478600001)(4326008)(7736002)(81166006)(8936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5792;H:VI1PR04MB3310.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FnUyb50JPdpDGYLBOFG5DRG+eSKys5HlXoINpN9bymTOHULFzkBaX/PinaSgl34OTfH/YP2xcZ5TtGc5Z8lvj4jWGzxjuz4p89n5M0vHSm3zup0yxnQ7YDQFvctMIDeyR8eCCr/FRz039Ahph032gc2P+jEt9HZI6KAHEI7kqkzcRde9rl96gVXcn3TK6QUK2gRGPlvnPBG4+LL1PHbcGYG9bYc6Ad6Fs2VWyOrsRehanjz/RD7jRypZH+jKLu5gGhvuS1CgOuHTYAgRnlyV30PjaXUSmNwuLs5bkTHQ4bFLcpAkMDvwROxo/RdwJinGqO6z/WwD+rP4n7fqDY9Y4LTmfwqsPjfwyWeGZaqJg2JOjBQ3plIHGHrbP2n1ywAQIO/bZq3Cs3DLiq6t8j+0A+yoLpGO2DLFQTvVkheDIDo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a44bf-5f21-4a2d-a1c4-08d6d925ca5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:09:25.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQoNCkFkZCBmc3BpIG5vZGUg
cHJvcGVydHkgZm9yIExTMTAyOEEgU29DIGZvciBGbGV4U1BJIGRyaXZlci4NClByb3BlcnR5IGFk
ZGVkIGZvciB0aGUgRmxleFNQSSBjb250cm9sbGVyIGFuZCBmb3IgdGhlIGNvbm5lY3RlZA0Kc2xh
dmUgZGV2aWNlIGZvciB0aGUgTFMxMDI4QVJEQiBhbmQgTFMxMDI4QVFEUyB0YXJnZXQuDQpUaGlz
IGlzIGhhdmluZyBvbmUgU1BJLU5PUiBmbGFzaCBkZXZpY2UsIG10MzV4dTAyZyBjb25uZWN0ZWQg
YXQNCkNTMC4NCg0KU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5j
b20+DQotLS0NCnYyOg0KIC0gbW9kaWZ5IHRoZSBjb21taXQgbWVzc2FnZSBhbmQgdGhlIGR0cyBm
b3JtYXQuDQoNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMu
ZHRzIHwgICAxNSArKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDI4YS1yZGIuZHRzIHwgICAxNSArKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpICAgIHwgICAxMiArKysrKysrKysr
KysNCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1x
ZHMuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0
cw0KaW5kZXggNWJjZDQ5MS4uNmUxMjgwNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCkBAIC0xNTgsNiArMTU4LDIxIEBADQog
CX07DQogfTsNCiANCismZnNwaSB7DQorCXN0YXR1cyA9ICJva2F5IjsNCisJbXQzNXh1MDJnOiBm
bGFzaEAwIHsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MT47
DQorCQljb21wYXRpYmxlID0gInNwYW5zaW9uLG0yNXA4MCI7DQorCQltMjVwLGZhc3QtcmVhZDsN
CisJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDIwMDAwMDAwPjsNCisJCXJlZyA9IDwwPjsNCisJCS8q
IFRoZSBmb2xsb3dpbmcgc2V0dGluZyBlbmFibGVzIDEtMS04IChDTUQtQUREUi1EQVRBKSBtb2Rl
ICovDQorCQlzcGktcngtYnVzLXdpZHRoID0gPDg+OyAvKiA4IFNQSSBSeCBsaW5lcyAqLw0KKwkJ
c3BpLXR4LWJ1cy13aWR0aCA9IDwxPjsgLyogMSBTUEkgVHggbGluZSAqLw0KKwl9Ow0KK307DQor
DQogJnNhaTEgew0KIAlzdGF0dXMgPSAib2theSI7DQogfTsNCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KaW5kZXggMjVkMjM3MC4uNWQz
OTYxNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEw
MjhhLXJkYi5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEw
MjhhLXJkYi5kdHMNCkBAIC0xMzYsNiArMTM2LDIxIEBADQogCX07DQogfTsNCiANCismZnNwaSB7
DQorCXN0YXR1cyA9ICJva2F5IjsNCisJbXQzNXh1MDJnOiBmbGFzaEAwIHsNCisJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MT47DQorCQljb21wYXRpYmxlID0gInNw
YW5zaW9uLG0yNXA4MCI7DQorCQltMjVwLGZhc3QtcmVhZDsNCisJCXNwaS1tYXgtZnJlcXVlbmN5
ID0gPDIwMDAwMDAwPjsNCisJCXJlZyA9IDwwPjsNCisJCS8qIFRoZSBmb2xsb3dpbmcgc2V0dGlu
ZyBlbmFibGVzIDEtMS04IChDTUQtQUREUi1EQVRBKSBtb2RlICovDQorCQlzcGktcngtYnVzLXdp
ZHRoID0gPDg+OyAvKiA4IFNQSSBSeCBsaW5lcyAqLw0KKwkJc3BpLXR4LWJ1cy13aWR0aCA9IDwx
PjsgLyogMSBTUEkgVHggbGluZSAqLw0KKwl9Ow0KK307DQorDQogJmR1YXJ0MCB7DQogCXN0YXR1
cyA9ICJva2F5IjsNCiB9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDI4YS5kdHNpDQppbmRleCBiYTcxYTMzLi5hMjdjZDYwIDEwMDY0NA0KLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KQEAgLTEwOSw2ICsxMDksMTgg
QEANCiAJCX07DQogCX07DQogDQorCWZzcGk6IHNwaUAyMGMwMDAwIHsNCisJCWNvbXBhdGlibGUg
PSAibnhwLGx4MjE2MGEtZnNwaSIsICJzaW1wbGUtYnVzIjsNCisJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MD47DQorCQlyZWcgPSA8MHgwIDB4MjBjMDAwMCAweDAg
MHgxMDAwMD4sDQorCQkgICAgPDB4MCAweDIwMDAwMDAwIDB4MCAweDEwMDAwMDAwPjsNCisJCXJl
Zy1uYW1lcyA9ICJGU1BJIiwgIkZTUEktbWVtb3J5IjsNCisJCWludGVycnVwdHMgPSA8MCAyNSAw
eDQ+OyAvKiBMZXZlbCBoaWdoIHR5cGUgKi8NCisJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPiwg
PCZjbG9ja2dlbiA0IDM+Ow0KKwkJY2xvY2stbmFtZXMgPSAiZnNwaV9lbiIsICJmc3BpIjsNCisJ
fTsNCisNCiAJc29jOiBzb2Mgew0KIAkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCiAJCSNh
ZGRyZXNzLWNlbGxzID0gPDI+Ow0KLS0gDQoxLjcuMQ0KDQo=
