Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168CC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AE21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U6HE9yGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKLIAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:00:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbfKLIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:00:11 -0500
X-UUID: 1f35b5d1f85a4f4c9ed00ad46d019617-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4RVlzdcDuNrzrh5f83WnNDQstUL/8Qt6uk2mPJJ+ERY=;
        b=U6HE9yGRkWNGNiLOwdYGx+akMPQRd2fQ6EyZG59SmsfYeSAA6b9Bo1rE3GeN8kaXfl4V1fu6PINlag6n42MKaddop2rblfHrU1V/WloQvJjbFcjeokYILq8CcOqbyIH+3zC3m8z5G/a2QzjOnHYGD32Y1vtcMHlugKJMoUJRCbI=;
X-UUID: 1f35b5d1f85a4f4c9ed00ad46d019617-20191112
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 883599369; Tue, 12 Nov 2019 16:00:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:00:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:00:00 +0800
Message-ID: <1573545601.14232.8.camel@mtkswgap22>
Subject: Re: [PATCH v2] soc: mediatek: add SMC fid table for SIP interface
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 12 Nov 2019 16:00:01 +0800
In-Reply-To: <71b9cfcc-bd4f-75de-0057-d64c5dc49e92@gmail.com>
References: <1573439402-16249-1-git-send-email-eason.yen@mediatek.com>
         <71b9cfcc-bd4f-75de-0057-d64c5dc49e92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCg0KSSB3aWxsIHVwc3RyZWFtIG10Njc3OSBzb3VuZCBjYXJkIGRyaXZl
ciBvbiBNYXJrJ3MgQVNvQyByZXBvOg0KaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9icm9vbmllL3NvdW5kLmdpdA0KDQpCdXQgaXQgaXMgc3RpbGwgdW5kZXIg
aW50ZXJuYWwgcmV2aWV3aW5nIGFuZCBub3QgeWV0IHVwc3RyZWFtLg0KU28sIEkgdGhpbmsgdGhh
dCB0aGlzIHBhdGNoIGNvdWxkIGJlIHVwc3RyZWFtIGZpcnN0Lg0KDQpNYXliZSwgb3RoZXIgbXRr
IHNpcCBjbGllbnRzIGNhbiB1c2UgdGhpcyBoZWFkZXIgYW5kIGFkZCB0aGVpcidzDQpzcGVjaWZp
YyBNVFNLX1NJUF8qIElELg0KDQpSZWdhcmRzLA0KRWFzb24NCg0KDQpPbiBNb24sIDIwMTktMTEt
MTEgYXQgMTY6MTcgKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAxMS8x
MS8yMDE5IDAzOjMwLCBFYXNvbiBZZW4gd3JvdGU6DQo+ID4gc29jOiBtZWRpYXRlazogYWRkIFNN
QyBmaWQgdGFibGUgZm9yIFNJUCBpbnRlcmZhY2UNCj4gPiANCj4gPiAxLiBBZGQgYSBoZWFkZXIg
ZmlsZSB0byBwcm92aWRlIFNJUCBpbnRlcmZhY2UgdG8gQVRGDQo+ID4gICAgZm9yIGNsaWVudHMs
IHBsZWFzZSBkZWZpbmUgTVRLX1NJUF9YWFggIHdpdGggc3BlY2lmaWMgSUQNCj4gPiANCj4gPiAy
LiBBZGQgQVVESU8gU01DIGZpZA0KPiA+ICAgIG10ayBzaXAgY2FsbCBleGFtcGxlOg0KPiA+ICAg
IGFybV9zbWNjY19zbWMoTVRLX1NJUF9BVURJT19DT05UUk9MLA0KPiA+ICAgICAgICAgICAgICAg
ICAgTVRLX0FVRElPX1NNQ19PUF9EUkFNX1JFUVVFU1QsDQo+ID4gICAgICAgICAgICAgICAgICAw
LCAwLCAwLCAwLCAwLCAwLCAmcmVzKQ0KPiANCj4gQXJlIHlvdSBwbGFubmluZyB0byB1cHN0cmVh
bSBhIGRyaXZlciBjb25zdW1pbmcgdGhpcyBpbnRlcmZhY2U/DQo+IElmIHNvLCBJIHByb3Bvc2Ug
dG8gYWRkIHRoaXMgcGF0Y2ggdG8gdGhlIHN1Ym1pc3Npb24gb2YgdGhlIGRyaXZlci4gU291bmRz
IGdvb2Q/DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiANCj4gPiANCj4gPiBF
YXNvbiBZZW4gKDEpOg0KPiA+ICAgc29jOiBtZWRpYXRlazogYWRkIFNNQyBmaWQgdGFibGUgZm9y
IFNJUCBpbnRlcmZhY2UNCj4gPiANCj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
X3NpcF9zdmMuaCB8ICAgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaA0KPiA+IA0KDQo=

