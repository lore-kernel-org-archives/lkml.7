Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3EDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A3E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vrpvgnkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfF1GQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:16:05 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:55461
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfF1GQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BV46yX/0oYx/ElfV9CKy95sbRnD1yIUVbioe7zWDhk=;
 b=VrpvgnktL4k5VQxtdztodoTMHA7ZHYu0Ts5xl/cbx4dt7sHN04CegvWMbp4BOa4A16OL6PFCB57i0asRdpwbPdypOm2fp8gXGISMK2ZAZ0jSittckl65bOpvibZPG43evLDfkY1zBuxnvgOa8+yZS8txIigOpetmNqFyxlkbpl4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 06:16:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 06:16:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLGC+RlanjcBUWXXhB78aHmNqawlITg
Date:   Fri, 28 Jun 2019 06:16:00 +0000
Message-ID: <DB3PR0402MB39161C60DC780B693933F9EAF5FC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
 <VI1PR04MB50553915C0D978A8019BDC5CEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB50553915C0D978A8019BDC5CEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0d5d6b8-74ff-4637-bccc-08d6fb90172b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-microsoft-antispam-prvs: <DB3PR0402MB3865EA2B1D0EE068FD8DE3DFF5FC0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(13464003)(478600001)(186003)(102836004)(316002)(26005)(110136005)(6246003)(54906003)(229853002)(11346002)(476003)(99286004)(8676002)(4326008)(8936002)(53936002)(81156014)(9686003)(55016002)(7696005)(44832011)(81166006)(6436002)(446003)(14444005)(6506007)(53546011)(256004)(76176011)(33656002)(68736007)(2501003)(74316002)(66066001)(305945005)(71190400001)(486006)(3846002)(6116002)(7736002)(14454004)(25786009)(52536014)(66446008)(76116006)(71200400001)(66476007)(66556008)(64756008)(66946007)(73956011)(5660300002)(7416002)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U2kfR7jcPLVwDqhJCVNT/HyW53ab6R27wCqFPaCdoac5s5Ezu3FJjKm9SqwJyCGlsHlp8dKgKcAvFK/Yu3jyxAGrdxb5+bru/wf0gLa18GZlc4ei7++84JCKAT6g6e67kOnPOeLpvdCIkEGXhK34US9fXXp5iAZzmvzhlXQU2DRf+eN+4z0VCmKGakubYs3eg++FFXPhoFMvwFBXjEceHAaCUfz4MLQU3TIt2XKC9Z20YOEUdOJRlgoQ3PXe0fYTN4Zk8MDUcyq6gVHJZlVo/TC9RxFujrz09MWNkIkbAD9OYqM8qMNu1MvPwpW8e4lD/1roP5wcp5RVjotDkk8dxWvfYPSFSMdSv+Kvi54xJGEDMk9xF1E+ebzlqd70WTz6jSQYzJ/vvgs/aIcp6bLdWPW9k8RfWKuX+my+PkqiGVY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d5d6b8-74ff-4637-bccc-08d6fb90172b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:16:00.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogRnJpZGF5LCBKdW5lIDI4LCAyMDE5IDE6NTkgUE0NCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsg
