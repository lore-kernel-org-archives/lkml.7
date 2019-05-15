Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815CC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419DD2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEOGwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:52:09 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:48168 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:52:08 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id AC04224E2491;
        Wed, 15 May 2019 08:52:06 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 May
 2019 08:52:06 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 15 May 2019 08:52:06 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Jeff Kletsky <lede@allycomm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spinand: Add support for two-byte device IDs
Thread-Topic: [PATCH v2 2/3] mtd: spinand: Add support for two-byte device IDs
Thread-Index: AQHVCp/WPaZWYiYCKEGU6+s/F1KvdqZrnqKA
Date:   Wed, 15 May 2019 06:52:06 +0000
Message-ID: <b7d79b90-a690-6b31-662e-6ad63eb93b50@kontron.de>
References: <20190514215315.19228-1-lede@allycomm.com>
 <20190514215315.19228-3-lede@allycomm.com>
In-Reply-To: <20190514215315.19228-3-lede@allycomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BAF618DD1E9414784A6D8C384C38383@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: AC04224E2491.A8D1F
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, lede@allycomm.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDUuMTkgMjM6NTMsIEplZmYgS2xldHNreSB3cm90ZToNCj4gRnJvbTogSmVmZiBLbGV0
c2t5IDxnaXQtY29tbWl0c0BhbGx5Y29tbS5jb20+DQo+IA0KPiBUaGUgR2lnYURldmljZSBHRDVG
MUdRNFVGeHhHIFNQSSBOQU5EIHV0aWxpemVzIHR3by1ieXRlIGRldmljZSBJRHMuDQo+IA0KPiBo
dHRwOi8vd3d3LmdpZ2FkZXZpY2UuY29tL2RhdGFzaGVldC9nZDVmMWdxNHhmeHhnLw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmVmZiBLbGV0c2t5IDxnaXQtY29tbWl0c0BhbGx5Y29tbS5jb20+DQoN
ClJldmlld2VkLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jIHwgMiArLQ0KPiAg
IGluY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaCB8IDQgKystLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0K
PiBpbmRleCBmYTg3YWUyOGNkZmUuLmExMzE1NDc4NWRhZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvbmFuZC9zcGkvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUu
Yw0KPiBAQCAtODUzLDcgKzg1Myw3IEBAIHNwaW5hbmRfc2VsZWN0X29wX3ZhcmlhbnQoc3RydWN0
IHNwaW5hbmRfZGV2aWNlICpzcGluYW5kLA0KPiAgICAqLw0KPiAgIGludCBzcGluYW5kX21hdGNo
X2FuZF9pbml0KHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4gICAJCQkgICBjb25z
dCBzdHJ1Y3Qgc3BpbmFuZF9pbmZvICp0YWJsZSwNCj4gLQkJCSAgIHVuc2lnbmVkIGludCB0YWJs
ZV9zaXplLCB1OCBkZXZpZCkNCj4gKwkJCSAgIHVuc2lnbmVkIGludCB0YWJsZV9zaXplLCB1MTYg
ZGV2aWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbmFuZF9kZXZpY2UgKm5hbmQgPSBzcGluYW5kX3Rv
X25hbmQoc3BpbmFuZCk7DQo+ICAgCXVuc2lnbmVkIGludCBpOw0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tdGQvc3BpbmFuZC5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oDQo+
IGluZGV4IDA1ZmU5OGVlYmUyNy4uODkwMWJhMjcyNTM4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L210ZC9zcGluYW5kLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5o
DQo+IEBAIC0yOTAsNyArMjkwLDcgQEAgc3RydWN0IHNwaW5hbmRfZWNjX2luZm8gew0KPiAgICAq
Lw0KPiAgIHN0cnVjdCBzcGluYW5kX2luZm8gew0KPiAgIAljb25zdCBjaGFyICptb2RlbDsNCj4g
LQl1OCBkZXZpZDsNCj4gKwl1MTYgZGV2aWQ7DQo+ICAgCXUzMiBmbGFnczsNCj4gICAJc3RydWN0
IG5hbmRfbWVtb3J5X29yZ2FuaXphdGlvbiBtZW1vcmc7DQo+ICAgCXN0cnVjdCBuYW5kX2VjY19y
ZXEgZWNjcmVxOw0KPiBAQCAtNDQ1LDcgKzQ0NSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzcGlu
YW5kX3NldF9vZl9ub2RlKHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4gICANCj4g
ICBpbnQgc3BpbmFuZF9tYXRjaF9hbmRfaW5pdChzdHJ1Y3Qgc3BpbmFuZF9kZXZpY2UgKmRldiwN
Cj4gICAJCQkgICBjb25zdCBzdHJ1Y3Qgc3BpbmFuZF9pbmZvICp0YWJsZSwNCj4gLQkJCSAgIHVu
c2lnbmVkIGludCB0YWJsZV9zaXplLCB1OCBkZXZpZCk7DQo+ICsJCQkgICB1bnNpZ25lZCBpbnQg
dGFibGVfc2l6ZSwgdTE2IGRldmlkKTsNCj4gICANCj4gICBpbnQgc3BpbmFuZF91cGRfY2ZnKHN0
cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwgdTggbWFzaywgdTggdmFsKTsNCj4gICBpbnQg
c3BpbmFuZF9zZWxlY3RfdGFyZ2V0KHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwgdW5z
aWduZWQgaW50IHRhcmdldCk7DQo+IA==
