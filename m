Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B60C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483B520656
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDSDqgeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfDYKOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:14:34 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:15186
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfDYKOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsjovnhVLnvkhSbYgFg/TGHW0ptUX3p0PiX7K0JGfMI=;
 b=DDSDqgeM5+3eNZJm3S/v4SOV19W4AVGG86DKE/NPPZgPucwXG/KGe0HUVK7tuGzcICB6PqDKr103j9VUid4uaZ04cEBcOdAxZrK8Ihgws18QM/7B7JZlE6jxKaxlHj8S44u4axgJA3siVLE0i/ZOYNsKV4ul1BPTwF12KMueqQA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5986.eurprd04.prod.outlook.com (20.178.116.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Thu, 25 Apr 2019 10:14:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::94a2:9f9a:41bf:6355]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::94a2:9f9a:41bf:6355%3]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 10:14:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: pll14xx: drop unused variable
Thread-Topic: [PATCH] clk: imx: pll14xx: drop unused variable
Thread-Index: AQHU+0+qGQ/M85MjFkGdnBen7mxehA==
Date:   Thu, 25 Apr 2019 10:14:28 +0000
Message-ID: <20190425102740.19286-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cf42ee5-360a-472e-6064-08d6c966cccc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5986;
x-ms-traffictypediagnostic: AM0PR04MB5986:
x-microsoft-antispam-prvs: <AM0PR04MB5986AAC1901726A617C99253883D0@AM0PR04MB5986.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(6116002)(14454004)(478600001)(386003)(2201001)(2501003)(8676002)(86362001)(102836004)(99286004)(52116002)(305945005)(66066001)(7736002)(4326008)(6506007)(25786009)(3846002)(97736004)(68736007)(6486002)(81156014)(81166006)(2906002)(71190400001)(71200400001)(1076003)(26005)(44832011)(6436002)(2616005)(476003)(53936002)(66476007)(66946007)(66446008)(36756003)(6512007)(73956011)(8936002)(64756008)(54906003)(186003)(50226002)(110136005)(256004)(486006)(5660300002)(316002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5986;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KJaMCWExiEwppx8DmROrOkimOZVZmZE33g0f8MLZQZD5rwSz/1BV7PXD6yDBKzLyaEe6Hhf9rLXjIIiMEZuV3JElFY/FBKqvkxhhM0+a+kYycTYmwRxEn0DOM7Ld7IvjbOs9ea306J9EYPfkcQ/6vRHbWBUPb55RhDchv3eg3mJFg3lIrkf3DJ4f4zclcPl8E/0TrSruQ9CVnCWRnUEGaMlCl+d9z4r9evYIbsv//9j64BCMYcwr/9sbn8NKnQOUVv2P6u3wm9NsojSMZwKs3Px0iKdVlccE4FWJEnJBB1MXueVcs9yXZTbGOWS0zFHpDH/2C6MrSdAEjGvCFuCrGehMFWZh5dZyNBcwjr1rF0LtEqLKBmxEmkSnDT33sIfsTyt4OtvdO/yvecS6OHv47FL4GGG7orgL3xiFkkfGbIw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf42ee5-360a-472e-6064-08d6c966cccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 10:14:28.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXQgZG9lcyBub3QgbWFrZSBzZW5zZSB0byBvbmx5IGdldCB2YWx1ZSBmcm9tIHBsbC0+YmFzZSBh
bmQgYXNzaWduDQp0byBhIGxvY2FsIHZhcmlhYmxlIHdoZW4gcmVjYWxjX3JhdGUuDQoNClNpZ25l
ZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
aW14L2Nsay1wbGwxNHh4LmMgfCA2ICsrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LXBsbDE0eHguYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsMTR4eC5jDQppbmRleCAxYWNmYTNl
M2NmYjQuLjEyZTU4NDE4NWRhZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstcGxs
MTR4eC5jDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbDE0eHguYw0KQEAgLTc0LDEwICs3
NCw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNsa19wbGwxNDE2eF9yZWNhbGNfcmF0ZShzdHJ1
Y3QgY2xrX2h3ICpodywNCiAJCQkJCQkgIHVuc2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpDQogew0K
IAlzdHJ1Y3QgY2xrX3BsbDE0eHggKnBsbCA9IHRvX2Nsa19wbGwxNHh4KGh3KTsNCi0JdTMyIG1k
aXYsIHBkaXYsIHNkaXYsIHBsbF9nbnJsLCBwbGxfZGl2Ow0KKwl1MzIgbWRpdiwgcGRpdiwgc2Rp
diwgcGxsX2RpdjsNCiAJdTY0IGZ2Y28gPSBwYXJlbnRfcmF0ZTsNCiANCi0JcGxsX2ducmwgPSBy
ZWFkbF9yZWxheGVkKHBsbC0+YmFzZSk7DQogCXBsbF9kaXYgPSByZWFkbF9yZWxheGVkKHBsbC0+
YmFzZSArIDQpOw0KIAltZGl2ID0gKHBsbF9kaXYgJiBNRElWX01BU0spID4+IE1ESVZfU0hJRlQ7
DQogCXBkaXYgPSAocGxsX2RpdiAmIFBESVZfTUFTSykgPj4gUERJVl9TSElGVDsNCkBAIC05Mywx
MSArOTIsMTAgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3BsbDE0NDN4X3JlY2FsY19yYXRl
KHN0cnVjdCBjbGtfaHcgKmh3LA0KIAkJCQkJCSAgdW5zaWduZWQgbG9uZyBwYXJlbnRfcmF0ZSkN
CiB7DQogCXN0cnVjdCBjbGtfcGxsMTR4eCAqcGxsID0gdG9fY2xrX3BsbDE0eHgoaHcpOw0KLQl1
MzIgbWRpdiwgcGRpdiwgc2RpdiwgcGxsX2ducmwsIHBsbF9kaXZfY3RsMCwgcGxsX2Rpdl9jdGwx
Ow0KKwl1MzIgbWRpdiwgcGRpdiwgc2RpdiwgcGxsX2Rpdl9jdGwwLCBwbGxfZGl2X2N0bDE7DQog
CXNob3J0IGludCBrZGl2Ow0KIAl1NjQgZnZjbyA9IHBhcmVudF9yYXRlOw0KIA0KLQlwbGxfZ25y
bCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlKTsNCiAJcGxsX2Rpdl9jdGwwID0gcmVhZGxfcmVs
YXhlZChwbGwtPmJhc2UgKyA0KTsNCiAJcGxsX2Rpdl9jdGwxID0gcmVhZGxfcmVsYXhlZChwbGwt
PmJhc2UgKyA4KTsNCiAJbWRpdiA9IChwbGxfZGl2X2N0bDAgJiBNRElWX01BU0spID4+IE1ESVZf
U0hJRlQ7DQotLSANCjIuMTYuNA0KDQo=
