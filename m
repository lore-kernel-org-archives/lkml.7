Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04447C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9592173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F2/DBW/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:47:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5718 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfLFJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:47:02 -0500
X-UUID: 9fce05fdf67f4188b96202d363922662-20191206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MfhpXxQ/w8N8yiPedpLQHV2EbmNpCMaSyfPIvtu8lKM=;
        b=F2/DBW/mJz8GO7w2fjose7XQzSkwHsPEOpzZ2abFVajeFFPXZDz1eyukhgr0QrLRAcRaEA5ONIWIDxWKKZvLEes0aYb5W71IdHqX9LcF3w4C+H5pc9ho/hs429eM4E7qPd75R10kh37J8+vMB4Yc6xpvlJk/1tplzqFe/LaWb5o=;
X-UUID: 9fce05fdf67f4188b96202d363922662-20191206
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1365662087; Fri, 06 Dec 2019 17:46:57 +0800
Received: from mtkmbs05n1.mediatek.inc (172.21.101.15) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Dec 2019 17:46:39 +0800
Received: from mtkmbs05n1.mediatek.inc ([fe80::a928:1166:13d9:ca99]) by
 mtkmbs05n1.mediatek.inc ([fe80::a928:1166:13d9:ca99%18]) with mapi id
 15.00.1395.000; Fri, 6 Dec 2019 17:46:38 +0800
From:   =?utf-8?B?TWljaGFlbCBLYW8gKOmrmOaMr+e/lCk=?= 
        <Michael.Kao@mediatek.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v2 1/8] arm64: dts: mt8183: add thermal zone node
Thread-Topic: [PATCH v2 1/8] arm64: dts: mt8183: add thermal zone node
Thread-Index: AQHVBzQSKfKREsG5ZkOZOYh5RCMLhqaCzPwAgACiUYCBKrUzcA==
Date:   Fri, 6 Dec 2019 09:46:38 +0000
Message-ID: <54a1684466364c7496218705b3c26581@mtkmbs05n1.mediatek.inc>
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
 <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
 <CAJMQK-giJTeERnqjxoSMjF-JXxW9SPmeARWf3f9ZyRgBsYN5fg@mail.gmail.com>
 <20190530160825.GM40515@google.com>
