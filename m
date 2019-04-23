Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31403C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1820811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qHVCqelC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfDWLmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:42:55 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:63458
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfDWLmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEV7n+bHzMn4A2hVFaRREL7227tLQLxYpjs0xn5Cdbc=;
 b=qHVCqelCUO1ssUFScOsRB42uov81o29FBeNwrL/CJ6whdu68p0PRoiHTH+BbW+aUf4I0CI8LPhBW4Ua1yjQ8GZj2IT1N/9s+8vHfJNtfAxPkJRqLx8n+2HvIAKxI8/Pb+cjm09+66nvYA9xqB++AMz42HcmpKaZX9gBNP8qklr4=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4878.eurprd04.prod.outlook.com (20.177.49.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Tue, 23 Apr 2019 11:42:51 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 11:42:51 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Topic: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Index: AQHU+cmuEJQ1seVcO0uOXKGj5Q3IFw==
Date:   Tue, 23 Apr 2019 11:42:50 +0000
Message-ID: <20190423114424.3578-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f19f5e0-25cb-4e13-33b0-08d6c7e0d09f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4878;
x-ms-traffictypediagnostic: VI1PR04MB4878:
x-microsoft-antispam-prvs: <VI1PR04MB4878A08530893E61919E92C7E9230@VI1PR04MB4878.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(73956011)(66446008)(66946007)(36756003)(6486002)(71190400001)(66556008)(2906002)(97736004)(71200400001)(64756008)(53936002)(66476007)(102836004)(316002)(6506007)(25786009)(54906003)(256004)(110136005)(386003)(44832011)(3846002)(81156014)(81166006)(68736007)(26005)(6116002)(8676002)(52116002)(14444005)(8936002)(6512007)(14454004)(186003)(4326008)(486006)(1076003)(305945005)(86362001)(5660300002)(6436002)(7736002)(476003)(99286004)(478600001)(50226002)(66066001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4878;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TnvfVIWPirgPSEZoSckWp0GSNRwGS2BfMTif4ILHU7Rt1oEOpW+exF0uml4oFhhn63rsbbw3ppGZRVuTOhpxK/sHmnpzt64AbO0sdfJVtSyfNfuM0xZpb7plxNYVUH4SY5Tm/C0YxKwJrtq1vkcrzTEaVnzSy0yM3liedXD/mrn4d8eaF86VljqzLF5nrRrREinCsvfs7qP1mdK8zpI2ctFSfnseGLNNiGLVGvCRBWNsS+fO4qpFVWSHqBaZ3FVABP3kUpEV4Bdsv0XVTt4gyAn0yCgwtW5TRVT13bWfrwcFxkdK9ChI7CIJ0Y5l3l9vQepyxZ0K7asbxbiN45E64Mt/ap5xl5PxjmVHwLqrrUHwqa2a4JiJxRW/DjYxo1aAmjAq05Enr+EkSi2lypu/Q7TCr5F7mv5zMagIpnz5wCo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f19f5e0-25cb-4e13-33b0-08d6c7e0d09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:42:50.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXNoaXNoIEt1bWFyIDxBc2hpc2guS3VtYXJAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBp
cyB0byBhZGQgZXNkaGMgbm9kZSBhbmQgZW5hYmxlIFNEIFVIUy1JLA0KZU1NQyBIUzIwMCBmb3Ig
bHMxMDI4YXJkYi9sczEwMjhhcWRzIGJvYXJkLg0KDQpTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3Vt
YXIgPEFzaGlzaC5LdW1hckBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogWWFuZ2JvIEx1IDx5YW5n
Ym8ubHVAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5j
b20+DQotLS0NCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMgICAg
fCAgOCArKysrKysNCiAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMg
ICAgfCAxMyArKysrKysrKysNCiAuLi4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEw
MjhhLmR0c2kgfCAyNyArKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0OCBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDI4YS1xZHMuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWxzMTAyOGEtcWRzLmR0cw0KaW5kZXggMTRjNzlmNDY5MWVhLi4xODBlNWQyYTAwZDEgMTAwNjQ0
DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRz
DQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRz
DQpAQCAtNDIsNiArNDIsMTQgQEANCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQogDQorJmVzZGhj
IHsNCisJc3RhdHVzID0gIm9rYXkiOw0KK307DQorDQorJmVzZGhjMSB7DQorCXN0YXR1cyA9ICJv
a2F5IjsNCit9Ow0KKw0KICZpMmMwIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIA0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQppbmRleCBm
ODZiMDU0YTc0YWUuLjFiZmFmNDI5NGRiNCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCkBAIC0zMCw2ICszMCwxOSBAQA0KIAl9
Ow0KIH07DQogDQorJmVzZGhjIHsNCisJc3RhdHVzID0gIm9rYXkiOw0KKwlzZC11aHMtc2RyMTA0
Ow0KKwlzZC11aHMtc2RyNTA7DQorCXNkLXVocy1zZHIyNTsNCisJc2QtdWhzLXNkcjEyOw0KKwl9
Ow0KKw0KKyZlc2RoYzEgew0KKwlzdGF0dXMgPSAib2theSI7DQorCW1tYy1oczIwMC0xXzh2Ow0K
Kwl9Ow0KKw0KICZpMmMwIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIA0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQppbmRleCAyODk2YmJjZmEzYmIu
LmQxM2NkM2ZiNDU1YiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwMjhhLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczEwMjhhLmR0c2kNCkBAIC0yNzQsNiArMjc0LDMzIEBADQogCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCiAJCX07DQogDQorCQllc2RoYzogZXNkaGNAMjE0MDAwMCB7DQorCQkJY29tcGF0aWJs
ZSA9ICJmc2wsbHMxMDI4YS1lc2RoYyIsICJmc2wsZXNkaGMiOw0KKwkJCXJlZyA9IDwweDAgMHgy
MTQwMDAwIDB4MCAweDEwMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPDAgMjggMHg0PjsgLyogTGV2
ZWwgaGlnaCB0eXBlICovDQorCQkJY2xvY2stZnJlcXVlbmN5ID0gPDA+Ow0KKwkJCWNsb2NrcyA9
IDwmY2xvY2tnZW4gMiAxPjsNCisJCQl2b2x0YWdlLXJhbmdlcyA9IDwxODAwIDE4MDAgMzMwMCAz
MzAwPjsNCisJCQlzZGhjaSxhdXRvLWNtZDEyOw0KKwkJCWxpdHRsZS1lbmRpYW47DQorCQkJYnVz
LXdpZHRoID0gPDQ+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KKwkJZXNk
aGMxOiBlc2RoY0AyMTUwMDAwIHsNCisJCQljb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWVzZGhj
IiwgImZzbCxlc2RoYyI7DQorCQkJcmVnID0gPDB4MCAweDIxNTAwMDAgMHgwIDB4MTAwMDA+Ow0K
KwkJCWludGVycnVwdHMgPSA8MCA2MyAweDQ+OyAvKiBMZXZlbCBoaWdoIHR5cGUgKi8NCisJCQlj
bG9jay1mcmVxdWVuY3kgPSA8MD47DQorCQkJY2xvY2tzID0gPCZjbG9ja2dlbiAyIDE+Ow0KKwkJ
CXZvbHRhZ2UtcmFuZ2VzID0gPDE4MDAgMTgwMCAzMzAwIDMzMDA+Ow0KKwkJCXNkaGNpLGF1dG8t
Y21kMTI7DQorCQkJYnJva2VuLWNkOw0KKwkJCWxpdHRsZS1lbmRpYW47DQorCQkJYnVzLXdpZHRo
ID0gPDQ+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KIAkJc2F0YTogc2F0
YUAzMjAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWFoY2kiOw0KIAkJCXJl
ZyA9IDwweDAgMHgzMjAwMDAwIDB4MCAweDEwMDAwPiwNCi0tIA0KMi4xNy4xDQoNCg==
