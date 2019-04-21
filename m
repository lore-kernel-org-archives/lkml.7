Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA834C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801A20857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZIUi4w4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDUTJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:09:40 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:18293
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726257AbfDUTJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51Vzfp04Epz7DGAAxjZY4Szn0Da+XZMAW8XtRTOuccc=;
 b=ZIUi4w4DMTIVLsNRL8VCNE0uFDBx10igWKsBFDq0KQQZ1L4AjWDwYRkzCSb7a8pLNGs4FNu4RiY7G6xtazAoa6lFD/8pQVoaF52t+BztlY1Oom6E6aOhOlYlP3rcXfASK5FYa8j0NS95WjyndaEU9D1Z1NdAO/ElOB5J0u6ni3g=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB4726.eurprd06.prod.outlook.com (20.177.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 19:09:30 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%6]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 19:09:30 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Topic: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Index: AQHU+HW/2y2bWzfwvUCVCh3bzOHlxA==
Date:   Sun, 21 Apr 2019 19:09:30 +0000
Message-ID: <20190421190913.1478-3-nandor.han@vaisala.com>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
In-Reply-To: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [91.195.247.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c737d067-804b-4624-2be5-08d6c68ce17e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB4726;
x-ms-traffictypediagnostic: DB7PR06MB4726:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB4726CEB26532A4CF6F0E425685210@DB7PR06MB4726.eurprd06.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39840400004)(376002)(346002)(366004)(396003)(189003)(199004)(446003)(6512007)(486006)(71200400001)(66446008)(66476007)(36756003)(2501003)(26005)(14454004)(8936002)(81156014)(25786009)(316002)(81166006)(8676002)(110136005)(2906002)(1076003)(6506007)(76176011)(476003)(256004)(86362001)(11346002)(68736007)(66556008)(64756008)(71190400001)(2616005)(73956011)(66946007)(186003)(2201001)(102836004)(386003)(11926002)(97736004)(5660300002)(7736002)(6486002)(478600001)(99286004)(53936002)(52116002)(4326008)(5790100002)(3846002)(66066001)(6116002)(6436002)(107886003)(305945005)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4726;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fNyXlAqyTHktxfpqABO2IPY8fagjGbE3745l/WsduHZkz1DZTCiixhgO/ZMZdt2RV6sQe4WUAwRxvUp6A0gpbwhHeb3Z0tjJAoKUU9LzQD/xaiIHwESSXyfEWDcQQ5ppQEp9/Gj2liTVfeqD6GVJ4ssDxku62dzvqNM9kGlka+XZhogUbGrY4sUWZqEVDbIjEPi4HRw7MLruT3ZVLzSFfQxp7ucO2JJx1lkFsqc4ZGo4XP5NgPPlM+Nqy5ey9l30lCSrzO8liCM98qvMCgQZGST46zpBwmNG8vgTpdIvciI7OQVaGAc8eCfojdnVkHSbBvFqrhZUyut7/QqSK7L8D7JPGHlx6jGi2yraiIFhe7FPSD6AxJQ5IL+sm8u18t4CKJTgmVUKcn4VewmEztVt5/ABxXtXIf9lQbi5QnZ1hK0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c737d067-804b-4624-2be5-08d6c68ce17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 19:09:30.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBkb2N1bWVudCBmb3IgdGhlIE5WTUVNIGJhc2Vk
IHJlYm9vdC1tb2RlDQpkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IE5hbmRvciBIYW4gPG5hbmRv
ci5oYW5AdmFpc2FsYS5jb20+DQotLS0NCiAuLi4vcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1v
ZGUudHh0ICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLnR4dA0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252
bWVtLXJlYm9vdC1tb2RlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
b3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQpp
bmRleCAwMDAwMDAwMDAwMDAuLjJlMWI4NmMzMWNiMw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1t
b2RlLnR4dA0KQEAgLTAsMCArMSwzMiBAQA0KK05WTUVNIHJlYm9vdCBtb2RlIGRyaXZlcg0KKw0K
K1RoaXMgZHJpdmVyIGdldHMgcmVib290IG1vZGUgbWFnaWMgdmFsdWUgZnJvbSByZWJvb3QtbW9k
ZSBkcml2ZXINCithbmQgc3RvcmVzIGl0IGluIGEgTlZNRU0gY2VsbCBuYW1lZCAicmVib290LW1v
ZGUiLiBUaGVuIHRoZSBib290bG9hZGVyDQorY2FuIHJlYWQgaXQgYW5kIHRha2UgZGlmZmVyZW50
IGFjdGlvbiBhY2NvcmRpbmcgdG8gdGhlIG1hZ2ljDQordmFsdWUgc3RvcmVkLg0KKw0KK1RoaXMg
RFQgbm9kZSBzaG91bGQgYmUgcmVwcmVzZW50ZWQgYXMgYSBzdWItbm9kZSBvZiBhICJzaW1wbGUt
bWZkIg0KK25vZGUuDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCistIGNvbXBhdGlibGU6IHNo
b3VsZCBiZSAibnZtZW0tcmVib290LW1vZGUiLg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRsZSB0
byB0aGUgcmVib290IG1vZGUgcHJvdmlkZWQgYnkgYSBudm1lbSBkZXZpY2UuDQorLSBudm1lbS1j
ZWxsLW5hbWVzOiBTaG91bGQgYmUgInJlYm9vdC1tb2RlIi4NCisNCitUaGUgcmVzdCBvZiB0aGUg
cHJvcGVydGllcyBzaG91bGQgZm9sbG93IHRoZSBnZW5lcmljIHJlYm9vdC1tb2RlIGRlc2NyaXB0
aW9uDQorZm91bmQgaW4gcmVib290LW1vZGUudHh0DQorDQorRXhhbXBsZToNCisJcmVib290LW1v
ZGUtbnZtZW1AMCB7DQorCQljb21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KKwkJcmVib290LW1v
ZGUgew0KKwkJCWNvbXBhdGlibGUgPSAibnZtZW0tcmVib290LW1vZGUiOw0KKwkJCW52bWVtLWNl
bGxzID0gPCZyZWJvb3RfbW9kZT47DQorCQkJbnZtZW0tY2VsbC1uYW1lcyA9ICJyZWJvb3QtbW9k
ZSI7DQorDQorCQkJbW9kZS1ub3JtYWwgICAgID0gPDB4QUFBQTU1MDE+Ow0KKwkJCW1vZGUtYm9v
dGxvYWRlciA9IDwweEJCQkI1NTAwPjsNCisJCQltb2RlLXJlY292ZXJ5ICAgPSA8MHhDQ0NDNTUw
Mj47DQorCQkJbW9kZS10ZXN0ICAgICAgID0gPDB4RERERDU1MDM+Ow0KKwkJfTsNCisJfTsNCi0t
IA0KMi4xNy4yDQoNCg==
