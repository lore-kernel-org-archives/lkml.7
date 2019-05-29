Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A797C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560282081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="coO59u9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE2LtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:49:14 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:8933
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfE2LtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIiSuFGTVl9m/ZTNoQ/FCHYPKxVgP6vxQTjp2VbdnMU=;
 b=coO59u9dqTCJrfNqWgP4RLmuZEGK0SL58ZBtzn4ByJBkZ4Jveoq7koB4FHKOXkt6S6xwTyjlzUjafw7kW4TPCOeSLFmD/PRgn/0oye18MxIixaUVslBGM34M0op+/L5JF5AVjOBU48tcQPR/3/qhYXoS1FIgEJhg1pglRG0IXXI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4065.eurprd04.prod.outlook.com (52.134.90.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 11:48:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 11:48:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Topic: [RFC 1/2] dt-bindings: imx-ocotp: Add fusable-node property
Thread-Index: AQHVDrkIcB6j+hDf/kC51b4HJvSviKaCCwCg
Date:   Wed, 29 May 2019 11:48:29 +0000
Message-ID: <AM0PR04MB44810069F874677C6A2DE795881F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190520032020.7920-1-peng.fan@nxp.com>
In-Reply-To: <20190520032020.7920-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [180.110.22.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e8061f8-c6bb-4868-b89c-08d6e42b91e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4065;
x-ms-traffictypediagnostic: AM0PR04MB4065:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB4065767687E27F78D7B9D080881F0@AM0PR04MB4065.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(4326008)(2201001)(110136005)(54906003)(68736007)(102836004)(76116006)(7416002)(8936002)(71200400001)(256004)(44832011)(6436002)(33656002)(73956011)(66066001)(305945005)(26005)(14444005)(71190400001)(25786009)(53936002)(2501003)(7736002)(52536014)(9686003)(55016002)(186003)(6306002)(14454004)(99286004)(86362001)(6506007)(81166006)(2906002)(81156014)(5660300002)(11346002)(7696005)(76176011)(3846002)(316002)(478600001)(6116002)(229853002)(966005)(64756008)(66556008)(74316002)(8676002)(476003)(446003)(66476007)(66446008)(486006)(6246003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4065;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yxkVRGT4pg0n6za3JUiANNNdkcEtPnVhRutj6kBt/l+JExpKOfmt7P+jyeAi2HTxL82A8FEY9zabUR6uvqatee26d+NOMW48EajsCqBewzNketENMIF6nVLu1yI2Mr5obew/c8MIPyqDtPv8nZDYugNGsyGyc2/enR8COl8qmdvjsoG2JB6ESDi7J8fpUxsx+h1+LTIUJIT4F1/0exD+I/Xu+UKtuq9G04Z+Ui0nq8hD1c7CkXH449JsvR/6DAamO9DSu7Aw8NeutEPRFSGLPTB8h7JzAsOraEn/zS/kJWeNIAdLMOJrdsZpfexcmvfXsWQBFg+cG/1a7a/FPlvNgjDXj7ayQapTiw/uD556R3Cg266YgxEmMSGD/jzb7udggogoh9jxJ5jSUJBTlI6UX3Y46Cpq8kjLK36wDJ6uV7M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8061f8-c6bb-4868-b89c-08d6e42b91e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 11:48:30.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBTcmluaXZhcw0KDQo+IFN1YmplY3Q6IFtSRkMgMS8yXSBkdC1iaW5kaW5nczogaW14
LW9jb3RwOiBBZGQgZnVzYWJsZS1ub2RlIHByb3BlcnR5DQoNCkRvIHlvdSBoYXZlIGFueSBjb21t
ZW50cyBhYm91dCB0aGlzIHBhdGNoPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBJbnRyb2R1
Y2UgZnVzYWJsZS1ub2RlIHByb3BlcnR5IGZvciBpLk1YIE9DT1RQIGRyaXZlci4NCj4gVGhlIHBy
b3BlcnR5IHdpbGwgb25seSBiZSB1c2VkIGJ5IEZpcm13YXJlKGVnLiBVLUJvb3QpIHRvIHJ1bnRp
bWUgZGlzYWJsZSB0aGUNCj4gbm9kZXMuDQo+IA0KPiBUYWtlIGkuTVg2VUxMIGZvciBleGFtcGxl
LCB0aGVyZSBhcmUgc2V2ZXJhbCBwYXJ0cyB0aGF0IG9ubHkgaGF2ZSBsaW1pdGVkDQo+IG1vZHVs
ZXMgZW5hYmxlZCBjb250cm9sbGVkIGJ5IE9DT1RQIGZ1c2UuIEl0IGlzIG5vdCBmbGV4aWJsZSB0
byBwcm92aWRlIHNldmVyYWwNCj4gZHRzIGZvciB0aGUgc2VydmFsIHBhcnRzLCBpbnN0ZWFkIHdl
IGNvdWxkIHByb3ZpZGUgb25lIGRldmljZSB0cmVlIGFuZCBsZXQNCj4gRmlybXdhcmUgdG8gcnVu
dGltZSBkaXNhYmxlIHRoZSBkZXZpY2UgdHJlZSBub2RlcyBmb3IgdGhvc2UgbW9kdWxlcyB0aGF0
IGFyZQ0KPiBkaXNhYmxlKGZ1c2VkKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gDQo+IEN1cnJlbnRseSBOWFAgdmVuZG9yIHVzZSBV
LUJvb3QgdG8gc2V0IHN0YXR1cyB0byBkaXNhYmxlZCBmb3IgZGV2aWNlcyB0aGF0DQo+IGNvdWxk
IG5vdCBmdW5jdGlvbiwNCj4gaHR0cHM6Ly9zb3VyY2UuY29kZWF1cm9yYS5vcmcvZXh0ZXJuYWwv
aW14L3Vib290LWlteC90cmVlL2FyY2gvYXJtL21hY2gNCj4gLWlteC9teDYvbW9kdWxlX2Z1c2Uu
Yz9oPWlteF92MjAxOC4wM180LjE0Ljk4XzIuMC4wX2dhI24xNDkNCj4gQnV0IHRoaXMgYXBwcm9h
Y2ggaXMgd2lsbCBub3Qgd29yayBpZiBrZXJuZWwgZHRzIG5vZGUgcGF0aCBjaGFuZ2VkLg0KPiAN
Cj4gVGhlcmUgYXJlIHR3byBhcHByb2FjaGVzIHRvIHJlc29sdmU6DQo+IA0KPiAxLiBUaGlzIHBh
dGNoIGlzIHRvIGFkZCBhIGZ1c2FibGUtbm9kZSBwcm9wZXJ0eSwgYW5kIEZpcm13YXJlIHdpbGwg
cGFyc2UNCj4gICAgdGhlIHByb3BlcnR5IGFuZCByZWFkIGZ1c2UgdG8gZGVjaWRlIHdoZXRoZXIg
dG8gZGlzYWJsZSBvciBrZWVlcCBlbmFibGUNCj4gICAgdGhlIG5vZGVzLg0KPiANCj4gMi4gVGhl
cmUgaXMgYW5vdGhlciBhcHByb2FjaCBpcyB0aGF0IGFkZCBudm1lbS1jZWxscyBmb3IgYWxsIG5v
ZGVzIHRoYXQNCj4gICAgY291bGQgYmUgZGlzYWJsZWQoZnVzZWQpLiBUaGVuIGluIGVhY2ggbGlu
dXggZHJpdmVyIHRvIHVzZSBudm1lbQ0KPiAgICBhcGkgdG8gZGV0ZWN0IGZ1c2VkIG9yIG5vdCwg
b3IgaW4gbGludXggZHJpdmVyIGNvbW1vbiBjb2RlIHRvIGNoZWNrDQo+ICAgIGRldmljZSBmdW5j
dGlvbmFibGUgb3Igbm90IHdpdGggbnZtZW0gQVBJLg0KPiANCj4gDQo+IFRvIG1ha2UgaXQgZWFz
eSB0byB3b3JrLCB3ZSBjaG9vc2UgWzFdIGhlcmUuIFBsZWFzZSBhZHZpc2Ugd2hldGhlciBpdCBp
cw0KPiBhY2NlcHRhYmxlLCBiZWNhdXNlIHRoZSBwcm9wZXJ0eSBpcyBub3QgdXNlZCBieSBsaW51
eCBkcml2ZXIgaW4gYXBwcm9hY2ggWzFdLg0KPiBPciB5b3UgcHJlZmVyIFsyXSBvciBwbGVhc2Ug
YWR2aXNlIGlmIGFueSBiZXR0ZXIgc29sdXRpb24uDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQgfCA1ICsr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQN
Cj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vaW14LW9jb3RwLnR4
dA0KPiBpbmRleCA3YTk5OWExMzVlNTYuLmU5YTk5ODU4OGRiZCAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQN
Cj4gQEAgLTIxLDYgKzIxLDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gDQo+ICBPcHRpb25h
bCBwcm9wZXJ0aWVzOg0KPiAgLSByZWFkLW9ubHk6IGRpc2FibGUgd3JpdGUgYWNjZXNzDQo+ICst
IGZ1c2FibGUtbm9kZTogYXJyYXkgb2YgcGhhbmRsZXMgd2l0aCByZWcgYmFzZSBhbmQgYml0IG9m
ZnNldCwgdGhpcw0KPiArCQlwcm9wZXJ0eSBpcyB1c2VkIGJ5IEZpcm13YXJlIHRvIHJ1bnRpbWUg
ZGlzYWJsZSBub2Rlcy4NCj4gDQo+ICBPcHRpb25hbCBDaGlsZCBub2RlczoNCj4gDQo+IEBAIC00
Miw0ICs0NCw3IEBAIEV4YW1wbGU6DQo+ICAJCXRlbXBtb25fdGVtcF9ncmFkZTogdGVtcC1ncmFk
ZUAyMCB7DQo+ICAJCQlyZWcgPSA8MHgyMCA0PjsNCj4gIAkJfTsNCj4gKw0KPiArCQlmdXNhYmxl
LW5vZGUgPSA8JnVzZGhjMSAweDEwIDQNCj4gKwkJCQkmdXNkaGMyIDB4MTAgNT47DQo+ICAJfTsN
Cj4gLS0NCj4gMi4xNi40DQoNCg==
