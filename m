Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F9C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621992087E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CvDwWER9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD1D1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:27:23 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:64350
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfD1D1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylxzJ6jku5D9eXVqOkKVH7cFogpW9wMbR6ybfEQQKlU=;
 b=CvDwWER9Qw8vVtTjQsi9qnO2CeB5b/4XMVFxF1SM5fpfsWAgWSxczmeK6Ldg0NLJibkgNawd56BAtdU2TZAHXYv3nnXoaXxV/rMUpMUHOYwXIaW2OQmaBFRGFMdxxo7dlOHVp9xkxhy8uBHUnUy+wMFH/E+354ey4KA+2kFngUQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 03:27:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.015; Sun, 28 Apr 2019
 03:27:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 4/4] dt-bindings: watchdog: remove i.MX system controller
 watchdog
Thread-Topic: [PATCH V2 4/4] dt-bindings: watchdog: remove i.MX system
 controller watchdog
Thread-Index: AQHU/XJHVvpWJzeSMUO3ikfCWcHdPQ==
Date:   Sun, 28 Apr 2019 03:27:17 +0000
Message-ID: <1556421727-7401-4-git-send-email-Anson.Huang@nxp.com>
References: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98477339-1cea-4184-6b02-08d6cb8969f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB3897D26184DBAFE21577291AF5380@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(256004)(71190400001)(14444005)(71200400001)(97736004)(6116002)(186003)(66066001)(86362001)(2201001)(476003)(2616005)(8936002)(36756003)(486006)(11346002)(81156014)(81166006)(25786009)(53936002)(50226002)(3846002)(446003)(2906002)(2501003)(386003)(6506007)(76176011)(68736007)(4326008)(102836004)(64756008)(52116002)(66946007)(66476007)(66556008)(8676002)(66446008)(6486002)(6436002)(7416002)(14454004)(73956011)(7736002)(99286004)(478600001)(316002)(110136005)(305945005)(26005)(6512007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7/KpAzxugEy/SpBUv8hvUX8ozwE1tRLXlMy+PA8G4GN42+DdDLSzlVUbkBRKXsQmub1VV8R/8hflRSzuUymaRS5Kz2B9+/trafDoRsT9EwsThL61BYYN5dQ9whCNYwDETfZNxXbhXu8Xl3MqYEM2iBuZ4J4QowVBSwvVYIpnixLb5ldltrSzrt+OhAuBlZJtvH1inbgE6gvXpXKhLmDwQwoVqe48z7QfqSk+DzCVy6eOgkqyMPmsd+okYaRv0UPObUMlbX4vDsQTOqNZXYr+wK8idfZoYa/mbe5wekw9Q8srG4HquqvXcWRNR5r/yXlO3aF1J5cNK9Fxnn5+7nRZwObY4nBs/1MHvxDzBnCjQGOUZeKG3fUoeU/fBR/qTm0Ztqk1a2btQVWm39SmBiyUTUUT/lcp85pwlJkXEmOdK3g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98477339-1cea-4184-6b02-08d6cb8969f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 03:27:17.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZyBub3cgZGVwZW5kcyBvbiBTQ1UgZHJpdmVy
LCBzbyBpdA0KbmVlZHMgdG8gYmUgc3Vibm9kZSBvZiBTQ1Ugbm9kZSBpbiBEVCwgYmluZGluZyBk
b2MgaXMgbW92ZWQgdG8NCmZzbCxzY3UudHh0IGFzIHdlbGwuDQoNClNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpOZXcgcGF0Y2guDQotLS0NCiAu
Li4vYmluZGluZ3Mvd2F0Y2hkb2cvZnNsLWlteC1zYy13ZHQudHh0ICAgICAgICAgICB8IDI0IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjQgZGVsZXRpb25zKC0pDQog
ZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRj
aGRvZy9mc2wtaW14LXNjLXdkdC50eHQNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9mc2wtaW14LXNjLXdkdC50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvZnNsLWlteC1zYy13ZHQudHh0DQpkZWxl
dGVkIGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAyYjg3ZTkuLjAwMDAwMDANCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9mc2wtaW14LXNjLXdkdC50eHQN
CisrKyAvZGV2L251bGwNCkBAIC0xLDI0ICswLDAgQEANCi0qIEZyZWVzY2FsZSBpLk1YIFN5c3Rl
bSBDb250cm9sbGVyIFdhdGNoZG9nDQotDQotaS5NWCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRv
ZyBpcyBmb3IgaS5NWCBTb0NzIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgaW5zaWRlLA0KLXRoZSB3
YXRjaGRvZyBpcyBtYW5hZ2VkIGJ5IHN5c3RlbSBjb250cm9sbGVyLCB1c2VycyBjYW4gT05MWSBj
b21tdW5pY2F0ZSB3aXRoDQotc3lzdGVtIGNvbnRyb2xsZXIgZnJvbSBzZWN1cmUgbW9kZSBmb3Ig
d2F0Y2hkb2cgb3BlcmF0aW9ucywgc28gTGludXggaS5NWCBzeXN0ZW0NCi1jb250cm9sbGVyIHdh
dGNoZG9nIGRyaXZlciB3aWxsIGNhbGwgQVJNIFNNQyBBUEkgYW5kIHRyYXAgaW50byBBUk0tVHJ1
c3RlZC1GaXJtd2FyZQ0KLWZvciB3YXRjaGRvZyBvcGVyYXRpb25zLCBBUk0tVHJ1c3RlZC1GaXJt
d2FyZSBpcyBydW5uaW5nIGF0IHNlY3VyZSBFTDMgbW9kZSBhbmQNCi1pdCB3aWxsIHJlcXVlc3Qg
c3lzdGVtIGNvbnRyb2xsZXIgdG8gZXhlY3V0ZSB0aGUgd2F0Y2hkb2cgb3BlcmF0aW9uIHBhc3Nl
ZCBmcm9tDQotTGludXgga2VybmVsLg0KLQ0KLVJlcXVpcmVkIHByb3BlcnRpZXM6DQotLSBjb21w
YXRpYmxlOglTaG91bGQgYmUgOg0KLQkJImZzbCxpbXg4cXhwLXNjLXdkdCINCi0JCWZvbGxvd2Vk
IGJ5ICJmc2wsaW14LXNjLXdkdCI7DQotDQotT3B0aW9uYWwgcHJvcGVydGllczoNCi0tIHRpbWVv
dXQtc2VjIDogQ29udGFpbnMgdGhlIHdhdGNoZG9nIHRpbWVvdXQgaW4gc2Vjb25kcy4NCi0NCi1F
eGFtcGxlczoNCi0NCi13YXRjaGRvZyB7DQotCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mt
d2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCi0JdGltZW91dC1zZWMgPSA8NjA+Ow0KLX07DQotLSAN
CjIuNy40DQoNCg==
