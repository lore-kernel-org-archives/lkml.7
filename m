Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C960C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D520872
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCQMd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:33:28 -0400
Received: from mail-oln040092065050.outbound.protection.outlook.com ([40.92.65.50]:21217
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfCQMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:33:27 -0400
Received: from VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (10.152.2.52) by VE1EUR01HT139.eop-EUR01.prod.protection.outlook.com
 (10.152.3.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.9; Sun, 17 Mar
 2019 12:33:19 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.2.57) by
 VE1EUR01FT016.mail.protection.outlook.com (10.152.2.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.9 via Frontend Transport; Sun, 17 Mar 2019 12:33:19 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009%5]) with mapi id 15.20.1709.015; Sun, 17 Mar 2019
 12:33:19 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Thread-Topic: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Thread-Index: AQHUxucMoxU67kG9/EyxObajZ+kTbqX4eAaAgAAypACAACM+AIAW8zEAgAAsSQA=
Date:   Sun, 17 Mar 2019 12:33:19 +0000
Message-ID: <AM3PR03MB0966C5CA52CE87DFB35D172BAC460@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <20190217173407.29189-2-katsuhiro@katsuster.net>
 <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
 <AM3PR03MB0966F2308C6003C192A68F4DAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
 <fb36eddb-ef3b-df4a-5e1a-6f8866726ae9@katsuster.net>
 <b855ff66-19e5-4ea5-3337-23d5ada1bf1c@katsuster.net>
