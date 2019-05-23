Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F6C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02E20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EXSdI4g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfEWBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:48:27 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:24853
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfEWBs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npPU9WFO4GFYAixvY2NBx7WIkmuJ91uDW1b6L0Jvwsg=;
 b=EXSdI4g81dMn0StMsIGAaadVcwTfh5WwPm0wGTo4nb3b9gnfx0zCpZlhsbLiTK4HNx+IFLVNfHirexqJLmIiwCsh1rkQIoYgNMG5MuZYg4f4vIYbV2PWleGxz5wilLMjxoGLOJwPs5pIJxS+s2KthPbKfGZO8SOi0vXNfEuWlvU=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3044.eurprd04.prod.outlook.com (10.173.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 23 May 2019 01:47:43 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::15e3:bb28:7e33:1adb]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::15e3:bb28:7e33:1adb%7]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 01:47:43 +0000
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
Subject: [PATCHv3] arm64: dts: ls1028a: add flexspi nodes
Thread-Topic: [PATCHv3] arm64: dts: ls1028a: add flexspi nodes
Thread-Index: AQHVEQmDureenWGIPkqqXMOejO/D4g==
Date:   Thu, 23 May 2019 01:47:42 +0000
Message-ID: <20190523014921.15020-1-xiaowei.bao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To AM5PR04MB3299.eurprd04.prod.outlook.com
 (2603:10a6:206:d::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b682a0-c735-416e-cd54-08d6df20a54a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR04MB3044;
x-ms-traffictypediagnostic: AM5PR04MB3044:
x-microsoft-antispam-prvs: <AM5PR04MB3044EE04B44779BE9A9C0029F5010@AM5PR04MB3044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(14454004)(6486002)(5660300002)(6436002)(26005)(73956011)(66946007)(305945005)(64756008)(7736002)(81166006)(66476007)(66556008)(81156014)(66446008)(8676002)(66066001)(186003)(1076003)(256004)(8936002)(50226002)(6512007)(53936002)(478600001)(2906002)(386003)(6506007)(2501003)(36756003)(25786009)(99286004)(486006)(102836004)(4326008)(2616005)(110136005)(71200400001)(71190400001)(44832011)(476003)(3846002)(316002)(86362001)(52116002)(2201001)(68736007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3044;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XggY+XlbRQos+BGWFNcg7Lep9tYHdSHaGN6LlRFzb7lbUH7buqeFlK/JFrpU10Y9Jq+z2A3RfiRmL2LsuSZIUiYPHJsWec8T0soLqpIHtSvceWTu1qWTLKb7YPVPXSRLu9DyE81OTWI0KcbnrUkjShELslPFGKyFZFriyuNQLMFd+J3OKMF0l1A1z4zu6UUMb3Kq7ZziUamfjczJ7nnAG6+wHP2iD13gwM/XkInI0FuSpdqZtsSF0hcVW3V2D/z8sc+Pm2OEmMceu+/0vxTb7oWw1CEfICgZM0nLQD8gn/y4S98wJVeK3N0EfhpEiahdrVSZdl+0MYvEOaEtuCGrzKNN4DQCNf9PooCafEDYEytsVbLXB5TohdxgOLgPrcuYwoXyuR8W7b/b3T1x/8sHmocSbg9xK/j+4r1Lao0fLi0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b682a0-c735-416e-cd54-08d6df20a54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 01:47:43.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiaowei.bao@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3044
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
b20+DQotLS0NCnYzOg0KIC0gbW92ZSB0aGUgInNwYW5zaW9uLG0yNXA4MCIgY29tcGF0aWJsZSBw
cm9wZXJ0eSB0byB0aGUgdG9wLg0KDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWxzMTAyOGEtcWRzLmR0cyB8ICAgMTUgKysrKysrKysrKysrKysrDQogYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cyB8ICAgMTUgKysrKysrKysrKysrKysr
DQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSAgICB8ICAg
MTIgKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTAyOGEtcWRzLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwMjhhLXFkcy5kdHMNCmluZGV4IDVjM2ZmNDMuLmI4Y2FiZDMgMTAwNjQ0DQotLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQorKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQpAQCAtMTY2LDYg
KzE2NiwyMSBAQA0KIAl9Ow0KIH07DQogDQorJmZzcGkgew0KKwlzdGF0dXMgPSAib2theSI7DQor
CW10MzV4dTAyZzogZmxhc2hAMCB7DQorCQljb21wYXRpYmxlID0gInNwYW5zaW9uLG0yNXA4MCI7
DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCSNzaXplLWNlbGxzID0gPDE+Ow0KKwkJbTI1
cCxmYXN0LXJlYWQ7DQorCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQorCQlyZWcg
PSA8MD47DQorCQkvKiBUaGUgZm9sbG93aW5nIHNldHRpbmcgZW5hYmxlcyAxLTEtOCAoQ01ELUFE
RFItREFUQSkgbW9kZSAqLw0KKwkJc3BpLXJ4LWJ1cy13aWR0aCA9IDw4PjsgLyogOCBTUEkgUngg
bGluZXMgKi8NCisJCXNwaS10eC1idXMtd2lkdGggPSA8MT47IC8qIDEgU1BJIFR4IGxpbmUgKi8N
CisJfTsNCit9Ow0KKw0KICZzYWkxIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCmluZGV4
IGY3ZDRkYTYuLmI1ZTA1MmMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQpAQCAtMTUyLDYgKzE1MiwyMSBAQA0KIAl9Ow0KIH07
DQogDQorJmZzcGkgew0KKwlzdGF0dXMgPSAib2theSI7DQorCW10MzV4dTAyZzogZmxhc2hAMCB7
DQorCQljb21wYXRpYmxlID0gInNwYW5zaW9uLG0yNXA4MCI7DQorCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCisJCSNzaXplLWNlbGxzID0gPDE+Ow0KKwkJbTI1cCxmYXN0LXJlYWQ7DQorCQlzcGkt
bWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQorCQlyZWcgPSA8MD47DQorCQkvKiBUaGUgZm9s
bG93aW5nIHNldHRpbmcgZW5hYmxlcyAxLTEtOCAoQ01ELUFERFItREFUQSkgbW9kZSAqLw0KKwkJ
c3BpLXJ4LWJ1cy13aWR0aCA9IDw4PjsgLyogOCBTUEkgUnggbGluZXMgKi8NCisJCXNwaS10eC1i
dXMtd2lkdGggPSA8MT47IC8qIDEgU1BJIFR4IGxpbmUgKi8NCisJfTsNCit9Ow0KKw0KICZkdWFy
dDAgew0KIAlzdGF0dXMgPSAib2theSI7DQogfTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KaW5kZXggZTgwOTVjZi4uMDZkOWM5MCAxMDA2NDQN
Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCisr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCkBAIC0x
ODksNiArMTg5LDE4IEBADQogCQkJc25wcyxpbmNyLWJ1cnN0LXR5cGUtYWRqdXN0bWVudCA9IDwx
PiwgPDQ+LCA8OD4sIDwxNj47DQogCQl9Ow0KIA0KKwkJZnNwaTogc3BpQDIwYzAwMDAgew0KKwkJ
CWNvbXBhdGlibGUgPSAibnhwLGx4MjE2MGEtZnNwaSI7DQorCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQorCQkJI3NpemUtY2VsbHMgPSA8MD47DQorCQkJcmVnID0gPDB4MCAweDIwYzAwMDAgMHgw
IDB4MTAwMDA+LA0KKwkJCSAgICAgIDwweDAgMHgyMDAwMDAwMCAweDAgMHgxMDAwMDAwMD47DQor
CQkJcmVnLW5hbWVzID0gIkZTUEkiLCAiRlNQSS1tZW1vcnkiOw0KKwkJCWludGVycnVwdHMgPSA8
MCAyNSAweDQ+OyAvKiBMZXZlbCBoaWdoIHR5cGUgKi8NCisJCQljbG9ja3MgPSA8JmNsb2NrZ2Vu
IDQgMz4sIDwmY2xvY2tnZW4gNCAzPjsNCisJCQljbG9jay1uYW1lcyA9ICJmc3BpX2VuIiwgImZz
cGkiOw0KKwkJfTsNCisNCiAJCWkyYzA6IGkyY0AyMDAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0g
ImZzbCx2ZjYxMC1pMmMiOw0KIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoxLjcuMQ0K
DQo=
