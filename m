Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB090CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9992D21929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ayudw2I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfJXUvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:51:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59866 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfJXUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:51:31 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 80251891AA;
        Fri, 25 Oct 2019 09:51:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571950289;
        bh=36dRwa4A3dXnVtv62AMlqKd/AOZMMynqclVnGxr8isw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=ayudw2I37bEQw727kRHvKBEMERS0Gpo/z2IDf2lqxKK872dXJq79qp/GWr4TOWG4T
         vECIIFEGpNjNNxr1ZyLNnKbDj1pTuGElFLBf34ft44FnxVWBHdylGs+Yqe8jIfKOUA
         hQ/krNJzEI4d065TdFh24oxmea/h1+TJMeoKxcvis8S52GJNxlzTdkTaR2AdSKei2i
         zGjDoarL2LBo82JUXeKrRAY3GP0yd/lPYiDdUgzhwxSq88ugkpVTQlhOz6T5YPH/NB
         ReWVmJMcDRVSclliVWvhdX2wnQ+IwwlQPswL3Hg4pzR2B8lLejC376YN2InDM+JXXr
         H+HBJxxSei5TA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db20ed00000>; Fri, 25 Oct 2019 09:51:28 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 25 Oct 2019 09:51:24 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 25 Oct 2019 09:51:24 +1300
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
Thread-Index: AQHViqRDYXn+aypHWkCn7i9MADN5nKdpZCEAgAAGP4A=
Date:   Thu, 24 Oct 2019 20:51:23 +0000
Message-ID: <1ddbd3045d6a989b32065c0bd5b3a3c0ef525953.camel@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
         <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
         <20191024142902.6bd413f6@lwn.net>
In-Reply-To: <20191024142902.6bd413f6@lwn.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:254c:490a:57ec:fd27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <45AC7B2AB981C24CB2FEE40DD3AF56B2@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uLA0KDQpPbiBUaHUsIDIwMTktMTAtMjQgYXQgMTQ6MjkgLTA2MDAsIEpvbmF0aGFuIENv
cmJldCB3cm90ZToNCj4gT24gRnJpLCAyNSBPY3QgMjAxOSAwODo1MDoxNSArMTMwMA0KPiBDaHJp
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
PiANCj4gVGhpcyBvbmUgc3RpbGwgZG9lc24ndCBhcHBseTsgaGF2ZSB5b3UgdmVyaWZpZWQgdGhh
dCB5b3UgY2FuIGFwcGx5IHRoZQ0KPiB3aG9sZSBzZXJpZXMgdG8gZG9jcy1uZXh0Pw0KDQpJIGNh
biBzZWUgdGhlIHByb2JsZW0uIEknbGwgcmViYXNlIGFnYWluc3QgZG9jcy1uZXh0IGFuZCBzZW5k
IGEgdjQuDQoNCldoZW4gSSBkbyBhY3R1YWxseSBnZXQgYSBzZXJpZXMgdGhhdCBhcHBsaWVzIHRv
IGRvY3MtbmV4dCBpdCdsbA0KY29uZmxpY3Qgd2l0aCA1OWJiNDc5ODVjMWQgKCJtbSwgc2xbYW91
XWI6IGd1YXJhbnRlZQ0KbmF0dXJhbCBhbGlnbm1lbnQgZm9yIGttYWxsb2MocG93ZXItb2YtdHdv
KSIpIGluIExpbnVzJ3MgdHJlZS4NCg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IGpvbg0K
