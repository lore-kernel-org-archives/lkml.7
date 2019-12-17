Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D51C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FA920716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfLQNxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:53:11 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:41569 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728388AbfLQNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:53:10 -0500
Received: from [46.226.52.196] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id F5/18-19908-4CDD8FD5; Tue, 17 Dec 2019 13:53:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRWlGSWpSXmKPExsVyU+ECq+6Ruz9
  iDb7P0ba4vGsOmwOjx+dNcgGMUayZeUn5FQmsGS8/72EruMlXca/7J0sD4wG+LkZODiGBfYwS
  pztVIeyzjBLNG8tBbDYBLYkZW6cygtgiAhoSL4/eYuli5OJgFuhklLj9+gBYQljAW+JRwzE2i
  CIfifb5X6EarCSW9k0Hs1kEVCXeN29kAbF5BXwl5nf2M4IMEhLoZ5TYcaeJFSTBKWAosf3bRi
  YQm1FAVuLRyl/sIDazgLjErSfzweISAgISS/acZ4awRSVePv7HCmEbSGxduo8FwlaUuLH6BFC
  cA8i2lrjxgB/EZBbQlFi/Sx9ioqLElO6H7BDnCEqcnPmEZQKj2Cwky2YhdMxC0jELSccCRpZV
  jOZJRZnpGSW5iZk5uoYGBrqGhka6hpYWukYWeolVukl6qaW65anFJbqGeonlxXrFlbnJOSl6e
  aklmxiB8ZVScExmB2PHp7d6hxglOZiURHnf7vwRK8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCN+
  sOUE6wKDU9tSItMwcY6zBpCQ4eJRFefZA0b3FBYm5xZjpE6hSjJceEl3MXMXMcPDoPSB6Zu3Q
  RsxBLXn5eqpQ470mQBgGQhozSPLhxsHR0iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwbzvI
  FJ7MvBK4ra+ADmICOsjI7xvIQSWJCCmpBqa5q0/ucjvqHHxHP6Jpk/nnRedj/+zR2dy/sbDE6
  cuvX4XMWi80PsxMa6/46fj6v5b0nHnOIYzSz3jubEvRW8nCsNIi6E78EQNt++e7esS8DX8963
  f/9jQ7SCR7w9efPXv7q1zs/lXlLJjGuDpkR98ay00RH1dc9ZuR+yyjznPFXOs5e08J/zxSaXB
  2e4GIwtZHaadZ+v9Kr3Q232V4cvr/NM+LWb2P503hszqUtMk70UWq+/mER8rSh54LPb15gMNw
  q7wVX/arJPUP0xSag6Yf39t5nO/v7d4Twt/sniQtjz8tufPfCfduLfMfm/8VWO9/9PzzewbjX
  nnB6IinK/quFf3hZrk0b8q+h1K9l9aXK7EUZyQaajEXFScCAM9uV6fCAwAA
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-33.tower-284.messagelabs.com!1576590788!695443!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22366 invoked from network); 17 Dec 2019 13:53:08 -0000
Received: from unknown (HELO exukdagfar01.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-33.tower-284.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Dec 2019 13:53:08 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Dec 2019 13:53:07 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Tue, 17 Dec 2019 13:53:07 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVtN0iUtD2ObauYk2ExPz0BKUZFqe+UyYAgAAAZ/Y=
Date:   Tue, 17 Dec 2019 13:53:06 +0000
Message-ID: <823cb0c0263c441aaaf256169de5a816@exukdagfar01.INTERNAL.ROOT.TES>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>,<20191217133234.GB3362771@kroah.com>
In-Reply-To: <20191217133234.GB3362771@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.194.37.115]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KVGhhbmtzIGZvciB0aGUgc3BlZWR5IHJlcGxpZXMuIFllcywgSSB3aWxsIGFk
ZCBtb3JlIGJhY2tncm91bmQgaW5mb3JtYXRpb24gYW5kIG1ha2UgdGhlIHF1aWNrIGZvcm1hdHRp
bmcgY2hhbmdlcyBmb3IgYSB2Mi4gV2UnbGwgcmVwbHkgdG8geW91ciBvdGhlciBlbWFpbCBjb21t
ZW50cyBhbmQgZ2V0IHRob3NlIHJlc29sdmVkIGFzIHdlbGwuIEkgd2FzIHRyeWluZyB0byBiZSB0
ZXJzZSBidXQgbG9va3MgbGlrZSBJIHdhcyB0b28gdGVyc2UuIEkgdGhvdWdodCB0aGUgY2hhbmdl
bG9nIHRleHQgc2hvdWxkIGJlIGJyaWVmIGFuZCB0aGUgY292ZXIgbGV0dGVyIHdvdWxkIGJlIG1v
cmUgdmVyYm9zZT8NCg0KUmVnYXJkcywNCkRhdmUNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KRnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNywgMjAxOSAxOjMyIFBNDQpUbzogS2ltLCBE
YXZpZA0KQ2M6IGFybmRAYXJuZGIuZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1h
Z2VlLCBUaW0NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBkcml2ZXJzOiBtaXNjOiBBZGQgc3Vw
cG9ydCBmb3IgbkNpcGhlciBIU00gZGV2aWNlcw0KDQpPbiBUdWUsIERlYyAxNywgMjAxOSBhdCAw
MToyMjo0NFBNICswMDAwLCBEYXZlIEtpbSB3cm90ZToNCj4g77u/RnJvbTogRGF2aWQgS2ltIDxk
YXZpZC5raW1AbmNpcGhlci5jb20+DQo+DQo+IEludHJvZHVjZSB0aGUgZHJpdmVyIGZvciBuQ2lw
aGVyJ3MgU29sbyBhbmQgU29sbyBYQyByYW5nZSBvZiBQQ0llIGhhcmR3YXJlDQo+IHNlY3VyaXR5
IG1vZHVsZXMgKEhTTSksIHdoaWNoIHByb3ZpZGUga2V5IGNyZWF0aW9uL21hbmFnZW1lbnQgYW5k
DQo+IGNyeXB0b2dyYXBoeSBzZXJ2aWNlcy4NCg0KQSBiaXQgbW9yZSBkZXNjcmlwdGlvbiBvZiBl
eGFjdGx5IF93aGF0XyB0aGVzZSBkZXZpY2VzIGRvIHdvdWxkIGJlDQpoZWxwZnVsLg0KDQpBbHNv
LCBob3cgZG9lcyB1c2Vyc3BhY2UgaW50ZXJhY3Qgd2l0aCB0aGUgZHJpdmVyPyAgV2hhdCBhcGko
cykgYXJlIHlvdQ0KdXNpbmcvY3JlYXRpbmc/ICBXaGF0IHVzZXJzcGFjZSB0b29scyB3b3JrIHdp
dGggdGhlIGRldmljZT8NCg0KSW4gc2hvcnQsIHdlIG5lZWQgbW9yZSB0aGFuIGp1c3QgYSBvbmUg
c2VudGFuY2UgZGVzY3JpcHRpb24gdG8gYmUgYWJsZQ0KdG8gcHJvcGVybHkgcmV2aWV3IHRoZSBj
b2RlIGFuZCBwcm92aWRlIHRleHQgZm9yIGEgdXNlciB0byBrbm93IHdoYXQgdG8NCmRvIHdpdGgg
dGhpcyBkcml2ZXIuDQoNCkNhbiB5b3UgZml4IGFsbCB0aGF0IHVwIGFuZCBzZW5kIGEgdjI/DQoN
CnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==
