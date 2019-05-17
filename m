Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5AB20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfEQSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:20:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:7450 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEQSUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:20:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 11:20:37 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2019 11:20:37 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 17 May 2019 11:20:37 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 fmsmsx101.amr.corp.intel.com ([169.254.1.175]) with mapi id 14.03.0415.000;
 Fri, 17 May 2019 11:20:36 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] mm, memory-failure: clarify error message
Thread-Topic: [PATCH] mm, memory-failure: clarify error message
Thread-Index: AQHVDGYyA0CPmuStD0eYJ9uY1/4/yKZwFv2A
Date:   Fri, 17 May 2019 18:20:35 +0000
Message-ID: <530f16a9207bd90b7752c8ea6bf38302a8cd7b4b.camel@intel.com>
References: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.254.87.144]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9903A53504C41478420F4FC21BBEA5A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTE2IGF0IDIyOjA4IC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4gU29t
ZSB1c2VyIHdobyBpbnN0YWxsIFNJR0JVUyBoYW5kbGVyIHRoYXQgZG9lcyBsb25nam1wIG91dA0K
PiB0aGVyZWZvcmUga2VlcGluZyB0aGUgcHJvY2VzcyBhbGl2ZSBpcyBjb25mdXNlZCBieSB0aGUg
ZXJyb3INCj4gbWVzc2FnZQ0KPiAgICJbMTg4OTg4Ljc2NTg2Ml0gTWVtb3J5IGZhaWx1cmU6IDB4
MTg0MDIwMDogS2lsbGluZw0KPiAgICBjZWxsc3J2OjMzMzk1IGR1ZSB0byBoYXJkd2FyZSBtZW1v
cnkgY29ycnVwdGlvbiINCj4gU2xpZ2h0bHkgbW9kaWZ5IHRoZSBlcnJvciBtZXNzYWdlIHRvIGlt
cHJvdmUgY2xhcml0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1IDxqYW5lLmNodUBv
cmFjbGUuY29tPg0KPiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCA3ICsrKystLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
aW5kZXggZmM4YjUxNy4uMTRkZTVlMiAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUu
Yw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0yMTYsMTAgKzIxNiw5IEBAIHN0
YXRpYyBpbnQga2lsbF9wcm9jKHN0cnVjdCB0b19raWxsICp0aywgdW5zaWduZWQgbG9uZyBwZm4s
IGludCBmbGFncykNCj4gIAlzaG9ydCBhZGRyX2xzYiA9IHRrLT5zaXplX3NoaWZ0Ow0KPiAgCWlu
dCByZXQ7DQo+ICANCj4gLQlwcl9lcnIoIk1lbW9yeSBmYWlsdXJlOiAlI2x4OiBLaWxsaW5nICVz
OiVkIGR1ZSB0byBoYXJkd2FyZSBtZW1vcnkgY29ycnVwdGlvblxuIiwNCj4gLQkJcGZuLCB0LT5j
b21tLCB0LT5waWQpOw0KPiAtDQo+ICAJaWYgKChmbGFncyAmIE1GX0FDVElPTl9SRVFVSVJFRCkg
JiYgdC0+bW0gPT0gY3VycmVudC0+bW0pIHsNCj4gKwkJcHJfZXJyKCJNZW1vcnkgZmFpbHVyZTog
JSNseDogS2lsbGluZyAlczolZCBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5ICINCj4gKwkJCSJjb3Jy
dXB0aW9uXG4iLCBwZm4sIHQtPmNvbW0sIHQtPnBpZCk7DQoNCk1pbm9yIG5pdCwgYnV0IHRoZSBz
dHJpbmcgc2hvdWxkbid0IGJlIHNwbGl0IG92ZXIgbXVsdGlwbGUgbGluZXMgdG8NCnByZXNlcnZl
IGdyZXAtYWJpbGl0eS4gSW4gc3VjaCBhIGNhc2UgaXQgaXMgdXN1YWxseSBjb25zaWRlcmVkIE9L
IHRvDQpleGNlZWQgODAgY2hhcmFjdGVycyBmb3IgdGhlIGxpbmUgaWYgbmVlZGVkLg0KDQo+ICAJ
CXJldCA9IGZvcmNlX3NpZ19tY2VlcnIoQlVTX01DRUVSUl9BUiwgKHZvaWQgX191c2VyICopdGst
PmFkZHIsDQo+ICAJCQkJICAgICAgIGFkZHJfbHNiLCBjdXJyZW50KTsNCj4gIAl9IGVsc2Ugew0K
PiBAQCAtMjI5LDYgKzIyOCw4IEBAIHN0YXRpYyBpbnQga2lsbF9wcm9jKHN0cnVjdCB0b19raWxs
ICp0aywgdW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gIAkJICogVGhpcyBjb3VsZCBj
YXVzZSBhIGxvb3Agd2hlbiB0aGUgdXNlciBzZXRzIFNJR0JVUw0KPiAgCQkgKiB0byBTSUdfSUdO
LCBidXQgaG9wZWZ1bGx5IG5vIG9uZSB3aWxsIGRvIHRoYXQ/DQo+ICAJCSAqLw0KPiArCQlwcl9l
cnIoIk1lbW9yeSBmYWlsdXJlOiAlI2x4OiBTZW5kaW5nIFNJR0JVUyB0byAlczolZCBkdWUgdG8g
aGFyZHdhcmUgIg0KPiArCQkJIm1lbW9yeSBjb3JydXB0aW9uXG4iLCBwZm4sIHQtPmNvbW0sIHQt
PnBpZCk7DQo+ICAJCXJldCA9IHNlbmRfc2lnX21jZWVycihCVVNfTUNFRVJSX0FPLCAodm9pZCBf
X3VzZXIgKil0ay0+YWRkciwNCj4gIAkJCQkgICAgICBhZGRyX2xzYiwgdCk7ICAvKiBzeW5jaHJv
bm91cz8gKi8NCj4gIAl9DQo=
