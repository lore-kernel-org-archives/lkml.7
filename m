Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078102064A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="A0TLMPDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437257AbfJXTjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:39:40 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59707 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391742AbfJXTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:39:39 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2883A891AA;
        Fri, 25 Oct 2019 08:39:37 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571945977;
        bh=PZD/J8Qr7amc/LAo8dKJPS+luUzJRzJ/OETQD4LtPjg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=A0TLMPDstcrt0k1fxldnyJb9gaoH4/Y4MTWD129lSLAduQ840uTqH5xrh2+xI0EpA
         42eWouO5xeo0DaHfhgayoGvESMrAJSJAdmaXGd4Frd/a3EeTIKR3ombXAoJJp9HOq3
         BMntGwNilQUpJ/ZWGHAgoaMX4VOwH3ayfru4e/1YKWlV1G33/8Pm1heAKmFxIJNdVp
         doajcYt/b5tLQ9rdku176sXMcWxvth/HWkf7bi+heP6SWkRoxQOcaV86Anc0JwhXsh
         0+Sl3Kho3q8A5o+IeMUt8QmO751kkv9bx29Te81p6grCUEwUoqE+e96c/a4IIoFtuv
         zRl2Cmn1lwuWA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db1fdf80001>; Fri, 25 Oct 2019 08:39:36 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 25 Oct 2019 08:39:36 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 25 Oct 2019 08:39:36 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] docs/core-api: memory-allocation: remove uses of
 c:func:
Thread-Topic: [PATCH v2 1/2] docs/core-api: memory-allocation: remove uses of
 c:func:
Thread-Index: AQHViR27xRtV35bqBUiFGlgZof0yOqdpPjqAgAAbJQA=
Date:   Thu, 24 Oct 2019 19:39:36 +0000
Message-ID: <d053a8dc8e08b5b3ff4f2f4ff5b7c6ce4c3e773f.camel@alliedtelesis.co.nz>
References: <20191022211438.3938-1-chris.packham@alliedtelesis.co.nz>
         <20191022211438.3938-2-chris.packham@alliedtelesis.co.nz>
         <20191024120227.0bd1ae92@lwn.net>
In-Reply-To: <20191024120227.0bd1ae92@lwn.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:254c:490a:57ec:fd27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <206A6BC4A272EA4496E9DBF8A2576C41@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uLA0KDQpPbiBUaHUsIDIwMTktMTAtMjQgYXQgMTI6MDIgLTA2MDAsIEpvbmF0aGFuIENv
cmJldCB3cm90ZToNCj4gT24gV2VkLCAyMyBPY3QgMjAxOSAxMDoxNDozNyArMTMwMA0KPiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPiAN
Cj4gPiBUaGVzZSBhcmUgbm8gbG9uZ2VyIG5lZWRlZCBhcyB0aGUgZG9jdW1lbnRhdGlvbiBidWls
ZCB3aWxsIGF1dG9tYXRpY2FsbHkNCj4gPiBhZGQgdGhlIGNyb3NzIHJlZmVyZW5jZXMuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0
ZWxlc2lzLmNvLm56Pg0KPiA+IC0tLQ0KPiA+IA0KPiA+IE5vdGVzOg0KPiA+ICAgICBJdCBzaG91
bGQgYmUgbm90ZWQgdGhhdCBrdm1hbGxvYygpIGFuZCBrbWVtX2NhY2hlX2Rlc3Ryb3koKSBsYWNr
IGENCj4gPiAgICAga2VybmVsZG9jIGhlYWRlciwgYSBzaWRlLWVmZmVjdCBvZiB0aGlzIGNoYW5n
ZSBpcyB0aGF0IHRoZSA6YzpmdW5jOg0KPiA+ICAgICBmYWxsYmFjayBvZiBtYWtpbmcgdGhlbSBi
b2xkIGlzIGxvc3QuIFRoaXMgaXMgcHJvYmFibHkgYmVzdCBmaXhlZCBieQ0KPiA+ICAgICBhZGRp
bmcgYSBrZXJuZWxkb2MgaGVhZGVyIHRvIHRoZWlyIHNvdXJjZS4NCj4gPiAgICAgDQo+ID4gICAg
IENoYW5nZXMgaW4gdjI6DQo+ID4gICAgIC0gbmV3DQo+ID4gDQo+ID4gIERvY3VtZW50YXRpb24v
Y29yZS1hcGkvbWVtb3J5LWFsbG9jYXRpb24ucnN0IHwgNDkgKysrKysrKysrLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0K
PiANCj4gU28gSSBjYW4ndCBnZXQgdGhpcyBwYXRjaCB0byBhcHBseSwgYW5kIEkgY2FuJ3QgZXZl
biBmaWd1cmUgb3V0IHdoeS4gIElmDQo+IHlvdSB0YWtlIHRoZSBwYXRjaCBmcm9tIHRoZSBsaXN0
LCBjYW4geW91IGFwcGx5IGl0IHRvIGEgZG9jcy1uZXh0IChvcg0KPiBtYWlubGluZSkgYnJhbmNo
Pw0KPiANCg0KSSB0aGluayBpdCBtaWdodCBiZSBkZXBlbmRlbnQgb24gbXkgb3RoZXIgdHlwbyBm
aXggcGF0Y2hbMV0uIEknbGwNCnJlYmFzZSB0byB2NS40LXJjNCBhbmQgc2VuZCBhcyBhIHNlcmll
cyBvZiAzLiBTb3JyeSBmb3IgdGhlIGhhc3NsZS4NCg0KLS0NClsxXSANCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAxOTEwMjEwMDM4MzMuMTU3MDQtMS1jaHJpcy5wYWNraGFtQGFsbGll
ZHRlbGVzaXMuY28ubnovDQoNCg0KPiBUaGFua3MsDQo+IA0KPiBqb24NCg==
