Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B20C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6498A206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfHAJ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:28:42 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44982 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfHAJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:28:42 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 4533367A8D7;
        Thu,  1 Aug 2019 11:28:34 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 1 Aug 2019
 11:28:33 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 1 Aug 2019 11:28:33 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Thread-Topic: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Thread-Index: AQHVSEGkENWr6+HjfEGe5le+et6Jcabl2bqAgAALMwA=
Date:   Thu, 1 Aug 2019 09:28:33 +0000
Message-ID: <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
In-Reply-To: <20190801084827.m42ci3amo37hmesi@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <6902432E5480BF48B377D0BC2FB45B09@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4533367A8D7.AE7BB
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpPbiAwMS4wOC4xOSAxMDo0OCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDAxLCAyMDE5IGF0IDA4OjE4OjA1QU0gKzAwMDAsIFNjaHJlbXBmIEZyaWVk
ZXIgd3JvdGU6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+DQo+Pg0KPj4gSWYgQ09ORklHX0dQSU9MSUIgaXMgbm90IGVuYWJsZWQsIG1jdHJs
X2dwaW9faW5pdCgpIHdpbGwgcmV0dXJuDQo+PiAtRU5PU1lTIGFuZCBjYXVzZSB0aGUgcHJvYmlu
ZyBvZiB0aGUgaW14IFVBUlQgdG8gZmFpbC4gQXMgdGhlDQo+PiBHUElPcyBhcmUgb3B0aW9uYWws
IHdlIHNob3VsZCBjb250aW51ZSBwcm9iaW5nIGluIHRoaXMgY2FzZS4NCj4gDQo+IElzIHRoaXMg
cmVhbGx5IHN0aWxsIHRoZSBjYXNlPyBPbiB3aGljaCB2ZXJzaW9uIGRpZCB5b3UgaGl0IHRoaXMN
Cj4gcHJvYmxlbT8NCg0KWWVzLCBJIHRoaW5rIGl0IGlzLiBJIHVzZWQgdjUuMi41LCB0aGF0IGFs
cmVhZHkgaGFzIGQ5OTQ4MjY3M2Y5NS4NCg0KPiANCj4gSSB3b3VsZCBleHBlY3QgdGhhdCBpcyBn
b25lIHdpdGgNCj4gZDk5NDgyNjczZjk1MDgxN2IzMGNhZjNmY2RmYjMxMTc5YjA1MGNlMSBpZiBu
b3QgZWFybGllci4NCg0KSSB0aGluayB0aGlzIGlzIGEgZGlmZmVyZW50IHByb2JsZW0uIElmIENP
TkZJR19HUElPTElCIGlzIGRpc2FibGVkLCANCm1jdHJsX2dwaW9faW5pdCgpIHJldHVybnMgLUVO
T1NZUyB1bmNvbmRpdGlvbmFsbHkgaGVyZTogWzFdLiBUaGUgDQpleGlzdGluZyBwYXRjaCAoZDk5
NDgyNjczZjk1KSBzZWVtcyB0byBoYW5kbGUgdGhlIGNhc2Ugd2hlbiANCkNPTkZJR19HUElPTElC
IGlzIGVuYWJsZWQsIGJ1dCBubyBvciBub3QgYWxsIEdQSU9zIGFyZSBnaXZlbiBpbiB0aGUgZHRi
Lg0KDQpUaGUgc2gtc2NpLmMgZHJpdmVyIGhhcyBhIHNpbWlsYXIgY2hlY2sgdG8gc2tpcCB0aGlz
IGNhc2U6IFsyXS4NCg0KUmVnYXJkcywNCkZyaWVkZXINCg0KWzFdIA0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9tY3RybF9ncGlvLmgjbjEyMQ0KWzJdIA0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvZHJpdmVycy90dHkvc2VyaWFsL3NoLXNjaS5jI24zMjkw
