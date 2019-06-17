Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BEDC31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D9D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k47Sm7te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfFQBpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:45:11 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:39815
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbfFQBpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkvRMODMJ2+ouerSUH+T4/ZC4YPa/rgoFSLgEQ56J7M=;
 b=k47Sm7tehDCVO2ISM04Fhl21oCG2tSOdZ/6DpK9GVBXRKaq1vnrC010StZcgUmP+iHGa1N18YGyoSTCCfRqVTk+dZcdSnEDKhppX18UYRKK+xC4Zy1BN6W+aEZCtFB/RRHOo+rl19ymgZ4ITBotnIjt98Z/oupJxyMoe0eAIgt4=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5451.eurprd04.prod.outlook.com (20.178.105.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Mon, 17 Jun 2019 01:45:04 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::d99:5c8e:94a9:5ca0]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::d99:5c8e:94a9:5ca0%6]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 01:45:04 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] Re: [v1 1/4] dt-bindings: display: Add DT bindings for
 LS1028A HDP-TX PHY.
Thread-Topic: [EXT] Re: [v1 1/4] dt-bindings: display: Add DT bindings for
 LS1028A HDP-TX PHY.
Thread-Index: AQHVBYm/GjgqdY4+pUuRDaU4fFYL0aaaPGKAgAUSaRA=
Date:   Mon, 17 Jun 2019 01:45:04 +0000
Message-ID: <DB7PR04MB5195E49670279C9A28C28A5EE2EB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190508103703.40885-1-wen.he_1@nxp.com>
 <20190613200813.GA895@bogus>