In-Reply-To: <b855ff66-19e5-4ea5-3337-23d5ada1bf1c@katsuster.net>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::21) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:D46B4692027B03911B022275B8B43DD05384FF0747227C3207958F8960FD3FAC;UpperCasedChecksum:A8B40E2AFF728942F5F9F6C04ED95140D71BDC320BB65D127AC021811AE75CF7;SizeAsReceived:8076;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2ENW0eRzFAmf3kbDMD9pqJOpPcGJmv5R]
x-microsoft-original-message-id: <4247fb06-86cf-0e32-845c-d2617a6f6317@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT139;
x-ms-traffictypediagnostic: VE1EUR01HT139:
x-microsoft-antispam-message-info: nz07cA9dnOl2QME0EUM/xtYj27HgN1PnPhBWKl1XpgsL+D82pVyyk9kkpKz/DVJV
Content-Type: text/plain; charset="utf-8"
Content-ID: <C621DA6FB204EE47A772479BC91DB66D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 518be6a6-ae77-4e0b-899c-08d6aad4bc08
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2019 12:33:19.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS2F0c3VoaXJvLA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5LCBJIGhhdmUgbm90IGJlZW4g
YWJsZSB0byBmdWxseSB0ZXN0IHRoaXMgeWV0IGJ1dCB3aWxsIGRvIG1vcmUgdGVzdGluZyBsYXRl
ciB0b25pZ2h0Lg0KDQpNeSBjb25jZXJuIGFyZSByZWdhcmRpbmcgaG93IHRvIGNvbmZpZ3VyZSBh
IHNpbmdsZSBncmFwaCBjYXJkIG5vZGUgdG8gYWRkIGEgaGRtaTogKGFuZCBpZWM5NTg6IGZvciBz
cGRpZikgdmFyaWFudHMgdXNpbmcgYW4gYWxzYSBjb25maWcgZmlsZS4NCkluIExpYnJlRUxFQyBJ
IGV4cG9zZSBIRE1JIGFuZCBTUERJRiBhcyB0d28gZGlmZmVyZW50IGNhcmQgbm9kZXMgdG8gc2lt
cGxpZnkgYXBwbHlpbmcgYWxzYSBjb25maWcgZmlsZXMsIHNlZSBbMV0gYW5kIFsyXSBmb3IgdGhl
IGFsc2EgY29uZmlnIGZpbGVzIEkgdXNlLg0KRG8geW91IGtub3cgaG93IEkgY2FuIGNvbmZpZ3Vy
ZSB0aGUgaGRtaTogYW5kIGllYzk1ODogY2FyZHMgYW5kIGFkZCBhICJJRUM5NTggUGxheWJhY2si
IGN0bCB3aXRoIHRoZSBjb21iaW5lZCBncmFwaCBjYXJkIG5vZGU/DQoNCkkgYW0gYWxzbyB3b3Jr
aW5nIG9uIE5MLVBDTS9IQlItYXVkaW8gc3VwcG9ydCBmb3IgZHctaGRtaS1pMnMgYW5kIGl0IHdp
bGwgcmVxdWlyZSAiSUVDOTU4IFBsYXliYWNrIiBjdGwgYW5kIHBsYXllcnMgc3VjaCBhcyBrb2Rp
IGFuZCBtcHYgb25seSBzZXRzIEFFUzAtMyBmb3IgaGRtaTogYW5kIGllYzk1ODogY2FyZHMuDQoN
ClsxXSBodHRwczovL2dpdGh1Yi5jb20vTGlicmVFTEVDL0xpYnJlRUxFQy50di9ibG9iL21hc3Rl
ci9wcm9qZWN0cy9Sb2NrY2hpcC9maWxlc3lzdGVtL3Vzci9zaGFyZS9hbHNhL2NhcmRzL0hETUku
Y29uZg0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9MaWJyZUVMRUMvTGlicmVFTEVDLnR2L2Jsb2Iv
bWFzdGVyL3Byb2plY3RzL1JvY2tjaGlwL2ZpbGVzeXN0ZW0vdXNyL3NoYXJlL2Fsc2EvY2FyZHMv
U1BESUYuY29uZg0KDQpSZWdhcmRzLA0KSm9uYXMNCg0KT24gMjAxOS0wMy0xNyAxMDo1NCwgS2F0
c3VoaXJvIFN1enVraSB3cm90ZToNCj4gSGVsbG8gSm9uYXMsDQo+DQo+IEhvdyBhYm91dCB0aGlz
IHRvcGljPw0KPg0KPiBJIHRoaW5rIHRoaXMgcGF0Y2ggZG9lcyBub3QgaGF2ZSBiYWQgZWZmZWN0
IGZvciBtdWx0aSBjaGFubmVsDQo+IHNvdW5kIG9mIEhETUkuIElmIHlvdSBkb24ndCB0aGluayBz
bywgcGxlYXNlIHRlbGwgbWUuDQo+IEkgd2FpdCB5b3VyIHNvdW5kIHBhdGNoIGFuZCBhZnRlciBy
ZS1jaGVjayB0aGlzIHBhdGNoLg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IEthdHN1aGlybyBTdXp1
a2kNCj4NCj4gT24gMjAxOS8wMy8wMyA0OjI2LCBLYXRzdWhpcm8gU3V6dWtpIHdyb3RlOg0KPj4g
SGVsbG8gSm9uYXMsDQo+Pg0KPj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPj4NCj4+IE9u
IDIwMTkvMDMvMDMgMjoyMCwgSm9uYXMgS2FybG1hbiB3cm90ZToNCj4+PiBPbiAyMDE5LTAzLTAy
IDE1OjE5LCBLYXRzdWhpcm8gU3V6dWtpIHdyb3RlOg0KPj4+PiBQaW5nLi4uDQo+Pj4+DQo+Pj4+
IE9uIDIwMTkvMDIvMTggMjozNCwgS2F0c3VoaXJvIFN1enVraSB3cm90ZToNCj4+Pj4+IFRoaXMg
cGF0Y2ggYWRkcyBIRE1JIHNvdW5kIChJMlMwKSBub2RlIGZvciByb2NrNjQuDQo+Pj4+Pg0KPj4+
Pj4gQWZ0ZXIgYXBwbHkgdGhpcyBwYXRjaCwgVUFSVDIgd2lsbCBmYWlsIHRvIGFsbG9jYXRlIERN
QSByZXNvdXJjZXMNCj4+Pj4+IGJ1dCBVQVJUIGRyaXZlciBjYW4gd29yayBmaW5lIHdpdGhvdXQg
RE1BLg0KPj4+Pj4NCj4+Pj4+IFRoaXMgZXJyb3IgaXMgcmVsYXRlZCB0byB0aGUgRE1BQyBvZiBy
azMzMjggKHBsMzMwIG9yIGNvbXBhdGlibGUpLg0KPj4+Pj4gRE1BQyBjb25uZWN0ZWQgdG8gMTYg
RE1BIHNvdXJjZXMuIEVhY2ggc291cmNlcyBoYXZlIElEIG51bWJlciB0aGF0IGlzDQo+Pj4+PiBj
YWxsZWQgJ1JlcSBudW1iZXInIGluIHJrMzMyOCBUUk0uIEN1cnJlbnRseSB0b3RhbCA3IHNvdXJj
ZXMgaGFzIGJlZW4NCj4+Pj4+IGFjdGl2YXRlZCBhcyBmb2xsb3dzOg0KPj4+Pj4NCj4+Pj4+IHwg
UmVxIG51bWJlciB8IFNvdXJjZSB8IFJlcXVpcmVkwqAgfA0KPj4+Pj4gfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgIHwgY2hhbm5lbHPCoCB8DQo+Pj4+PiB8LS0tLS0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tfA0KPj4+Pj4gfCAxNCwgMTXCoMKgwqDCoCB8IEkyUzHC
oMKgIHwgMmNowqDCoMKgwqDCoMKgIHwNCj4+Pj4+IHzCoCA2LMKgIDfCoMKgwqDCoCB8IFVBUlQy
wqAgfCAyY2jCoMKgwqDCoMKgwqAgfA0KPj4+Pj4gfMKgwqDCoMKgIDEwwqDCoMKgwqAgfCBTUERJ
RsKgIHwgMWNowqDCoMKgwqDCoMKgIHwNCj4+Pj4+IHzCoCA4LMKgIDnCoMKgwqDCoCB8IFNQSTDC
oMKgIHwgMmNowqDCoMKgwqDCoMKgIHwNCj4+Pj4+IHwtLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0t
LS0tLS0tLS18DQo+Pj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFRvdGFswqAgfCA3Y2jC
oMKgwqDCoMKgwqAgfA0KPj4+Pj4NCj4+Pj4+IEhETUkgYXVkaW8gbmVlZHMgdG8gYWN0aXZhdGUg
bmV3IHNvdXJjZSBJMlMwIChSZXEgbnVtYmVyIDExIGFuZCAxMikuDQo+Pj4+PiBJMlMwIGNhbiB3
b3JrIGNvbmN1cnJlbnRseSB3aXRoIG90aGVyIHNvdXJjZXMsIGJ1dCByazMzMjggRE1BQyBjYW4N
Cj4+Pj4+IHVzZSBtYXggOCBjaGFubmVscyBhdCBzYW1lIHRpbWUuIElmIEkyUzAgaXMgc2ltcGx5
IGFjdGl2YXRlZCBieSB0aGlzDQo+Pj4+PiBwYXRjaCwgcmVxdWlyZWQgRE1BQyBjaGFubmVscyB3
aWxsIGJlIDkuIFNvIGxhc3Qgb25lIChVQVJUMikgY2Fubm90DQo+Pj4+PiBhbGxvY2F0ZSB0aGUg
RE1BIHJlc291cmNlcy4NCj4+Pj4+DQo+Pj4+PiBWaXJ0LWRtYSBtZWNoYW5pc20gZm9yIHBsMDMz
MCBETUFDIGRyaXZlciBpcyBuZWVkZWQgdG8gZml4IHRoaXMNCj4+Pj4+IHByb2JsZW0uDQo+Pj4+
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogS2F0c3VoaXJvIFN1enVraSA8a2F0c3VoaXJvQGthdHN1
c3Rlci5uZXQ+DQo+Pj4+PiAtLS0NCj4+Pj4+IMKgwqAgLi4uL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzMyOC1yb2NrNjQuZHRzIHwgMjEgDQo+Pj4+PiArKysrKysrKysrKysrKysrKystDQo+
Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszMzI4LXJvY2s2NC5kdHMgDQo+Pj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszMzI4LXJvY2s2NC5kdHMNCj4+Pj4+IGluZGV4IDIxNTdhNTI4Mjc2Yi4uYmZjMDkzMGQyNDVj
IDEwMDY0NA0KPj4+Pj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzMjgt
cm9jazY0LmR0cw0KPj4+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMz
Mjgtcm9jazY0LmR0cw0KPj4+Pj4gQEAgLTY4LDcgKzY4LDggQEANCj4+Pj4+IMKgwqDCoMKgwqDC
oCBzb3VuZCB7DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImF1ZGlv
LWdyYXBoLWNhcmQiOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGFiZWwgPSAicm9ja2No
aXAscmszMzI4IjsNCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBkYWlzID0gPCZpMnMxX3AwDQo+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgZGFpcyA9IDwmaTJzMF9wMA0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgJmkyczFfcDANCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnNw
ZGlmX3AwPjsNCj4+PiBJIGFtIHdvcmtpbmcgb24gbXVsdGktY2hhbm5lbCBoZG1pIGF1ZGlvIHN1
cHBvcnQgZm9yIGR3LWhkbWkgYXQgWzFdIA0KPj4+IGFuZCBhcmUgd29uZGVyaW5nIGlmIGhhdmlu
ZyBtdWx0aXBsZSBkYWlzIG9uIG9uZSBncmFwaCBjYXJkDQo+Pj4gaW5zdGVhZCBvZiBhIHNlcGFy
YXRlIGhkbWkgc291bmQgY2FyZCB3aWxsIGFmZmVjdCB0aGUgYWJpbGl0eSB0byANCj4+PiBkZWZp
bmUgYSBwcm9wZXIgYWxzYSBjb25maWcgZm9yIG11bHRpIGNoYW5uZWwgaGRtaSBzb3VuZC4NCj4+
Pg0KPj4+IFsxXSANCj4+PiBodHRwczovL2dpdGh1Yi5jb20vS3dpYm9vL2xpbnV4LXJvY2tjaGlw
L2NvbXBhcmUvODg3NGMyMDZkNjEzZGM1NzVmNWNiNmUzODVlN2E4NjYwMjAxMzhkMC4uLjkyYjIw
ZWFhNmI2ZGQyY2YzNDE4YTQyOGY5MDVkMTBiYmM2MjcyNGYgDQo+Pj4NCj4+Pg0KPj4gSXQgc2Vl
bXMgYSBwYXJ0IG9mIG11bHRpIGNoYW5uZWwgKDUuMSBjaCkgaGFzIGFscmVhZHkgYmVlbiBzdXBw
b3J0ZWQNCj4+IGJ5IHJvY2tjaGlwLWkycyBhbmQgZHctaGRtaS4gU28gSSBhcHBsaWVkIHRoaXMg
cGF0Y2ggYW5kIHRyaWVkIGJlbG93DQo+PiBjb21tYW5kLg0KPj4gIMKgIHNwZWFrZXItdGVzdCAt
RCBodzowLDAgLWYgNDgwMDAgLWMgNg0KPj4gSXQgZG9lcyBub3QgcmV0dXJuIGVycm9ycy4NCj4+
DQo+PiBXb3VsZCB5b3UgdGVsbCBtZSBtb3JlIGRldGFpbHMgeW91IHdvcnJpZWQgYWJvdXQgaWYg
c29tZXRoaW5nIHdyb25nPw0KPj4NCj4+DQo+PiBGWUk6IFJvY2s2NCBQQ00gZGV2aWNlcyBhcmUg
YXMgZm9sbG93cyBhZnRlciBhcHBsaWVkIHRoaXMgcGF0Y2guDQo+PiB+fn5+fg0KPj4gJCBjYXQg
L3Byb2MvYXNvdW5kL3BjbQ0KPj4gMDAtMDA6IGZmMDAwMDAwLmkycy1pMnMtaGlmaSBpMnMtaGlm
aS0wIDrCoCA6IHBsYXliYWNrIDENCj4+IDAwLTAxOiBmZjAxMDAwMC5pMnMtcmszMzI4LWhpZmkg
ZmY0MTAwMDAuY29kZWMtMSA6wqAgOiBwbGF5YmFjayAxIDogDQo+PiBjYXB0dXJlIDENCj4+IDAw
LTAyOiBmZjAzMDAwMC5zcGRpZi1kaXQtaGlmaSBkaXQtaGlmaS0yIDrCoCA6IHBsYXliYWNrIDEN
Cj4+IH5+fn5+DQo+Pg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gS2F0c3VoaXJvIFN1enVraQ0KPj4N
Cj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBKb25hcw0KPj4+DQo+Pj4+PiDCoMKgwqDCoMKgwqAgfTsN
Cj4+Pj4+IEBAIC0xNDEsNiArMTQyLDEyIEBADQo+Pj4+PiDCoMKgICZoZG1pIHsNCj4+Pj4+IMKg
wqDCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgIHBvcnRA
MCB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaGRtaV9wMF8wOiBlbmRwb2ludCB7DQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZW1vdGUtZW5kcG9pbnQgPSA8JmkyczBfcDBfMD47DQo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgfTsNCj4+Pj4+ICvCoMKgwqAgfTsNCj4+Pj4+IMKgwqAgfTsN
Cj4+Pj4+IMKgwqAgJmhkbWlwaHkgew0KPj4+Pj4gQEAgLTI1Niw2ICsyNjMsMTggQEANCj4+Pj4+
IMKgwqDCoMKgwqDCoCB9Ow0KPj4+Pj4gwqDCoCB9Ow0KPj4+Pj4gKyZpMnMwIHsNCj4+Pj4+ICvC
oMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoCBpMnMwX3AwOiBw
b3J0IHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpMnMwX3AwXzA6IGVuZHBvaW50IHsNCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhaS1mb3JtYXQgPSAiaTJzIjsNCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG1jbGstZnMgPSA8MjU2PjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaV9wMF8wPjsNCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCB9Ow0KPj4+Pj4gK8KgwqDCoCB9Ow0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiDC
oMKgICZpMnMxIHsNCj4+Pj4+IMKgwqDCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+Pj4+Pg0K
Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+
PiBMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QNCj4+Pj4gTGludXgtcm9ja2NoaXBAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXJvY2tjaGlwDQo+Pj4+DQo+Pj4NCj4+Pg0KPj4NCg0K
