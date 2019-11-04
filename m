Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA8CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE1222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfKDIQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:16:27 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:57278 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:16:27 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 3561D600391;
        Mon,  4 Nov 2019 09:16:24 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 09:16:23 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 09:16:23 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] MAINTAINERS: Add an entry for Kontron
 Electronics ARM board support
Thread-Topic: [PATCH v3 11/11] MAINTAINERS: Add an entry for Kontron
 Electronics ARM board support
Thread-Index: AQHVj/bq00l6FB82qEKQsJ90JRSWJad6lucAgAAIsYA=
Date:   Mon, 4 Nov 2019 08:16:23 +0000
Message-ID: <78b7f1e9-5c21-9829-07b9-9746991e56db@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-12-frieder.schrempf@kontron.de>
 <20191104074514.GU24620@dragon>
In-Reply-To: <20191104074514.GU24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <923E8A050600B14F89B6675F9074D87F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 3561D600391.ABEC6
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

T24gMDQuMTEuMTkgMDg6NDUsIFNoYXduIEd1byB3cm90ZToNCj4gT24gVGh1LCBPY3QgMzEsIDIw
MTkgYXQgMDI6MjQ6MzRQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEZyb206
IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBL
b250cm9uIEVsZWN0cm9uaWNzIEdtYkggcHJvZHVjZXMgc2V2ZXJhbCBBUk0gYm9hcmRzLCB0aGF0
IGFyZQ0KPj4gcGxhbm5lZCB0byBiZSB1cHN0cmVhbWVkIGV2ZW50dWFsbHkuIEZvciBub3cgd2Ug
aGF2ZSBzb21lDQo+PiBpLk1YNlVML1VMTCBiYXNlZCBTb01zIGFuZCBib2FyZHMsIHRoYXQgYXJl
IGFscmVhZHkgYXZhaWxhYmxlDQo+PiBpbiB0aGUga2VybmVsLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+
IFdlIHVzdWFsbHkgZG8gbm90IG5lZWQgTUFJTlRBSU5FUlMgZW50cnkgZm9yIGluZGl2aWR1YWwg
RFRTIGZpbGVzLg0KDQpPaywgSSBqdXN0IHRob3VnaHQgaXQgd291bGQgYmUgbmljZSBmb3IgdGhp
bmdzIGxpa2UgZ2V0X21haW50YWluZXIucGwsIA0KdG8gbWFrZSBzdXJlIEkgcmVjZWl2ZSBub3Rp
ZmljYXRpb25zLCB3aGVuIHNvbWVvbmUgc2VuZHMgcGF0Y2hlcyBmb3IgDQp0aGVzZXMgRFRTIGZp
bGVzLiBCdXQgaWYgdGhpcyBpcyBhZ2FpbnN0IHRoZSB1c3VhbCBjb252ZW50aW9ucywgSSB3aWxs
IA0KZHJvcCB0aGlzLg0KDQo+IA0KPiBTaGF3bg0KPiANCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVS
UyB8IDYgKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggMjk2ZGUy
YjUxYzgzLi5hNDYxZDMxZWU5OGQgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4gKysr
IGIvTUFJTlRBSU5FUlMNCj4+IEBAIC05MTAzLDYgKzkxMDMsMTIgQEAgRjoJaW5jbHVkZS9saW51
eC9rbW9kLmgNCj4+ICAgRjoJbGliL3Rlc3Rfa21vZC5jDQo+PiAgIEY6CXRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2ttb2QvDQo+PiAgIA0KPj4gK0tPTlRST04gRUxFQ1RST05JQ1MgQVJNIEJPQVJE
UyBTVVBQT1JUDQo+PiArTToJRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPj4gK1M6CU1haW50YWluZWQNCj4+ICtGOglhcmNoL2FybS9ib290L2R0cy9pbXg2
dWwta29udHJvbi0qDQo+PiArRjoJYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1rb250cm9uLSoN
Cj4+ICsNCj4+ICAgS1BST0JFUw0KPj4gICBNOglOYXZlZW4gTi4gUmFvIDxuYXZlZW4ubi5yYW9A
bGludXguaWJtLmNvbT4NCj4+ICAgTToJQW5pbCBTIEtlc2hhdmFtdXJ0aHkgPGFuaWwucy5rZXNo
YXZhbXVydGh5QGludGVsLmNvbT4NCj4+IC0tIA0KPj4gMi4xNy4x
