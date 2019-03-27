Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBAE206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfC0QJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:09:52 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:39579 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfC0QJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:09:51 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2RG9OaR003947
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 01:09:24 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2RG9OVi004412;
        Thu, 28 Mar 2019 01:09:24 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2RG9Oun016852;
        Thu, 28 Mar 2019 01:09:24 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3739533; Thu, 28 Mar 2019 01:07:23 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Thu,
 28 Mar 2019 01:07:22 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Dave Anderson" <anderson@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: RE: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
Thread-Topic: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
Thread-Index: AQHU4/Imyc3PaHNWqE2bQC4mNQLA76YfiYUQ
Date:   Wed, 27 Mar 2019 16:07:22 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
In-Reply-To: <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNi8yMDE5IDEyOjM2IFBNLCBKYW1lcyBNb3JzZSB3cm90ZToNCj4gSGkgQmh1cGVzaCwN
Cj4gDQo+IE9uIDIwLzAzLzIwMTkgMDU6MDksIEJodXBlc2ggU2hhcm1hIHdyb3RlOg0KPiA+IFdp
dGggQVJNdjguMi1MVkEgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbiBhdmFpbGFiaWxpdHksIGFybTY0
IGhhcmR3YXJlDQo+ID4gd2hpY2ggc3VwcG9ydHMgdGhpcyBleHRlbnNpb24gY2FuIHN1cHBvcnQg
YSB2aXJ0dWFsIGFkZHJlc3Mtc3BhY2UgdXB0bw0KPiA+IDUyLWJpdHMuDQo+ID4NCj4gPiBTaW5j
ZSBhdCB0aGUgbW9tZW50IHdlIGVuYWJsZSB0aGUgc3VwcG9ydCBvZiB0aGlzIGV4dGVuc2lvbiBp
biBrZXJuZWwNCj4gPiB2aWEgQ09ORklHIGZsYWdzLCBlLmcuDQo+ID4gIC0gVXNlci1zcGFjZSA1
Mi1iaXQgTFZBIHZpYSBDT05GSUdfQVJNNjRfVVNFUl9WQV9CSVRTXzUyDQo+ID4NCj4gPiBzbywg
dGhlcmUgaXMgbm8gY2xlYXIgbWVjaGFuaXNtIGluIHRoZSB1c2VyLXNwYWNlIHJpZ2h0IG5vdyB0
bw0KPiA+IGRldGVybWluZSB0aGVzZSBDT05GSUcgZmxhZyB2YWx1ZXMgYW5kIGhlbmNlIGRldGVy
bWluZSB0aGUgbWF4aW11bQ0KPiA+IHZpcnR1YWwgYWRkcmVzcyBzcGFjZSBzdXBwb3J0ZWQgYnkg
dGhlIHVuZGVybHlpbmcga2VybmVsLg0KPiA+DQo+ID4gVXNlci1zcGFjZSB0b29scyBsaWtlICdt
YWtlZHVtcGZpbGUnIHRoZXJlZm9yZSBhcmUgYnJva2VuIGN1cnJlbnRseQ0KPiA+IGFzIHRoZXkg
aGF2ZSBubyBwcm9wZXIgbWV0aG9kIHRvIGNhbGN1bGF0ZSB0aGUgJ1BUUlNfUEVSX1BHRCcgdmFs
dWUNCj4gPiB3aGljaCBpcyByZXF1aXJlZCB0byBwZXJmb3JtIGEgcGFnZSB0YWJsZSB3YWxrIHRv
IGRldGVybWluZSB0aGUNCj4gPiBwaHlzaWNhbCBhZGRyZXNzIG9mIGEgY29ycmVzcG9uZGluZyB2
aXJ0dWFsIGFkZHJlc3MgZm91bmQgaW4NCj4gPiBrY29yZS92bWNvcmVpbmZvLg0KPiA+DQo+ID4g
SWYgb25lIGFwcGVuZHMgJ1BUUlNfUEVSX1BHRCcgbnVtYmVyIHRvIHZtY29yZWluZm8gZm9yIGFy
bTY0LA0KPiA+IGl0IGNhbiBiZSB1c2VkIGluIHVzZXItc3BhY2UgdG8gZGV0ZXJtaW5lIHRoZSBt
YXhpbXVtIHZpcnR1YWwgYWRkcmVzcw0KPiA+IHN1cHBvcnRlZCBieSB1bmRlcmx5aW5nIGtlcm5l
bC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyByZWFsbHkgc29sdmVzIHRoZSBwcm9ibGVtLCBp
dCBmZWVscyBmcmFnaWxlLg0KPiANCj4gSSBjYW4gc2VlIGhvdyB2bWNvcmVpbmZvIHRlbGxzIHlv
dSBWQV9CSVRTPT00OCwgUEFHRV9TSVpFPT02NEsgYW5kIFBUUlNfUEVSX1BHRD0xMDI0Lg0KPiBZ
b3UgY2FuIHVzZSB0aGlzIHRvIHdvcmsgb3V0IHRoYXQgdGhlIHRvcCBsZXZlbCBwYWdlIHRhYmxl
IHNpemUgaXNuJ3QgY29uc2lzdGVudCB3aXRoIGENCj4gNDhiaXQgVkEsIHNvIDUyYml0IFZBIG11
c3QgYmUgaW4gdXNlLi4uDQo+IA0KPiBCdXQgd2Fzbid0IHlvdXIgcHJvYmxlbSB3YWxraW5nIHRo
ZSBrZXJuZWwgcGFnZSB0YWJsZXM/IEluIHBhcnRpY3VsYXIgdGhlIG9mZnNldCB0aGF0IHdlDQo+
IGFwcGx5IGJlY2F1c2UgdGhlIHRhYmxlcyB3ZXJlIGJhc2VkIG9uIGEgNDhiaXQgVkEgc2hpZnRl
ZCB1cCBpbiBzd2FwcGVyX3BnX2Rpci4NCj4gDQo+IFdoZXJlIGRvZXMgdGhlIFRUQlIxX0VMMSBv
ZmZzZXQgY29tZSBmcm9tIHdpdGggdGhpcyBwcm9wZXJ0eT8gSSBhc3N1bWUgbWFrZWR1bXBmaWxl
DQo+IGhhcmQtY29kZXMgaXQgd2hlbiBpdCBzZWVzIDUyYml0IGlzIGluIHVzZSAuLi4gc29tZXdo
ZXJlLg0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIFRUQlIxX0VMMSBvZmZzZXQgY29t
ZXMgZnJvbSBhIGtlcm5lbA0KdmlydHVhbCBhZGRyZXNzIHdpdGggdGhlIGV4cG9ydGVkIFBUUlNf
UEVSX1BHRC4NCg0KV2l0aCBUMVNaIGlzIDQ4Yml0IGFuZCBUMFNaIGlzIDUyYml0LA0KDQprdmEg
PSAweGZmZmYwMDAwMDAwMDAwMDAgICAgPC0tLSBzdGFydCBvZiBrZXJuZWwgdmlydHVhbCBhZGRy
ZXNzDQpwZ2RfaW5kZXgoa3ZhKSA9IChrdmEgPj4gUEdESVJfU0hJRlQpICYgKFBUUlNfUEVSX1BH
RCAtIDEpDQogICAgICAgICAgICAgICA9ICgweGZmZmYwMDAwMDAwMDAwMDAgPj4gNDIpICYgKDEw
MjQgLSAxKQ0KICAgICAgICAgICAgICAgPSAweDAwMDAwMDAwMDAzZmZmYzAgJiAweDNmZg0KICAg
ICAgICAgICAgICAgPSAweDNjMCAgICAgIDwtLS0gdGhlIG9mZnNldCAoMHgzYzApIGlzIGluY2x1
ZGVkDQoNClRoaXMgaXMgd2hhdCBrZXJuZWwgZG9lcyBub3csIHNvIG1ha2VkdW1wZmlsZSBhbHNv
IHdhbnRzIHRvIGRvLg0KDQo+IFdlIGhhdmVuJ3Qgc29sdmVkIHRoZSBwcm9ibGVtIQ0KPiANCj4g
VG9kYXkgX19jcHVfc2V0dXAoKSBzZXRzIFQwU1ogYW5kIFQxU1ogZGlmZmVyZW50bHkgZm9yIDUy
Yml0IFZBLCBidXQgaW4gdGhlIGZ1dHVyZSBpdA0KPiBjb3VsZCBzZXQgdGhlbSB0aGUgc2FtZSwg
b3IgZGlmZmVyZW50IHRoZSBvdGhlci13YXktcm91bmQuDQo+IA0KPiBXaWxsIG1ha2VkdW1wZmls
ZSB1c2luZyB0aGlzIHZhbHVlIGtlZXAgd29ya2luZyBvbmNlIFQxU1ogaXMgNTJiaXQgVkEgdG9v
PyBJbiB0aGlzIGNhc2UNCj4gdGhlcmUgd291bGQgYmUgbm8gdHRiciBvZmZzZXQuDQoNCklmIFQx
U1ogaXMgNTJiaXQsIHByb2JhYmx5IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3Mgc3RhcnRzIGZyb20g
MHhmZmYwMDAwMDAwMDAwMDAwLA0KdGhlbiB0aGUgb2Zmc2V0IGJlY29tZXMgMCB3aXRoIHRoZSBw
Z2RfaW5kZXgoKSBhYm92ZS4NCkkgdGhpbmsgbWFrZWR1bXBmaWxlIHdpbGwga2VlcCB3b3JraW5n
IHdpdGggdGhhdC4NCg0KVGhhbmtzLA0KS2F6dQ0KDQo+IA0KPiBJZiB5b3UgbmVlZCBhbm90aGVy
IHZtY29yZWluZm8gZmxhZyBvbmNlIHRoYXQgaGFwcGVucywgd2UndmUgZG9uZSBzb21ldGhpbmcg
d3JvbmcgaGVyZS4NCj4gDQo+IChOb3QgdG8gbWVudGlvbiB3aGF0IGhhcHBlbnMgaWYgdGhlIFRU
QlIxX0VMMSB1c2VzIDUyYml0IHZhLCBidXQgVFRCUjBfRUwxIGRvZXNuJ3QpDQo+IA0KPiANCj4g
PiBTdWdnZXN0ZWQtYnk6IFN0ZXZlIENhcHBlciA8U3RldmUuQ2FwcGVyQGFybS5jb20+DQo+IA0K
PiAoQ0M6ICtTdGV2ZSkNCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKYW1lcw0KDQo=

