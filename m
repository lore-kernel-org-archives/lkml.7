Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8E2C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2B2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfHNHcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:32:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53274 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHNHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:31:59 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7E7Vj8v012646, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7E7Vj8v012646
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 14 Aug 2019 15:31:46 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS02.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Wed, 14 Aug 2019 15:31:45 +0800
From:   =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnRydGw6IFNhdmUgZmly?= =?utf-8?Q?mware_and_config?=
Thread-Topic: [PATCH v2] Bluetooth: btrtl: Save firmware and config
Thread-Index: AQHVSzrgIOMMDCbw+0u3p878+lh/Rab3O0oAgAMP67A=
Date:   Wed, 14 Aug 2019 07:31:44 +0000
Message-ID: <0551C926975A174EA8972327741C7889EE81187B@RS-MBS01.realsil.com.cn>
References: <20190805030733.GA11069@toshiba>
 <1BB38E27-5FAD-4402-86C1-6AA47E6BA08A@holtmann.org>
In-Reply-To: <1BB38E27-5FAD-4402-86C1-6AA47E6BA08A@holtmann.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.36.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2VsLA0KSXQgb25seSBzYXZlcyB0aGUgbGF0ZXN0IGZ3IGFuZCBjb25maWcgZm9yIG9u
bHkgb25lIGRldmljZS4NCkkgd2lsbCBkaWcgdGhlIGNhY2hpbmcgY2FwYWJpbGl0eSBvZiByZXF1
ZXN0X2Zpcm13YXJlIGZpcnN0Lg0KDQpUaGFua3MsDQpCUnMsDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gQmx1ZXRvb3RoOiBidHJ0bDogU2F2ZSBmaXJtd2FyZSBhbmQgY29uZmlnDQo+IA0K
PiBIaSBBbGV4LA0KPiANCj4gPiB1c2IgcmVzZXQgcmVzdW1lIHdpbGwgY2F1c2UgZG93bmxvYWRp
bmcgZmlybXdhcmUgYWdhaW4gYW5kDQo+ID4gcmVxdWVzdGluZyBmaXJtd2FyZSBtYXkgYmUgZmFp
bGVkIHdoaWxlIGhvc3QgaXMgcmVzdW1pbmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXgg
THUgPGFsZXhfbHVAcmVhbHNpbC5jb20uY24+DQo+ID4gLS0tDQo+ID4gZHJpdmVycy9ibHVldG9v
dGgvYnRydGwuYyB8IDEwMQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMgYi9kcml2ZXJz
L2JsdWV0b290aC9idHJ0bC5jDQo+ID4gaW5kZXggMjA4ZmVlZjYzZGU0Li40MTZhNWNiNjc2ZTMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmMNCj4gPiBAQCAtNTYsNiArNTYsOCBAQCBzdHJ1Y3QgYnRy
dGxfZGV2aWNlX2luZm8gew0KPiA+IAlpbnQgY2ZnX2xlbjsNCj4gPiB9Ow0KPiA+DQo+ID4gK3N0
YXRpYyBzdHJ1Y3QgYnRydGxfZGV2aWNlX2luZm8gZGV2X2luZm87DQo+ID4gKw0KPiANCj4gTm8u
IFdlIGFyZSBhcmUgbm90IHVzaW5nIG1hZ2ljIGdsb2JhbCB2YXJpYWJsZXMuIFdoYXQgaGFwcGVu
cyBpZiB5b3UgYXR0YWNoDQo+IG1vcmUgdGhhbiBvbmUgZGV2aWNlPyBBbHNvIEkgYXNzdW1lZCB0
aGF0IHJlcXVlc3RfZmlybXdhcmUgaGFzIGEgY2FjaGluZw0KPiBjYXBhYmlsaXR5IG9mIHNvcnRz
IHNvIHRoYXQgZHJpdmVycyBkb27igJl0IGhhdmUgdG8gcmUtaW1wbGVtZW50IGNhY2hpbmcgb2Yg
dGhlDQo+IGZpcm13YXJlLg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2VsDQo+IA0KPiANCj4g
LS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhp
cyBlLW1haWwuDQo=
