Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0F0C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o2anj2eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFEHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:00:38 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:4038
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfFEHAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HccSg1pjcRa0jcE1T/DJWoI8g/5bbQ14TUp6NTIiDrI=;
 b=o2anj2eb/cJD5rrk5FfRNzwe1Jo3iqge/vl69qkiYaLn/6QscB31EIkuBNUpbe3uHnzVDFyV+oWHm0GNmKBiBS/bNP8U7JOTSFvWjPG1UUgyrmpEyhZB5woMcqtMgMp9A8tpDS7q2vi2OOrAmNFjLVtNzpIdo0mByumU9BqagDk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4321.eurprd04.prod.outlook.com (52.134.126.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 07:00:34 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1943.023; Wed, 5 Jun 2019
 07:00:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pramod Kumar <pramod.kumar_1@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH v3 1/3] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH v3 1/3] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Thread-Index: AQHVFIg0QNRaL3LFI0OeuwRCFx28W6aMqHwAgAAF/gA=
Date:   Wed, 5 Jun 2019 07:00:33 +0000
Message-ID: <AM0PR04MB42115435AD01AD6481C9D0B980160@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190527123404.30858-1-pramod.kumar_1@nxp.com>
 <20190527123404.30858-2-pramod.kumar_1@nxp.com>
 <20190605063449.GG29853@dragon>
In-Reply-To: <20190605063449.GG29853@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b980fd1-edd5-4c32-f807-08d6e983815b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4321;
x-ms-traffictypediagnostic: AM0PR04MB4321:
x-microsoft-antispam-prvs: <AM0PR04MB4321EE0F54A312D44C0ADD4480160@AM0PR04MB4321.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(86362001)(6636002)(26005)(74316002)(5660300002)(6506007)(53546011)(71200400001)(102836004)(71190400001)(73956011)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(53936002)(305945005)(7736002)(6436002)(99286004)(486006)(9686003)(52536014)(476003)(478600001)(7696005)(446003)(256004)(44832011)(76176011)(11346002)(55016002)(186003)(68736007)(14454004)(4326008)(3846002)(6116002)(110136005)(54906003)(66066001)(229853002)(6246003)(8676002)(81166006)(81156014)(8936002)(25786009)(33656002)(316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4321;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S+B07aN9+xI+il/Rey/bivbsRBkyjdigNbMv2KWfwv/IQ9q2MwU73DuhQc+VLXqqJYdnHjbP8XJTExR8CSQQ43lCJ5GwGwV/1LG5qKEK3oGyjxdCVRk4BciDaPexxg20y6aFz3JS67SZNdlqNrJB5LnyK27tU0SRMhWiSDGl/q8nPpgUsEcE/2i926VOiwc4z+DcVt0gSia4bWQxuBSZ9e7Wt7LTZ6eC2//jjqS0aciBaGBPr0TTU5oyF4luaogBU/y4WXDfeodRZEgk5j7ELcOvsAJTU70FSXpHXz49P0IElugFOit/i1cIJzJQDYgkccnI9rig+2Ev9gRn7Zwlug5EOTaJgRdg4n5RITQHWB0hIws4wD6SE0Oi3atyTE75q8qvIaSCkDyBbW03glqgl9OpoAHYWtqAJJJtCSWFYJg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b980fd1-edd5-4c32-f807-08d6e983815b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 07:00:33.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhbW9kLA0KDQo+IEZyb206IFNoYXduIEd1byBbbWFpbHRvOnNoYXduZ3VvQGtlcm5lbC5v
cmddDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA1LCAyMDE5IDI6MzUgUE0NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBhcm06IG54cDogQWRkIGRldmljZSB0cmVl
IGJpbmRpbmcgZm9yDQo+IGxzMTA0NmEtZnJ3eSBib2FyZA0KPiANCj4gT24gTW9uLCBNYXkgMjcs
IDIwMTkgYXQgMTI6MzI6MDlQTSArMDAwMCwgUHJhbW9kIEt1bWFyIHdyb3RlOg0KPiA+IEFkZCAi
ZnNsLGxzMTA0NmEtZnJ3eSIgYmluZGluZ3MgZm9yIGxzMTA0NmFmcnd5IGJvYXJkIGJhc2VkIG9u
IGxzMTA0NmEgU29DDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJo
YXYuc2hhcm1hQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFt
b2Qua3VtYXJfMUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiANCj4gSSBjYW5ub3QgYXBwbHkgcGF0Y2ggZnJvbSBtZXNzYWdlIHVzaW5n
ICdDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiBiYXNlNjQnLg0KPiANCg0KV2hpY2ggc2VydmVy
IGFyZSB5b3UgdXNpbmc/IElzIGl0IGluIHRoZSB3aGl0ZWxpc3QgZm9yIHVzaW5nIHRoZSBzcGVj
aWZpYyBTTVRQPw0KSSByZW1lbWJlciBETiBzZXJ2ZXIgZG9lcyBub3QgaGF2ZSB0aGlzIGlzc3Vl
LiBNYXliZSB1c2luZyB0aGUgd3Jvbmcgb25lPw0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0K
PiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55
YW1sIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlh
bWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+
ID4gaW5kZXggNDA3MTM4ZWJjMGQwLi4wOWZmMTk5OWNlOTYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiBAQCAtMjQx
LDYgKzI0MSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIGVudW06DQo+ID4gICAg
ICAgICAgICAgICAgLSBmc2wsbHMxMDQ2YS1xZHMNCj4gPiAgICAgICAgICAgICAgICAtIGZzbCxs
czEwNDZhLXJkYg0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGxzMTA0NmEtZnJ3eQ0KPiANCj4g
SXQgbWlnaHQgYmUgYmV0dGVyIHRvIGtlZXAgdGhlIGxpc3QgYWxwaGFiZXRpY2FsbHkgc29ydGVk
Lg0KPiANCj4gU2hhd24NCj4gDQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBmc2wsbHMxMDQ2YQ0K
PiA+DQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IExTMTA4OEEgYmFzZWQgQm9hcmRzDQo+ID4g
LS0NCj4gPiAyLjE3LjENCj4gPg0K
