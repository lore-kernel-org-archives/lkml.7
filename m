Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DFC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E9521743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEUJbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:31:08 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:38418 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:31:08 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 67FAE712765;
        Tue, 21 May 2019 11:31:05 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 May
 2019 11:31:04 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 21 May 2019 11:31:04 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Richard Weinberger" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength
 and nand-ecc-step-size optional
Thread-Topic: [PATCH v2 1/2] dt-bindings: mtd: brcmnand: Make
 nand-ecc-strength and nand-ecc-step-size optional
Thread-Index: AQHVDz8jb5hF1+WcOEmTRsDzDEmg4aZ1L8wA
Date:   Tue, 21 May 2019 09:31:04 +0000
Message-ID: <5986da5d-2a61-b98d-9d44-d972a19ab732@kontron.de>
References: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <B54EE96B077D034D931F5F0990D55015@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 67FAE712765.AEBDC
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bcm-kernel-feedback-list@broadcom.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2FtYWwsDQoNCk9uIDIwLjA1LjE5IDIxOjA1LCBLYW1hbCBEYXN1IHdyb3RlOg0KPiBuYW5k
LWVjYy1zdHJlbmd0aCBhbmQgbmFuZC1lY2Mtc3RlcC1zaXplIGNhbiBiZSBtYWRlIG9wdGlvbmFs
IGFzDQo+IGJyY21uYW5kIGRyaXZlciBjYW4gc3VwcG9ydCB1c2luZyByYXcgTkFORCBsYXllciBk
ZXRlY3RlZCB2YWx1ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYW1hbCBEYXN1IDxrZGFzdS5r
ZGV2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL210ZC9icmNtLGJyY21uYW5kLnR4dCB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9icmNtLGJyY21uYW5kLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYnJjbSxicmNtbmFuZC50eHQNCj4gaW5k
ZXggYmNkYTFkZi4uMjlmZWFiYSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL210ZC9icmNtLGJyY21uYW5kLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2JyY20sYnJjbW5hbmQudHh0DQo+IEBAIC0xMDEsMTAg
KzEwMSwxMCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG51bWJlciAoZS5nLiwgMCwgMSwgMiwgZXRjLikNCj4gICAtICNhZGRyZXNzLWNl
bGxzICAgICAgICAgICAgOiBzZWUgcGFydGl0aW9uLnR4dA0KPiAgIC0gI3NpemUtY2VsbHMgICAg
ICAgICAgICAgICA6IHNlZSBwYXJ0aXRpb24udHh0DQo+IC0tIG5hbmQtZWNjLXN0cmVuZ3RoICAg
ICAgICAgOiBzZWUgbmFuZC50eHQNCj4gLS0gbmFuZC1lY2Mtc3RlcC1zaXplICAgICAgICA6IG11
c3QgYmUgNTEyIG9yIDEwMjQuIFNlZSBuYW5kLnR4dA0KPiAgIA0KPiAgIE9wdGlvbmFsIHByb3Bl
cnRpZXM6DQo+ICstIG5hbmQtZWNjLXN0cmVuZ3RoICAgICAgICAgOiBzZWUgbmFuZC50eHQNCj4g
Ky0gbmFuZC1lY2Mtc3RlcC1zaXplICAgICAgICA6IG11c3QgYmUgNTEyIG9yIDEwMjQuIFNlZSBu
YW5kLnR4dA0KPiAgIC0gbmFuZC1vbi1mbGFzaC1iYnQgICAgICAgICA6IGJvb2xlYW4sIHRvIGVu
YWJsZSB0aGUgb24tZmxhc2ggQkJUIGZvciB0aGlzDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY2hpcC1zZWxlY3QuIFNlZSBuYW5kLnR4dA0KPiAgIC0gYnJjbSxuYW5kLW9vYi1z
ZWN0b3Itc2l6ZSA6IGludGVnZXIsIHRvIGRlbm90ZSB0aGUgc3BhcmUgYXJlYSBzZWN0b3Igc2l6
ZQ0KDQpJIHRoaW5rIHlvdSBhbHNvIG5lZWQgdG8gY2hhbmdlIGFsbCByZWZlcmVuY2VzIHRvIG5h
bmQudHh0LiBUaGlzIGZpbGUgDQp3YXMgcmVjZW50bHkgbW92ZWQgdG8gbmFuZC1jb250cm9sbGVy
LnlhbWwuDQoNClJlZ2FyZHMsDQpGcmllZGVy
