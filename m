Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BFC282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC7213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R1h9/mKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfDVEyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:54:31 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:13070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfDVEy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FngXZWLrO9Q88lRLV8iHR4ZgDn1yWcKHPjTdmN41maQ=;
 b=R1h9/mKadd5ilVdA2M/RIp8hEJ9cr8CTK/6C6XkdurasghtbBrca7iJXdJ00KU2ctwa3HifkoEhJ2x2W+3omifMQolRTPDlidCb1JAHMbvE9SGWBU8AAd982EvryLi3yZ2l4oTU8cmT2Yo8Z3nd2hD6qL8R3Yn+Mmf8gG4gLm7E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Mon, 22 Apr 2019 04:54:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:54:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] arm64: defconfig: Add i.MX8 SoC driver
Thread-Topic: [PATCH 2/2] arm64: defconfig: Add i.MX8 SoC driver
Thread-Index: AQHU+Md0bu2fMm7Fw0y7JxGuy6xPBg==
Date:   Mon, 22 Apr 2019 04:54:23 +0000
Message-ID: <1555908516-13354-2-git-send-email-Anson.Huang@nxp.com>
References: <1555908516-13354-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555908516-13354-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac018fb8-fb7a-4ea7-359c-08d6c6de9636
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850402F4F674434BC0F2D56F5220@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(199004)(189003)(186003)(8936002)(66446008)(66556008)(66476007)(66946007)(64756008)(476003)(50226002)(2906002)(73956011)(52116002)(6506007)(386003)(26005)(76176011)(81166006)(486006)(81156014)(102836004)(99286004)(4744005)(97736004)(2616005)(11346002)(446003)(5660300002)(8676002)(68736007)(256004)(6486002)(4326008)(2501003)(66066001)(25786009)(71200400001)(14454004)(6512007)(110136005)(86362001)(71190400001)(316002)(2201001)(305945005)(7736002)(7416002)(36756003)(3846002)(478600001)(6116002)(53936002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W7KQeKQAgTXikv8RUlij7yHn5tk+/O25y2g2y6VCVFXMTm28IHHm2+iyN2UJb0XKm7K6JQqMPc4CKnsIRpeW3mx9QAuVS4jA/lss0UHAK06C1tLDcVbMvnfXCqhS9PB4Q5+jVUOje0APFfvpZ0GRxhcqQ0Q3Rk01lT7V2rnpHMneqb3plfNnoFqBIkDVYVRLx4WEin46aonoqh4TyIitZVXP/S99rK2TNQqwqXzgkiww+QKw67NYHZ7buKkItCffONGSy4yxULSzmCKO+Jz19j0DzdUhVbv1LbHvOkyA6jbyikLh2FtvOjEI9c6CAdD2osGVH3dh7qOCRrsg0aA47Z2fpzYvWRJSGUN+GGjJ5hxnfUjLM+BKjdbO6tlTVi31aRJ4YR4PBcZZLcSRgesAem3PUsmXEGtvvcju4KIJdWo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac018fb8-fb7a-4ea7-359c-08d6c6de9636
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:54:23.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZWxlY3RzIENPTkZJR19JTVg4X1NPQyBieSBkZWZhdWx0IHRvIHN1cHBvcnQN
CmkuTVg4IFNvQyBkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDEgKw0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4
IDJkOWMzOTAuLmM4YWI2MmUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29u
ZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQpAQCAtNjc3LDYgKzY3Nyw3
IEBAIENPTkZJR19SUE1TR19RQ09NX0dMSU5LX1NNRU09bQ0KIENPTkZJR19SUE1TR19RQ09NX1NN
RD15DQogQ09ORklHX1JBU1BCRVJSWVBJX1BPV0VSPXkNCiBDT05GSUdfSU1YX0dQQ1YyX1BNX0RP
TUFJTlM9eQ0KK0NPTkZJR19JTVg4X1NPQz15DQogQ09ORklHX1FDT01fQ09NTUFORF9EQj15DQog
Q09ORklHX1FDT01fR0VOSV9TRT15DQogQ09ORklHX1FDT01fR0xJTktfU1NSPW0NCi0tIA0KMi43
LjQNCg0K
