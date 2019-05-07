Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2016C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E58D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DNImPYDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEGGei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:34:38 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:40673
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfEGGeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irwAQtzDqb8H/upB8X/rIf2Q6cCoGyAO+mMYLq3mc0k=;
 b=DNImPYDdadnirOpXWbY1XvM1D+axiBOwXzsK4mad/qUkSiBl0wjbBRC65xt5QHMXEujSbBFMf7g+3mz2ruYkGpkaxyYP+dSRoMSBCc4R5XhWr+AxBpzmfDS77gRpwo0CTnp8jA0eJ5UuQ0CdCAL33rO5tUouk8f0DOIkTxz0XRM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 06:34:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 06:34:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 4/5] ARM: dts: imx6sll-evk: Assign corresponding power supply
 for vdd3p0
Thread-Topic: [PATCH 4/5] ARM: dts: imx6sll-evk: Assign corresponding power
 supply for vdd3p0
Thread-Index: AQHVBJ7uVmO2K9BxTE+S0xAOeBLBgQ==
Date:   Tue, 7 May 2019 06:34:33 +0000
Message-ID: <1557210565-4457-4-git-send-email-Anson.Huang@nxp.com>
References: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c7dea28-302c-43e3-b297-08d6d2b610f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB3866A2B0328C093991F022E7F5310@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(6116002)(3846002)(8676002)(52116002)(36756003)(66476007)(7736002)(6436002)(6486002)(2501003)(2201001)(73956011)(66946007)(66556008)(64756008)(478600001)(66446008)(2906002)(316002)(86362001)(66066001)(14454004)(110136005)(50226002)(99286004)(8936002)(6512007)(186003)(76176011)(71190400001)(4326008)(71200400001)(68736007)(53936002)(25786009)(81166006)(81156014)(26005)(256004)(102836004)(305945005)(446003)(11346002)(2616005)(476003)(5660300002)(486006)(4744005)(386003)(6506007)(138113003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LkAD8G4KT5iSdxGUyV6KZSmYbIKf7wcQQ9+WRczpbJh9vkeAq2dSbNtgayD5UVGooNQYlwea0zh8LZ6ZHzvJy0hDhil4LWhCO7RW0eUAHSFBY4FV4F0+48T4Be+Q2yQ0cFw2N4lEogsrimGXROBkAm0HHEbOQNXZJz4TcmAiXfD/u/MNSN9mLB5ane3fUoaweaPs3XvKTFQaQnJ24Q7nlLp51bSrRWVg3u4cveg2R3apoLx2Z6fXJd7FLBswE2dLNCm1jDxkh/LnFavBjQwT0tJhIuXMIms1vPwMGh2rIP7m8VqkVbRwSHS8WKoiFSnd0lMrOx5NxGt7lgJuDm+2dVFFnWuS/R01yFnrKmVyQV6qOjjjVIu7bkz0UuNkmIg+YG4pBIRg49oqhUsglGzFIN3QdEFtn2HWHXBAOKCKlrE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7dea28-302c-43e3-b297-08d6d2b610f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 06:34:33.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDZTTEwgRVZLIGJvYXJkLCBzdzIgc3VwcGxpZXMgdmRkM3AwIExETywgdGhpcyBwYXRj
aCBhc3NpZ25zDQpjb3JyZXNwb25kaW5nIHBvd2VyIHN1cHBseSBmb3IgdmRkM3AwIHRvIGF2b2lk
IGNvbmZ1c2lvbiBieSBiZWxvdyBsb2c6DQoNCnZkZDNwMDogc3VwcGxpZWQgYnkgcmVndWxhdG9y
LWR1bW15DQoNCldpdGggdGhpcyBwYXRjaCwgdGhlIHBvd2VyIHN1cHBseSBpcyBtb3JlIGFjY3Vy
YXRlOg0KDQp2ZGQzcDA6IHN1cHBsaWVkIGJ5IFNXMg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZz
bGwtZXZrLmR0cyB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwtZXZrLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZzbGwtZXZrLmR0cw0KaW5kZXggNGEzMWE0MS4uNzg4MDllYSAxMDA2NDQN
Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwtZXZrLmR0cw0KKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnNsbC1ldmsuZHRzDQpAQCAtMjY1LDYgKzI2NSwxMCBAQA0KIAlzdGF0dXMg
PSAib2theSI7DQogfTsNCiANCismcmVnXzNwMCB7DQorCXZpbi1zdXBwbHkgPSA8JnN3Ml9yZWc+
Ow0KK307DQorDQogJnVhcnQxIHsNCiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGlu
Y3RybC0wID0gPCZwaW5jdHJsX3VhcnQxPjsNCi0tIA0KMi43LjQNCg0K
