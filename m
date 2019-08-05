Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD42C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CB620B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfHEJBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:01:42 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:56060 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:01:42 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id CCC1167A8D1;
        Mon,  5 Aug 2019 11:01:39 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 5 Aug 2019
 11:01:39 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 5 Aug 2019 11:01:39 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Thread-Topic: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Thread-Index: AQHVSRmhj6XM1Buz9UqFmvYk2hHNCKbno2OAgASBqgA=
Date:   Mon, 5 Aug 2019 09:01:39 +0000
Message-ID: <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
In-Reply-To: <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF108CA9207A10409A058A7C2410B1EC@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: CCC1167A8D1.A25F7
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDguMTkgMTQ6MTIsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBGcmksIEF1
ZyAwMiwgMjAxOSBhdCAxMDowNDoxMEFNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4NCj4+IEFzIGl0IGlzIGFsbG93ZWQgdG8gdXNlIHRoZSBtY3RybF9ncGlvXyogZnVuY3Rpb25z
IGJlZm9yZQ0KPj4gaW5pdGlhbGl6YXRpb24gKGFzIHRoZSA4MjUwIGRyaXZlciBkb2VzIGFjY29y
ZGluZyB0byA0MzRiZTBhZTdhYTcpLA0KPiANCj4gQWN0dWFsbHkgSSB3YXMgc3VycHJpc2VkIHNv
bWUgdGltZSBhZ28gdGhhdCA4MjUwIHVzZWQgc2VyaWFsX21jdHJsDQo+IHdpdGhvdXQgZmlyc3Qg
aW5pdGlhbGl6aW5nIGl0IGFuZCBleHBlY3RpbmcgaXQgdG8gd29yay4gSSBkaWRuJ3QgbG9vayBp
bg0KPiBkZXRhaWwsIGJ1dCBJIHdvdWxkbid0IGdvIHNvIGZhciB0byBjYWxsIHRoaXMgImFsbG93
ZWQiLiBUaGUgY29tbWl0DQo+IGl0c2VsZiBjYWxscyBpdCAid29ya2Fyb3VuZCIgd2hpY2ggc2Vl
bXMgYSBiZXR0ZXIgbWF0Y2guDQoNCk9rLCBidXQgaWYgdGhpcyBpcyBjb25zaWRlcmVkIHRvIGJl
IGEgd29ya2Fyb3VuZCBhbmQgYXMgdGhlIDgyNTAgZHJpdmVyIA0KZG9lcyBub3QgdXNlIG1jdHJs
X2dwaW9fdG9fZ3Bpb2QoKSwgd2Ugc2hvdWxkIG1heWJlIGp1c3QgZHJvcCB0aGlzIHBhdGNoIA0K
aW5zdGVhZCBvZiBlbmNvdXJhZ2luZyBvdGhlcnMgdG8gdXNlIG1jdHJsX2dwaW8gYmVmb3JlIGlu
aXRpYWxpemF0aW9uLg0KDQpJJ20gcmVhbGx5IG5vdCBzdXJlIHdoYXQncyBiZXN0LCBzbyBkZXBl
bmRpbmcgb24gd2hhdCB5b3Ugd2lsbCBwcm9wb3NlLCANCkknbGwgc2VuZCBhIG5ldyB2ZXJzaW9u
IG9mIHRoaXMgcGF0Y2ggd2l0aCBhZGp1c3RlZCBjb21taXQgbWVzc2FnZSBvciBub3QuDQoNCkJ5
IHRoZSB3YXksIFV3ZSBhbmQgRmFiaW86IFRoYW5rcyBmb3IgeW91ciByZXZpZXdzIQ0KDQo+IA0K
Pj4gaXQgc2VlbXMgYXBwcm9wcmlhdGUgdG8gaGF2ZSBhIE5VTEwgY2hlY2sgaW4gYWxsIG9mIHRo
ZSBmdW5jdGlvbnMuDQo+PiBPdGhlcndpc2UgdGhlIG1jdHJsX2dwaW9fdG9fZ3Bpb2QoKSBmdW5j
dGlvbiBpcyBwcm9uZSB0byBiZSB1c2VkDQo+PiBpbiBhIGNvbnRleHQgdGhhdCBjYW4gbGVhZCB0
byBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmll
ZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+IA0KPiBCZXN0IHJl
Z2FyZHMNCj4gVXdlDQo+IA==
