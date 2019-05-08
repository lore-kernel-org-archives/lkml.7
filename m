Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F6C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BEF21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEqzag+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEHKfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:35:36 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:23427
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfEHKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JDZ1ndfxZ/LGMLKjgHn4vd5N+Bi7zALvX8htPO3b/k=;
 b=CEqzag+G05m6MBVR59LmeC/N+X/6AoS4WJitk8nwCykn2CUVMKWJ/H21+7fYOODkU3V9oLdJkMCkehEKKXyFNRBTSFUNVxkpk44JwNmIfE+aOGVCoPSEi9EzJ95m3lJUVFrRgccRHSJGxrjRDkqIsW4wKG7xr4OPfMs23ZOFqAI=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.177.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:35:31 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:35:31 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v1 3/4] arm64: ls1028aqds: Add support DP nodes for LS1028AQDS
Thread-Topic: [v1 3/4] arm64: ls1028aqds: Add support DP nodes for LS1028AQDS
Thread-Index: AQHVBYnCrlf8Tn/pH0e2gIr+L++74A==
Date:   Wed, 8 May 2019 10:35:30 +0000
Message-ID: <20190508103703.40885-3-wen.he_1@nxp.com>
References: <20190508103703.40885-1-wen.he_1@nxp.com>
In-Reply-To: <20190508103703.40885-1-wen.he_1@nxp.com>
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
x-ms-office365-filtering-correlation-id: 27612a90-6f86-4705-5f04-08d6d3a0e4bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
x-microsoft-antispam-prvs: <AM0PR04MB4962889C9B661D9B7F5F8FF4E2320@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(66946007)(186003)(2616005)(476003)(53936002)(66556008)(99286004)(4326008)(66066001)(73956011)(1076003)(66446008)(36756003)(64756008)(305945005)(316002)(7736002)(54906003)(2501003)(110136005)(76176011)(52116002)(6506007)(386003)(256004)(2201001)(102836004)(86362001)(446003)(11346002)(66476007)(5660300002)(26005)(6116002)(3846002)(14454004)(2906002)(6512007)(8936002)(71190400001)(71200400001)(486006)(50226002)(6486002)(6436002)(68736007)(25786009)(8676002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TwWt+Wvx9k8J70dnqBjNTk0Zq4f6cwtdHHQhRiGoqB6Ka/ziwNuVTjcnOnq5qn74FVX2A/KoUoYDS6vPH3n/U5Rw2oLH6Guuu1S75BIhKYkzzJtkCynQDynj8Vhn7dSTkYo+g9tri0/53Cmdy97toPs98rHc3evBH7r0u5ed4/gm+y7cskR2F+fc6ETJB6B0R4UGaEpvXPOUzsvVoAvOQN3mGGXp6Lnl6nBT7juf37ArN2KK8vHGR8jQZhNKFDVSap7zN6LuYLGo4ijhTBkkg4YCOHoPrqGbnFRSyxKaBNP4tWES9pkvzdx9Ou4d5nUI4FNBrT0OP19dSsZsEhIhhYNcci6yWF3HquX99S1Rn37s/pVeGHPOjhSR6Vj2yiuY916jjBAvf1V7GB3Vl9vaWq4kUSvzjy5oh3i8obQmGF8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27612a90-6f86-4705-5f04-08d6d3a0e4bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:35:30.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgSERQIFBIWSBDb250cm9sbGVyIHJlbGF0ZWQgbm9kZXMgb24gdGhlIExT
MTAyOEFRRFMuDQpOb3cgTFMxMDI4QVFEUyBvbiBEUCBoYXMgZm9sbG93aW5nIGZlYXR1cmVzOg0K
LSBTdXBwb3J0cyA0IGRwIGxhbmUgY2hhbm5lbCBhbmQgbGFuZSBtYXBwaW5nIGlzIDEtMC0zLTIu
DQotIEJ5IGRlZmF1bHQsIHRoZSBwaXhlbCBsaW5rIHJhdGUgdmFsdWUncyAyN01oei4NCi0gQnkg
ZGVmYXVsdCwgc3VwcG9ydCB0aGUgcmVzb2x1aW9ucyBhcmUgNGtANjAsMTA4MHBANjAsNzIwcEA2
MCwNCjQ4MHBANjAuIGFsc28gdXNlciBjYW4gc3BlY2lmeSBhbnkgY29tYmluYXRpb24gb2YgbW9u
aXRvciBzdXBwb3J0ZWQNCnJlc29sdWlvbnMgYnkgd3JpdHRlbiBpbiB0aGUgbm9kZSAncmVzb2x1
aW9uJy4NCi0gQnkgZGVmYXVsdCwgdGhlIGVkaWQgZnVuY3Rpb24gaXMgbm90IGluIHVzZS4NCg0K
U2lnbmVkLW9mZi1ieTogQWxpc29uIFdhbmcgPGFsaXNvbi53YW5nQG54cC5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzIHwgMTIgKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQppbmRleCBiMzU5MDY4ZDk2MDUuLmM4
YTkyZDRjNDk2NCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczEwMjhhLXFkcy5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczEwMjhhLXFkcy5kdHMNCkBAIC0xNTMsMyArMTUzLDE1IEBADQogJnNhaTEgew0KIAlzdGF0
dXMgPSAib2theSI7DQogfTsNCisNCismaGRwIHsNCisJZnNsLG5vX2VkaWQ7DQorCXJlc29sdXRp
b24gPSAiMzg0MHgyMTYwQDYwIiwNCisJCSAgICIxOTIweDEwODBANjAiLA0KKwkJICAgIjEyODB4
NzIwQDYwIiwNCisJCSAgICI3MjB4NDgwQDYwIjsNCisJbGFuZV9tYXBwaW5nID0gPDB4NGU+Ow0K
KwllZHBfbGlua19yYXRlID0gPDB4Nj47DQorCWVkcF9udW1fbGFuZXMgPSA8MHg0PjsNCisJc3Rh
dHVzID0gIm9rYXkiOw0KK307DQotLSANCjIuMTcuMQ0KDQo=
