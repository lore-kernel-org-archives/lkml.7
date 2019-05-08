Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA92C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2EF214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ODb/aVkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEHKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:35:30 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:23427
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfEHKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuyGBdsvb1ZSS+ut8oGSo82qb7LY29W3sX+054MBzfY=;
 b=ODb/aVkOUgriQE+UD1H5MRcQQ29SijjVXMXGk52Dn+g8Qy8ogatw7Wy3NaTYdQHwcoVudvn5/kMe4j6WZaapf/HeebGI/Rqi4Glli8Ll4/7GDWwrlwakSIxpCmsyqMlUNWqSuo0lWXIzA+odw/3ZKvwHNdpmGARaHblbL1NN/BA=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.177.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:35:25 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:35:25 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v1 1/4] dt-bindings: display: Add DT bindings for LS1028A HDP-TX
 PHY.
Thread-Topic: [v1 1/4] dt-bindings: display: Add DT bindings for LS1028A
 HDP-TX PHY.
Thread-Index: AQHVBYm/GjgqdY4+pUuRDaU4fFYL0Q==
Date:   Wed, 8 May 2019 10:35:25 +0000
Message-ID: <20190508103703.40885-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:203:2f::25) To AM0PR04MB4865.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 911ccc03-accb-4ffd-c8cf-08d6d3a0e148
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
x-microsoft-antispam-prvs: <AM0PR04MB49628E074373A37AF7D53BB7E2320@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(14444005)(66946007)(186003)(2616005)(476003)(53936002)(66556008)(99286004)(4326008)(66066001)(73956011)(1076003)(66446008)(36756003)(64756008)(305945005)(316002)(7736002)(54906003)(2501003)(110136005)(52116002)(6506007)(386003)(256004)(2201001)(102836004)(86362001)(66476007)(5660300002)(26005)(6116002)(3846002)(14454004)(2906002)(6512007)(8936002)(71190400001)(71200400001)(486006)(50226002)(6486002)(6436002)(68736007)(25786009)(8676002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XSzdo0y2m/pSCRaGq6hkDofDKsRmTh3kWiliwEWtoXNkCLXhwvI7s0dxEBnSaUbHFWTwprkWDN6OGtWPLUdExcTLzDaArBt7CgR9Kwi1Ksle4+7n91GilnOOyF3Y6HB6SOkKpwXXjkJO/PgiEZdKXveCL1tb5BGOwt6Lc8Oy1MwNE91YTYxgU0bZDCzXSAEI7UyMDo5ESRHT17hYEzxCEOkVfKx9rVHWN5is7iTUA02d/cgtL0E0JdkmfrmEVXjybcoUf/LvFPRF61g0YHm5S9yfNrTQaXUj8wkBE6zfomSaetOQY5xqQSjmwNiBdSUCzc9etYztA/AVf0nnuX0pSn8ZsDurJQRi8ZfqIatWIxpBj4dFHbSF+d6vCBngmD7iekV6KJCL73xhRaDIcvp0saYW+qAA5oe7a1CPRIt39ts=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911ccc03-accb-4ffd-c8cf-08d6d3a0e148
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:35:25.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIERUIGJpbmRpbmdzIGRvY3VtZW50bWF0aW9uIGZvciB0aGUgSERQLVRYIFBIWSBjb250cm9s
bGVyLiBUaGUgZGVzY3JpYmVzDQp3aGljaCBjb3VsZCBiZSBmb3VuZCBvbiBOWFAgTGF5ZXJzY2Fw
ZSBsczEwMjhhIHBsYXRmb3JtLg0KDQpTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54
cC5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2ZzbCxoZHAudHh0
ICAgfCA1NiArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlv
bnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2ZzbCxoZHAudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQppbmRleCAwMDAwMDAwMDAwMDAuLjM2YjU2ODdhMTI2MQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQNCkBA
IC0wLDAgKzEsNTYgQEANCitOWFAgTGF5ZXJzY3BhZSBsczEwMjhhIEhEUC1UWCBQSFkgQ29udHJv
bGxlcg0KKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQorDQor
VGhlIGZvbGxvd2luZyBiaW5kaW5ncyBkZXNjcmliZSB0aGUgQ2FkZW5jZSBIRFAgVFggUEhZIG9u
IGxzMTAyOGEgdGhhdA0KK29mZmVyIG11bHRpLXByb3RvY29sIHN1cHBvcnQgb2Ygc3RhbmRhcnMg
c3VjaCBhcyBlRFAgYW5kIERpc3BsYXlwb3J0LA0KK3N1cHBvcnRzIGZvciAyNS02MDBNSHogcGl4
ZWwgY2xvY2sgYW5kIHVwIHRvIDRrMmsgYXQgNjBNSHogcmVzb2x1dGlvbi4NCitUaGUgSERQIHRy
YW5zbWl0dGVyIGlzIGEgQ2FkZW5jZSBIRFAgVFggY29udHJvbGxlciBJUCB3aXRoIGEgY29tcGFu
aW9uDQorUEhZIElQLg0KKw0KK1JlcXVpcmVkIHByb3BlcnRpZXM6DQorICAtIGNvbXBhdGlibGU6
ICAgU2hvdWxkIGJlICJmc2wsbHMxMDI4YS1kcCIgZm9yIGxzMTAyOGEuDQorICAtIHJlZzogICAg
ICAgICAgUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBibG9jayBvZiByZWdp
c3RlcnMgdXNlZA0KKyAgYnkgdGhlIHByb2Nlc3Nvci4NCisgIC0gaW50ZXJydXB0czogICBIRFAg
aG90cGx1ZyBpbi9vdXQgZGV0ZWN0IGludGVycnVwdCBudW1iZXINCisgIC0gY2xvY2tzOiAgICAg
ICBBIGxpc3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNo
IGVudHJ5DQorICBpbiAnY2xvY2stbmFtZXMnDQorICAtIGNsb2NrLW5hbWVzOiAgQSBsaXN0IG9m
IGNsb2NrIG5hbWVzLiBJdCBzaG91bGQgY29udGFpbjoNCisgICAgICAtICJjbGtfaXBnIjogaW50
ZXItSW50ZWdyYXRlZCBjaXJjdWl0IGNsb2NrDQorICAgICAgLSAiY2xrX2NvcmUiOiBmb3IgdGhl
IE1haW4gRGlzcGxheSBUWCBjb250cm9sbGVyIGNsb2NrDQorICAgICAgLSAiY2xrX3B4bCI6IGZv
ciB0aGUgcGl4ZWwgY2xvY2sgZmVlZGluZyB0aGUgb3V0cHV0IFBMTCBvZiB0aGUgcHJvY2Vzc29y
DQorICAgICAgLSAiY2xrX3B4bF9tdXgiOiBmb3IgdGhlIGhpZ2ggUGVyZlBMTCBieXBhc3MgY2xv
Y2sNCisgICAgICAtICJjbGtfcHhsX2xpbmsiOiBmb3IgdGhlIGxpbmsgcmF0ZSBwaXhlbCBjbG9j
aw0KKyAgICAgIC0gImNsa19hcGIiOiBmb3IgdGhlIEFQQiBpbnRlcmZhY2UgY2xvY2sNCisgICAg
ICAtICJjbGtfdmlmIjogZm9yIHRoZSBWaWRlbyBwaXhlbCBjbG9jaw0KKw0KK1JlcXVpcmVkIHN1
Yi1ub2RlczoNCisgIC0gcG9ydDogVGhlIEhEUCBjb25uZWN0aW9uIHRvIGFuIGVuY29kZXIgb3V0
cHV0IHBvcnQuIFRoZSBjb25uZWN0aW9uDQorICAgIGlzIG1vZGVsbGVkIHVzaW5nIHRoZSBPRiBn
cmFwaCBiaW5kaW5ncyBzcGVjaWZpZWQgaW4NCisgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2dyYXBoLnR4dA0KKw0KKw0KK0V4YW1wbGU6DQorDQorLyB7DQorICAgICAgICAu
Li4NCisNCisJaGRwOiBkaXNwbGF5QGYyMDAwMDAgew0KKyAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImZzbCxsczEwMjhhLWRwIjsNCisJCXJlZyA9IDwweDAgMHhmMWYwMDAwIDB4MCAweGZm
ZmY+LA0KKwkJICAgIDwweDAgMHhmMjAwMDAwIDB4MCAweGZmZmZmPjsNCisgICAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDwwIDIyMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCWNsb2NrcyA9
IDwmc3lzY2xrPiwgPCZoZHBjbGs+LCA8JmRwY2xrPiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgPCZkcGNsaz4sIDwmZHBjbGs+LCA8JnBjbGs+LCA8JmRwY2xrPjsNCisJCWNsb2NrLW5hbWVz
ID0gImNsa19pcGciLCAiY2xrX2NvcmUiLCAiY2xrX3B4bCIsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImNsa19weGxfbXV4IiwgImNsa19weGxfbGluayIsICJjbGtfYXBiIiwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiY2xrX3ZpZiI7DQorDQorCQlwb3J0IHsNCisJ
CQlkcDFfb3V0cHV0OiBlbmRwb2ludCB7DQorCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmZHAwX2lu
cHV0PjsNCisJCQl9Ow0KKwkJfTsNCisgICAgICAgIH07DQorDQorICAgICAgICAuLi4NCit9Ow0K
LS0gDQoyLjE3LjENCg0K
