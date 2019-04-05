Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfDEGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:51:50 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:57390 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfDEGvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:51:50 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-2c-5ca6fb04cd18
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 47.48.05313.40BF6AC5; Fri,  5 Apr 2019 08:51:48 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Fri, 5 Apr 2019 08:51:44 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks
 list
Thread-Topic: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating
 clocks list
Thread-Index: AQHU6zDhsEv70ksLMUWTxM/SG851haYtACOA
Date:   Fri, 5 Apr 2019 06:51:43 +0000
Message-ID: <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
References: <20190404215344.6330-1-sboyd@kernel.org>
         <20190404215344.6330-2-sboyd@kernel.org>
In-Reply-To: <20190404215344.6330-2-sboyd@kernel.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <754FC85CFB2A034C9293C1B78B81256A@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUgUURznzcyu4zH1Wq+XltBSQkaWkTYftKwlWL+EYJ9iS0cdd8U9bHbX
        1MyElPKoDDRxUwvzqjwXsggtXaXSgoiVLcMCj5I8OsywTbNmdvL49P7vd/x//8f7k7jstjSA
        TNWbWE7PaOVSD6KnabFjN7HYoNp7w+5Bz4z14/TQuJr+XvJBQtsfVUlpW3k3oPsuPpbQrweP
        0suODoJ22l5h0e5Ku+M1rvz6tsBNWdN8Vmm/chlTto/dkyitdwulyh/WoFi3E56RiYwpIy5V
        rd9zMMFTM9RSKU3vh5nz5TZpHiiBRcCdRHA/elNwFRQBD1IGHQB1dv8hxMszgEovvMSKAElK
        YSQqGnYTDD4wAdVf/4ELGhzOYujjbLOL8IZx6P3INC6KjqNfD6aBWO9D+ZMzmFATcDt6VtHn
        wil4DPVOTblwGd+0z1Hv6uMOw1He/TqXBsCtqDDvi0uDQ39k/bQgEaeGqK7rFS7Wvujz+PJ/
        XI66naOEMDMOd6K2R3tEazSaG2wnxHobKisedRNH2IQGKieIUuBnWZdgWXNb1rkt69yWde5b
        QHIXIB2TqlUzJjYslGPNoZxBo+OPJIPOCsRvnn8I/tpibACSQO5FnRxvUMkkTIYxS2cDm0lM
        7kvFVvDQhkRDcpaGMWriObOWNdoAInG5DxV0h+eoZCYrm+UMK1QgScj9qTONZSoZFJLTWDad
        5VbYLSQpRxTzmzdu4lg1m5mSqjWt0RjpLjT3CPAxsvpklmPMJk28sC3xRn5dBMqLzz3nFHKN
        6YyOR0XrINhF9tSOVuPkbO9kNS4j9AY9G+BPHRGSoCDVmPWrQVPAn3+vN1UosF785q/2meIj
        MD6CNt8UIkzMGhWQB9C30aUBekiSs2AKPuDTOefp7KuKwiaSPA8/CSRa25oqAjf6KSJys08t
        1OQMa1tQD/nwZ8yhOqfjRYQyeDZBZTV5b097N56x93TlluKq5zvCryH7+drGlIjJ+JElSf5T
        xZ2vrSpF6+6U0lyFYl4TVa6eCcu8NL3QlUTVlx1RhMgJo4YJC8E5I/MPPB2zJLYDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzIQ0KDQpPbiBU
