Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A3C28CC0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NFE0jV0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfE0MEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:04:31 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:23262
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbfE0ME3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1tNCt1Zo2Elml1aZsL4ncYgBz1AR7VKcCef9PzKego=;
 b=NFE0jV0iek+BH9nFkKcdxorwLOLToTJUJmMOTdntx5HlR48HxvWpPVf5tptACxEXGqvnwD8Xh25AvUzmWe3v6mV+0xZ5laeWvRw2SDsSljuWsPxcrZ5YFrq7bc6/T1ZZBUj3hWR4g/27YtouCLaNYInnYUGyMt7plfrge/L6PjE=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6421.eurprd04.prod.outlook.com (20.179.244.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 12:04:26 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:04:26 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [PATCH 3/3] arm64: dts: frwy-ls1046a: add support for micron nor
 flash
Thread-Topic: [PATCH 3/3] arm64: dts: frwy-ls1046a: add support for micron nor
 flash
Thread-Index: AQHVFIRU1CGDaCeXeUuac6cU0kHN7Q==
Date:   Mon, 27 May 2019 12:04:25 +0000
Message-ID: <20190527120619.30546-4-pramod.kumar_1@nxp.com>
References: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BMXPR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::26) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2edb073f-3d3d-45df-f1de-08d6e29b7689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6421;
x-ms-traffictypediagnostic: AM6PR04MB6421:
x-microsoft-antispam-prvs: <AM6PR04MB64212457B50DD286700E32DAF61D0@AM6PR04MB6421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(6636002)(14444005)(4326008)(6486002)(256004)(102836004)(99286004)(3846002)(6436002)(8676002)(478600001)(71200400001)(71190400001)(53936002)(305945005)(2501003)(1076003)(2201001)(54906003)(6116002)(4744005)(8936002)(110136005)(5660300002)(36756003)(14454004)(66446008)(73956011)(186003)(52116002)(86362001)(7736002)(26005)(486006)(2616005)(386003)(446003)(11346002)(81156014)(81166006)(6506007)(476003)(316002)(76176011)(25786009)(6512007)(2906002)(66946007)(66476007)(66556008)(64756008)(66066001)(50226002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6421;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h7flMk9AgNPuxRX3SquA7R2CjT33Eq94p3y0+eXN999ASa5ndWs96Japh6y2PDkZieTyn6+rZJ3HRJfZ36ZwsxyoV/+RZOS4syolxKTEKMhT+3eSCPgc66NxWKv2E12Z2nwhf3Z/ZU76ItDkaNGoC241USmCVoAljWGQQpe8Y88HbO+YbARawHYsKwQOwNZ+QcbgYFjGssW5EybeI6BOzs19QVz5hmidgQu2idsMtlHGFjJc5p7oM7qvExz3Y7QCYu9Y213xPqtC0v772UEXK7b98euMHLiot21gg6W9Wx/F1hdOsdtQ8Mqel+zUCgFEnhbAxcQ73fXpmdsyluva1OBZ6kTtaPKXJZJzp/sD5ekGCNqLzDzM3FjMBG/GxS6LTN6DDtuzsjWtr7KOZ9B9jVcPJwa+HsDQQcQEusYbV7k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb073f-3d3d-45df-f1de-08d6e29b7689
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:04:25.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIG1pY3JvbiBub3IgZmxhc2ggc3VwcG9ydCBmb3IgbHMxMDQ2YSBmcnd5IGJvYXJkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPGFzaGlzaC5rdW1hckBueHAuY29tPg0KU2lnbmVk
LW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3VtYXJfMUBueHAuY29tPg0KLS0tDQogLi4u
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cyAgICB8IDE4ICsrKysrKysr
KysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMx
MDQ2YS1mcnd5LmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZh
LWZyd3kuZHRzDQppbmRleCBjZGE0OTk4OGQ4YjguLjBmNjI2Yzk4NmE5YSAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRzDQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cw0KQEAg
LTIsNyArMiw3IEBADQogLyoNCiAgKiBEZXZpY2UgVHJlZSBJbmNsdWRlIGZpbGUgZm9yIEZyZWVz
Y2FsZSBMYXllcnNjYXBlLTEwNDZBIGZhbWlseSBTb0MuDQogICoNCi0gKiBDb3B5cmlnaHQgMjAx
OSBOWFAuDQorICogQ29weXJpZ2h0IDIwMTkgTlhQDQogICoNCiAgKi8NCiANCkBAIC0xMTMsNiAr
MTEzLDIyIEBADQogDQogfTsNCiANCismcXNwaSB7DQorCW51bS1jcyA9IDwxPjsNCisJYnVzLW51
bSA9IDwwPjsNCisJc3RhdHVzID0gIm9rYXkiOw0KKw0KKwlxZmxhc2gwOiBmbGFzaEAwIHsNCisJ
CWNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciI7DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
CisJCSNzaXplLWNlbGxzID0gPDE+Ow0KKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+
Ow0KKwkJcmVnID0gPDA+Ow0KKwkJc3BpLXJ4LWJ1cy13aWR0aCA9IDw0PjsNCisJCXNwaS10eC1i
dXMtd2lkdGggPSA8ND47DQorCX07DQorfTsNCisNCiAjaW5jbHVkZSAiZnNsLWxzMTA0Ni1wb3N0
LmR0c2kiDQogDQogJmZtYW4wIHsNCi0tIA0KMi4xNy4xDQoNCg==