In-Reply-To: <20190530160825.GM40515@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTU2OThcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02YmNiMGYyYi0xODBkLTExZWEtYjVmYy03MDIwODQwMjg2YzBcYW1lLXRlc3RcNmJjYjBmMmQtMTgwZC0xMWVhLWI1ZmMtNzAyMDg0MDI4NmMwYm9keS50eHQiIHN6PSIyNzMwIiB0PSIxMzIyMDA5OTI1MjA0NzgyNjAiIGg9IlhNQi90VmlsS3JUbTZJR210ek1ZSW9wQmxFMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: =?utf-8?B?5IyA5r2s5pWz5LWJ5p2z5pWT542z5r2p5IGuNA==?=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXR0aGlhcyBLYWVobGNrZSBb
bWFpbHRvOm1rYUBjaHJvbWl1bS5vcmddIA0KU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgMTI6
MDggQU0NClRvOiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQpDYzogTWljaGFl
bCBLYW8gKOmrmOaMr+e/lCkgPE1pY2hhZWwuS2FvQG1lZGlhdGVrLmNvbT47IFpoYW5nIFJ1aSA8
cnVpLnpoYW5nQGludGVsLmNvbT47IEVkdWFyZG8gVmFsZW50aW4gPGVkdWJlenZhbEBnbWFpbC5j
b20+OyBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPjsgTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxrbWwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElN
WCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc+OyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDEvOF0gYXJtNjQ6IGR0czogbXQ4MTgzOiBhZGQgdGhlcm1hbCB6b25lIG5vZGUN
Cg0KT24gVGh1LCBNYXkgMzAsIDIwMTkgYXQgMDI6Mjc6MjhQTSArMDgwMCwgSHNpbi1ZaSBXYW5n
IHdyb3RlOg0KPiBPbiBGcmksIE1heSAxMCwgMjAxOSBhdCA5OjI3IFBNIG1pY2hhZWwua2FvIDxt
aWNoYWVsLmthb0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgdHp0czE6IHR6dHMxIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwwPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXkgPSA8MD47DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0aGVybWFsLXNlbnNvcnMgPSA8JnRoZXJtYWwgMT47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdXN0YWluYWJsZS1wb3dlciA9IDwwPjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRyaXBzIHt9Ow0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29vbGluZy1tYXBzIHt9Ow0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiBJcyAwIGEgdmFsaWQgaW5pdGlhbCBzdXN0YWlu
YWJsZS1wb3dlciBzZXR0aW5nPyBTaW5jZSB3ZSdsbCBzdGlsbCBnZXQgDQo+IHdhcm5pbmdbMV0g
YWJvdXQgdGhpcywgdGhvdWdoIGl0IG1pZ2h0IG5vdCBiZSBoYXJtZnVsLg0KPiANCj4gSWYgMCBp
cyBhIHZhbGlkIHNldHRpbmcsIG1heWJlIHdlIHNob3VsZCBjb25zaWRlciBzaG93aW5nIHRoZSB3
YXJuaW5nIA0KPiBvZiBub3Qgc2V0dGluZyB0aGlzIHByb3BlcnR5IGluIFsyXT8NCj4gDQo+IFsx
XSANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2
ZXJzL3RoZXJtYWwvcG93ZXJfYQ0KPiBsbG9jYXRvci5jI0w1NzAgWzJdIA0KPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvdGhlcm1hbC9vZi10
aGVyDQo+IG1hbC5jI0wxMDQ5DQoNCklJVUMgYSB2YWx1ZSBvZiAwIGlzIHBvaW50bGVzcywgdGhl
IHRoZXJtYWwgZnJhbWV3b3JrIHdpbGwgc3RpbGwgdXNlIGFuIGVzdGltYXRlZCB2YWx1ZToNCg0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMS41L3NvdXJjZS9kcml2ZXJzL3Ro
ZXJtYWwvcG93ZXJfYWxsb2NhdG9yLmMjTDIwMw0KDQpBcyBjb21tZW50ZWQgb24gdjEgKGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5MjY1MTkvIzIyNjIwOTA1KQ0KdGhlIHZh
bHVlIG9mIHRoZSBwcm9wZXJ0eSBtYXkgZGVwZW5kIG9uIHRoZSB0aGVybWFsIGNoYXJhY3Rlcmlz
dGljcyBvZiB0aGUgZGV2aWNlLCB0aGVyZSBpcyBub3Qgb25lIGNvcnJlY3QgdmFsdWUgcGVyIFNv
Qy9jb3JlLiBJZiBpdCBpcyBzcGVjaWZpZWQgYXQgU29DIGxldmVsIGRldmljZSBtYWtlcnMgc2hv
dWxkIGJlIGF3YXJlIHRoYXQgdGhleSBtaWdodCBoYXZlIHRvIG92ZXJyaWRlIGl0IGZvciAnb3B0
aW1hbCcgYmVoYXZpb3Igb24gdGhlaXIgZGV2aWNlLg0KDQpJIHRoaW5rIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gc2V0IHN1c3RhaW5hYmxlLXBvd2VyIGZvciB0enRzMX42Lg0KVGhleSBkb24ndCBiaW5k
IHRoZXJtYWwgaW5zdGFuY2UgYW5kIHdpbGwgbm90IHRoZXJtYWwgdGhyb3R0bGUuDQpTbyBpdCB3
aWxsIGJlIGFsc28gemVybyBpZiB3ZSBkb24ndCBzZXQgc3VzdGFpbmFibGUtcG93ZXIgYW5kIGxl
dCBpdCB1c2UgZXN0aW1hdGUgdmFsdWUuDQpGb3IgdGhlIHB1cnBvc2Ugb2YgcHJldmVudGluZyB3
YXJuaW5nLCBJIHRoaW5rIEkgY2FuIHNldCBzdXN0YWluYWJsZS1wb3dlciBvZiB0enRzMX42IHRo
ZSBzYW1lIHRvIGNwdV90aGVybWFsLg0K
