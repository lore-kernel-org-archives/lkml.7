Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE9C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F7F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SR/pJRTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfDYFTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:19:12 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:17022
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfDYFTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuxQ8ul2eKExo4ZIFTuRm555FPWrI/4prFYeRiad8pY=;
 b=SR/pJRTeSNoW5fpznV/Xk+Xw9wNkhaDKz5NgIPXZtn8wVJ2eJMXoooZq1BptnMFXrnYIU4G1tLQmVbvbrqkdpfIesLjaxYZ3nqh5vHnYbocKJv9u4GABoGuMuZOEupqq2tC9iYzRJRRkOKQU0KhYtzFNChmyF4OeozJ3iDVva4s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 05:19:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 05:19:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] clk: imx7ulp: update nic1_bus_clk parent info
Thread-Topic: [PATCH 1/2] clk: imx7ulp: update nic1_bus_clk parent info
Thread-Index: AQHU+yZo1imoxnc2yEuB0Vl7xqmoQQ==
Date:   Thu, 25 Apr 2019 05:19:07 +0000
Message-ID: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9167b82-fc55-4969-64ca-08d6c93d8a76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB394614909D5F9E83BCD5DF6DF53D0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(26005)(2616005)(3846002)(66946007)(2906002)(64756008)(81166006)(81156014)(8936002)(476003)(6116002)(66066001)(50226002)(6486002)(8676002)(52116002)(110136005)(102836004)(73956011)(6436002)(14454004)(386003)(66476007)(15650500001)(66446008)(99286004)(66556008)(186003)(478600001)(486006)(14444005)(6512007)(4326008)(71200400001)(53936002)(86362001)(71190400001)(25786009)(256004)(2201001)(5660300002)(97736004)(36756003)(7736002)(316002)(7416002)(305945005)(2501003)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sxFFmMqNFAx5BfOqd5VgQKDcdgB0CxZ7UNCMZQEuAgfHitBOfHpRTotdo/LtPhfU6QCAZ/FWf5ocG+u0I+GKU3wwrpwHTyhm/pLudrPYVy9L8FMaUKJpPW8QJLloeE4tssQQt3sY9Ko6jIIA5OVu7gJQ/Qo6Lxzp53HcohuTrlRIDb5NERgv+ybsJN4fzfkbIiZY0xtNH4JxlbIpZ0gN4d2dE6rJmoxW+FcnP0BBXZFi/+k1pGRrFobTiQx3VcUIJypj3KSbDgRVwGB0ljD0IkvhOthUL+qWDF+xOSVdOojHipE7efz82qSnJ1Katyap0tQnLpJNCZ7j6rxAKjXUWKnoNJmxfUPyTELFS2I+vX4553NIoSqlzBsuvISTiPx1me5f2zGasmJaaTpK2zUNOduIjekKm64StnlKCMJTx2Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9167b82-fc55-4969-64ca-08d6c93d8a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 05:19:07.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2luY2UgaS5NWDdVTFAgQjAgY2hpcCwgbmljMV9idXNfY2xrJ3MgcGFyZW50IGlzIGNoYW5nZWQg
dG8NCmZyb20gbmljMF9jbGsgZGlyZWN0bHksIHVwZGF0ZSBpdCBhY2NvcmRpbmdseS4NCg0KU2ln
bmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBkcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDd1bHAuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14N3VscC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCmluZGV4IDY2Njgy
MTAuLjQyZTQ2NjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDd1bHAuYw0K
KysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCkBAIC0xMTUsNyArMTE1LDcgQEAg
c3RhdGljIHZvaWQgX19pbml0IGlteDd1bHBfY2xrX3NjZzFfaW5pdChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wKQ0KIA0KIAljbGtzW0lNWDdVTFBfQ0xLX05JQzBfRElWXQk9IGlteF9jbGtfaHdfZGl2
aWRlcl9mbGFncygibmljMF9jbGsiLAkJIm5pY19zZWwiLCAgYmFzZSArIDB4NDAsIDI0LCA0LCBD
TEtfU0VUX1JBVEVfUEFSRU5UIHwgQ0xLX0lTX0NSSVRJQ0FMKTsNCiAJY2xrc1tJTVg3VUxQX0NM
S19OSUMxX0RJVl0JPSBpbXhfY2xrX2h3X2RpdmlkZXJfZmxhZ3MoIm5pYzFfY2xrIiwJCSJuaWMw
X2NsayIsIGJhc2UgKyAweDQwLCAxNiwgNCwgQ0xLX1NFVF9SQVRFX1BBUkVOVCB8IENMS19JU19D
UklUSUNBTCk7DQotCWNsa3NbSU1YN1VMUF9DTEtfTklDMV9CVVNfRElWXQk9IGlteF9jbGtfaHdf
ZGl2aWRlcl9mbGFncygibmljMV9idXNfY2xrIiwJIm5pYzFfY2xrIiwgYmFzZSArIDB4NDAsIDQs
ICA0LCBDTEtfU0VUX1JBVEVfUEFSRU5UIHwgQ0xLX0lTX0NSSVRJQ0FMKTsNCisJY2xrc1tJTVg3
VUxQX0NMS19OSUMxX0JVU19ESVZdCT0gaW14X2Nsa19od19kaXZpZGVyX2ZsYWdzKCJuaWMxX2J1
c19jbGsiLAkibmljMF9jbGsiLCBiYXNlICsgMHg0MCwgNCwgIDQsIENMS19TRVRfUkFURV9QQVJF
TlQgfCBDTEtfSVNfQ1JJVElDQUwpOw0KIA0KIAljbGtzW0lNWDdVTFBfQ0xLX0dQVV9ESVZdCT0g
aW14X2Nsa19od19kaXZpZGVyKCJncHVfY2xrIiwgIm5pYzBfY2xrIiwgYmFzZSArIDB4NDAsIDIw
LCA0KTsNCiANCi0tIA0KMi43LjQNCg0K
