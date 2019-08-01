Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C611C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30406214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfHAJ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:26:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfHAJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:26:47 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5C8EA79EC784232036FF;
        Thu,  1 Aug 2019 17:26:44 +0800 (CST)
Received: from DGGEMI524-MBX.china.huawei.com ([169.254.7.227]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 17:26:34 +0800
From:   chengzhihao <chengzhihao1@huawei.com>
To:     Richard Weinberger <richard@nod.at>
CC:     "zhangyi (F)" <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCBSRkNdIHViaTogdWJpX3dsX2dldF9w?=
 =?utf-8?B?ZWI6IFJlcGxhY2UgYSBsaW1pdGVkIG51bWJlciBvZiBhdHRlbXB0cyB3aXRo?=
 =?utf-8?Q?_polling_while_getting_PEB?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggUkZDXSB1Ymk6IHViaV93bF9nZXRfcGViOiBSZXBs?=
 =?utf-8?B?YWNlIGEgbGltaXRlZCBudW1iZXIgb2YgYXR0ZW1wdHMgd2l0aCBwb2xsaW5n?=
 =?utf-8?Q?_while_getting_PEB?=
Thread-Index: AQHVSEkuRooM7Daz00mNhjuG43MDw6bmAggAJrEe1mz+ynmUUA==
Date:   Thu, 1 Aug 2019 09:26:34 +0000
Message-ID: <0B80F9D4116B2F4484E7279D5A66984F7A8A3A@dggemi524-mbx.china.huawei.com>
References: <1564651065-4585-1-git-send-email-chengzhihao1@huawei.com>
 <0B80F9D4116B2F4484E7279D5A66984F7A8A13@dggemi524-mbx.china.huawei.com>
 <1515821930.55881.1564651254907.JavaMail.zimbra@nod.at>
In-Reply-To: <1515821930.55881.1564651254907.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.224.82]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZb3Ugc2VuZCB0aGlzIHBhdGNoIHRocmVlIHRpbWVzLCBJIGd1ZXNzIHlvdXIgbWFpbCBzZXR1
cCBoYXMgaXNzdWVzPyA6LSkNClNvcnJ5LCBJIHRob3VnaHQgSSBoYWRuJ3Qgc2VudCB0aGUgZmly
c3QgdHdvIGUtbWFpbHMuIChUaGUgUGF0Y2ggd29yayB3ZWJzaXRlIHJlZnJlc2hlcyBzbG93bHkp
DQoNCj4gRG8geW91IGhhdmUgbnVtYmVycyBob3cgbWFueSBhdHRlbXB0cyB3ZXJlIG5lZWRlZCB0
byBnZXQgYSBmcmVlIGJsb2NrPw0KSSB0ZXN0ZWQgaXQgZG96ZW5zIG9mIHRpbWVzLiBUaGUgYmln
Z2VzdCBudW1iZXIgb2YgYXR0ZW1wdHMgSSd2ZSBldmVyIGhhZCBzbyBmYXIgaXMgNi4gSW4gbW9z
dCBjYXNlcywgaXQgb25seSB0YWtlcyAyIG9yIDMgdGltZXMuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogUmljaGFyZCBXZWluYmVyZ2VyIFttYWlsdG86cmljaGFyZEBub2Qu
YXRdIA0K5Y+R6YCB5pe26Ze0OiAyMDE55bm0OOaciDHml6UgMTc6MjENCuaUtuS7tuS6ujogY2hl
bmd6aGloYW8gPGNoZW5nemhpaGFvMUBodWF3ZWkuY29tPg0K5oqE6YCBOiB6aGFuZ3lpIChGKSA8
eWkuemhhbmdAaHVhd2VpLmNvbT47IGxpbnV4LW10ZCA8bGludXgtbXRkQGxpc3RzLmluZnJhZGVh
ZC5vcmc+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQrkuLvp
opg6IFJlOiDnrZTlpI06IFtQQVRDSCBSRkNdIHViaTogdWJpX3dsX2dldF9wZWI6IFJlcGxhY2Ug
YSBsaW1pdGVkIG51bWJlciBvZiBhdHRlbXB0cyB3aXRoIHBvbGxpbmcgd2hpbGUgZ2V0dGluZyBQ
RUINCg0KLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQ0KPiBWb246ICJjaGVuZ3poaWhh
bzEiIDxjaGVuZ3poaWhhbzFAaHVhd2VpLmNvbT4NCj4gQW46ICJyaWNoYXJkIiA8cmljaGFyZEBu
b2QuYXQ+LCAieWkgemhhbmciIDx5aS56aGFuZ0BodWF3ZWkuY29tPg0KPiBDQzogImxpbnV4LW10
ZCIgPGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnPiwgImxpbnV4LWtlcm5lbCIgDQo+IDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBHZXNlbmRldDogRG9ubmVyc3RhZywgMS4g
QXVndXN0IDIwMTkgMTE6MTM6MjANCj4gQmV0cmVmZjog562U5aSNOiBbUEFUQ0ggUkZDXSB1Ymk6
IHViaV93bF9nZXRfcGViOiBSZXBsYWNlIGEgbGltaXRlZCBudW1iZXIgDQo+IG9mIGF0dGVtcHRz
IHdpdGggcG9sbGluZyB3aGlsZSBnZXR0aW5nIFBFQg0KDQo+IEkgZG9uJ3QgcXVpdGUgdW5kZXJz
dGFuZCB3aHkgYSBsaW1pdGVkIG51bWJlciBvZiBhdHRlbXB0cyBoYXZlIGJlZW4gDQo+IG1hZGUg
dG8gZ2V0IGEgZnJlZSBQRUIgaW4gdWJpX3dsX2dldF9wZWIgKGluIGZhc3RtYXAtd2wuYykuIEkg
cHJvcG9zZWQgDQo+IHRoaXMgUEFUQ0ggd2l0aCByZWZlcmVuY2UgdG8gdGhlIGltcGxlbWVudGF0
aW9uIG9mIHViaV93bF9nZXRfcGViIChpbiANCj4gd2wuYykuIEFzIGZhciBhcyBJIGtub3csIGdl
dHRpbmcgUEVCIGJ5IHBvbGxpbmcgcHJvYmFibHkgd29uJ3QgZmFsbCBpbnRvIHNvZnQtbG9ja3Vw
Lg0KPiB1YmlfdXBkYXRlX2Zhc3RtYXAgbWF5IGFkZCBuZXcgdGFza3MgKGluY2x1ZGluZyBlcmFz
ZSB0YXNrIG9yIHdsIA0KPiB0YXNraywgd2wgdGFza3MgZ2VuZXJhbGx5IGRvIG5vdCBnZW5lcmF0
ZSBhZGRpdGlvbmFsIGZyZWUgUEVCcykgdG8gDQo+IHViaS0+d29ya3MsIGFuZCBwcm9kdWNlX2Zy
ZWVfcGViIHdpbGwgZXZlbnR1YWxseSBjb21wbGV0ZSBhbGwgdGFza3MgaW4gDQo+IHViaS0+d29y
a3Mgb3Igb2J0YWluIGFuIGZyZWUgUEVCIHRoYXQgY2FuIGJlIGZpbGxlZCBpbnRvIHBvb2wuDQoN
CllvdSBzZW5kIHRoaXMgcGF0Y2ggdGhyZWUgdGltZXMsIEkgZ3Vlc3MgeW91ciBtYWlsIHNldHVw
IGhhcyBpc3N1ZXM/IDotKQ0KIA0KVGhpcyBpcyBvbmUgb2YgdGhlIGRhcmtlc3QgY29ybmVycyBv
ZiBGYXN0bWFwIHdoZXJlIHRoaW5ncyBnZXQgbWVzc3kuDQpUaGUgbnVtYmVyIG9mIHJldHJ5IGF0
dGVtcHRzIHdhcyBsaW1pdGVkIHRvIGF2b2lkIGEgbGl2ZSBsb2NrLg0KDQpJIGFncmVlIHRoYXQg
YWxsb3dpbmcgb25seSBvbmUgcmV0cnkgaXMgYSBsaXR0bGUgdG8gZmV3Lg0KV2l0aCBuYW5kc2lt
LCBhIHNtYWxsIG5hbmQgYW5kIGEgZmFzdCBQQyB5b3UgY2FuIGhpdCB0aGF0Lg0KDQpEbyB5b3Ug
aGF2ZSBudW1iZXJzIGhvdyBtYW55IGF0dGVtcHRzIHdlcmUgbmVlZGVkIHRvIGdldCBhIGZyZWUg
YmxvY2s/DQoNClRoYW5rcywNCi8vcmljaGFyZA0K
