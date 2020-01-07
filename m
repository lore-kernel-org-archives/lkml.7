Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C789EC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B12073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAGJKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:10:47 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:42186 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:10:46 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 582A26060C8;
        Tue,  7 Jan 2020 10:10:38 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 7 Jan 2020
 10:10:37 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.005; Tue, 7 Jan 2020 10:10:37 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Michael Trimarchi <michael@amarulasolutions.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add UART1 UART1_DCE_RTS/CTS pin's mux
 option #4
Thread-Topic: [PATCH] arm64: dts: imx8mm: Add UART1 UART1_DCE_RTS/CTS pin's
 mux option #4
Thread-Index: AQHVwMFlJpnub1/s2UOtwCRRiYR06afe4l+A
Date:   Tue, 7 Jan 2020 09:10:37 +0000
Message-ID: <5d7cf7d5-7fd3-eafe-2443-cbf4f1eebcf9@kontron.de>
References: <20200101163438.1761-1-michael@amarulasolutions.com>
In-Reply-To: <20200101163438.1761-1-michael@amarulasolutions.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3C95FD2895E649AC01B8E1092E1A3A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 582A26060C8.AE413
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, kernel@pengutronix.de,
        linux-amarula@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWljaGFlbCwNCg0KT24gMDEuMDEuMjAgMTc6MzQsIE1pY2hhZWwgVHJpbWFyY2hpIHdy
b3RlOg0KPiBBY2NvcmRpbmcgdG8gaS5NWDhNTSByZWZlcmVuY2UgbWFudWFsIFJldi4yLCAwOC8y
MDE5LiBBY2NvcmRpbmcNCj4gdG8gdGhlIG1hbnVhbCB0aGUgdHdvIHBpbnMgaGFzIGFzc29jaWF0
ZWQgZGFpc3kgY2hhaW4gc28gaW5wdXQNCj4gcmVnaXN0ZXIgYW5kIGlucHV0IHZhbHVlIHNob3Vs
ZCBiZSBzZXQgdG9vDQoNCkkgaGF2ZSBzZW50IGEgcGF0Y2ggdGhhdCBjb3ZlcnMgdGhpcyBhbmQg
aXQgd2FzIGFscmVhZHkgYXBwbGllZCB0byANCmxpbnV4LW5leHQuIFNlZSBbMV0uDQoNCldoYXQg
Ym90aGVycyBtZSBpcyB0aGF0IHlvdSBoYXZlIGRpZmZlcmVudCB2YWx1ZXMgZm9yIA0KTVg4TU1f
SU9NVVhDX1NBSTJfVFhGU19VQVJUMV9EQ0VfQ1RTX0IuDQoNCkNvdWxkIHlvdSBkb3VibGUgY2hl
Y2sgdGhvc2UgdmFsdWVzIHRvIGZpbmQgb3V0IGlmIG15IHZlcnNpb24gb3IgeW91ciANCnZlcnNp
b24gaXMgY29ycmVjdD8gRGlkIHlvdSBhbHJlYWR5IHRlc3QgdGhlc2Ugc2V0dGluZ3Mgb24gcmVh
bCBoYXJkd2FyZSANCihJIGRpZG4ndCBzbyBmYXIpPw0KDQpUaGFua3MsDQpGcmllZGVyDQoNClsx
XTogDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0
L2xpbnV4LW5leHQuZ2l0L2NvbW1pdD9oPW5leHQtMjAyMDAxMDcmaWQ9MjcyOGM0YTEyNGExMGU5
Njg5MWU5Mzc0ODQ3MWY4ZTIzOThjMjY2Zg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4gLS0tDQo+ICAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBpbmZ1bmMuaCB8IDIgKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBpbmZ1bmMuaCBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waW5mdW5jLmgNCj4gaW5kZXggY2ZmYTg5OTE4ODBkLi42
MmQxNmIxZDdjNWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1waW5mdW5jLmgNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLXBpbmZ1bmMuaA0KPiBAQCAtNDM4LDEwICs0MzgsMTIgQEANCj4gICAjZGVmaW5lIE1Y
OE1NX0lPTVVYQ19TQUkyX1JYQ19TSU1fTV9IU0laRTEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgxQjQgMHg0MUMgMHgwMDAgMHg3IDB4MA0KPiAgICNkZWZpbmUgTVg4TU1fSU9N
VVhDX1NBSTJfUlhEMF9TQUkyX1JYX0RBVEEwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAweDFCOCAweDQyMCAweDAwMCAweDAgMHgwDQo+ICAgI2RlZmluZSBNWDhNTV9JT01VWENfU0FJ
Ml9SWEQwX1NBSTVfVFhfREFUQTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MUI4
IDB4NDIwIDB4MDAwIDB4MSAweDANCj4gKyNkZWZpbmUgTVg4TU1fSU9NVVhDX1NBSTJfUlhEMF9V
QVJUMV9EQ0VfUlRTX0IgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDFCOCAweDQyMCAw
eDRGMCAweDQgMHgyDQo+ICAgI2RlZmluZSBNWDhNTV9JT01VWENfU0FJMl9SWEQwX0dQSU80X0lP
MjMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MUI4IDB4NDIwIDB4MDAwIDB4
NSAweDANCj4gICAjZGVmaW5lIE1YOE1NX0lPTVVYQ19TQUkyX1JYRDBfU0lNX01fSFNJWkUyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgxQjggMHg0MjAgMHgwMDAgMHg3IDB4MA0K
PiAgICNkZWZpbmUgTVg4TU1fSU9NVVhDX1NBSTJfVFhGU19TQUkyX1RYX1NZTkMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAweDFCQyAweDQyNCAweDAwMCAweDAgMHgwDQo+ICAgI2Rl
ZmluZSBNWDhNTV9JT01VWENfU0FJMl9UWEZTX1NBSTVfVFhfREFUQTEgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDB4MUJDIDB4NDI0IDB4MDAwIDB4MSAweDANCj4gKyNkZWZpbmUgTVg4
TU1fSU9NVVhDX1NBSTJfVFhGU19VQVJUMV9EQ0VfQ1RTX0IgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDFCQyAweDQyNCAweDRGMCAweDQgMHgyDQo+ICAgI2RlZmluZSBNWDhNTV9JT01V
WENfU0FJMl9UWEZTX0dQSU80X0lPMjQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MUJDIDB4NDI0IDB4MDAwIDB4NSAweDANCj4gICAjZGVmaW5lIE1YOE1NX0lPTVVYQ19TQUky
X1RYRlNfU0lNX01fSFdSSVRFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgxQkMg
MHg0MjQgMHgwMDAgMHg3IDB4MA0KPiAgICNkZWZpbmUgTVg4TU1fSU9NVVhDX1NBSTJfVFhDX1NB
STJfVFhfQkNMSyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDFDMCAweDQyOCAw
eDAwMCAweDAgMHgwDQo+IA==
