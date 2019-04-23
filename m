Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE9C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F962206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxuI8/pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfDWNuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:50:51 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:40949
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDWNuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjCzHinQhwjY44/hnLLNi+yj8vUvaa0nPFDq/SuwCB8=;
 b=jxuI8/pMsmkqKCj28FC915s2M2SWeD9vHebSFtLgEat2Fko7ynH7q1IaetUW1FvAHDS+DQRerkjiNomHokVoU1NSDMQbundlkL2AUxBVkS23vBY/yu+9F+vQukVm5w/3zH5uopYv6MFzLBS5Pj6BQoP9xRX7xW/BgM2PR4q9Eh4=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:50:46 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:50:46 +0000
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
Subject: [PATCH v1 02/15] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Thread-Topic: [PATCH v1 02/15] Revert "ARM: dts: imx6: Use correct SDMA script
 for SPI cores"
Thread-Index: AQHU+duNv4Oa2JeYTUGrU3TX4OrJbw==
Date:   Tue, 23 Apr 2019 13:50:46 +0000
Message-ID: <1556027045-5269-3-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: a535c803-50ff-44d3-ac40-08d6c7f2af5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-microsoft-antispam-prvs: <VI1PR04MB5901083EDDB25750178C6C2389230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CJwA+PrqhnDVSO1P13nJtfj5sPZj8XzSmKo8l4a1E4cUKeNksHKwp2nRKP2m2aywqqhCoAWP56Ye3U6GgbpQZe5DkQoAkfq/FZOnHVEo8cTQJRxkcmq7bEnBTDyseFGQX9lLqsoxWHwt9PZKnBIFXKF+DAztsKW6kt3GEPR/lyH1pbHX5Hx05pK+ufshL+TkU/AIOhSNKv6wmiUuJeLE4HFt8i6TuyveW3NIgYF/w1dBjIuH0KlHvkMaAMFjpurdZzcLQ8jnRiVhmbSG6xa9frJjt0Dp06ccNmintRURdRJ9w0CXpyLSb13O4tWhP/b5AaacXnJEmGU2S+aJYT6vskAlcDjvBmZJa/GuPWftWCGrwUjUAJBkwczGcCqV8gJPzuBDJMIgZ0mEn5ba40qLXa0l9AtDP/naKIkRe47obAM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a535c803-50ff-44d3-ac40-08d6c7f2af5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:50:46.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBkZDRiNDg3YjMyYTM1NzFmZGNjNjYwNjJlNjYxZTNhM2UzNjBl
MzViLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQot
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kgfCA4ICsrKystLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
ZGwuZHRzaQ0KaW5kZXggYjNhNzdiYy4uYTkwZjIxNyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxZGwuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNp
DQpAQCAtMzM5LDcgKzMzOSw3IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtf
RUNTUEkxPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZRRExfQ0xLX0VDU1BJMT47DQogCQkJCQljbG9j
ay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCi0JCQkJCWRtYXMgPSA8JnNkbWEgMyA4IDE+LCA8JnNk
bWEgNCA4IDI+Ow0KKwkJCQkJZG1hcyA9IDwmc2RtYSAzIDcgMT4sIDwmc2RtYSA0IDcgMj47DQog
CQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CiAJCQkJfTsNCkBAIC0zNTMsNyArMzUzLDcgQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2
UURMX0NMS19FQ1NQSTI+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEkyPjsNCiAJ
CQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwmc2RtYSA1IDgg
MT4sIDwmc2RtYSA2IDggMj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDUgNyAxPiwgPCZzZG1hIDYg
NyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KIAkJCQl9Ow0KQEAgLTM2Nyw3ICszNjcsNyBAQA0KIAkJCQkJY2xvY2tzID0gPCZj
bGtzIElNWDZRRExfQ0xLX0VDU1BJMz4sDQogCQkJCQkJIDwmY2xrcyBJTVg2UURMX0NMS19FQ1NQ
STM+Ow0KIAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQotCQkJCQlkbWFzID0gPCZz
ZG1hIDcgOCAxPiwgPCZzZG1hIDggOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8
JnNkbWEgOCA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQpAQCAtMzgxLDcgKzM4MSw3IEBADQogCQkJCQljbG9j
a3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEk0PiwNCiAJCQkJCQkgPCZjbGtzIElNWDZRRExf
Q0xLX0VDU1BJND47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCi0JCQkJCWRt
YXMgPSA8JnNkbWEgOSA4IDE+LCA8JnNkbWEgMTAgOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEg
OSA3IDE+LCA8JnNkbWEgMTAgNyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQog
CQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJCQl9Ow0KLS0gDQoyLjcuNA0KDQo=
