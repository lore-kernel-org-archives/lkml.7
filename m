Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC11720730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfL3OqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:46:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59630 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3OqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:46:11 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBUEjtwA017410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBUEjtwA017410
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:45:55 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 30 Dec 2019 22:45:55 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:45:55 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Mon, 30 Dec 2019 22:45:55 +0800
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
Subject: RE: [PATCH 12/14] arm64: dts: realtek: rtd139x: Add SB2 and SCPU Wrapper syscon nodes
Thread-Topic: [PATCH 12/14] arm64: dts: realtek: rtd139x: Add SB2 and SCPU
 Wrapper syscon nodes
Thread-Index: AQHVqT1wXKs+1M+tZkKZ/lA6DuQFQ6fS7Rdg
Date:   Mon, 30 Dec 2019 14:45:55 +0000
Message-ID: <5578fd50918b4b0ca05b3d1f706d78bf@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-13-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-13-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.128.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBZGQgc3lzY29uIG1mZCBub2RlcyBmb3IgU0IyIGFuZCBTQ1BVIFdyYXBwZXIgdG8gUlREMTM5
eCBEVC4NCj4gDQo+IENjOiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzl4LmR0c2kgfCAxOCArKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDEzOXguZHRzaQ0KPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMzl4LmR0c2kNCj4gaW5kZXggM2E1NzFmM2I3
ZTM4Li5hM2MxMGNlZWI1ODYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVh
bHRlay9ydGQxMzl4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0
ZDEzOXguZHRzaQ0KPiBAQCAtNzksNiArNzksMTUgQEANCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4
NzAwMCAweDEwMDA+Ow0KPiAgCQkJfTsNCj4gDQo+ICsJCQlzYjI6IHN5c2NvbkAxYTAwMCB7DQo+
ICsJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ICsJCQkJcmVnID0g
PDB4MWEwMDAgMHgxMDAwPjsNCj4gKwkJCQlyZWctaW8td2lkdGggPSA8ND47DQo+ICsJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQkJcmFu
Z2VzID0gPDB4MCAweDFhMDAwIDB4MTAwMD47DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQltaXNjOiBz
eXNjb25AMWIwMDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAic3lzY29uIiwgInNpbXBsZS1tZmQi
Ow0KPiAgCQkJCXJlZyA9IDwweDFiMDAwIDB4MTAwMD47DQo+IEBAIC04Nyw2ICs5NiwxNSBAQA0K
PiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDwweDAgMHgxYjAwMCAw
eDEwMDA+Ow0KPiAgCQkJfTsNCj4gKw0KPiArCQkJc2NwdV93cmFwcGVyOiBzeXNjb25AMWQwMDAg
ew0KPiArCQkJCWNvbXBhdGlibGUgPSAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPiArCQkJCXJl
ZyA9IDwweDFkMDAwIDB4MjAwMD47DQo+ICsJCQkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiArCQkJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiArCQkJ
CXJhbmdlcyA9IDwweDAgMHgxZDAwMCAweDIwMDA+Ow0KPiArCQkJfTsNCj4gIAkJfTsNCj4gDQo+
ICAJCWdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAZmYwMTEwMDAgew0KPiAtLQ0KPiAyLjE2LjQN
Cj4gDQo+IA0KDQpBY2tlZC1ieTogSmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRlay5jb20+DQoN
Cg==
