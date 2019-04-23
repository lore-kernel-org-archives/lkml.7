Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B38C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE71206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="isaiPa4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfDWNvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:55 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:39649
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfDWNvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g0lTa6I7/GKE2J/Te7pvuU1GY/Y0Di8Xu7jjSBYGMU=;
 b=isaiPa4tjmIu+/dqfF+bmFVhTWLz3Ey2UXkqykAmkhbHzJCg5RuAYs3c2sOOYrHwhazjPeltGdTj7BowRbTYEGe+jB6/uc96/rvGe8tIHpsdOGAezURoVpYpuV53D2rO9BhPHSJr8XVk9yH1D2Uvm9/otl6hzeoNGu7A6jUqMwg=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:50 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 15/15] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Topic: [PATCH v1 15/15] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Thread-Index: AQHU+duzRuZ1Gl0aI0CUf3GuJSUSGg==
Date:   Tue, 23 Apr 2019 13:51:50 +0000
Message-ID: <1556027045-5269-16-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d9c2fb-1c98-481a-027b-08d6c7f2d56f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854F16A203871964C85938E89230@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(2201001)(71200400001)(86362001)(54906003)(110136005)(52116002)(6116002)(3846002)(2906002)(71190400001)(76176011)(14454004)(73956011)(2616005)(5660300002)(446003)(476003)(68736007)(6436002)(97736004)(11346002)(99286004)(478600001)(316002)(486006)(2501003)(66446008)(66476007)(102836004)(66066001)(26005)(6486002)(66556008)(386003)(53936002)(6506007)(50226002)(4326008)(186003)(6512007)(7736002)(81166006)(81156014)(305945005)(8676002)(8936002)(256004)(36756003)(66946007)(4744005)(7416002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Ztryl8J7HtYXcrMWF38Gqy8r8xUTMF5EB/oNIfOxstIY6nBnZo/0hRVyt1rz7N2QNZSzkoiEmonK0ESxRToGNfu1VmR9S/g5xdnASbYM0ltRs5/TsxIW9uhrDuMKytBzKa+W2BG86xroxJKCnnzzGcx6MMY0i4laVzjQS9fmL3yRaa+kTmX5pJOURYOa4KRZOPmG31QMVgWNVqsCG4C1kGZaoMj5bo4gaNLyXr1BeUubnqmRS9Dv88nXV2nEkgFMeV6c+hNMaHED/vSebRDiW3LA3s3bbKd2ugQaA454ZRSjGEeZKxjE0oR99/1DzjKEn+RfoGvhdQE8wexhgHcKYoivyTspTkiQpbw39k9JaEzCBOjrQ/Gmkm0RlrGHTeoRxHk/JKfk/2N5vRvjtB35CQrSLJx+oJ/suQUmF2n6nE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d9c2fb-1c98-481a-027b-08d6c7f2d56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:50.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIFNETUEgc3VwcG9ydCBvbiBpLm14OG1xLzhtbSBjaGlwcywgaW5jbHVkaW5nIGVuYWJs
aW5nDQpDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSL0NPTkZJR19GV19MT0FERVJfVVNFUl9I
RUxQRVJfRkFMTEJBQ0sNCmZvciBmaXJtd2FyZSBsb2FkZWQgYnkgdWRldi4NCg0KU2lnbmVkLW9m
Zi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJt
NjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IDE3ZGFhOTcuLjcwODE4MTcgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtMjAzLDYgKzIwMyw4IEBAIENPTkZJR19ORVRfOVBfVklSVElPPXkNCiBD
T05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0KIENPTkZJR19ERVZUTVBG
Uz15DQogQ09ORklHX0RFVlRNUEZTX01PVU5UPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVM
UEVSPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSX0ZBTExCQUNLPXkNCiBDT05GSUdf
RE1BX0NNQT15DQogQ09ORklHX0NNQV9TSVpFX01CWVRFUz0zMg0KIENPTkZJR19ISVNJTElDT05f
TFBDPXkNCkBAIC02MzUsNiArNjM3LDcgQEAgQ09ORklHX1JUQ19EUlZfSU1YX1NDPW0NCiBDT05G
SUdfUlRDX0RSVl9YR0VORT15DQogQ09ORklHX0RNQURFVklDRVM9eQ0KIENPTkZJR19ETUFfQkNN
MjgzNT1tDQorQ09ORklHX0lNWF9TRE1BPXkNCiBDT05GSUdfSzNfRE1BPXkNCiBDT05GSUdfTVZf
WE9SX1YyPXkNCiBDT05GSUdfUEwzMzBfRE1BPXkNCi0tIA0KMi43LjQNCg0K
