Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F48C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E2B206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfC0Pjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:39:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45379 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfC0Pjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:39:40 -0400
Received: by ajax-webmail-mail (Coremail) ; Wed, 27 Mar 2019 23:39:16 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [120.244.111.203]
Date:   Wed, 27 Mar 2019 23:39:16 +0800 (GMT+08:00)
From:   qiaochong <qiaochong@loongson.cn>
To:     "Doug Anderson" <dianders@chromium.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@mips.com>,
        "James Hogan" <jhogan@kernel.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "Christophe Leroy" <christophe.leroy@c-s.fr>,
        linux-mips <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>
Subject: Re:Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: /52iU2Zvb3Rlcl90eHQ9Mjc5Njo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <69c9a379.9e90.169bfce37d1.Coremail.qiaochong@loongson.cn>
X-CM-TRANSID: QMiowPDxpuQlmZtcjDO0AA--.9548W
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/1tbiAQACDFEBqdSvPAAGs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c29ycnkuIFRoZSBwYXRjaCBJIGp1c3Qgc2VudCBtaXNzaW5nIGhlYWRlciBhc20vaXJxcmVncy5o
LgpJIHJlc2VudCBhIHBhdGNoIGp1c3Qgbm93LgoKSSB1c2Uga2dkYiBvbiBsb29uZ3NvbiAzYSBw
bGF0Zm9ybSwgIHdoaWNoIGlzIDQgY29yZSBjcHUuCkxvb25nc29uIGNwdSBjYWxsIHNtcCBjYWxs
IGZ1bmN0aW9uIGJ5IGlwaSBpbnRlcnJ1cHQuCgpJIGhhdmUgdGVzdGVkIGNwdSBjbWQgaW4ga2Ri
IGFuZCBpbmZvIHRocmVhZHMgY21kIGluIGtnZGIgd2l0aCB0aGlzIHBhdGNoLgoKTWlwcyBzYXZl
IHJlZ3MgYW5kIHNldCAgcHRfcmVncyB0byAgY3VycmVudF90aHJlYWRfaW5mbygpLT5yZWdzKFRJ
X1JFR1MoJDI4KSkgYXMgYmVsbG93LgoKaGFuZGxlX2ludDoKLi4uClNBVkVfQUxMIGRvY2ZpPTEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIENMSSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRSQUNFX0lS
UVNfT0ZGICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IExPTkdfTCAgczAsIFRJX1JFR1MoJDI4KQpMT05HX1MgIHNwLCBUSV9SRUdTKCQyOCkKCnN0YXRp
YyBpbmxpbmUgc3RydWN0IHB0X3JlZ3MgKmdldF9pcnFfcmVncyh2b2lkKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICByZXR1cm4gY3VycmVudF90aHJl
YWRfaW5mbygpLT5yZWdzOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfQoK5ZyoIDIwMTktMDMtMjcgMjI6Mzc6MDLvvIwiRG91ZyBBbmRlcnNvbiIgPGRpYW5k
ZXJzQGNocm9taXVtLm9yZz4g5YaZ6YGT77yaCgo+SGksCj4KPk9uIFdlZCwgTWFyIDI3LCAyMDE5
IGF0IDY6MTcgQU0gcWlhb2Nob25nIDxxaWFvY2hvbmdAbG9vbmdzb24uY24+IHdyb3RlOgo+Pgo+
PiBLR0RCX2NhbGxfbm1pX2hvb2sgaXMgY2FsbGVkIGJ5IG90aGVyIGNwdSB0aHJvdWdoIHNtcCBj
YWxsLgo+PiBNSVBTIHNtcCBjYWxsIGlzIHByb2Nlc3NlZCBpbiBpcGkgaXJxIGhhbmRsZXIgYW5k
IHJlZ3MgaXMgc2F2ZWQgaW4KPj4gIGhhbmRsZV9pbnQuCj4+IFNvIGtnZGJfY2FsbF9ubWlfaG9v
ayBnZXQgcmVncyBieSBnZXRfaXJxX3JlZ3MgYW5kIHJlZ3Mgd2lsbCBiZSBwYXNzZWQKPj4gIHRv
IGtnZGJfY3B1X2VudGVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBxaWFvY2hvbmcgPHFpYW9jaG9u
Z0Bsb29uZ3Nvbi5jbj4KPj4gLS0tCj4+ICBhcmNoL21pcHMva2VybmVsL2tnZGIuYyB8IDIgKy0K
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9rZ2RiLmMgYi9hcmNoL21pcHMva2VybmVsL2tn
ZGIuYwo+PiBpbmRleCA2ZTU3NGMwMmU0YzNiLi42YzQzOGEwZmQyMDc1IDEwMDY0NAo+PiAtLS0g
YS9hcmNoL21pcHMva2VybmVsL2tnZGIuYwo+PiArKysgYi9hcmNoL21pcHMva2VybmVsL2tnZGIu
Ywo+PiBAQCAtMjE0LDcgKzIxNCw3IEBAIHZvaWQga2dkYl9jYWxsX25taV9ob29rKHZvaWQgKmln
bm9yZWQpCj4+ICAgICAgICAgb2xkX2ZzID0gZ2V0X2ZzKCk7Cj4+ICAgICAgICAgc2V0X2ZzKEtF
Uk5FTF9EUyk7Cj4+Cj4+IC0gICAgICAga2dkYl9ubWljYWxsYmFjayhyYXdfc21wX3Byb2Nlc3Nv
cl9pZCgpLCBOVUxMKTsKPj4gKyAgICAgICBrZ2RiX25taWNhbGxiYWNrKHJhd19zbXBfcHJvY2Vz
c29yX2lkKCksIGdldF9pcnFfcmVncygpKTsKPj4KPj4gICAgICAgICBzZXRfZnMob2xkX2ZzKTsK
Pj4gIH0KPgo+SSdtIGV4Y2l0ZWQgdG8gc2VlIG90aGVycyB1c2luZyBrZ2RiISAgOi0pCj4KPkFz
IGZhciBhcyBJIGNhbiB0ZWxsIHlvdXIgcGF0Y2ggaXMgZ29vZCwgb3IgYXQgbGVhc3QgYXMgc2Vl
bXMgbGlrZSBpdAo+d2lsbCBtYWtlIE1JUFMgb24gcGFyIHdpdGggb3RoZXIgcGxhdGZvcm1zLiAg
SSBhbHdheXMgd29uZGVyZWQgd2h5Cj5NSVBTIChhbmQgQVJDKSBkaWRuJ3QgaGF2ZSB0aGUgZ2V0
X2lycV9yZWdzKCkgY2FsbCBidXQgd2hlbiBJIGxhc3QKPnRvdWNoZWQgdGhpcyBjb2RlIEkgbGVm
dCBpdCBhbG9uZSBzaW5jZSBJIGRpZG4ndCBoYXZlIHRoZSBoaXN0b3J5IGZvcgo+aXQgYW5kIGhh
ZCBubyB3YXkgdG8gdGVzdC4gIFNpbmNlIGl0IHNlZW1zIGxpa2UgeW91IGhhdmUgYSB3YXkgdG8g
dGVzdAo+dGhpcyB0aGVuIHdlIHNob3VsZCBkbyBpdC4gIE5vdyB0byBmaW5kIHNvbWVvbmUgd2hv
IHdvdWxkIGRvIHRoZSBzYW1lCj5mb3IgQVJDLiAgOi1QICBUaHVzOgo+Cj5SZXZpZXdlZC1ieTog
RG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPgo+Cj5OT1RFIGFzIHBvaW50
ZWQgb3V0IGluIGNvZGUgcmV2aWV3cyB3aGVuIEkgbGFzdCB0b3VjaGVkIHRoaXMgY29kZSwKPnVz
aW5nIGdldF9pcnFfcmVncygpIGlzbid0IHBlcmZlY3Qgc2luY2UgaXQgY291bGQgcGxhdXNpYmx5
IHJldHVybgo+TlVMTC4gIEkgY3JlYXRlZCBhIGJ1ZyBpbiB0aGUgQ2hyb21pdW0gdHJhY2tlciB3
aXRoIGFsbCB0aGUgZGV0YWlscwo+Zm9yIHRoaXMgYXQgPGh0dHBzOi8vY3JidWcuY29tLzkwODcy
Mz4uCj4KPi1Eb3VnCg0KDQrljJfkuqzluILmtbfmt4DljLrkuK3lhbPmnZHnjq/kv53np5HmioDn
pLrojIPlm63pvpnoiq/kuqfkuJrlm60y5Y+35qW8IDEwMDA5NeeUteivnTogKzg2ICgxMCkgNjI1
NDY2NjjkvKDnnJ86ICs4NiAoMTApIDYyNjAwODI2d3d3Lmxvb25nc29uLmNu5pys6YKu5Lu25Y+K
5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv5Lit56eR5oqA5pyv5pyJ6ZmQ5YWs5Y+455qE5ZWG5Lia56eY
5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq
5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So
77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOoIOWIhuWcsOazhOmcsuOAgeWkjeWItuaI
luaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmU
meaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6
uuW5tuWIoOmZpOacrOmCruS7tuOAgiANCg0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRz
IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24NClRlY2hub2xv
Z3kgQ29ycG9yYXRpb24gTGltaXRlZCwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBl
cnNvbiBvciBlbnRpdHkNCndob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9m
IHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluDQphbnkgd2F5IChpbmNsdWRpbmcs
IGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLA0KcmVwcm9k
dWN0aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50KHMpDQppcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWls
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkNCnBob25lIG9yIGVtYWlsIGlt
bWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuIA==
