Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71858CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D8C21928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="n367ZZoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJXVHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:07:41 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59944 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfJXVHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:07:41 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F33CB891AA;
        Fri, 25 Oct 2019 10:07:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571951258;
        bh=nLYWZmfo2EArkYJRQdLZy6LtWfpZT42k7cHcj+sN/Ak=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=n367ZZoHK10Ei/cdFPk5IiOHOvfUv1paEcPxEffwwsKPbVZjv7p59Yh+bHXNajJab
         FjzcLZ/mDa7nhHu5bIeaV7s1jxTjmFC64FZHWRZl7I8J9LF8oVSEx+S9IUF1qZOAmI
         f4A8z8D98g3NaswuyqRPtb4T1vm27tKGwdF7nkwH/IqkO8m4h1TC5bktuG8cl4scQI
         drfVQRDvGTi5Lcj3+ahw1ykaeRGG1Sn3hEWM/uJil7/oKwZO5fL/5hO6rL4mTwCcyA
         jJ6b/I8v21VlkjG4SAwsyh1r0HHinfECSW1yursZy/aPtvdHxDOAmgSG6zRn4zJuPW
         k1g2D2UdZHdAQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db212990000>; Fri, 25 Oct 2019 10:07:37 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 25 Oct 2019 10:07:37 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 25 Oct 2019 10:07:37 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "corbet@lwn.net" <corbet@lwn.net>
CC:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of
 c:func:
Thread-Topic: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of
 c:func:
Thread-Index: AQHViqRDYXn+aypHWkCn7i9MADN5nKdpZCEAgAAGP4CAAAGgAIAAAugA
Date:   Thu, 24 Oct 2019 21:07:36 +0000
Message-ID: <1ab8d0451f29ba9b72dc758f7c1fc1ba0657ac61.camel@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
         <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
         <20191024142902.6bd413f6@lwn.net>
         <1ddbd3045d6a989b32065c0bd5b3a3c0ef525953.camel@alliedtelesis.co.nz>
         <20191024145712.165556c1@lwn.net>
In-Reply-To: <20191024145712.165556c1@lwn.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:254c:490a:57ec:fd27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <73A395BDD4D643419016DDD4AD748637@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTI0IGF0IDE0OjU3IC0wNjAwLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6
DQo+IE9uIFRodSwgMjQgT2N0IDIwMTkgMjA6NTE6MjMgKzAwMDANCj4gQ2hyaXMgUGFja2hhbSA8
Q2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4gDQo+ID4gV2hlbiBJ
IGRvIGFjdHVhbGx5IGdldCBhIHNlcmllcyB0aGF0IGFwcGxpZXMgdG8gZG9jcy1uZXh0IGl0J2xs
DQo+ID4gY29uZmxpY3Qgd2l0aCA1OWJiNDc5ODVjMWQgKCJtbSwgc2xbYW91XWI6IGd1YXJhbnRl
ZQ0KPiA+IG5hdHVyYWwgYWxpZ25tZW50IGZvciBrbWFsbG9jKHBvd2VyLW9mLXR3bykiKSBpbiBM
aW51cydzIHRyZWUuDQo+IA0KPiBBbHRlcm5hdGl2ZWx5LCBpZiBJIHN5bmMgdXAgdG8gLXJjNCwg
ZG9lcyB0aGUgcHJvYmxlbSBnbyBhd2F5PyAgSSBzaG91bGQNCj4gYmUgYWJsZSB0byBleHBsYWlu
IHRoYXQgdG8gTGludXMgd2l0aG91dCB0b28gbXVjaCB0cm91YmxlLi4uDQo+IA0KDQpZZXMgdGhl
IHNlcmllcyBhcHBsaWVzIGNsZWFubHkgb25jZSBkb2NzLW5leHQgaXMgbWVyZ2VkIHdpdGggdjUu
NC1yYzQuDQoNClRoZXJlIGlzIGEgbWVyZ2UgY29uZmxpY3QgYmV0d2VlbiA2ZWUwZmFjMTk5ZTEg
KCJkb2NzOiBmaXggbWVtb3J5Lmxvdw0KZGVzY3JpcHRpb24gaW4gY2dyb3VwLXYyLnJzdCIpIGlu
IHlvdXIgdHJlZSBhbmQgOTc4M2FhOTkxN2Y4ICgibW0sDQptZW1jZzogcHJvcG9ydGlvbmFsIG1l
bW9yeS57bG93LG1pbn0gcmVjbGFpbSIpIGluIExpbnVzJ3MgdHJlZS4gSGVyZSdzDQp0aGUgcmVz
b2x1dGlvbiBJIGNhbWUgdXAgd2l0aCBpbiBteSB0ZXN0IG1lcmdlDQoNCmRpZmYgLS1jYyBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12Mi5yc3QNCmluZGV4IDI2ZDFjZGU2YjM0YSw1
MzYxZWJlYzMzNjEuLjUxNWMyZDllZWY4NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9jZ3JvdXAtdjIucnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12
Mi5yc3QNCkBAQCAtMTExNyw4IC0xMTIwLDExICsxMTIwLDExIEBAQCBQQUdFX1NJWkUgbXVsdGlw
bGUgd2hlbiByZWFkIGJhY2sNCiAgDQogICAgICAgIEJlc3QtZWZmb3J0IG1lbW9yeSBwcm90ZWN0
aW9uLiAgSWYgdGhlIG1lbW9yeSB1c2FnZSBvZiBhDQogICAgICAgIGNncm91cCBpcyB3aXRoaW4g
aXRzIGVmZmVjdGl2ZSBsb3cgYm91bmRhcnksIHRoZSBjZ3JvdXAncw0KIC0gICAgICBtZW1vcnkg
d29uJ3QgYmUgcmVjbGFpbWVkIHVubGVzcyBtZW1vcnkgY2FuIGJlIHJlY2xhaW1lZA0KICsgICAg
ICBtZW1vcnkgd29uJ3QgYmUgcmVjbGFpbWVkIHVubGVzcyB0aGVyZSBpcyBubyByZWNsYWltYWJs
ZQ0KLSAgICAgICBtZW1vcnkgYXZhaWxhYmxlIGluIHVucHJvdGVjdGVkIGNncm91cHMuDQorICAg
ICAgIGZyb20gdW5wcm90ZWN0ZWQgY2dyb3Vwcy4gIEFib3ZlIHRoZSBlZmZlY3RpdmUgbG93IGJv
dW5kYXJ5IChvcg0KKyAgICAgICBlZmZlY3RpdmUgbWluIGJvdW5kYXJ5IGlmIGl0IGlzIGhpZ2hl
ciksIHBhZ2VzIGFyZSByZWNsYWltZWQNCisgICAgICAgcHJvcG9ydGlvbmFsbHkgdG8gdGhlIG92
ZXJhZ2UsIHJlZHVjaW5nIHJlY2xhaW0gcHJlc3N1cmUgZm9yDQorICAgICAgIHNtYWxsZXIgb3Zl
cmFnZXMuDQogIA0KICAgICAgICBFZmZlY3RpdmUgbG93IGJvdW5kYXJ5IGlzIGxpbWl0ZWQgYnkg
bWVtb3J5LmxvdyB2YWx1ZXMgb2YNCiAgICAgICAgYWxsIGFuY2VzdG9yIGNncm91cHMuIElmIHRo
ZXJlIGlzIG1lbW9yeS5sb3cgb3ZlcmNvbW1pdG1lbnQNCg0K
