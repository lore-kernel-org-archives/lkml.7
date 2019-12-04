Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F6C43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C77820684
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfLDEMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:12:03 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60847 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLDEMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:12:03 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB44BW9G012223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB44BW9G012223
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Dec 2019 12:11:32 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 4 Dec 2019 12:11:32 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Dec 2019 12:11:32 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::35ac:d9d0:1393:a902]) by
 RTEXMB03.realtek.com.tw ([fe80::35ac:d9d0:1393:a902%8]) with mapi id
 15.01.1779.005; Wed, 4 Dec 2019 12:11:32 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        =?utf-8?B?RWRnYXIgTGVlIFvmnY7mib/oq61d?= <cylee12@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: clock: add bindings for RTD1619 clocks
Thread-Topic: [PATCH 1/6] dt-bindings: clock: add bindings for RTD1619 clocks
Thread-Index: AQHVqbBpUIXp8SpLNkeT1cD+cHVMu6enn5cAgACGSxA=
Date:   Wed, 4 Dec 2019 04:11:31 +0000
Message-ID: <1130d9316ffb49c8a99b9b2c2d8fa90f@realtek.com>
References: <20191203074513.9416-1-james.tai@realtek.com>
 <20191203074513.9416-2-james.tai@realtek.com>
 <f069747b-7f10-f47c-684d-11138b8fd129@suse.de>
In-Reply-To: <f069747b-7f10-f47c-684d-11138b8fd129@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiBIaSBKYW1lcyBhbmQgQ2hlbmctWXUsDQo+IA0KPiBBbSAwMy4xMi4x
OSB1bSAwODo0NSBzY2hyaWViIEphbWVzIFRhaToNCj4gPiBGcm9tOiBjeWxlZTEyIDxjeWxlZTEy
QHJlYWx0ZWsuY29tPg0KPiANCj4gUGxlYXNlIGZpeCB0aGUgYXV0aG9yIChnaXQgY29tbWl0IC0t
YW1lbmQgLS1hdXRob3I9Ii4uLiIpIGFuZCB1c2UgYW4NCj4gYXBwcm9wcmlhdGUgZ2l0IGNvbmZp
ZyBzZXR0aW5nIChhbmQgY29tbXVuaWNhdGlvbiB0byB5b3VyIHRlYW0pIHRvIGF2b2lkIHRoaXMN
Cj4gcmVvY2N1cnJpbmcgZm9yIG5ldyBjb21taXRzIC0gYWxyZWFkeSBwb2ludGVkIG91dCB0byBK
YW1lcy4NCj4gDQo+IEJUVyBJIHdvbmRlciB3aHkgd2UgaGF2ZSBzbyBtYW55IHNlZW1pbmdseSB1
bnJlbGF0ZWQgcGVvcGxlIGluIENDDQo+IChNZWRpYXRlaywgUklTQy1WKSB0aGF0IHRoZSBwYXRj
aGVzIGFuZCByZXNwb25zZXMga2VlcCBoYW5naW5nIGluIG1haWxpbmcgbGlzdA0KPiBtb2RlcmF0
aW9uPw0KDQpJIHVzZWQgdGhlICJnZXRfbWFpbnRhaW5lci5wbCIgdG8gZmluZCB0aGUgZW1haWwg
YWRkcmVzcyBvZiBtYWludGFpbmVycy4gSG93ZXZlciwgDQpJJ20gc28gc29ycnkgZm9yIG1pc3Rh
a2VubHkgYWRkaW5nIHNvbWUgdW5yZWxhdGVkIHBlb3BsZSB0byB0aGlzIG1haWwuDQoNClJlZ2Fy
ZHMsDQpKYW1lcw0KDQoNCg==