In-Reply-To: <20190613200813.GA895@bogus>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b9333fa-8539-42fc-29da-08d6f2c56b4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5451;
x-ms-traffictypediagnostic: DB7PR04MB5451:
x-microsoft-antispam-prvs: <DB7PR04MB54517961FBE65D056D297984E2EB0@DB7PR04MB5451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(51914003)(13464003)(189003)(199004)(64756008)(2906002)(478600001)(71190400001)(71200400001)(6916009)(6436002)(229853002)(7736002)(53936002)(99286004)(256004)(6246003)(14444005)(52536014)(53546011)(6506007)(102836004)(66066001)(7696005)(86362001)(76176011)(3846002)(6116002)(305945005)(66946007)(486006)(8936002)(316002)(11346002)(446003)(476003)(76116006)(33656002)(186003)(73956011)(66476007)(81166006)(8676002)(81156014)(54906003)(74316002)(14454004)(55016002)(5660300002)(9686003)(25786009)(66446008)(66556008)(26005)(4326008)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5451;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fX7oQslInmlDF4p+mML50rZ4XtNSvL8t/Rkfk/l6ZoAmN+p7Sz/vOn0oaT0hlW5ZNnnJS68RCw1/KsmtuzuvPmYUbMJNGxhnv3tbjkiBcymFmOB/S9ibbFlyn8r/Geerb7w1J7dryWCFraAqPrx9Q5zxDzLcueBEJX3r3x8FXp0GjYhzpu3dOYPP+tCXcAn9tGkPG1CLppP8a2wI6jSeWRSp3n/TmOOkM56CtoUSUIkUKpI6rcKHfO3limTUSar4rNXAFpQLsCQhTu1kUL6JXQJjXHCTmwoMddd34wjUPxCtxsuQHs+dTPLDtKX+Z0zeg4NeQyQ2aLDxsU9Bxi7ZZVPIpXqP7jtRDzhaLYbMa/LEk8VZm6WTNIJ8YGz+rMvONcFHXFwt01zdLi2RzQGog+rGyGY9ch6FFX0BMd8iucE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9333fa-8539-42fc-29da-08d6f2c56b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 01:45:04.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wen.he_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqNtTCMTTI1SA0OjA4DQo+IFRvOiBXZW4gSGUg
PHdlbi5oZV8xQG54cC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhw
LmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFt2MSAxLzRdIGR0LWJpbmRpbmdzOiBkaXNwbGF5
OiBBZGQgRFQgYmluZGluZ3MgZm9yIExTMTAyOEENCj4gSERQLVRYIFBIWS4NCj4gDQo+IENhdXRp
b246IEVYVCBFbWFpbA0KPiANCj4gT24gV2VkLCBNYXkgMDgsIDIwMTkgYXQgMTA6MzU6MjVBTSAr
MDAwMCwgV2VuIEhlIHdyb3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5ncyBkb2N1bWVudG1hdGlvbiBm
b3IgdGhlIEhEUC1UWCBQSFkgY29udHJvbGxlci4gVGhlDQo+ID4gZGVzY3JpYmVzIHdoaWNoIGNv
dWxkIGJlIGZvdW5kIG9uIE5YUCBMYXllcnNjYXBlIGxzMTAyOGEgcGxhdGZvcm0uDQo+IA0KPiBE
cm9wIHRoZSBoYXJkIHN0b3AgKC4pIGZyb20gdGhlIHN1YmplY3QuDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2ZzbCxoZHAudHh0ICAgfCA1NiArKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L2ZzbCxoZHAudHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2ZzbCxoZHAudHh0DQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjM2YjU2ODdhMTI2MQ0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9mc2wsaGRwLnR4dA0KPiA+IEBAIC0wLDAgKzEsNTYgQEANCj4gPiArTlhQIExheWVy
c2NwYWUgbHMxMDI4YSBIRFAtVFggUEhZIENvbnRyb2xsZXINCj4gPiArPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiArDQo+ID4gK1RoZSBmb2xsb3dpbmcg
YmluZGluZ3MgZGVzY3JpYmUgdGhlIENhZGVuY2UgSERQIFRYIFBIWSBvbiBsczEwMjhhDQo+ID4g
K3RoYXQgb2ZmZXIgbXVsdGktcHJvdG9jb2wgc3VwcG9ydCBvZiBzdGFuZGFycyBzdWNoIGFzIGVE
UCBhbmQNCj4gPiArRGlzcGxheXBvcnQsIHN1cHBvcnRzIGZvciAyNS02MDBNSHogcGl4ZWwgY2xv
Y2sgYW5kIHVwIHRvIDRrMmsgYXQgNjBNSHoNCj4gcmVzb2x1dGlvbi4NCj4gPiArVGhlIEhEUCB0
cmFuc21pdHRlciBpcyBhIENhZGVuY2UgSERQIFRYIGNvbnRyb2xsZXIgSVAgd2l0aCBhDQo+ID4g
K2NvbXBhbmlvbiBQSFkgSVAuDQo+IA0KPiBJJ20gY29uZnVzZWQuIFRoaXMgYmluZGluZyBjb3Zl
cnMgYm90aCBibG9ja3Mgb3IgaXMganVzdCBvbmUgb2YgdGhlbT8NCj4gDQoNCkhpIFJvYiwNCg0K
VGhpcyBiaW5kaW5nIGNvdmVycyBib3RoIGJsb2NrcyhIRFAgVFggUEhZIGFuZCBIRFAgVFggQ29u
dHJvbGxlciksIA0KQmVjYXVzZSB0aGV5IGFyZSBiZWxvbmcgdG8gdGhlIG9uZSBJUC4NCg0KPiA+
ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArICAtIGNvbXBhdGlibGU6ICAgU2hv
dWxkIGJlICJmc2wsbHMxMDI4YS1kcCIgZm9yIGxzMTAyOGEuDQo+ID4gKyAgLSByZWc6ICAgICAg
ICAgIFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgYmxvY2sgb2YgcmVnaXN0
ZXJzDQo+IHVzZWQNCj4gPiArICBieSB0aGUgcHJvY2Vzc29yLg0KPiA+ICsgIC0gaW50ZXJydXB0
czogICBIRFAgaG90cGx1ZyBpbi9vdXQgZGV0ZWN0IGludGVycnVwdCBudW1iZXINCj4gPiArICAt
IGNsb2NrczogICAgICAgQSBsaXN0IG9mIHBoYW5kbGUgKyBjbG9jay1zcGVjaWZpZXIgcGFpcnMs
IG9uZSBmb3IgZWFjaA0KPiBlbnRyeQ0KPiA+ICsgIGluICdjbG9jay1uYW1lcycNCj4gPiArICAt
IGNsb2NrLW5hbWVzOiAgQSBsaXN0IG9mIGNsb2NrIG5hbWVzLiBJdCBzaG91bGQgY29udGFpbjoN
Cj4gPiArICAgICAgLSAiY2xrX2lwZyI6IGludGVyLUludGVncmF0ZWQgY2lyY3VpdCBjbG9jaw0K
PiA+ICsgICAgICAtICJjbGtfY29yZSI6IGZvciB0aGUgTWFpbiBEaXNwbGF5IFRYIGNvbnRyb2xs
ZXIgY2xvY2sNCj4gPiArICAgICAgLSAiY2xrX3B4bCI6IGZvciB0aGUgcGl4ZWwgY2xvY2sgZmVl
ZGluZyB0aGUgb3V0cHV0IFBMTCBvZiB0aGUgcHJvY2Vzc29yDQo+ID4gKyAgICAgIC0gImNsa19w
eGxfbXV4IjogZm9yIHRoZSBoaWdoIFBlcmZQTEwgYnlwYXNzIGNsb2NrDQo+ID4gKyAgICAgIC0g
ImNsa19weGxfbGluayI6IGZvciB0aGUgbGluayByYXRlIHBpeGVsIGNsb2NrDQo+ID4gKyAgICAg
IC0gImNsa19hcGIiOiBmb3IgdGhlIEFQQiBpbnRlcmZhY2UgY2xvY2sNCj4gPiArICAgICAgLSAi
Y2xrX3ZpZiI6IGZvciB0aGUgVmlkZW8gcGl4ZWwgY2xvY2sNCj4gDQo+IFRoZSAnY2xrXycgcGFy
dCBpcyByZWR1bmRhbnQuDQo+IA0KDQpZb3UgbWVhbiBzaG91bGQgSSByZW1vdmUgdGhlc2UgJ2Ns
a18nIHBhcnQ/DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzLA0KV2Vu
DQoNCj4gPiArDQo+ID4gK1JlcXVpcmVkIHN1Yi1ub2RlczoNCj4gPiArICAtIHBvcnQ6IFRoZSBI
RFAgY29ubmVjdGlvbiB0byBhbiBlbmNvZGVyIG91dHB1dCBwb3J0LiBUaGUgY29ubmVjdGlvbg0K
PiA+ICsgICAgaXMgbW9kZWxsZWQgdXNpbmcgdGhlIE9GIGdyYXBoIGJpbmRpbmdzIHNwZWNpZmll
ZCBpbg0KPiA+ICsgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dyYXBoLnR4
dA0KPiA+ICsNCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKw0KPiA+ICsvIHsNCj4gPiArICAg
ICAgICAuLi4NCj4gPiArDQo+ID4gKyAgICAgaGRwOiBkaXNwbGF5QGYyMDAwMDAgew0KPiA+ICsg
ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1kcCI7DQo+ID4gKyAgICAg
ICAgICAgICByZWcgPSA8MHgwIDB4ZjFmMDAwMCAweDAgMHhmZmZmPiwNCj4gPiArICAgICAgICAg
ICAgICAgICA8MHgwIDB4ZjIwMDAwMCAweDAgMHhmZmZmZj47DQo+ID4gKyAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHRzID0gPDAgMjIxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAg
ICAgICAgY2xvY2tzID0gPCZzeXNjbGs+LCA8JmhkcGNsaz4sIDwmZHBjbGs+LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgPCZkcGNsaz4sIDwmZHBjbGs+LCA8JnBjbGs+LCA8JmRwY2xr
PjsNCj4gPiArICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImNsa19pcGciLCAiY2xrX2NvcmUi
LCAiY2xrX3B4bCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJjbGtfcHhs
X211eCIsICJjbGtfcHhsX2xpbmsiLCAiY2xrX2FwYiIsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJjbGtfdmlmIjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBwb3J0IHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgZHAxX291dHB1dDogZW5kcG9pbnQgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmZHAwX2lucHV0
PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAgIH07DQo+
ID4gKyAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgLi4uDQo+ID4gK307DQo+ID4gLS0N
Cj4gPiAyLjE3LjENCj4gPg0K
