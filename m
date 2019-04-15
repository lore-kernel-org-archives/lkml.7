Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2628A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfDOT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:58:15 -0400
Received: from mail-eopbgr760093.outbound.protection.outlook.com ([40.107.76.93]:33793
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728548AbfDOT6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:58:15 -0400
Received: from CO2PR01MB2168.prod.exchangelabs.com (10.166.200.9) by
 CO2PR01MB2008.prod.exchangelabs.com (10.166.90.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 19:58:09 +0000
Received: from CO2PR01MB2168.prod.exchangelabs.com
 ([fe80::f12d:c6a7:1b65:a199]) by CO2PR01MB2168.prod.exchangelabs.com
 ([fe80::f12d:c6a7:1b65:a199%4]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 19:58:09 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Thread-Topic: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Thread-Index: AQHU88FusCfPFHtDSUOfLafK2JkH0qY9nThggAADYoCAAAD/kA==
Date:   Mon, 15 Apr 2019 19:58:09 +0000
Message-ID: <CO2PR01MB2168426AD665DC2C8DAA1040D02B0@CO2PR01MB2168.prod.exchangelabs.com>
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415192734.935387-2-arnd@arndb.de>
 <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
 <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=HartleyS@visionengravers.com; 
x-originating-ip: [63.230.248.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19116ec6-e98c-4159-d18d-08d6c1dcaf15
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600140)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:CO2PR01MB2008;
x-ms-traffictypediagnostic: CO2PR01MB2008:
x-microsoft-antispam-prvs: <CO2PR01MB20087B8E6C3378039972BDF1D02B0@CO2PR01MB2008.prod.exchangelabs.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(39840400004)(376002)(189003)(199004)(71190400001)(55016002)(71200400001)(52536014)(25786009)(80792005)(26005)(93886005)(6116002)(9686003)(3846002)(102836004)(186003)(2906002)(74316002)(5660300002)(33656002)(6436002)(97736004)(72206003)(229853002)(7696005)(7736002)(54906003)(14454004)(316002)(66066001)(99286004)(11346002)(476003)(305945005)(8676002)(76176011)(81166006)(446003)(81156014)(6506007)(68736007)(486006)(6246003)(106356001)(105586002)(256004)(4326008)(86362001)(6916009)(53936002)(53546011)(508600001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR01MB2008;H:CO2PR01MB2168.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: visionengravers.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m6pEkoSjpodbYmgYfe8hkOxQfT3yJRlIBx3d9nky2PqRBzeotVeEnkOCjy7yjIdmH9O1feHOkL8h9Hpaz3LniFdQm/9HI1t4tGY+E2OHcspaHUYWOH8Io+z/p66U2YQQIQsYR+YGXoWQv7CqZyHVxuO3/faw34nMlVuoQOMhDWGdYUdkvM/f+Cj0Qi9e2LwcycXLMp5F0yzyLT/OkX4tvHtaPKtHfLwexQRe4aw1kU0jBL2T6Ga5g2v77cQz+rQ2NOUUfJ9FFNLPF48PyC1BrGIfsDm7CheInvwZjlWAN9kRb8yEdxA5jl68TySffAcRuJRXjJWo0TxByGGo2kYhzrmsenj0sFj3/izNDVNZ2z8GtWgHPnscCzlKIh1Iq9wb3jv2yr1ya6KtGM6pvkDL57ytLB9NHNGpsXzj8bm/QI0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19116ec6-e98c-4159-d18d-08d6c1dcaf15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 19:58:09.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5LCBBcHJpbCAxNSwgMjAxOSAxMjo0NyBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToN
Cj4gT24gTW9uLCBBcHIgMTUsIDIwMTkgYXQgOTozOSBQTSBIYXJ0bGV5IFN3ZWV0ZW4gPEhhcnRs
ZXlTQHZpc2lvbmVuZ3JhdmVycy5jb20+IHdyb3RlOg0KPj4+IC0jZGVmaW5lIEVQOTNYWF9LRVlQ
QURfS0RJViAgICAgICAgICAgKDE8PDQpICAvKiAxLzQgY2xvY2sgb3IgMS8xNiBjbG9jayAqLw0K
Pj4+IC0jZGVmaW5lIEVQOTNYWF9LRVlQQURfQVVUT1JFUEVBVCAgICAgKDE8PDUpICAvKiBlbmFi
bGUga2V5IGF1dG9yZXBlYXQgKi8NCj4+PiArI2RlZmluZSBFUDkzWFhfS0VZUEFEX0FVVE9SRVBF
QVQgICAgICgxPDw0KSAgLyogZW5hYmxlIGtleSBhdXRvcmVwZWF0ICovDQo+Pg0KPj4gWW91IGhh
dmUgcmUtZGVmaW5lZCB0aGUga2V5cGFkIHJlZ2lzdGVyIGJpdHMgaGVyZS4NCj4+DQo+PiBUaGUg
S0RJViBiaXQgY2hhbmdlcyB0aGUgY2xvY2sgcmF0ZS4gVGhlIEFVVE9SRVBFQVQgYml0IGVuYWJs
ZXMga2V5IGF1dG9yZXBlYXQuDQo+DQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGV5IGFyZSBu
b3QgcmVnaXN0ZXIgYml0cywganVzdCBzb2Z0d2FyZSBmbGFncyBmb3IgY29tbXVuaWNhdGluZyBi
ZXR3ZWVuIGENCj4gYm9hcmQgZmlsZSBhbmQgdGhlIGRyaXZlciwgc28gSSBhc3N1bWVkIEkgY291
bGQgZnJlZWx5IHJlb3JnYW5pemUgdGhlbS4NCj4NCj4gRGlkIEkgbWlzcyBzb21ldGhpbmc/DQoN
ClVnaC4uIEl0J3MgYmVlbiBxdWl0ZSBhIHdoaWxlIHNpbmNlIEkgbG9va2VkIGF0IHRoYXQgY29k
ZS4uLg0KDQpZb3VyIGNvcnJlY3QsIHRoZXNlIGFyZSBqdXN0IGZsYWdzIHRvIHRoZSBkcml2ZXIu
DQoNClRoZSBLZXlTY2FuSW5pdCByZWdpc3RlciBkb2VzIGhhdmUgc29tZSBiaXRzIHRoYXQgdGhl
c2UgZmxhZ3MgZWZmZWN0IGJ1dCB0aGUgZHJpdmVyIGRlYWxzDQp3aXRoIHRoZW0uDQoNCkkgaGF2
ZSBiZWVuIGJ1cmllZCB1cGRhdGluZyBhbiBvbGQgUG93ZXJQQyBoYXJkd2FyZS9zb2Z0d2FyZSBk
ZXNpZ24gYW5kIGhhdmVuJ3QgbG9va2VkDQphdCB0aGUgRVA5M3h4IGxhdGVseS4gTXkgRVA5MzA3
IGJvYXJkIGRvZXMgaGF2ZSB0aGUga2V5cGFkIGludGVyZmFjZS4gSG9wZWZ1bGx5IEkgd2lsbCBn
ZXQNCnNvbWUgdGltZSB0byBjaGVjayB0aGUgbGF0ZXN0IG1haW5saW5lIG9uIGl0IHNvbWV0aW1l
IHNvb24uDQoNCk92ZXJhbGwgdGhlc2UgcGF0Y2hlcyBsb29rIGdvb2QuIFNvLCBmb3IgdGhlIHNl
cmllcy4uLg0KDQpBY2tlZC1ieTogSCBIYXJ0bGV5IFN3ZWV0ZW4gPGhzd2VldGVuQHZpc2lvbmVu
Z3JhdmVycy5jb20+DQoNCg==
