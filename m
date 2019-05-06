Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3205C004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EC5205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ibqcNQNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfEFD0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 23:26:54 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:6081
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfEFD0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 23:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxvQGQbH2tLbVgKYQP3jL/FBS7qQD22SU+HfqpMWV74=;
 b=ibqcNQNyC5leozw1lkqDDMl/xxCktXxqinK54W8MLEX4VqkPaaiDKIOB2qF3R/usN5RosD/eQ5LkFeU22xOdF5oLJ+GLtwEfuA5qIGvnOzXfcODRzi2qkLLBNTZbH/gvKbzGSjZ+t3xM+5WV8WDhofmP7DssyU0OpoyAgDZNCyQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 03:26:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 03:26:49 +0000
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
Subject: [PATCH 1/2] ARM: dts: imx6sl: Assign corresponding clocks instead of
 dummy clock
Thread-Topic: [PATCH 1/2] ARM: dts: imx6sl: Assign corresponding clocks
 instead of dummy clock
Thread-Index: AQHVA7uKX2mzfOc840Ke1bKA2KP6TQ==
Date:   Mon, 6 May 2019 03:26:48 +0000
Message-ID: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2cadbc5-e755-4308-63b9-08d6d1d2ac65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB375645686B1BE5663A860FBDF5300@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(6436002)(14444005)(110136005)(6486002)(316002)(71190400001)(71200400001)(256004)(8676002)(81156014)(81166006)(8936002)(50226002)(66946007)(7736002)(2501003)(4326008)(52116002)(66556008)(64756008)(86362001)(66476007)(2201001)(66446008)(2906002)(99286004)(6116002)(3846002)(305945005)(478600001)(68736007)(6512007)(14454004)(53936002)(2616005)(36756003)(5660300002)(73956011)(66066001)(102836004)(186003)(26005)(386003)(6506007)(25786009)(486006)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pvii0iXonzZ9x6rKMHbqLnTNOV13UhBo4ytvuF7c6NZXR5mmF02AWNawuEl0FNK2r/cUzeej7QY5PzRJ5En2PNPyQMlAj9Y8rjNLOMaQzBhS7YdFMdMXrRdvjos/iBSbsyvJ7Y0KiY612bgLVQXr3DvhGgW54P7/kXupTAnwq37KTy0podgSn947vf6LChsKr0Y/JhVvHeeR0DEgGEoCOhXIDjzn9Btmiz9s906FYz5qKpKtEKWbLcw5bvawiB9FSjNl1H/6Ole5DVd7knvc0CJoHHRUGY4QRdFa7LWOutSoN9nwFPvSVmAw1ALy4VyOM7ugEofjdNhLvIqvwfUa6SjKynbdZQJzKesHp5MfG0zSNjloY+9EV4ciUMow5Mw1FIVdQBvrv+L0jAVx+cdUzJ7y9UC8Bv794xc27MjNsuk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cadbc5-e755-4308-63b9-08d6d1d2ac65
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 03:26:49.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDZTTCdzIEtQUCBhbmQgV0RPRyB1c2UgSU1YNlNMX0NMS19JUEcgYXMgY2xvY2sgcm9vdCwN
CmFzc2lnbiBJTVg2U0xfQ0xLX0lQRyB0byB0aGVtIGluc3RlYWQgb2YgSU1YNlNMX0NMS19EVU1N
WS4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQot
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaSB8IDYgKysrLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZzbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0
c2kNCmluZGV4IDlkZGJlZWEuLjkzOTNmMDMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0
cy9pbXg2c2wuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kNCkBAIC00
OTUsNyArNDk1LDcgQEANCiAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnNsLWtwcCIsICJmc2ws
aW14MjEta3BwIjsNCiAJCQkJcmVnID0gPDB4MDIwYjgwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJy
dXB0cyA9IDwwIDgyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KLQkJCQljbG9ja3MgPSA8JmNsa3Mg
SU1YNlNMX0NMS19EVU1NWT47DQorCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U0xfQ0xLX0lQRz47
DQogCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJfTsNCiANCkBAIC01MDMsMTQgKzUwMywx
NCBAQA0KIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2c2wtd2R0IiwgImZzbCxpbXgyMS13ZHQi
Ow0KIAkJCQlyZWcgPSA8MHgwMjBiYzAwMCAweDQwMDA+Ow0KIAkJCQlpbnRlcnJ1cHRzID0gPDAg
ODAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQotCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U0xfQ0xL
X0RVTU1ZPjsNCisJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZTTF9DTEtfSVBHPjsNCiAJCQl9Ow0K
IA0KIAkJCXdkb2cyOiB3ZG9nQDIwYzAwMDAgew0KIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2
c2wtd2R0IiwgImZzbCxpbXgyMS13ZHQiOw0KIAkJCQlyZWcgPSA8MHgwMjBjMDAwMCAweDQwMDA+
Ow0KIAkJCQlpbnRlcnJ1cHRzID0gPDAgODEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQotCQkJCWNs
b2NrcyA9IDwmY2xrcyBJTVg2U0xfQ0xLX0RVTU1ZPjsNCisJCQkJY2xvY2tzID0gPCZjbGtzIElN
WDZTTF9DTEtfSVBHPjsNCiAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQl9Ow0KIA0KLS0g
DQoyLjcuNA0KDQo=
