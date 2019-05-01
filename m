Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE08C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0C21734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="NnusVxqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfEAJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:29:11 -0400
Received: from mail-eopbgr20106.outbound.protection.outlook.com ([40.107.2.106]:43822
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfEAJ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7UK1yvx+6dt/H08M6Av+IoQeTp9R+On4KnxRkShpFk=;
 b=NnusVxqG5VIx0NbBKbau7kzaEYxDV2tcYdyxYyOBcXCQ87z7q5ee9fNTN3EVDEFgiEhDjmPf2irhgmMBmvykmR4sPAeMoxJE55dvaKh/NBusCrR1RBDduE5C0SCsCu68cnQP5vO98BeqBjsdzuMXc5Xurbc28FPkcmwGPwvfTGg=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2143.EURPRD10.PROD.OUTLOOK.COM (20.177.60.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Wed, 1 May 2019 09:29:03 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8%2]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 09:29:03 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH v2 1/6] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Topic: [PATCH v2 1/6] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Index: AQHVAABQIpXKyeFs/Eiq39Pa+YXsOg==
Date:   Wed, 1 May 2019 09:29:03 +0000
Message-ID: <20190501092841.9026-2-rasmus.villemoes@prevas.dk>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::29) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6f031c6-46db-49d1-0a98-08d6ce17731c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2143;
x-ms-traffictypediagnostic: VI1PR10MB2143:
x-microsoft-antispam-prvs: <VI1PR10MB2143B8FB7570F4110E7AD1B38A3B0@VI1PR10MB2143.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39850400004)(346002)(396003)(366004)(189003)(199004)(14454004)(81166006)(110136005)(54906003)(26005)(68736007)(8676002)(6512007)(4326008)(8976002)(486006)(74482002)(71200400001)(2906002)(7416002)(6486002)(72206003)(186003)(316002)(478600001)(2501003)(36756003)(6436002)(71190400001)(25786009)(1076003)(6506007)(2616005)(305945005)(3846002)(44832011)(256004)(11346002)(6116002)(5660300002)(8936002)(14444005)(446003)(4744005)(476003)(50226002)(76176011)(42882007)(7736002)(99286004)(66446008)(64756008)(53936002)(52116002)(107886003)(386003)(66066001)(66946007)(66476007)(102836004)(66556008)(81156014)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2143;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ai0PVEIrvp7KjmqARhrh9el48YNiGUWDm2VoRocSI/vrkJzgmaCK2Wf/YxXPYwIN33FIBuGS0gsbEzxnPBWCy948+oVoH5xBpU54WAP3JHNmm66Oixgq6XetQBhCF7PPf1S+X596k9vmn74GToVVQlhywKCFTwgbY5ks0asvVP/e3nt78XeR0Ztx5NCam1TslJ4db4zw1aMUe76NmVJOsj6E1WGBn+8bF+OD9vynijCifjqRq3tpKrx3GOMP30BPD3nNUwYXFMWN0zg5/ln4L8T5LrQzO9Xd4BoZni357MHKcUMWmitWYe9e4I4Pxnn0eVHGlluZqJ1bDwL/FhCpIG/VdxRTu1TNU8Ek5tZOzZAXdpNsn26JEr9RdacXSTm7T7Mo7mDHDbZs2GhnUBYNHuGa5qVlwA11gRtunj2YLMk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f031c6-46db-49d1-0a98-08d6ce17731c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 09:29:03.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxvY2FsIHZhcmlhYmxlIHNudW1faW5pdCBoYXMgbm8gcmVhc29uIHRvIGhhdmUgc3RhdGlj
IHN0b3JhZ2UgZHVyYXRpb24uDQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGMtcy5mcj4NClNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPHJh
c211cy52aWxsZW1vZXNAcHJldmFzLmRrPg0KLS0tDQogZHJpdmVycy9zb2MvZnNsL3FlL3FlLmMg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyBiL2RyaXZlcnMvc29jL2ZzbC9x
ZS9xZS5jDQppbmRleCA2MTJkOWM1NTFiZTUuLjg1NTM3M2RlYjc0NiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL2ZzbC9xZS9xZS5jDQorKysgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYw0KQEAg
LTMwNiw3ICszMDYsNyBAQCBzdGF0aWMgdm9pZCBxZV9zbnVtc19pbml0KHZvaWQpDQogCQkweDI4
LCAweDI5LCAweDM4LCAweDM5LCAweDQ4LCAweDQ5LCAweDU4LCAweDU5LA0KIAkJMHg2OCwgMHg2
OSwgMHg3OCwgMHg3OSwgMHg4MCwgMHg4MSwNCiAJfTsNCi0Jc3RhdGljIGNvbnN0IHU4ICpzbnVt
X2luaXQ7DQorCWNvbnN0IHU4ICpzbnVtX2luaXQ7DQogDQogCXFlX251bV9vZl9zbnVtID0gcWVf
Z2V0X251bV9vZl9zbnVtcygpOw0KIA0KLS0gDQoyLjIwLjENCg0K
