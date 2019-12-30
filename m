Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DDC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93002464B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfL3Fx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:53:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52488 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfL3Fx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:53:57 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBU5rJ3X019983, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBU5rJ3X019983
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Dec 2019 13:53:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 30 Dec 2019 13:53:19 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 13:53:18 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Mon, 30 Dec 2019 13:53:18 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 04/14] arm64: dts: realtek: rtd16xx: Introduce iso and misc syscon
Thread-Topic: [PATCH 04/14] arm64: dts: realtek: rtd16xx: Introduce iso and
 misc syscon
Thread-Index: AQHVqT1uQqwPTFDEQkWFr30YR8TW7qfSV49w
Date:   Mon, 30 Dec 2019 05:53:18 +0000
Message-ID: <863ffd39a45848ad9743ce854425b77c@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-5-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-5-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBHcm91cCBVQVJUMCBpbnRvIGFuIElzb2xhdGlvbiBzeXNjb24gbWZkIG5vZGUuDQo+IEdyb3Vw
IFVBUlQxIGFuZCBVQVJUMiBpbnRvIGEgTWlzY2VsbGFuZW91cyBzeXNjb24gbWZkIG5vZGUuDQo+
IA0KPiBDYzogSmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRlay5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4NCj4gLS0tDQo+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpIHwgNzANCj4gKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAy
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
YWx0ZWsvcnRkMTZ4eC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2
eHguZHRzaQ0KPiBpbmRleCA2OWNjMGQ5NDFjOGQuLjhmOGYyYjMyOGNkMSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaQ0KPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpDQo+IEBAIC0xMTgsMzQgKzExOCwy
MiBAQA0KPiAgCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQlyYW5nZXMgPSA8MHgwIDB4OTgw
MDAwMDAgMHgyMDAwMDA+Ow0KPiANCj4gLQkJCXVhcnQwOiBzZXJpYWwwQDc4MDAgew0KPiAtCQkJ
CWNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7DQo+IC0JCQkJcmVnID0gPDB4NzgwMCAw
eDQwMD47DQo+IC0JCQkJcmVnLXNoaWZ0ID0gPDI+Ow0KPiArCQkJaXNvOiBzeXNjb25ANzAwMCB7
DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ICsJCQkJcmVn
ID0gPDB4NzAwMCAweDEwMDA+Ow0KPiAgCQkJCXJlZy1pby13aWR0aCA9IDw0PjsNCj4gLQkJCQlp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgNjggSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+IC0JCQkJY2xv
Y2stZnJlcXVlbmN5ID0gPDI3MDAwMDAwPjsNCj4gLQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0K
PiArCQkJCXJhbmdlcyA9IDwweDAgMHg3MDAwIDB4MTAwMD47DQo+ICAJCQl9Ow0KPiANCj4gLQkJ
CXVhcnQxOiBzZXJpYWwxQDFiMjAwIHsNCj4gLQkJCQljb21wYXRpYmxlID0gInNucHMsZHctYXBi
LXVhcnQiOw0KPiAtCQkJCXJlZyA9IDwweDFiMjAwIDB4NDAwPjsNCj4gLQkJCQlyZWctc2hpZnQg
PSA8Mj47DQo+ICsJCQltaXNjOiBzeXNjb25AMWIwMDAgew0KPiArCQkJCWNvbXBhdGlibGUgPSAi
c3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPiArCQkJCXJlZyA9IDwweDFiMDAwIDB4MTAwMD47DQo+
ICAJCQkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiAtCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4
OSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gLQkJCQljbG9jay1mcmVxdWVuY3kgPSA8NDMyMDAw
MDAwPjsNCj4gLQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAtCQkJfTsNCj4gLQ0KPiAtCQkJ
dWFydDI6IHNlcmlhbDJAMWI0MDAgew0KPiAtCQkJCWNvbXBhdGlibGUgPSAic25wcyxkdy1hcGIt
dWFydCI7DQo+IC0JCQkJcmVnID0gPDB4MWI0MDAgMHg0MDA+Ow0KPiAtCQkJCXJlZy1zaGlmdCA9
IDwyPjsNCj4gLQkJCQlyZWctaW8td2lkdGggPSA8ND47DQo+IC0JCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDkwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAtCQkJCWNsb2NrLWZyZXF1ZW5jeSA9
IDw0MzIwMDAwMDA+Ow0KPiAtCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQkJcmFuZ2Vz
ID0gPDB4MCAweDFiMDAwIDB4MTAwMD47DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiANCj4gQEAgLTE1
OSwzICsxNDcsMzcgQEANCj4gIAkJfTsNCj4gIAl9Ow0KPiAgfTsNCj4gKw0KPiArJmlzbyB7DQo+
ICsJdWFydDA6IHNlcmlhbDBAODAwIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJzbnBzLGR3LWFwYi11
YXJ0IjsNCj4gKwkJcmVnID0gPDB4ODAwIDB4NDAwPjsNCj4gKwkJcmVnLXNoaWZ0ID0gPDI+Ow0K
PiArCQlyZWctaW8td2lkdGggPSA8ND47DQo+ICsJCWludGVycnVwdHMgPSA8R0lDX1NQSSA2OCBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKwkJY2xvY2stZnJlcXVlbmN5ID0gPDI3MDAwMDAwPjsN
Cj4gKwkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJm1pc2Mg
ew0KPiArCXVhcnQxOiBzZXJpYWwxQDIwMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAic25wcyxkdy1h
cGItdWFydCI7DQo+ICsJCXJlZyA9IDwweDIwMCAweDQwMD47DQo+ICsJCXJlZy1zaGlmdCA9IDwy
PjsNCj4gKwkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
ODkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MzIwMDAw
MDA+Ow0KPiArCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCX07DQo+ICsNCj4gKwl1YXJ0Mjog
c2VyaWFsMkA0MDAgew0KPiArCQljb21wYXRpYmxlID0gInNucHMsZHctYXBiLXVhcnQiOw0KPiAr
CQlyZWcgPSA8MHg0MDAgMHg0MDA+Ow0KPiArCQlyZWctc2hpZnQgPSA8Mj47DQo+ICsJCXJlZy1p
by13aWR0aCA9IDw0PjsNCj4gKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDkwIElSUV9UWVBFX0xF
VkVMX0hJR0g+Ow0KPiArCQljbG9jay1mcmVxdWVuY3kgPSA8NDMyMDAwMDAwPjsNCj4gKwkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gKwl9Ow0KPiArfTsNCj4gLS0NCj4gMi4xNi40DQo+IA0KPiAN
CkFja2VkLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCg==
