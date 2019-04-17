Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08DC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195B121773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SJPDQbM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfDQDcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:32:01 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:9668
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbfDQDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZVyEs3kKclVL75X4mVA8Jbw6qvnT381/7Q8bTp9QiA=;
 b=SJPDQbM1+2qsFtm5mt15weNfuPSg6xzIOE/Dgk0JgLrlqzDL3ync46daBPKZfKVWTmPC6/kCNvpsYhCJ7iGIqDmeXaFp6jBZaxUlLDNPx+SJpxO2Q+9n5CKdxEATKNOROTRoXjcren5a77mXVWLFKpBDJB0QZVUNPMKz/GZd1LI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6465.eurprd04.prod.outlook.com (20.179.253.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 03:31:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 03:31:56 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHU9AOTUGgOS08iR0aOB0ANqNq0mqY/s5cw
Date:   Wed, 17 Apr 2019 03:31:55 +0000
Message-ID: <AM0PR04MB42118E59E441BE043A3BE54F80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a41f927-9e57-412f-7ce3-08d6c2e53deb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6465;
x-ms-traffictypediagnostic: AM0PR04MB6465:
x-microsoft-antispam-prvs: <AM0PR04MB646526034F033ECD8FECCB3F80250@AM0PR04MB6465.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(66066001)(74316002)(86362001)(186003)(99286004)(2501003)(6506007)(76176011)(6246003)(44832011)(6116002)(3846002)(2201001)(97736004)(4326008)(26005)(55016002)(9686003)(102836004)(53936002)(316002)(110136005)(2906002)(25786009)(476003)(478600001)(105586002)(81156014)(6436002)(486006)(106356001)(229853002)(33656002)(256004)(81166006)(7416002)(8936002)(446003)(305945005)(11346002)(52536014)(7736002)(7696005)(5660300002)(68736007)(71190400001)(71200400001)(14454004)(8676002)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6465;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XUxqdTzg6azgAN6tnFkeTsVLLTQKiFk3mNLKIn/G3lWOkYiynoNcreDNBj5nBACh+FJQlSGPhrWKzoXcggKfprJe6v8C5O0lUSpRMW4qql7I5XIEnCQvsOFcYOn6YQVzldX6ln5ZFRH+NM3ha2kILraasjc3BONF+TEtP9FuZ7+/+9Hlal3lhwRl8l7pPiJz8CHeVZnEvuh1wVqQ/ypXavnTBaX9OmE2oBKaTreEwdv7QRWu9iec/4UrCagHuoCCMt0AA2NRtbTEZ0UBT0dEuypsK7Lw/X7CCZu0/pjyagep7gOF7vc8WhBxfNmmyVTSmhPrNUYcE9LO0+XDm86VGpgHnBp1LpnWCvxbhxNrgtzuZmUUEjNkXLzgs5iUzRKOeK5/p8r7sxmCEq+E3ykS+7HdfCChuyYBNaZEuKeBNO4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41f927-9e57-412f-7ce3-08d6c2e53deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 03:31:55.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxNiwgMjAxOSAxMToy
MiBBTQ0KPiANCj4gTlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00
IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiBjb250cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xs
ZXIgaXMgaW4gY2hhcmdlIG9mIHN5c3RlbSBwb3dlciwgY2xvY2sgYW5kDQo+IHRoZXJtYWwgc2Vu
c29ycyBldGMuIG1hbmFnZW1lbnQsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNhdGUgd2l0
aA0KPiBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCB0
ZW1wZXJhdHVyZSBmcm9tIHRoZXJtYWwNCj4gc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzIGJpbmRp
bmcgZG9jIGZvciBpLk1YIHN5c3RlbSBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0K
PiBObyBjaGFuZ2VzLg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVl
c2NhbGUvZnNsLHNjdS50eHQgICAgICAgIHwgMTYNCj4gKysrKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3Uu
dHh0DQo+IGluZGV4IDVkN2RiYWIuLmY0ZmI2ZDUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3Uu
dHh0DQo+IEBAIC0xMzMsNiArMTMzLDE3IEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVz
c2FnZSBQcm90b2NvbA0KPiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgLSBjb21wYXRpYmxlOiBz
aG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+IA0KPiArVGhlcm1hbCBiaW5kaW5ncyBi
YXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK1JlcXVpcmVkIHBy
b3BlcnRpZXM6DQo+ICstIGNvbXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCj4gKwkJCQkgICJmc2ws
aW14OHF4cC1zYy10aGVybWFsIg0KPiArCQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJt
YWwiOw0KPiArDQo+ICstICN0aGVybWFsLXNlbnNvci1jZWxsczoJU2VlDQo+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwudHh0DQo+ICsJCQkJZm9yIGEg
ZGVzY3JpcHRpb24uDQoNCkJldHRlciB0byBoYXZlIGFuIGV4cGxpY2l0IHZhbHVlIGhlcmUuDQpl
LmcuDQpNdXN0IGJlIDEuIFNlZSB4eHggZm9yIGEgZGVzY3JpcHRpb24uDQoNCk90aGVyd2lzZToN
ClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdh
cmRzDQpEb25nIEFpc2hlbmcNCg==
