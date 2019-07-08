Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7626C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE572084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g19Wg0xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfGHIy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:54:26 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:8679
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbfGHIyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcNlbZo/PmBMhKNMU2vkni64ggmauEBrCouHRhzqkS8=;
 b=g19Wg0xgTBWjazM9GlyiY6M8P78AQN8D/g2dgpi1b/MfQP8XYVEPHlc3UH0FV1OU2zXUfi+SRXh7ezwUL+ma3fw7oUEHBp8yN3OUFB+wuwQ3+4lMZywitKwOb3q5LFCpum5hNNoDp+3t7CVibXFWawwzryXc7HMT7si2R92wvOg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 08:54:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 08:54:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: RE: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend opp
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend
 opp
Thread-Index: AQHVMjD62bccyXxndUyDszIpSDkBnabAaO+AgAACe/CAAARwgIAAADZQ
Date:   Mon, 8 Jul 2019 08:54:19 +0000
Message-ID: <DB3PR0402MB39164E2F386181255ED37F45F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
 <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190708084957.waiwdun327pgvfv4@vireshk-i7>
In-Reply-To: <20190708084957.waiwdun327pgvfv4@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fe22632-f024-41fc-58de-08d70381dd2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB375670A7E32EBD3CD424F656F5F60@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(102836004)(3846002)(76116006)(66946007)(11346002)(6116002)(73956011)(68736007)(81156014)(26005)(2906002)(71190400001)(81166006)(8676002)(66556008)(66476007)(44832011)(15650500001)(54906003)(64756008)(14454004)(66446008)(446003)(52536014)(71200400001)(186003)(486006)(8936002)(66066001)(476003)(6916009)(7416002)(478600001)(256004)(7696005)(86362001)(316002)(53936002)(14444005)(7736002)(99286004)(74316002)(6436002)(5660300002)(6246003)(55016002)(305945005)(25786009)(9686003)(229853002)(4326008)(33656002)(76176011)(6506007)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uDpyWP9lwNJsxGDH0PD5HdEXSqM6Qibt+w3utjtHcBnaXJf9s44t6d3JF3bzGm3WbcmQwMnkASD6DYFFT3xyzRJjkr9jBe0vpE5feUF9x5PKOWIfLS3IdwF3+xArZwFtYTTEPTTDAWI5ad7iHRFW1C0QSBVFZktvqwtW/gwBrAdeqfmCoMlu85AxlnGcle3dZf92NIeXYJ6Cwikmi4Jn0RC7k3YT7B1k9C6czgphiK5QR4pWevqZzSd21197GXJIOcuaVWMTndE5PRF5Sc7mtNUHh+q1TvyYukuguZMHFWblrS5ez8Qhyxe09AW84eYJVmOKYkp+xV4Uof1hQInNVGtBvFKFhWN4x0hPZ1uCftkt1xTu0ABlHNiy2XdBu3AV19AjCEaQ4W9tPcliwl1+Y1R5colHm2yE9ELT7OjshXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe22632-f024-41fc-58de-08d70381dd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 08:54:19.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDA4LTA3LTE5LCAwODo0MywgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gSGksIFZpcmVzaA0KPiA+DQo+ID4gPiBPbiAwNC0wNy0xOSwgMDc6NDksIExlb25hcmQgQ3Jl
c3RleiB3cm90ZToNCj4gPiA+ID4gT24gNy80LzIwMTkgOToyMyBBTSwgQW5zb24uSHVhbmdAbnhw
LmNvbSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFzc2lnbiBoaWdoZXN0IE9QUCBhcyBzdXNwZW5k
IE9QUCB0byByZWR1Y2Ugc3VzcGVuZC9yZXN1bWUNCj4gPiA+ID4gPiBsYXRlbmN5IG9uIGkuTVg4
TU0uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMSArDQo+ID4gPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+ID4gPiA+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiA+ID4gPiBpbmRl
eCBiMTFmYzVlLi4zYTYyNDA3IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiA+ID4gPiBAQCAtMTM2LDYgKzEzNiw3
IEBADQo+ID4gPiA+ID4gICAJCQlvcHAtbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KPiA+ID4gPiA+
ICAgCQkJb3BwLXN1cHBvcnRlZC1odyA9IDwweDg+LCA8MHgzPjsNCj4gPiA+ID4gPiAgIAkJCWNs
b2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCj4gPiA+ID4gPiArCQkJb3BwLXN1c3BlbmQ7DQo+
ID4gPiA+ID4gICAJCX07DQo+ID4gPiA+ID4gICAJfTsNCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBp
ZiB0aGUgaGlnaGVzdCBPUFAgaXMgdW5hdmFpbGFibGUgZHVlIHRvIHNwZWVkIGdyYWRpbmc/DQo+
ID4gPg0KPiA+ID4gV2hhdCBkb2VzIHRoaXMgZXhhY3RseSBtZWFuID8gSG93IGlzIHRoZSBPUFAg
bWFkZSB1bmF2YWlsYWJsZSBpbg0KPiA+ID4geW91ciBjYXNlID8NCj4gPg0KPiA+IFRoYXQgaXMg
YmVjYXVzZSBpbiBpLk1YOE0gc2VyaWVzIFNvQ3MsIHRoZSBzcGVlZCBncmFkaW5nIGFuZCBtYXJr
ZXQNCj4gPiBzZWdtZW50IGZ1c2VzIHNldHRpbmdzIGNvdWxkIGFmZmVjdCB0aGUgT1BQIGRlZmlu
ZWQgaW4gRFQsIGluIGEgd29yZCwNCj4gPiBhbGwgcG9zc2libGUgT1BQcyBhcmUgZGVmaW5lZCBp
biBEVCwgYnV0IGVhY2ggcGFydHMgY291bGQgT05MWSBzZWxlY3QNCj4gPiBzb21lIG9mIHRoZW0g
dG8gYmUgd29ya2luZyBPUFBzLCBzbyBpZiB0aGUgIm9wcC1zdXNwZW5kIiBpcyBhZGRlZCBmb3IN
Cj4gPiAxIE9QUCBpbiBEVCwgaWYgdGhlIHBhcnQncyBzcGVlZCBncmFkaW5nIG9yIG1hcmtldCBz
ZWdtZW50IGZ1c2Ugc2V0dGluZ3MNCj4gbWFrZSB0aGF0IE9QUCBhcyB1bmF2YWlsYWJsZSwgIHRo
ZW4gdGhhdCAib3BwLXN1c3BlbmQiDQo+ID4gaXMgTk9UIHdvcmtpbmcgYXQgYWxsLg0KPiANCj4g
SG93IGlzIHRoaXMgc2VsZWN0aW9uIGRvbmUgPyBZb3UgdXNpbmcgc29tZSBPUFAgaGVscGVyIG9y
IHNvbWV0aGluZyBlbHNlID8NCg0KRWFjaCBPUFAgaGFzICJvcHAtc3VwcG9ydGVkLWh3IiBwcm9w
ZXJ0eSBhcyBiZWxvdywgdGhlIGZpcnN0IHZhbHVlIG5lZWRzIHRvIGJlDQpjaGVja2VkIHdpdGgg
c3BlZWQgZ3JhZGluZyBmdXNlLCBhbmQgdGhlIHNlY29uZCBvbmUgbmVlZHMgdG8gYmUgY2hlY2tl
ZCB3aXRoDQptYXJrZXQgc2VnbWVudCBmdXNlLCBPTkxZIGJvdGggb2YgdGhlbSBwYXNzZWQsIHRo
ZW4gdGhpcyBPUFAgaXMgc3VwcG9ydGVkLiBJdA0KY2FsbHMgZGV2X3BtX29wcF9zZXRfc3VwcG9y
dGVkX2h3KCkgdG8gdGVsbCBPUFAgZnJhbWV3b3JrIHRvIHBhcnNlIHRoZSBPUFANCnRhYmxlLCB0
aGlzIGlzIG15IHVuZGVyc3RhbmRpbmcuDQoNCm9wcC1zdXBwb3J0ZWQtaHcgPSA8MHg4PiwgPDB4
Mz47DQoNCnRoYW5rcywNCkFuc29uDQoNCg==
