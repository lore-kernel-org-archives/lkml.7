Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8076EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727E2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LAPskKWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfLEII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:08:57 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726059AbfLEII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:08:57 -0500
X-UUID: 1eae3ca3ba74429fa92ad57cedf1b72a-20191205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fYO5uWzyAp5Mepj7WHcXlxm3oDWpfSRVYpybAKDaNFk=;
        b=LAPskKWOxSlESJShch3X6ttl0+yhEbrAkc1eBKguJxo/LQYFvly8fRyN/2ywTk86Q38tDMOLM/MT7vinMbIajkkvMHbdmnDNn0AeyxbxEZ01VYkdp3mTXilnmQO/UjkJ7U8+h0cLl9NkHL2Bo2GJ4UIvOKRjRhfMZv7R4WAPatI=;
X-UUID: 1eae3ca3ba74429fa92ad57cedf1b72a-20191205
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 985730359; Thu, 05 Dec 2019 16:08:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Dec 2019 16:08:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Dec 2019 16:08:12 +0800
Message-ID: <1575533323.11236.5.camel@mtksdaap41>
Subject: Re: [PATCH v2] drm/mediatek: add ctm property support
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 Dec 2019 16:08:43 +0800
In-Reply-To: <1575277423-31182-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1575277423-31182-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AE4A3690827D802DD0F66D5D9CC38B9F4D54BDD034A40FED4BC1007954A2A5DE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDE5LTEyLTAyIGF0IDE3OjAzICswODAwLCB5b25n
cWlhbmcubml1QG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gRnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9u
Z3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IA0KPiBhZGQgY3RtIHByb3BlcnR5IHN1cHBvcnQN
Cj4gDQo+IENoYW5nZS1JZDogSTgxMTFkYTdiMzA5YjE4MDljNjMwMmU3NzQ4ZGQ5ZmQwNmRjOTdi
ZGUNCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
ICAgICB8IDE1ICsrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8IDExICsrKysrKw0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCg0KW3NuaXBd
DQoNCg0KPiBAQCAtODcwLDYgKzg3NSwxMiBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1
Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCj4gIAkJfQ0KPiAgDQo+ICAJCW10a19jcnRjLT5kZHBf
Y29tcFtpXSA9IGNvbXA7DQo+ICsNCj4gKwkJaWYgKGNvbXBfaWQgPT0gRERQX0NPTVBPTkVOVF9D
Q09SUikNCj4gKwkJCWhhc19jdG0gPSB0cnVlOw0KPiArDQo+ICsJCWlmIChjb21wX2lkID09IERE
UF9DT01QT05FTlRfR0FNTUEpDQoNCk5vdCBvbmx5IEREUF9DT01QT05FTlRfR0FNTUEgaGFzIGdh
bW1hIGZ1bmN0aW9uLCBidXQgYWxzbw0KRERQX0NPTVBPTkVOVF9BQUwwIGFuZCBERFBfQ09NUE9O
RU5UX0FBTDEuIEkgdGhpbmsgaXQncyBubyBnb29kIHRvIHVzZQ0KY29tcF9pZCB0byBkZWNpZGUg
d2hhdCBmdW5jdGlvbiBvZiB0aGlzIGNvbXBvbmVudCBoYXMuIFRoZSBlYXN5IHdheSBpcw0KanVz
dCB0byBjaGVjayB3ZWF0aGVyIHRoZSBmdW5jdGlvbiBwb2ludCBleGlzdC4NCg0KUmVnYXJkcywN
CkNLDQoNCj4gKwkJCWdhbW1hX2x1dF9zaXplID0gTVRLX0xVVF9TSVpFOw0KPiAgCX0NCj4gIA0K
PiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykNCj4gQEAgLTg5
MSw3ICs5MDIsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAq
ZHJtX2RldiwNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAlkcm1fbW9k
ZV9jcnRjX3NldF9nYW1tYV9zaXplKCZtdGtfY3J0Yy0+YmFzZSwgTVRLX0xVVF9TSVpFKTsNCj4g
LQlkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdCgmbXRrX2NydGMtPmJhc2UsIDAsIGZhbHNlLCBN
VEtfTFVUX1NJWkUpOw0KPiArCWRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KCZtdGtfY3J0Yy0+
YmFzZSwgMCwgaGFzX2N0bSwgZ2FtbWFfbHV0X3NpemUpOw0KPiAgCXByaXYtPm51bV9waXBlcysr
Ow0KPiAgI2lmZGVmIENPTkZJR19NVEtfQ01EUQ0KPiAgCW10a19jcnRjLT5jbWRxX2NsaWVudCA9
DQoNCg==