aHUsIDIwMTktMDQtMDQgYXQgMTQ6NTMgLTA3MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gV2Ug
cmVjZW50bHkgaW50cm9kdWNlZCBhIGNoYW5nZSB0byBzdXBwb3J0IGRldm0gY2xrIGxvb2t1cHMu
IFRoYXQNCj4gY2hhbmdlDQo+IGludHJvZHVjZWQgYSBjb2RlLXBhdGggdGhhdCB1c2VkIGNsa19m
aW5kKCkgd2l0aG91dCBob2xkaW5nIHRoZQ0KPiAnY2xvY2tzX211dGV4Jy4gVW5mb3J0dW5hdGVs
eSwgY2xrX2ZpbmQoKSBpdGVyYXRlcyBvdmVyIHRoZSAnY2xvY2tzJw0KPiBsaXN0IGFuZCBzbyB3
ZSBuZWVkIHRvIHByZXZlbnQgdGhlIGxpc3QgZnJvbSBiZWluZyBtb2RpZmllZCB3aGlsZQ0KPiBp
dGVyYXRpbmcgb3ZlciBpdCBieSBob2xkaW5nIHRoZSBtdXRleC4gU2ltaWxhcmx5LCB3ZSBkb24n
dCBuZWVkIHRvDQo+IGhvbGQNCj4gdGhlICdjbG9ja3NfbXV0ZXgnIGJlc2lkZXMgd2hlbiB3ZSdy
ZSBkZXJlZmVyZW5jaW5nIHRoZSBjbGtfbG9va3VwDQo+IHBvaW50ZXINCg0KLy8vIFNuaXANCg0K
PiAtb3V0Og0KPiArc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwICpjbGtfZmluZChjb25zdCBjaGFy
ICpkZXZfaWQsIGNvbnN0IGNoYXINCj4gKmNvbl9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgY2xrX2xv
b2t1cCAqY2w7DQo+ICsNCj4gKwltdXRleF9sb2NrKCZjbG9ja3NfbXV0ZXgpOw0KPiArCWNsID0g
X19jbGtfZmluZChkZXZfaWQsIGNvbl9pZCk7DQo+ICAJbXV0ZXhfdW5sb2NrKCZjbG9ja3NfbXV0
ZXgpOw0KPiAgDQo+IC0JcmV0dXJuIGNsID8gY2xrIDogRVJSX1BUUigtRU5PRU5UKTsNCj4gKwly
ZXR1cm4gY2w7DQo+ICt9DQoNCkkgYW0gbm90IGFuIGV4cGVydCBvbiB0aGlzIGJ1dCByZWFkaW5n
IGNvbW1pdCBtZXNzYWdlIGFib3dlIGFuZCBzZWVpbmcNCnRoZSBjb2RlIGZvciBjbGtfZmluZCgp
IGxvb2tzIGEgYml0IHNjYXJ5LiBJZiBJIHVuZGVyc3RhbmQgaXQNCmNvcnJlY3RseSwgdGhlIGNs
b2Nrc19tdXRleCBzaG91bGQgYmUgaGVsZCB3aGVuIGRlcmVmZXJlbmNpbmcgdGhlDQpjbGtfbG9v
a3VwIHJldHVybmVkIGJ5IGNsa19maW5kLiBUaGUgY2xrX2ZpbmQgaW1wbGVtZW50YXRpb24gZHJv
cHMgdGhlDQpsb2NrIGJlZm9yZSByZXR1cm5pbmcgLSB3aGljaCBtYWtlcyBtZSB0aGluayBJIG1p
c3Mgc29tZXRoaW5nIGhlcmUuIEhvdw0KY2FuIHRoZSBjYWxsZXIgZXZlciBzYWZlbHkgZGVyZWZl
cmVuY2UgcmV0dXJuZWQgY2xrX2xvb2t1cCBwb2ludGVyPw0KSnVzdCByZWFkaW5nIGFib3dlIG1h
a2VzIG1lIHRoaW5rIHRoYXQgbG9jayBzaG91bGQgYmUgdGFrZW4gYnkgd2hvZXZlcg0KaXMgY2Fs
bGluZyB0aGUgY2xrX2ZpbmQsIGFuZCBkcm9wcGVkIG9ubHkgYWZ0ZXIgY2FsbGVyIGhhcyB1c2Vk
IHRoZQ0KZm91bmQgY2xrX2xvb2t1cCBmb3Igd2hhdGV2ZXIgY2FsbGVyIGludGVuZHMgdG8gdXNl
IGl0LiBNYXliZSBJIGFtDQptaXNzaW5nIHNvbWV0aGluZz8NCg0KQnIsDQoJTWF0dGkgVmFpdHRp
bmVuDQo=
