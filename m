Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B5C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81E6206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xypuXb7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfDYN5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:57:09 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:6078
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfDYN5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhLo980Z9FNglNps+aM4DA57SzvzK3sS3YwUOtX3bEw=;
 b=xypuXb7YgBX7PwO52oZVglSE7pP8bezwXDGK+iu56syc8XfRMAiQxB12t07w6dUZ+YA1CfxBCcZWWEO0VkcMzf3LtHBeYyfNxxGmW9gyV+QzPQH3XmB3GKY7MseCRtJ0qYd1I/Al4gHq4n1VXYTtOOA69yZWeZl7ej/YTKemEI8=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB3248.eurprd04.prod.outlook.com (10.170.232.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 13:57:05 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 13:57:05 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3] clk: qoriq: add support for lx2160a
Thread-Topic: [PATCH v3] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+27EnTHp/aOrT06vySVf5Nn13A==
Date:   Thu, 25 Apr 2019 13:57:05 +0000
Message-ID: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bb49b7f-4e22-4f61-da8f-08d6c985e667
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3248;
x-ms-traffictypediagnostic: VI1PR04MB3248:
x-microsoft-antispam-prvs: <VI1PR04MB32481EA7414F89FB8B43289DF33D0@VI1PR04MB3248.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(66066001)(53936002)(386003)(86362001)(71200400001)(71190400001)(2201001)(7736002)(5660300002)(8676002)(81156014)(8936002)(50226002)(81166006)(6506007)(305945005)(26005)(256004)(102836004)(186003)(6116002)(3846002)(44832011)(2616005)(54906003)(25786009)(14454004)(316002)(99286004)(2906002)(68736007)(4326008)(36756003)(6512007)(478600001)(110136005)(52116002)(2501003)(97736004)(66446008)(64756008)(6486002)(66476007)(66556008)(66946007)(6436002)(73956011)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3248;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aMhuQKq6HRhDOyRRDEy0JRwlHdrjnEMn2j2INaPxixgSiBv8Y0J++cGaN1tWoI528xGfw5+dFiZ9kXEEvkS/5yj0SNWwAZZ5ke3KZ1oEpuJ5w0+FErSMKmiiOFd69kuzzhJihRyRGY9a+2Km86GORMLR4uafxWK8r63Ub/0n+7AFysiIkcUdkw99rYsSw4uPCbbn3m9IgdevluFt6F5vwDFTdHf7k+S+DxdPgnmry33cOCdzzfUYIv0V/AReNs3RzDExHATb4v1Xc3lOBeczYSBrgQBphJi0yCM0pWTQb1z0qF8RJowDw9j2MUCD5D1mNzGqiTKCyCDrGi3QRcdxtz86bIKxhFHpLeGFebszOyvn7XUfhKCC9ZZnNMlTnlaIUKF148wFCk3Ll0UpF6axNvzupZWKNgsiqeQdHcRWwpU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb49b7f-4e22-4f61-da8f-08d6c985e667
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 13:57:05.6285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpBZGQgY2xv
Y2tnZW4gc3VwcG9ydCBhbmQgY29uZmlndXJhdGlvbiBmb3IgTlhQIFNvQyBseDIxNjBhIGluIHFv
cmlxDQpjbG9jayBkcml2ZXIgd2l0aCBjb21wYXRpYmxlIHByb3BlcnR5IGFzICJmc2wsbHgyMTYw
YS1jbG9ja2dlbiIuDQoNCnFvcmlxLWNwdWZyZXEgZHJpdmVyIGlzIGJhc2VkIG9uIHFvcmlxIGNs
b2NrIGRyaXZlciwgZW5hYmxlIHN1cHBvcnQNCm9mIE5YUCBTb0MgbHgyMTYwYSBpbiBxb3JpcSBj
cHVmcmVxIGRyaXZlciB0byBoYW5kbGUgdGhlIGx4MjE2MGEgU29DLg0KDQpTaWduZWQtb2ZmLWJ5
OiBUYW5nIFl1YW50aWFuIDxhbmR5LnRhbmdAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlvZ2Vz
aCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFZhYmhh
diBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCkFja2VkLWJ5OiBTY290dCBXb29kIDxv
c3NAYnVzZXJyb3IubmV0Pg0KQWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCkFja2VkLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KLS0t
DQpDaGFuZ2VzIGZvciB2MzoNCi0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50cyBvZiBSYWZh
ZWwgSi4gV3lzb2NraQ0KLSBVcGRhdGVkIGNvbW1pdCBtZXNzYWdlDQogDQpDaGFuZ2VzIGZvciB2
MjoNCi0gU3ViamVjdCBsaW5lIHVwZGF0ZWQNCg0KIGRyaXZlcnMvY2xrL2Nsay1xb3JpcS5jICAg
ICAgICAgfCAxMiArKysrKysrKysrKysNCiBkcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5j
IHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KaW5k
ZXggM2Q1MWQ3Yy4uMWExNTIwMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5j
DQorKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KQEAgLTU3MCw2ICs1NzAsMTcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyBjaGlwaW5mb1tdID0gew0KIAkJLmZs
YWdzID0gQ0dfVkVSMyB8IENHX0xJVFRMRV9FTkRJQU4sDQogCX0sDQogCXsNCisJCS5jb21wYXQg
PSAiZnNsLGx4MjE2MGEtY2xvY2tnZW4iLA0KKwkJLmNtdXhfZ3JvdXBzID0gew0KKwkJCSZjbG9j
a2dlbjJfY211eF9jZ2ExMiwgJmNsb2NrZ2VuMl9jbXV4X2NnYg0KKwkJfSwNCisJCS5jbXV4X3Rv
X2dyb3VwID0gew0KKwkJCTAsIDAsIDAsIDAsIDEsIDEsIDEsIDEsIC0xDQorCQl9LA0KKwkJLnBs
bF9tYXNrID0gMHgzNywNCisJCS5mbGFncyA9IENHX1ZFUjMgfCBDR19MSVRUTEVfRU5ESUFOLA0K
Kwl9LA0KKwl7DQogCQkuY29tcGF0ID0gImZzbCxwMjA0MS1jbG9ja2dlbiIsDQogCQkuZ3V0c19j
b21wYXQgPSAiZnNsLHFvcmlxLWRldmljZS1jb25maWctMS4wIiwNCiAJCS5pbml0X3BlcmlwaCA9
IHAyMDQxX2luaXRfcGVyaXBoLA0KQEAgLTE0MjcsNiArMTQzOCw3IEBAIENMS19PRl9ERUNMQVJF
KHFvcmlxX2Nsb2NrZ2VuX2xzMTA0M2EsICJmc2wsbHMxMDQzYS1jbG9ja2dlbiIsIGNsb2NrZ2Vu
X2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0NmEsICJmc2wsbHMx
MDQ2YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Ns
b2NrZ2VuX2xzMTA4OGEsICJmc2wsbHMxMDg4YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0K
IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMjA4MGEsICJmc2wsbHMyMDgwYS1jbG9j
a2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KK0NMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2x4
MjE2MGEsICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9E
RUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3AyMDQxLCAiZnNsLHAyMDQxLWNsb2NrZ2VuIiwgY2xvY2tn
ZW5faW5pdCk7DQogQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDMwNDEsICJmc2wscDMw
NDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9j
a2dlbl9wNDA4MCwgImZzbCxwNDA4MC1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEv
cW9yaXEtY3B1ZnJlcS5jDQppbmRleCA0Mjk1ZTU0Li44MWYwMjg4IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYw0KKysrIGIvZHJpdmVycy9jcHVmcmVxL3Fvcmlx
LWNwdWZyZXEuYw0KQEAgLTI4NCw2ICsyODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBub2RlX21hdGNoZXNbXSBfX2luaXRjb25zdCA9IHsNCiAJeyAuY29tcGF0aWJsZSA9
ICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTA4
OGEtY2xvY2tnZW4iLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxsczIwODBhLWNsb2NrZ2Vu
IiwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsIH0sDQogCXsg
LmNvbXBhdGlibGUgPSAiZnNsLHA0MDgwLWNsb2NrZ2VuIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9
ICJmc2wscW9yaXEtY2xvY2tnZW4tMS4wIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wscW9y
aXEtY2xvY2tnZW4tMi4wIiwgfSwNCi0tIA0KMi43LjQNCg0K
