Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F068CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA2218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKDHxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:53:12 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:49102 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:53:12 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id D5F9162730B;
        Mon,  4 Nov 2019 08:53:09 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 08:53:09 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 08:53:09 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 07/11] ARM: dts: imx6ul-kontron-n6x1x-s: Add
 vbus-supply and overcurrent polarity to usb nodes
Thread-Topic: [PATCH v3 07/11] ARM: dts: imx6ul-kontron-n6x1x-s: Add
 vbus-supply and overcurrent polarity to usb nodes
Thread-Index: AQHVj/bjTjNmxCvGY0q8/rNxh/Ilvad6kygAgAAF8QA=
Date:   Mon, 4 Nov 2019 07:53:09 +0000
Message-ID: <77f6c71e-19ee-50c6-ecbd-c3547f0c4e84@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-8-frieder.schrempf@kontron.de>
 <20191104073151.GR24620@dragon>
In-Reply-To: <20191104073151.GR24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <F72F5A035670224B8CDC395912F26E6B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D5F9162730B.A0A47
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMTEuMTkgMDg6MzEsIFNoYXduIEd1byB3cm90ZToNCj4gT24gVGh1LCBPY3QgMzEsIDIw
MTkgYXQgMDI6MjQ6MjFQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEZyb206
IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBU
byBzaWxlbmNlIHRoZSB3YXJuaW5ncyBzaG93biBieSB0aGUgZHJpdmVyIGF0IGJvb3QgdGltZSwg
d2UgYWRkIGENCj4+IGZpeGVkIHJlZ3VsYXRvciBmb3IgdGhlIDVWIHN1cHBseSBvZiB1c2JvdGcy
IGFuZCBzcGVjaWZ5IHRoZSBwb2xhcml0eQ0KPj4gb2YgdGhlIG92ZXJjdXJyZW50IHNpZ25hbCBm
b3IgdXNib3RnMS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmll
ZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+PiBGaXhlczogMWVhNGI3NmNkZmRlICgiQVJNOiBk
dHM6IGlteDZ1bC1rb250cm9uLW42MzEwOiBBZGQgS29udHJvbiBpLk1YNlVMIE42MzEwIFNvTSBh
bmQgYm9hcmRzIikNCj4gDQo+IEkgZG8gbm90IHRoaW5rIGl0J3MgYSBidWcgZml4LCBzbyB0aGUg
Rml4ZXMgdGFnIGRvZXNuJ3QgcmVhbGx5IGFwcGx5Lg0KDQpJIGd1ZXNzIHlvdSdyZSByaWdodC4g
SXQgb25seSBwcmV2ZW50cyB3YXJuaW5ncyBhdCBib290IHRpbWUgYW5kIA0KZnVuY3Rpb25hbGl0
eSBpcyBub3QgYnJva2VuLiBJIHRoaW5rIEkgaGFkIGEgd3JvbmcgdW5kZXJzdGFuZGluZyBvZiB0
aGUgDQpGaXhlcyB0YWcgYW5kIG5lZWQgdG8gcmVyZWFkIHRoZSBkb2NzLi4uDQoNCj4gDQo+IFNo
YXduDQo+IA0KPj4gLS0tDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42
eDF4LXMuZHRzaSB8IDkgKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRy
b24tbjZ4MXgtcy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjZ4MXgt
cy5kdHNpDQo+PiBpbmRleCAyMjk5Y2FkOTAwYWYuLmQzZWIyMWFhOTAxNCAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42eDF4LXMuZHRzaQ0KPj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjZ4MXgtcy5kdHNpDQo+PiBAQCAt
NDUsNiArNDUsMTMgQEANCj4+ICAgCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAw
PjsNCj4+ICAgCX07DQo+PiAgIA0KPj4gKwlyZWdfNXY6IHJlZ3VsYXRvci01diB7DQo+PiArCQlj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+PiArCQlyZWd1bGF0b3ItbmFtZSA9ICI1
diI7DQo+PiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4+ICsJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPj4gKwl9Ow0KPj4gKw0KPj4gICAJ
cmVnX3VzYl9vdGcxX3ZidXM6IHJlZ3VsYXRvci11c2Itb3RnMS12YnVzIHsNCj4+ICAgCQljb21w
YXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+PiAgIAkJcmVndWxhdG9yLW5hbWUgPSAidXNi
X290ZzFfdmJ1cyI7DQo+PiBAQCAtMTkxLDYgKzE5OCw3IEBADQo+PiAgIAlzcnAtZGlzYWJsZTsN
Cj4+ICAgCWhucC1kaXNhYmxlOw0KPj4gICAJYWRwLWRpc2FibGU7DQo+PiArCW92ZXItY3VycmVu
dC1hY3RpdmUtbG93Ow0KPj4gICAJdmJ1cy1zdXBwbHkgPSA8JnJlZ191c2Jfb3RnMV92YnVzPjsN
Cj4+ICAgCXN0YXR1cyA9ICJva2F5IjsNCj4+ICAgfTsNCj4+IEBAIC0xOTgsNiArMjA2LDcgQEAN
Cj4+ICAgJnVzYm90ZzIgew0KPj4gICAJZHJfbW9kZSA9ICJob3N0IjsNCj4+ICAgCWRpc2FibGUt
b3Zlci1jdXJyZW50Ow0KPj4gKwl2YnVzLXN1cHBseSA9IDwmcmVnXzV2PjsNCj4+ICAgCXN0YXR1
cyA9ICJva2F5IjsNCj4+ICAgfTsNCj4+ICAgDQo+PiAtLSANCj4+IDIuMTcuMQ0KPiANCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbA0KPiA=
