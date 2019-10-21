Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02137CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A7B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJUMoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:44:24 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:59978 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:44:23 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 846D1626D74;
        Mon, 21 Oct 2019 14:44:20 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 21 Oct
 2019 14:44:20 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 21 Oct 2019 14:44:20 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Thread-Topic: [PATCH 01/10] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Thread-Index: AQHVhDNnN9aGUH4T40yWqnEyL2tHoqdkyomAgAAmC4A=
Date:   Mon, 21 Oct 2019 12:44:19 +0000
Message-ID: <89a91b79-63f9-2a2d-30aa-d4447f1cbc96@kontron.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-2-frieder.schrempf@kontron.de>
 <20191021102809.GA1934@pi3>
In-Reply-To: <20191021102809.GA1934@pi3>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BDBCE0E9AD58646A5A23F8D39BE465A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 846D1626D74.AF304
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

T24gMjEuMTAuMTkgMTI6MjgsIGtyemtAa2VybmVsLm9yZyB3cm90ZToNCj4gT24gV2VkLCBPY3Qg
MTYsIDIwMTkgYXQgMDM6MDc6MTlQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+
IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+
DQo+PiBUaGUgS29udHJvbiBONjMxMSBhbmQgTjY0MTEgU29NcyBhcmUgdmVyeSBzaW1pbGFyIHRv
IE42MzEwLiBJbg0KPj4gcHJlcGFyYXRpb24gdG8gYWRkIHN1cHBvcnQgZm9yIHRoZW0sIHdlIG1v
dmUgdGhlIGNvbW1vbiBub2RlcyB0byBhDQo+PiBzZXBhcmF0ZSBmaWxlIGlteDZ1bC1rb250cm9u
LW42eDF4LXNvbS1jb21tb24uZHRzaS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNj
aHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+PiAtLS0NCj4+ICAgLi4uL2Jv
b3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEwLXNvbS5kdHNpICAgIHwgIDk1ICstLS0tLS0tLS0t
LS0tDQo+PiAgIC4uLi9kdHMvaW14NnVsLWtvbnRyb24tbjZ4MXgtc29tLWNvbW1vbi5kdHNpICB8
IDEyMyArKysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjQgaW5zZXJ0
aW9ucygrKSwgOTQgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zb20tY29tbW9uLmR0c2kNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtc29tLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zb20uZHRzaQ0KPj4g
aW5kZXggYTg5NmIyMzQ4ZGQyLi40N2QzY2U1ZDI1NWYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zb20uZHRzaQ0KPj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtc29tLmR0c2kNCj4+IEBAIC02LDcgKzYs
NyBAQA0KPj4gICAgKi8NCj4+ICAgDQo+PiAgICNpbmNsdWRlICJpbXg2dWwuZHRzaSINCj4+IC0j
aW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArI2luY2x1ZGUgImlteDZ1bC1r
b250cm9uLW42eDF4LXNvbS1jb21tb24uZHRzaSINCj4+ICAgDQo+PiAgIC8gew0KPj4gICAJbW9k
ZWwgPSAiS29udHJvbiBONjMxMCBTT00iOw0KPj4gQEAgLTE4LDQ5ICsxOCw3IEBADQo+PiAgIAl9
Ow0KPj4gICB9Ow0KPj4gICANCj4+IC0mZWNzcGkyIHsNCj4+IC0JY3MtZ3Bpb3MgPSA8JmdwaW80
IDIyIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
Pj4gLQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZWNzcGkyPjsNCj4+IC0Jc3RhdHVzID0gIm9rYXki
Ow0KPj4gLQ0KPj4gLQlzcGktZmxhc2hAMCB7DQo+PiAtCQljb21wYXRpYmxlID0gIm14aWN5LG14
MjV2ODAzNWYiLCAiamVkZWMsc3BpLW5vciI7DQo+PiAtCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw1
MDAwMDAwMD47DQo+PiAtCQlyZWcgPSA8MD47DQo+PiAtCX07DQo+PiAtfTsNCj4+IC0NCj4+IC0m
ZmVjMSB7DQo+PiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiAtCXBpbmN0cmwtMCA9
IDwmcGluY3RybF9lbmV0MSAmcGluY3RybF9lbmV0MV9tZGlvPjsNCj4+IC0JcGh5LW1vZGUgPSAi
cm1paSI7DQo+PiAtCXBoeS1oYW5kbGUgPSA8JmV0aHBoeTE+Ow0KPj4gLQlzdGF0dXMgPSAib2th
eSI7DQo+PiAtDQo+PiAtCW1kaW8gew0KPj4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiAt
CQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4+IC0NCj4+IC0JCWV0aHBoeTE6IGV0aGVybmV0LXBoeUAx
IHsNCj4+IC0JCQlyZWcgPSA8MT47DQo+PiAtCQkJbWljcmVsLGxlZC1tb2RlID0gPDA+Ow0KPj4g
LQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2VUxfQ0xLX0VORVRfUkVGPjsNCj4+IC0JCQljbG9jay1u
YW1lcyA9ICJybWlpLXJlZiI7DQo+PiAtCQl9Ow0KPj4gLQl9Ow0KPj4gLX07DQo+PiAtDQo+PiAt
JmZlYzIgew0KPj4gLQlwaHktbW9kZSA9ICJybWlpIjsNCj4+IC0Jc3RhdHVzID0gImRpc2FibGVk
IjsNCj4+IC19Ow0KPj4gLQ0KPj4gICAmcXNwaSB7DQo+PiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+PiAtCXBpbmN0cmwtMCA9IDwmcGluY3RybF9xc3BpPjsNCj4+IC0Jc3RhdHVzID0g
Im9rYXkiOw0KPj4gLQ0KPj4gICAJc3BpLWZsYXNoQDAgew0KPiANCj4gWW91IGxlZnQgcXNwaSBh
bmQgZmxhc2ggcGFydGl0aW9ucyBoZXJlLCB3aGlsZSBhZGRpbmcgaXQgbGF0ZXIuIEl0IGlzDQo+
IG5vdCBwdXJlIG1vdmUgdGhlbiBhbmQgc29tZSBkdXBsaWNhdGVkIHN0dWZmIHJlbWFpbnMuDQoN
CkluZGVlZCwgdGhlIHNwaS1mbGFzaCBub2RlIGlzIGR1cGxpY2F0ZWQsIGFzIEkgZm9yZ290IHRv
IHJlbW92ZSBpdCBmcm9tIA0KdGhlIGNvbW1vbiBpbmNsdWRlIGZpbGUuIEkgd2lsbCBjaGFuZ2Ug
dGhhdC4=
