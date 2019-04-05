Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217AAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BA32175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDEU0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:26:49 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:57638 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:26:49 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x35KQU1v016366
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Apr 2019 05:26:30 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x35KQUpl031615;
        Sat, 6 Apr 2019 05:26:30 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x35KQUQT026954;
        Sat, 6 Apr 2019 05:26:30 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4035757; Sat, 6 Apr 2019 05:23:37 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Sat, 6
 Apr 2019 05:23:37 +0900
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
Thread-Index: AQHU4/Imyc3PaHNWqE2bQC4mNQLA76YfiYUQgAkKgQCAA44RcA==
Date:   Fri, 5 Apr 2019 20:23:36 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03573F20@BPXM09GP.gisp.nec.co.jp>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
 <54efc2e4-6b3a-792a-16a6-8503c866ea2a@arm.com>
In-Reply-To: <54efc2e4-6b3a-792a-16a6-8503c866ea2a@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.238]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBIaSBLYXp1LA0KPiANCj4gT24gMjcvMDMvMjAxOSAxNjowNywgS2F6
dWhpdG8gSGFnaW8gd3JvdGU6DQo+ID4gT24gMy8yNi8yMDE5IDEyOjM2IFBNLCBKYW1lcyBNb3Jz
ZSB3cm90ZToNCj4gPj4gT24gMjAvMDMvMjAxOSAwNTowOSwgQmh1cGVzaCBTaGFybWEgd3JvdGU6
DQo+ID4+PiBXaXRoIEFSTXY4LjItTFZBIGFyY2hpdGVjdHVyZSBleHRlbnNpb24gYXZhaWxhYmls
aXR5LCBhcm02NCBoYXJkd2FyZQ0KPiA+Pj4gd2hpY2ggc3VwcG9ydHMgdGhpcyBleHRlbnNpb24g
Y2FuIHN1cHBvcnQgYSB2aXJ0dWFsIGFkZHJlc3Mtc3BhY2UgdXB0bw0KPiA+Pj4gNTItYml0cy4N
Cj4gPj4+DQo+ID4+PiBTaW5jZSBhdCB0aGUgbW9tZW50IHdlIGVuYWJsZSB0aGUgc3VwcG9ydCBv
ZiB0aGlzIGV4dGVuc2lvbiBpbiBrZXJuZWwNCj4gPj4+IHZpYSBDT05GSUcgZmxhZ3MsIGUuZy4N
Cj4gPj4+ICAtIFVzZXItc3BhY2UgNTItYml0IExWQSB2aWEgQ09ORklHX0FSTTY0X1VTRVJfVkFf
QklUU181Mg0KPiA+Pj4NCj4gPj4+IHNvLCB0aGVyZSBpcyBubyBjbGVhciBtZWNoYW5pc20gaW4g
dGhlIHVzZXItc3BhY2UgcmlnaHQgbm93IHRvDQo+ID4+PiBkZXRlcm1pbmUgdGhlc2UgQ09ORklH
IGZsYWcgdmFsdWVzIGFuZCBoZW5jZSBkZXRlcm1pbmUgdGhlIG1heGltdW0NCj4gPj4+IHZpcnR1
YWwgYWRkcmVzcyBzcGFjZSBzdXBwb3J0ZWQgYnkgdGhlIHVuZGVybHlpbmcga2VybmVsLg0KPiA+
Pj4NCj4gPj4+IFVzZXItc3BhY2UgdG9vbHMgbGlrZSAnbWFrZWR1bXBmaWxlJyB0aGVyZWZvcmUg
YXJlIGJyb2tlbiBjdXJyZW50bHkNCj4gPj4+IGFzIHRoZXkgaGF2ZSBubyBwcm9wZXIgbWV0aG9k
IHRvIGNhbGN1bGF0ZSB0aGUgJ1BUUlNfUEVSX1BHRCcgdmFsdWUNCj4gPj4+IHdoaWNoIGlzIHJl
cXVpcmVkIHRvIHBlcmZvcm0gYSBwYWdlIHRhYmxlIHdhbGsgdG8gZGV0ZXJtaW5lIHRoZQ0KPiA+
Pj4gcGh5c2ljYWwgYWRkcmVzcyBvZiBhIGNvcnJlc3BvbmRpbmcgdmlydHVhbCBhZGRyZXNzIGZv
dW5kIGluDQo+ID4+PiBrY29yZS92bWNvcmVpbmZvLg0KPiA+Pj4NCj4gPj4+IElmIG9uZSBhcHBl
bmRzICdQVFJTX1BFUl9QR0QnIG51bWJlciB0byB2bWNvcmVpbmZvIGZvciBhcm02NCwNCj4gPj4+
IGl0IGNhbiBiZSB1c2VkIGluIHVzZXItc3BhY2UgdG8gZGV0ZXJtaW5lIHRoZSBtYXhpbXVtIHZp
cnR1YWwgYWRkcmVzcw0KPiA+Pj4gc3VwcG9ydGVkIGJ5IHVuZGVybHlpbmcga2VybmVsLg0KPiA+
Pg0KPiA+PiBJIGRvbid0IHRoaW5rIHRoaXMgcmVhbGx5IHNvbHZlcyB0aGUgcHJvYmxlbSwgaXQg
ZmVlbHMgZnJhZ2lsZS4NCj4gPj4NCj4gPj4gSSBjYW4gc2VlIGhvdyB2bWNvcmVpbmZvIHRlbGxz
IHlvdSBWQV9CSVRTPT00OCwgUEFHRV9TSVpFPT02NEsgYW5kIFBUUlNfUEVSX1BHRD0xMDI0Lg0K
PiA+PiBZb3UgY2FuIHVzZSB0aGlzIHRvIHdvcmsgb3V0IHRoYXQgdGhlIHRvcCBsZXZlbCBwYWdl
IHRhYmxlIHNpemUgaXNuJ3QgY29uc2lzdGVudCB3aXRoIGENCj4gPj4gNDhiaXQgVkEsIHNvIDUy
Yml0IFZBIG11c3QgYmUgaW4gdXNlLi4uDQo+ID4+DQo+ID4+IEJ1dCB3YXNuJ3QgeW91ciBwcm9i
bGVtIHdhbGtpbmcgdGhlIGtlcm5lbCBwYWdlIHRhYmxlcz8gSW4gcGFydGljdWxhciB0aGUgb2Zm
c2V0IHRoYXQgd2UNCj4gPj4gYXBwbHkgYmVjYXVzZSB0aGUgdGFibGVzIHdlcmUgYmFzZWQgb24g
YSA0OGJpdCBWQSBzaGlmdGVkIHVwIGluIHN3YXBwZXJfcGdfZGlyLg0KPiA+Pg0KPiA+PiBXaGVy
ZSBkb2VzIHRoZSBUVEJSMV9FTDEgb2Zmc2V0IGNvbWUgZnJvbSB3aXRoIHRoaXMgcHJvcGVydHk/
IEkgYXNzdW1lIG1ha2VkdW1wZmlsZQ0KPiA+PiBoYXJkLWNvZGVzIGl0IHdoZW4gaXQgc2VlcyA1
MmJpdCBpcyBpbiB1c2UgLi4uIHNvbWV3aGVyZS4NCj4gDQo+ID4gTXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0IHRoZSBUVEJSMV9FTDEgb2Zmc2V0IGNvbWVzIGZyb20gYSBrZXJuZWwNCj4gPiB2aXJ0
dWFsIGFkZHJlc3Mgd2l0aCB0aGUgZXhwb3J0ZWQgUFRSU19QRVJfUEdELg0KPiA+DQo+ID4gV2l0
aCBUMVNaIGlzIDQ4Yml0IGFuZCBUMFNaIGlzIDUyYml0LA0KPiANCj4gKFBUUlNfUEVSX1BHRCBk
b2Vzbid0IHRlbGwgeW91IHRoaXMsIFBUUlNfUEVSX1BHRCBsZXRzIHlvdSBzcG90IHNvbWV0aGlu
ZyBvZGQgaXMNCj4gaGFwcGVuaW5nLCBhbmQgdGhpcyBqdXN0IGhhcHBlbnMgdG8gYmUgdGhlIG9u
bHkgb2RkIGNvbWJpbmF0aW9uIHRvZGF5LikNCg0KSSBkaWRuJ3QgaW50ZW5kIHRvIGd1ZXNzIG90
aGVyIHRoaW5ncyBmcm9tIFBUUlNfUEVSX1BHRC4NCg0KPiA+IGt2YSA9IDB4ZmZmZjAwMDAwMDAw
MDAwMCAgICA8LS0tIHN0YXJ0IG9mIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MNCj4gDQo+IERvZXMg
bWFrZWR1bXBmaWxlIGhhdmUgdGhpcyB2YWx1ZT8gSWYgdGhlIGtlcm5lbCB3ZXJlIHVzaW5nIDUy
Yml0IFZBIGZvciBUVEJSMSB0aGlzIHZhbHVlDQo+IHdvdWxkIGJlIGRpZmZlcmVudC4NCg0KVGhp
cyB3YXMgYW4gZXhhbXBsZSBhZGRyZXNzIHRvIHNob3cgdGhhdCBwZ2RfaW5kZXgoKSBhdXRvbWF0
aWNhbGx5IHJldHVybnMNCmEgdmFsdWUgaW5jbHVkaW5nIHRoZSBvZmZzZXQgZm9yIGFueSBrZXJu
ZWwgdmlydHVhbCBhZGRyZXNzIGJ5IHRoZSBleHBvcnRlZA0KUFRSU19QRVJfUEdELiBJbiB0aGlz
IGNhc2UsIGV2ZW4gZm9yIHRoZSBmaXJzdCB2aXJ0dWFsIGFkZHJlc3MsIGl0IHJldHVybnMNCnRo
ZSBub24temVybyB2YWx1ZSwgd2hpY2ggaXMgdGhlIG9mZnNldC4gKHNvcnJ5IGZvciB0aGUgcG9v
ciBleHBsYW5hdGlvbi4uKQ0KDQpTbyBtYWtlZHVtcGZpbGUgZG9lc24ndCBuZWVkIHRoZSBzdGFy
dCBhZGRyZXNzIHNwZWNpZmljYWxseSB0byB3YWxrIHRoZSBwYWdlDQp0YWJsZXMsIGFuZCBJIHdh
cyB0aGlua2luZyB0aGF0IGV4cG9ydGluZyBQVFJTX1BFUl9QR0QgbWF5IGJlIHN0YWJsZSB1bmxl
c3MNCnBnZF9pbmRleCgpIGRvZXNuJ3QgY2hhbmdlLg0KDQo+ID4gcGdkX2luZGV4KGt2YSkgPSAo
a3ZhID4+IFBHRElSX1NISUZUKSAmIChQVFJTX1BFUl9QR0QgLSAxKQ0KPiA+ICAgICAgICAgICAg
ICAgID0gKDB4ZmZmZjAwMDAwMDAwMDAwMCA+PiA0MikgJiAoMTAyNCAtIDEpDQo+ID4gICAgICAg
ICAgICAgICAgPSAweDAwMDAwMDAwMDAzZmZmYzAgJiAweDNmZg0KPiA+ICAgICAgICAgICAgICAg
ID0gMHgzYzAgICAgICA8LS0tIHRoZSBvZmZzZXQgKDB4M2MwKSBpcyBpbmNsdWRlZA0KPiA+DQo+
ID4gVGhpcyBpcyB3aGF0IGtlcm5lbCBkb2VzIG5vdywgc28gbWFrZWR1bXBmaWxlIGFsc28gd2Fu
dHMgdG8gZG8uDQo+IA0KPiBTdXJlLCBhbmQgaXQgd291bGQgd29yayB0b2RheS4gSSdtIHdvcnJp
ZWQgYWJvdXQgdG9tb3Jyb3csIHdoZXJlIHdlIHN1cHBvcnQgc29tZXRoaW5nIG5ldywNCj4gYW5k
IG5lZWQgdG8gYnVuZGxlIG5ldyBpbmZvcm1hdGlvbiBvdXQgdGhyb3VnaCB2bWNvcmVpbmZvLiBU
aGlzIGVuZHMgdXAgYmVpbmcgdXNlZCB0bw0KPiBmaW5nZXJwcmludCB0aGUga2VybmVsIHN1cHBv
cnQsIGluc3RlYWQgb2YgYXMgdGhlIHZhbHVlIGl0IHdhcyBpbnRlbmRlZCB0byBiZS4NCg0KWWVz
LCBtb3JlIHN0YWJsZSBhbmQgcmVhc29uYWJsZSB3YXkgaXMgcHJlZmVyYWJsZS4NCg0KPiA+PiBX
ZSBoYXZlbid0IHNvbHZlZCB0aGUgcHJvYmxlbSENCj4gPj4NCj4gPj4gVG9kYXkgX19jcHVfc2V0
dXAoKSBzZXRzIFQwU1ogYW5kIFQxU1ogZGlmZmVyZW50bHkgZm9yIDUyYml0IFZBLCBidXQgaW4g
dGhlIGZ1dHVyZSBpdA0KPiA+PiBjb3VsZCBzZXQgdGhlbSB0aGUgc2FtZSwgb3IgZGlmZmVyZW50
IHRoZSBvdGhlci13YXktcm91bmQuDQo+ID4+DQo+ID4+IFdpbGwgbWFrZWR1bXBmaWxlIHVzaW5n
IHRoaXMgdmFsdWUga2VlcCB3b3JraW5nIG9uY2UgVDFTWiBpcyA1MmJpdCBWQSB0b28/IEluIHRo
aXMgY2FzZQ0KPiA+PiB0aGVyZSB3b3VsZCBiZSBubyB0dGJyIG9mZnNldC4NCj4gPg0KPiA+IElm
IFQxU1ogaXMgNTJiaXQsIHByb2JhYmx5IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3Mgc3RhcnRzIGZy
b20gMHhmZmYwMDAwMDAwMDAwMDAwLA0KPiANCj4gSSBkaWRuJ3QgdGhpbmsgdGhpcyAnYm90dG9t
IG9mIHRoZSB0dGJyMSBtYXBwaW5nIHJhbmdlJyB2YWx1ZSB3YXMgZXhwb3NlZCBhbnl3aGVyZS4N
Cj4gV2hlcmUgY2FuIHVzZXItc3BhY2UgZ2V0IHRoaXMgZnJvbT8gKEkgY2FuJ3Qgc2VlIGl0IGlu
IHRoZSB2bWNvcmVpbmZvIGxpc3QpDQo+IA0KPiANCj4gPiB0aGVuIHRoZSBvZmZzZXQgYmVjb21l
cyAwIHdpdGggdGhlIHBnZF9pbmRleCgpIGFib3ZlLg0KPiA+IEkgdGhpbmsgbWFrZWR1bXBmaWxl
IHdpbGwga2VlcCB3b3JraW5nIHdpdGggdGhhdC4NCj4gDQo+IA0KPiBTdGV2ZSBtZW50aW9ucyBh
IDUyLzQ4IGNvbWJpbmF0aW9uIGluIGhpcyBrZXJuZWwgc2VyaWVzOg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIwMTkwMjE4MTcwMjQ1LjE0OTE1LTEtc3RldmUu
Y2FwcGVyQGFybS5jb20vDQo+IA0KPiANCj4gSSB0aGluayB2bWNvcmVpbmZvLXVzZXJzIHdpbGwg
ZXZlbnR1YWxseSBuZWVkIHRvIHNwb3QgNTJiaXQgdXNlZCBpbiBUVEJSMSBhbmQvb3IgVFRCUjAs
DQo+IGFuZCBwb3NzaWJseTogY29uZmlndXJlZCwgYnV0IG5vdCBlbmFibGVkIGluIGVpdGhlci4g
KHRoaXMgaXMgYmVjYXVzZSB0aGUgYml0cyBhcmUgYWxzbw0KPiB1c2VkIGZvciBwb2ludGVyLWF1
dGgsIHRoZSBrZXJuZWwgbWF5IGJlIGJ1aWx0IGZvciBib3RoIHBvaW50ZXItYXV0aCBhbmQgNTIt
Yml0IFZBLCBhbmQNCj4gY2hvc2Ugd2hpY2ggdG8gZW5hYmxlZCBhdCBib290IGJhc2VkIG9uIHNv
bWUgcG9saWN5KQ0KPiANCj4gSSBkb24ndCBzZWUgaG93IHlvdSBjYW4gZG8gdGhpcyB3aXRoIG9u
ZSB2YWx1ZS4NCj4gSSdkIGxpa2UgdG8gZ2V0IHRoaXMgcmlnaHQgbm93LCBzbyB3ZSB1c2VyLXNw
YWNlIGRvZXNuJ3QgbmVlZCB1cGRhdGluZyBhZ2FpbiENCg0KSSBuZWVkIHRvIHVuZGVyc3RhbmQg
dGhlIDUyLWJpdCBrZXJuZWwgVkEgaW1wbGVtZW50YXRpb24sIHBvaW50ZXItYXV0aCwNCmFuZCBC
aHVwZXNoJ3MgZGlzY3Vzc2lvbi4gSSB3aWxsIGNhdGNoIHVwIHRoZW0uDQoNClRoYW5rcyBhIGxv
dCENCkthenUNCg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVzDQoNCg==