SmFja3kNCj4gQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0K
PiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFs
dXRhQG54cC5jb20+OyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsNCj4gYW5kcmV3LnNt
aXJub3ZAZ21haWwuY29tOyBjY2Fpb25lQGJheWxpYnJlLmNvbTsgYW5ndXNAYWtrZWEuY2E7DQo+
IGFneEBzaWd4Y3B1Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSBhcm02NDogZHRzOiBpbXg4bXE6IENvcnJlY3QgT1BQIHRhYmxlIGFjY29yZGlu
ZyB0bw0KPiBsYXRlc3QgZGF0YXNoZWV0DQo+IA0KPiBPbiAyOC4wNi4yMDE5IDA2OjM3LCBBbnNv
bi5IdWFuZ0BueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIGxhdGVzdCBkYXRhc2hlZXQgKFJldi4x
LCAxMC8yMDE4KSBmcm9tIGJlbG93IGxpbmtzLCBpbg0KPiA+IHRoZSBjb25zdW1lciBkYXRhc2hl
ZXQsIDEuNUdIeiBpcyBtZW50aW9uZWQgYXMgaGlnaGVzdCBvcHAgYnV0IGRlcGVuZHMNCj4gPiBv
biBzcGVlZCBncmFkaW5nIGZ1c2UsIGFuZCBpbiB0aGUgaW5kdXN0cmlhbCBkYXRhc2hlZXQsIDEu
M0dIeiBpcw0KPiA+IG1lbnRpb25lZCBhcyBoaWdoZXN0IG9wcCBidXQgZGVwZW5kcyBvbiBzcGVl
ZCBncmFkaW5nIGZ1c2UuIDEuNUdIeiBhbmQNCj4gPiAxLjNHSHogb3BwIHVzZSBzYW1lIHZvbHRh
Z2UsIHNvIG5vIG5lZWQgZm9yIGNvbnN1bWVyIHBhcnQgdG8gc3VwcG9ydA0KPiA+IDEuM0dIeiBv
cHAsIHdpdGggc2FtZSB2b2x0YWdlLCBDUFUgc2hvdWxkIHJ1biBhdCBoaWdoZXN0IGZyZXF1ZW5j
eSBpbg0KPiA+IG9yZGVyIHRvIGdvIGludG8gaWRsZSBhcyBxdWljayBhcyBwb3NzaWJsZSwgdGhp
cyBjYW4gc2F2ZSBwb3dlci4NCj4gDQo+IEkgbG9va2VkIGF0IHRoZSBzYW1lIGRhdGFzaGVldHMg
YW5kIGl0J3Mgbm90IGNsZWFyIHRvIG1lIHRoYXQgMS4zIEdoeiBzaG91bGQNCj4gYmUgZGlzYWxs
b3dlZCBmb3IgY29uc3VtZXIgcGFydHMuIFBvd2VyIGNvbnN1bXB0aW9uIGluY3JlYXNlcyB3aXRo
IGJvdGgNCj4gdm9sdGFnZSBhbmQgZnJlcXVlbmN5IHNvIGhhdmluZyB0d28gT1BQcyB3aXRoIHNh
bWUgdm9sdGFnZSBkb2VzIG1ha2UNCj4gc2Vuc2UuDQoNClRoZSBjb25zdW1lciBwYXJ0IGRhdGFz
aGVldCBkb2VzIE5PVCBtZW50aW9uIDEuM0dIeiBhdCBhbGwsIHNvIGNvbnN1bWVyIHBhcnQgT05M
WQ0Kc3VwcG9ydCAxR0h6LzEuNUdIeiwgYW5kIGluZHVzdHJpYWwgcGFydCBPTkxZIHN1cHBvcnQg
ODAwTUh6LzEuM0dIeiwgdGhpcyBpcyB3aGF0DQp3ZSBkaWQgaW4gb3VyIGludGVybmFsIHRyZWUg
YW5kIE5QSSByZWxlYXNlLCBzbyBiZXR0ZXIgdG8gbWFrZSB0aGVtIGFsaWduZWQsIG90aGVyd2lz
ZSwNCndlIGhhdmUgdG8gY2hhbmdlIGl0IHdoZW4ga2VybmVsIHVwZ3JhZGUuDQoNCkFuZCBub3Jt
YWxseSwgd2l0aCBzYW1lIHZvbHRhZ2UsIGkuTVggU29DcyBhbHdheXMgcnVuIGF0IGhpZ2hlc3Qg
ZnJlcXVlbmN5LCBzbyBpdCBpcyBiZXR0ZXINCnRvIGtlZXAgdGhlIHJ1bGUsIG90aGVyd2lzZSBj
dXN0b21lciBtYXkgYXNrLCBob3cgYWJvdXQgdXNpbmcgc2FtZSB2b2x0YWdlIHRvIHJ1biBhdCAx
LjJHSHogb3INCjEuMUdIej8NCg0KPiANCj4gPiAgIAkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MTMw
MDAwMDAwMD47DQo+ID4gICAJCQlvcHAtbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KPiA+IC0JCQlv
cHAtc3VwcG9ydGVkLWh3ID0gPDB4Yz4sIDwweDc+Ow0KPiA+ICsJCQkvKiBJbmR1c3RyaWFsIG9u
bHkgYnV0IHJlbHkgb24gc3BlZWQgZ3JhZGluZyAqLw0KPiA+ICsJCQlvcHAtc3VwcG9ydGVkLWh3
ID0gPDB4Yz4sIDwweDQ+Ow0KPiANCj4gQ29tbWVudCBpcyBmYWxzZSwgeW91J3JlIGV4cGxpY2l0
bHkgZXhjbHVkaW5nIGNvbnN1bWVyIHBhcnRzIHZpYSB0aGUgc2Vjb25kDQo+IGVsZW1lbnQuDQoN
ClllcywgdGhhdCBpcyB3aGF0IEkgbWVhbnQgdG8gZG8sIGFzIHdlIG5vIG5lZWQgdG8gc3VwcG9y
dCAxLjNHSHogZm9yIGNvbnN1bWVyDQpwYXJ0LCB3aXRoIDEuMFYsIGNvbnN1bWVyIHBhcnQgY2Fu
IHJ1biB1cCB0byAxLjVHSHouDQoNCj4gDQo+ID4gICAJCQlvcHAtaHogPSAvYml0cy8gNjQgPDE1
MDAwMDAwMDA+Ow0KPiA+ICAgCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCj4gPiAgIAkJ
CS8qIENvbnN1bWVyIG9ubHkgYnV0IHJlbHkgb24gc3BlZWQgZ3JhZGluZyAqLw0KPiA+IC0JCQlv
cHAtc3VwcG9ydGVkLWh3ID0gPDB4OD4sIDwweDc+Ow0KPiA+ICsJCQlvcHAtc3VwcG9ydGVkLWh3
ID0gPDB4OD4sIDwweDM+Ow0KPiANCj4gSWYgeW91IGRvbid0IHdhbnQgdG8gcmVseSBvbiB0aGUg
ZmFjdCB0aGF0IG9ubHkgY29uc3VtZXIgcGFydHMgc2hvdWxkIGJlDQo+IGZ1c2VkIGZvciAxLjUg
R2h6IHRoZW4gcGxlYXNlIGRlbGV0ZSB0aGUgY29tbWVudC4NCg0KRG9uJ3QgcXVpdGUgdW5kZXJz
dGFuZCwgMS41R0h6IGlzIGluZGVlZCBjb25zdW1lciBPTkxZLCBidXQgaWYgdGhlIGNvbnN1bWVy
DQpwYXJ0IGlzIGZ1c2VkIHRvIDFHSHosIHRoZW4gMS41R0h6IGlzIGFsc28gTk9UIGF2YWlsYWJs
ZSwgc28gaXQgYWxzbyByZWx5IG9uIHNwZWVkDQpncmFkaW5nLiBTbyBrZWVwIHRoZSBjb21tZW50
IHRoZXJlIGlzIE9LPw0KDQpUaGFua3MsDQpBbnNvbi4NCg0K
