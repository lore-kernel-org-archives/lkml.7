Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E80CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79922086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDAKB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:01:58 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:47590 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:01:58 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 06:01:57 EDT
X-AuditID: c0a8fbf4-501ff700000014c1-66-5ca1de0e4a5a
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 70.B9.05313.E0ED1AC5; Mon,  1 Apr 2019 11:46:54 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Mon, 1 Apr 2019 11:46:43 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: regmap-irq: fix getting type default values
Thread-Topic: [PATCH] regmap: regmap-irq: fix getting type default values
Thread-Index: AQHU5YJ7pHJbHAzaf0GD/MZSyVe8TKYm8xcA
Date:   Mon, 1 Apr 2019 09:46:40 +0000
Message-ID: <631d409f73ec3d9639e734147f3ffa4935d432a2.camel@fi.rohmeurope.com>
References: <20190328162218.14569-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190328162218.14569-1-srinivas.kandagatla@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AD498000877CC41BF63936DA33A9CE5@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5sOL3Rl2+ewtjDJq/qlpMffiEzaJ58Xo2
        i8u75rBZzP0yldmi7dgxVgdWj02rOtk87lzbw+axf+4ado/Pm+QCWKK4bZISS8qCM9Pz9O0S
        uDN6FmxkKdjBX/Hq3yG2BsYW/i5GTg4JAROJHy82MnYxcnEICVxjlJja+4EFwjnOKLGyfxVz
        FyMHB5uAjUTXTXaQBhGBIonrjf/BGpgFVjJKfHu5lxkkISzgIXFu+gdGiCJPiecz50A1GEls
        mX0YLM4ioCJxu3cHG4jNK+AnsWL9AiYQW0jAWaL5+Wewek4BF4n5f9eA1TMKyEp0NrwDq2EW
        EJfY9Ow7K8TVAhJL9pxnhrBFJV4+/gcVV5LY+/MhC8jNzAKaEut36UO0OkhsW/qSHcJWlJjS
        /ZAd4gRBiZMzn7BMYBSbhWTDLITuWUi6ZyHpnoWkewEj6ypGidzEzJz0xJJUQ72i1FK9ovyM
        XCCVnJ+7iRESjV92MP4/5HmIUYCDUYmH1+zKwhgh1sSy4srcQ4ySHExKorzPNgGF+JLyUyoz
        Eosz4otKc1KLDzFKcDArifCe6V8QI8SbklhZlVqUD5OS5mBREuctXz4lRkgAZHN2ampBahFM
        VoaDQ0mCl/cu0FDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGqJLwYmF5AUD9De
        T3eA2nmLCxJzgaIQracYtTkOLHo4l5nj7cHnc5mFWPLy81KlxCE2CYCUZpTmwS16xSgO9K8w
        72uQQTzAlA035xXQCiagFRal80FWlCQipKQaGBfemfkpan5Fsd1Ji0SPD4qlIknn+udb8v9+
        Urnuzs398m6LgvxvXr0n/UCz+dj0id59pcntE84qn+nfHqj5sXqfxwPVQ64bp9WYJK5IO24z
        ceMxthuyPpYruGdLzfk5tWHC/b8yD4STgnVLJtt63+GU32Fc8ispq/3mHkthF1sRCwnvnmWn
        5imxFGckGmoxFxUnAgBqIZfZlgMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTI4IGF0IDE2OjIyICswMDAwLCBTcmluaXZhcyBLYW5kYWdhdGxhIHdy
b3RlOg0KPiBDaGVja2luZyBmb3IgdmFsdWUgb2YgdHlwZSBkZWZhdWx0IHZhbHVlIGp1c3QgYWZ0
ZXIgYWxsb2NhdGluZyB3aWxsDQo+IGFsd2F5cyBiZSB6ZXJvIGFuZCB0aGUgdHlwZSByZWdpc3Rl
ciBkZWZhdWx0IHZhbHVlcyB3aWxsIG5ldmVyIGJlDQo+IHJlYWQsDQo+IHNvIGZpeCB0aGlzIQ0K
PiANCj4gV2l0aG91dCB0aGlzIHBhdGNoIHNldHRpbmcgaXJxIHR5cGUgd2lsbCBiZSBzaWxlbnRs
eSBpZ25vcmVkLg0KPiBQYXRjaCAicmVnbWFwOiByZWdtYXAtaXJxOiBSZW1vdmUgZGVmYXVsdCBp
cnEgdHlwZSBzZXR0aW5nIGZyb20gY29yZSINCj4gZGlkIHJlbW92ZSB0aGUgZGVmYXVsdCBtYXNr
IGJ1dCBpdCBmb3Jnb3QgdG8gcmVtb3ZlIHRoZSBjaGVjayBiZWZvcmUNCj4gcmVhZGluZyB0aGUg
ZGVmYXVsdCB0eXBlIHJlZ2lzdGVyLg0KPiANCj4gRml4ZXM6IDg0MjY3ZDFiMThhYiAoInJlZ21h
cDogcmVnbWFwLWlycTogUmVtb3ZlIGRlZmF1bHQgaXJxIHR5cGUNCj4gc2V0dGluZyBmcm9tIGNv
cmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBLYW5kYWdhdGxhIDxzcmluaXZhcy5rYW5k
YWdhdGxhQGxpbmFyby5vcmc+DQpBY2tlZC1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0
dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2Jhc2UvcmVnbWFw
L3JlZ21hcC1pcnEuYyB8IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1pcnEuYw0KPiBi
L2RyaXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLWlycS5jDQo+IGluZGV4IDUwNTk3NDhhZmQ0Yy4u
MDJlYjc1NjQ2MTQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1p
cnEuYw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1pcnEuYw0KPiBAQCAtNzYx
LDkgKzc2MSw2IEBAIGludCByZWdtYXBfYWRkX2lycV9jaGlwKHN0cnVjdCByZWdtYXAgKm1hcCwg
aW50DQo+IGlycSwgaW50IGlycV9mbGFncywNCj4gIA0KPiAgCWlmIChjaGlwLT5udW1fdHlwZV9y
ZWcgJiYgIWNoaXAtPnR5cGVfaW5fbWFzaykgew0KPiAgCQlmb3IgKGkgPSAwOyBpIDwgY2hpcC0+
bnVtX3R5cGVfcmVnOyArK2kpIHsNCj4gLQkJCWlmICghZC0+dHlwZV9idWZfZGVmW2ldKQ0KPiAt
CQkJCWNvbnRpbnVlOw0KPiAtDQo+ICAJCQlyZWcgPSBjaGlwLT50eXBlX2Jhc2UgKw0KPiAgCQkJ
CShpICogbWFwLT5yZWdfc3RyaWRlICogZC0NCj4gPnR5cGVfcmVnX3N0cmlkZSk7DQo+ICANCkl0
IGxvb2tzIGxpa2UgSSBsZWZ0IGEgYnVnIHRoZXJlLiBUaGFua3MgZm9yIHRoZSBmaXghDQoNCkJy
LA0KICAgIE1hdHRpDQoNCg0K
