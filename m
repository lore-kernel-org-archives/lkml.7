Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8991C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19652064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcnPITLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfGHInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:43:35 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:52565
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbfGHInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX4D1UiJrMVKhd09t3cgQwyqtFs3H+NCC432Hv6DtHY=;
 b=IcnPITLrBWIzeTFQsudKSmGMpraAEr2Wy24+7yGl9jhGfgDRbyH0F8hZRbBilYvP9qnXBeHYjRn2Vuw45lXTL6L1iCG+H7WJoDP8RpMVMG+UFEjq0I1U9Q5NWh3KCXiIAVl17/MTu56ZmOox0TWZ2I5HImNVdIcJsPc/TJ66aV0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3820.eurprd04.prod.outlook.com (52.134.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 08:43:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 08:43:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Thread-Index: AQHVMjD62bccyXxndUyDszIpSDkBnabAaO+AgAACe/A=
Date:   Mon, 8 Jul 2019 08:43:31 +0000
Message-ID: <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
In-Reply-To: <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f90bada-6e9b-48ca-3a35-08d703805b1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3820;
x-ms-traffictypediagnostic: DB3PR0402MB3820:
x-microsoft-antispam-prvs: <DB3PR0402MB3820068CB0B32DDD7E85CB1FF5F60@DB3PR0402MB3820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(68736007)(11346002)(446003)(8936002)(4326008)(33656002)(66066001)(99286004)(6116002)(3846002)(14444005)(14454004)(486006)(15650500001)(476003)(2906002)(6636002)(256004)(71190400001)(71200400001)(44832011)(229853002)(81166006)(74316002)(9686003)(53936002)(6246003)(7416002)(55016002)(6436002)(64756008)(66446008)(66476007)(66556008)(305945005)(7736002)(76116006)(66946007)(81156014)(86362001)(73956011)(8676002)(316002)(25786009)(102836004)(186003)(52536014)(5660300002)(26005)(53546011)(54906003)(76176011)(6506007)(110136005)(7696005)(478600001)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3820;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KRBjVOkLSl0kZ74kdfagiMYd60unkY6XcOriLUE5IaqOAJbgji4I09Eqlk4gDqQSoxvKYNVQ3H5y0uWaFN9rW2GcxmHvUpKTnx5Z2qGEIvqA9U7AsGm1mrCcj7XYaLzOvDbpHgfkmNMm/sWPP6ofIcQkzU7aWkooIMSMEkzspCU8561XYcRlvi/NhtN0OxcCQsSaqsRJbxrALqpxpG44BqHVN5wOT5C0xMw+o14Z9cK4nz0p99RvmSR7DltS8pk+amASuYHWu8htl4PBEVSzKvTfPYcLW5WBPjJnOq072Z6sinXcke6qcdopU35RFQnUzHOFZpQ4aaqanBYzejZArehODsnkA+eonO0UfwggEksaafqJ8mbNYlHRZqYsoVeDGpq86Rjf8OrS0K7kJl7opCXwilo/fIniF3gyKsaIa/0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90bada-6e9b-48ca-3a35-08d703805b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 08:43:31.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDA0LTA3LTE5LCAwNzo0OSwgTGVvbmFyZCBDcmVzdGV6IHdyb3Rl
Og0KPiA+IE9uIDcvNC8yMDE5IDk6MjMgQU0sIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+
ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+DQo+ID4g
PiBBc3NpZ24gaGlnaGVzdCBPUFAgYXMgc3VzcGVuZCBPUFAgdG8gcmVkdWNlIHN1c3BlbmQvcmVz
dW1lIGxhdGVuY3kNCj4gPiA+IG9uIGkuTVg4TU0uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAxICsNCj4gPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gPiBpbmRleCBiMTFmYzVl
Li4zYTYyNDA3IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS5kdHNpDQo+ID4gPiBAQCAtMTM2LDYgKzEzNiw3IEBADQo+ID4gPiAgIAkJCW9wcC1t
aWNyb3ZvbHQgPSA8MTAwMDAwMD47DQo+ID4gPiAgIAkJCW9wcC1zdXBwb3J0ZWQtaHcgPSA8MHg4
PiwgPDB4Mz47DQo+ID4gPiAgIAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUwMDAwPjsNCj4gPiA+
ICsJCQlvcHAtc3VzcGVuZDsNCj4gPiA+ICAgCQl9Ow0KPiA+ID4gICAJfTsNCj4gPg0KPiA+IFdo
YXQgaWYgdGhlIGhpZ2hlc3QgT1BQIGlzIHVuYXZhaWxhYmxlIGR1ZSB0byBzcGVlZCBncmFkaW5n
Pw0KPiANCj4gV2hhdCBkb2VzIHRoaXMgZXhhY3RseSBtZWFuID8gSG93IGlzIHRoZSBPUFAgbWFk
ZSB1bmF2YWlsYWJsZSBpbiB5b3VyDQo+IGNhc2UgPw0KDQpUaGF0IGlzIGJlY2F1c2UgaW4gaS5N
WDhNIHNlcmllcyBTb0NzLCB0aGUgc3BlZWQgZ3JhZGluZyBhbmQgbWFya2V0IHNlZ21lbnQNCmZ1
c2VzIHNldHRpbmdzIGNvdWxkIGFmZmVjdCB0aGUgT1BQIGRlZmluZWQgaW4gRFQsIGluIGEgd29y
ZCwgYWxsIHBvc3NpYmxlIE9QUHMNCmFyZSBkZWZpbmVkIGluIERULCBidXQgZWFjaCBwYXJ0cyBj
b3VsZCBPTkxZIHNlbGVjdCBzb21lIG9mIHRoZW0gdG8gYmUgd29ya2luZw0KT1BQcywgc28gaWYg
dGhlICJvcHAtc3VzcGVuZCIgaXMgYWRkZWQgZm9yIDEgT1BQIGluIERULCBpZiB0aGUgcGFydCdz
IHNwZWVkIGdyYWRpbmcgb3INCm1hcmtldCBzZWdtZW50IGZ1c2Ugc2V0dGluZ3MgbWFrZSB0aGF0
IE9QUCBhcyB1bmF2YWlsYWJsZSwgIHRoZW4gdGhhdCAib3BwLXN1c3BlbmQiDQppcyBOT1Qgd29y
a2luZyBhdCBhbGwuDQoNCj4gDQo+IFdoYXQgd2lsbCBkZXZfcG1fb3BwX2dldF9zdXNwZW5kX29w
cF9mcmVxKCkgcmV0dXJuIGluIHRoaXMgY2FzZSA/DQoNCklmIHRoZSBPUFAgY29udGFpbnMgIm9w
cC1zdXNwZW5kIiBwcm9wZXJ0eSBpcyBOT1Qgc3VwcG9ydGVkIGJ5IHRoZSBIVywgdGhlbiB0aGVy
ZSB3aWxsDQpiZSBubyBzdXNwZW5kIE9QUCBkZWZpbmVkLCBzbyBpdCB3aWxsIHJldHVybiAwLiBU
aGUgX29wcF9pc19zdXBwb3J0ZWQoKSBwYXJzZXMgdGhlIG9wcC1zdXBwb3J0ZWQtaHcNCmJlZm9y
ZSBvcHAtc3VzcGVuZC4NCg0KPiANCj4gPiBJZGVhbGx5IHdlDQo+ID4gc2hvdWxkIGZpbmQgYSB3
YXkgdG8gc3VzcGVuZCBhdCB0aGUgaGlnaGVzdCAqc3VwcG9ydGVkKiBPUFAuDQo+ID4NCj4gPiBN
YXliZSB0aGUgb3BwLXN1c3BlbmQgbWFya2luZyBjb3VsZCBiZSBhc3NpZ25lZCBmcm9tIGlteC1j
cHVmcmVxLWR0DQo+ID4gZHJpdmVyIGNvZGU/DQoNCkkgZXZlciB0cmllZCB0aGF0LCBnbyB0aHJv
dWdoIHRoZSBPUFAgdGFibGUgYW5kIGNoZWNrIHRoZSBmdXNlIHNldHRpbmdzLCB0aGVuIHJ1bnRp
bWUgYWRkICJvcHAtc3VzcGVuZCINCnRvIHRoZSBvcHAgdGFibGUsIGJ1dCB1bmZvcnR1bmF0ZWx5
LCB0aGUgIiBzdHJ1Y3Qgb3BwX3RhYmxlICIgaXMgTk9UIG9wZW5lZCB0byBiZSB1c2VkLCBpdCBp
cyBhIHByaXZhdGUNCnN0cnVjdHVyZT8NCg0KPiANCj4gU29ycnkgZm9yIGp1bXBpbmcgaW4gbGF0
ZSwgdGhlIGxhdGVzdCBwYXRjaCBmcm9tIEFuc29uIGRyZXcgbXkgYXR0ZW50aW9uIHRvDQo+IHRo
aXMgdG9waWMgOikNCg0KVGhhdCBpcyBPS/CfmIoNCg0KVGhhbmtzLA0KQW5zb24uDQoNCg==
