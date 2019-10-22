Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC804CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44FA21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IoztEt39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfJVUFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:05:43 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55532 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfJVUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:05:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E9038806A8;
        Wed, 23 Oct 2019 09:05:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571774739;
        bh=ZAzrF3c701Q5En7yhnqJaJPDpGkraxfx66BqdRfMHpg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=IoztEt39IvxMRUjeFnL1s2fX2nu82jD49uVLV96oAzsrdu3rIKKmTHvVEE90tJTq+
         O+oO9SVkAzhrqmUHkWXXB82/aymNrTlIV4eiw1+lFdwlp7OOxvGEsUpCFqusA65eA0
         JyiLh6dNAhP24QHiv3s5PNfM3Ow0/p6JH8vM1GNMjsqmkYazLyZmUNuCpLRMUa5Fxn
         4gIB72nb92CeOaPhW/GhAEH3VoHDpEB9r0LYAjkQzTd3fOup4tHEXeTJOw5quLJZ2V
         1ox+mBiMwjG3ocoRzkeXCtTgk2ktwGIMhZ5oa4il6kjYv/AqnqwpKzCZsK4xPQGymd
         Zc2rhB9UatUXA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5daf61130001>; Wed, 23 Oct 2019 09:05:39 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 23 Oct 2019 09:05:39 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 23 Oct 2019 09:05:39 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs/core-api: memory-allocation: mention size helpers
Thread-Topic: [PATCH] docs/core-api: memory-allocation: mention size helpers
Thread-Index: AQHViFZz73VvXhctJkq3urlKh1RGBqdlzAUAgABxhQA=
Date:   Tue, 22 Oct 2019 20:05:38 +0000
Message-ID: <ed4a98e3d8c0efe58d888cf8fc6e913b40281f11.camel@alliedtelesis.co.nz>
References: <20191021212751.21300-1-chris.packham@alliedtelesis.co.nz>
         <20191022071920.4efff72b@lwn.net>
In-Reply-To: <20191022071920.4efff72b@lwn.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:a0a7:2bd4:9fed:473b]
Content-Type: text/plain; charset="utf-8"
Content-ID: <481BDAA1D53A234A88941CA38DCDD107@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uLA0KDQpPbiBUdWUsIDIwMTktMTAtMjIgYXQgMDc6MTkgLTA2MDAsIEpvbmF0aGFuIENv
cmJldCB3cm90ZToNCj4gT24gVHVlLCAyMiBPY3QgMjAxOSAxMDoyNzo0NyArMTMwMA0KPiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPiAN
Cj4gPiBNZW50aW9uIHN0cnVjdF9zaXplKCksIGFycmF5X3NpemUoKSBhbmQgYXJyYXkzX3NpemUo
KSBpbiB0aGUgc2FtZSBwbGFjZQ0KPiA+IGFzIGttYWxsb2MoKSBhbmQgZnJpZW5kcy4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRl
bGVzaXMuY28ubno+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vY29yZS1hcGkvbWVtb3J5
LWFsbG9jYXRpb24ucnN0IHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9jb3JlLWFwaS9tZW1vcnktYWxsb2NhdGlvbi5yc3QgYi9Eb2N1bWVudGF0aW9uL2NvcmUtYXBp
L21lbW9yeS1hbGxvY2F0aW9uLnJzdA0KPiA+IGluZGV4IGU1OTc3OWFhNzYxNS4uNmExMzE3Njdi
ZWNkIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vY29yZS1hcGkvbWVtb3J5LWFsbG9j
YXRpb24ucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9tZW1vcnktYWxsb2Nh
dGlvbi5yc3QNCj4gPiBAQCAtOTEsNyArOTEsOSBAQCBUaGUgbW9zdCBzdHJhaWdodGZvcndhcmQg
d2F5IHRvIGFsbG9jYXRlIG1lbW9yeSBpcyB0byB1c2UgYSBmdW5jdGlvbg0KPiA+ICBmcm9tIHRo
ZSA6YzpmdW5jOmBrbWFsbG9jYCBmYW1pbHkuIEFuZCwgdG8gYmUgb24gdGhlIHNhZmUgc2lkZSBp
dCdzDQo+ID4gIGJlc3QgdG8gdXNlIHJvdXRpbmVzIHRoYXQgc2V0IG1lbW9yeSB0byB6ZXJvLCBs
aWtlDQo+ID4gIDpjOmZ1bmM6YGt6YWxsb2NgLiBJZiB5b3UgbmVlZCB0byBhbGxvY2F0ZSBtZW1v
cnkgZm9yIGFuIGFycmF5LCB0aGVyZQ0KPiA+IC1hcmUgOmM6ZnVuYzpga21hbGxvY19hcnJheWAg
YW5kIDpjOmZ1bmM6YGtjYWxsb2NgIGhlbHBlcnMuDQo+ID4gK2FyZSA6YzpmdW5jOmBrbWFsbG9j
X2FycmF5YCBhbmQgOmM6ZnVuYzpga2NhbGxvY2AgaGVscGVycy4gVGhlIGhlbHBlcnMNCj4gPiAr
OmM6ZnVuYzpgc3RydWN0X3NpemVgLCA6YzpmdW5jOmBhcnJheV9zaXplYCBhbmQgOmM6ZnVuYzpg
YXJyYXkzX3NpemVgIGNhbiBiZQ0KPiA+ICt1c2VkIHRvIHNhZmVseSBjYWxjdWxhdGUgb2JqZWN0
IHNpemVzIHdpdGhvdXQgb3ZlcmZsb3dpbmcuDQo+IA0KPiBRdWljayBjb21tZW50OiB3ZSBkb24n
dCBuZWVkIDpjOmZ1bmM6IGFueW1vcmU7IHRoZSBtYXJrdXAgaGFwcGVucyBhbnl3YXkuDQo+IFNv
IHJhdGhlciB0aGFuIGFkZGluZyBtb3JlIG9mIHRoZW0sIGNvdWxkIEkgYXNrIHlvdSB0byBwbGVh
c2UgdGFrZSBvdXQgdGhlDQo+IG9uZXMgdGhhdCBhcmUgdGhlcmUgbm93Pw0KDQpTbyBqdXN0IHdp
dGggYmFja3F1b3RlcyBpLmUuIDpjOmZ1bmM6YGttYWxsb2NgIGJlY29tZXMgYGttYWxsb2NgPw0K
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBqb24NCg==
