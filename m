Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6CDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48441217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qqD8PE6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfDWNvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:42 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:31118
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfDWNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afq5IVLNDCFuCL2IDppdbya7BAAWAEDF6Cf4vK1zc7E=;
 b=qqD8PE6oCEQRcHPstV2+6Dorly5tIpmXAo5zDLLnu28cGF9orsrgypukRBFubw2NQiEIbVSslsHmvA1rHWiU0fe/uTS6kzOZ+rlJbpHBr5uXCc4bVhy1XGEM3Ze90epLOyj1Cctxwz5oGIjWWhMXUMwT0p6D9LbGVciY8ft+xwo=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:35 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:35 +0000
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
Subject: [PATCH v1 12/15] ARM64: dts: freescale: imx8mm/8mq: update new
 compatible name for ecspi and sdma
Thread-Topic: [PATCH v1 12/15] ARM64: dts: freescale: imx8mm/8mq: update new
 compatible name for ecspi and sdma
Thread-Index: AQHU+duqncs0wCTNlkCJGtSkCy0oSQ==
Date:   Tue, 23 Apr 2019 13:51:35 +0000
Message-ID: <1556027045-5269-13-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: fe89af33-e4f7-45c7-67ce-08d6c7f2cca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB58545FBDA6204A4174CA591E89230@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(2201001)(71200400001)(86362001)(54906003)(110136005)(52116002)(6116002)(3846002)(2906002)(71190400001)(76176011)(14454004)(73956011)(2616005)(5660300002)(446003)(476003)(68736007)(6436002)(97736004)(11346002)(99286004)(478600001)(316002)(486006)(2501003)(66446008)(66476007)(102836004)(66066001)(26005)(6486002)(66556008)(386003)(53936002)(6506007)(50226002)(4326008)(186003)(6512007)(7736002)(81166006)(81156014)(305945005)(8676002)(8936002)(256004)(36756003)(66946007)(7416002)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DlBu8louU6zz6zA+DImNLAM684oyR/qv8FAilHMr6DT3FY3RxhC4o9Rzn8l9UJfRwATo4LH0hcnYw/Rtzdf5xLIMHcJ3D3oCrhuMKUv0fWG8ZWiewkTfZrVsuMpCiKH+PNykYemQcMakQL+Xm0qRd3aLSWSUK2attJcBACGCMx5qzl1wN5XWlkIhVaCb4cSl2a11y8ZIdzavqZZCwwvltCU45UxM0LQqnphklChoMiNnCey4ODVXs2yQicpQ49UGBovYVA5Xq1NQj1gMWU3nJwq8/is9+dChfN7DJEGa1bcIrMMR78nuUu9t4NUqBMPDByRp1ZT21y6IPZQDmwlOJWJla9Hfo8VaOQfnYSHrC0vRb+wlV3DXh7pzOH4hyNyoLFKusjYGW7Ks0Ue85aiUxRnEDRDH3pJHUtJZ3Yxhf74=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe89af33-e4f7-45c7-67ce-08d6c7f2cca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:35.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyAnaW14NnVsLWVjc3BpJyBjb21wYXRpYmxlIG5hbWUgZm9yIGVjc3BpIGFuZCBuZXcg
J2lteDhtcS1zZG1hJyBuYW1lDQpmb3Igc2RtYSBzaW5jZSBvbiBpLm14OG1tL21xIGNoaXAgZml4
IGVjc3BpIGVycmF0YS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kg
fCAxNCArKysrKysrLS0tLS0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cS5kdHNpIHwgIDYgKysrLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0
c2kNCmluZGV4IGRlMzQ5OGMuLjE5NDVhYTMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kNCkBAIC0yNTEsNyArMjUxLDcgQEANCiAJCQl9Ow0KIA0KIAkJCXNk
bWEyOiBkbWEtY29udHJvbGxlckAzMDJjMDAwMCB7DQotCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS1zZG1hIiwgImZzbCxpbXg3ZC1zZG1hIjsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OG1tLXNkbWEiLCAiZnNsLGlteDhtcS1zZG1hIjsNCiAJCQkJcmVnID0gPDB4MzAyYzAwMDAgMHgx
MDAwMD47DQogCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMDMgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0RNQTJfUk9PVD4sDQpAQCAtMjYy
LDcgKzI2Miw3IEBADQogCQkJfTsNCiANCiAJCQlzZG1hMzogZG1hLWNvbnRyb2xsZXJAMzAyYjAw
MDAgew0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tc2RtYSIsICJmc2wsaW14N2Qtc2Rt
YSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1zZG1hIiwgImZzbCxpbXg4bXEtc2Rt
YSI7DQogCQkJCXJlZyA9IDwweDMwMmIwMDAwIDB4MTAwMDA+Ow0KIAkJCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgMzQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElN
WDhNTV9DTEtfU0RNQTNfUk9PVD4sDQpAQCAtMzkzLDcgKzM5Myw3IEBADQogCQkJcmFuZ2VzOw0K
IA0KIAkJCWVjc3BpMTogc3BpQDMwODIwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OG1tLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3BpIjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQogCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KIAkJCQlyZWcgPSA8MHgzMDgyMDAwMCAweDEw
MDAwPjsNCkBAIC00MDcsNyArNDA3LDcgQEANCiAJCQl9Ow0KIA0KIAkJCWVjc3BpMjogc3BpQDMw
ODMwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLWVjc3BpIiwgImZzbCxpbXg1
MS1lY3NwaSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1lY3NwaSIsICJmc2wsaW14
NnVsLWVjc3BpIjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJCSNzaXplLWNlbGxz
ID0gPDA+Ow0KIAkJCQlyZWcgPSA8MHgzMDgzMDAwMCAweDEwMDAwPjsNCkBAIC00MjEsNyArNDIx
LDcgQEANCiAJCQl9Ow0KIA0KIAkJCWVjc3BpMzogc3BpQDMwODQwMDAwIHsNCi0JCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14OG1tLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7DQorCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhtbS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3BpIjsNCiAJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KIAkJCQlyZWcgPSA8
MHgzMDg0MDAwMCAweDEwMDAwPjsNCkBAIC01NjcsMTEgKzU2NywxMSBAQA0KIAkJCX07DQogDQog
CQkJc2RtYTE6IGRtYS1jb250cm9sbGVyQDMwYmQwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJm
c2wsaW14OG1tLXNkbWEiLCAiZnNsLGlteDdkLXNkbWEiOw0KKwkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg4bW0tc2RtYSIsICJmc2wsaW14OG1xLXNkbWEiOw0KIAkJCQlyZWcgPSA8MHgzMGJkMDAw
MCAweDEwMDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0RNQTFfUk9PVD4sDQotCQkJ
CQkgPCZjbGsgSU1YOE1NX0NMS19TRE1BMV9ST09UPjsNCisJCQkJCSA8JmNsayBJTVg4TU1fQ0xL
X0FIQj47DQogCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJhaGIiOw0KIAkJCQkjZG1hLWNlbGxz
ID0gPDM+Ow0KIAkJCQlmc2wsc2RtYS1yYW0tc2NyaXB0LW5hbWUgPSAiaW14L3NkbWEvc2RtYS1p
bXg3ZC5iaW4iOw0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCmlu
ZGV4IDdjMGIxMmEuLmYyYTVkMTIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kNCkBAIC02MDcsNyArNjA3LDcgQEANCiAJCQllY3NwaTE6IHNwaUAzMDgyMDAw
MCB7DQogCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KIAkJCQkjc2l6ZS1jZWxscyA9IDwwPjsN
Ci0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7
DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3Bp
IjsNCiAJCQkJcmVnID0gPDB4MzA4MjAwMDAgMHgxMDAwMD47DQogCQkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAzMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJY2xvY2tzID0gPCZjbGsgSU1Y
OE1RX0NMS19FQ1NQSTFfUk9PVD4sDQpAQCAtNjE5LDcgKzYxOSw3IEBADQogCQkJZWNzcGkyOiBz
cGlAMzA4MzAwMDAgew0KIAkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAJCQkJI3NpemUtY2Vs
bHMgPSA8MD47DQotCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1lY3NwaSIsICJmc2wsaW14
NTEtZWNzcGkiOw0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZWNzcGkiLCAiZnNsLGlt
eDZ1bC1lY3NwaSI7DQogCQkJCXJlZyA9IDwweDMwODMwMDAwIDB4MTAwMDA+Ow0KIAkJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMzIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9
IDwmY2xrIElNWDhNUV9DTEtfRUNTUEkyX1JPT1Q+LA0KQEAgLTYzMSw3ICs2MzEsNyBAQA0KIAkJ
CWVjc3BpMzogc3BpQDMwODQwMDAwIHsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJ
CSNzaXplLWNlbGxzID0gPDA+Ow0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZWNzcGki
LCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWVjc3Bp
IiwgImZzbCxpbXg2dWwtZWNzcGkiOw0KIAkJCQlyZWcgPSA8MHgzMDg0MDAwMCAweDEwMDAwPjsN
CiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMzIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KIAkJ
CQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX0VDU1BJM19ST09UPiwNCi0tIA0KMi43LjQNCg0K
