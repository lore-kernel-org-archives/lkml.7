Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8083213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfDAIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:35:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39159 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:35:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x318Yj45004261, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x318Yj45004261
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 1 Apr 2019 16:34:45 +0800
Received: from RTITMBSVM07.realtek.com.tw ([fe80::a512:a803:bf1e:b23]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0399.000; Mon, 1 Apr 2019 16:34:45 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
Thread-Topic: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a
 rts5260
Thread-Index: AQHU1MpX6lDV9pyCr0mgYIhw2T/y7KYm/w7Q//+DhwCAAJ1xIA==
Date:   Mon, 1 Apr 2019 08:34:44 +0000
Message-ID: <BDFC8C62036EBE41BBBC808595CAAECA0307912A@RTITMBSVM07.realtek.com.tw>
References: <20190307094415.4853-1-ricky_wu@realtek.com>
 <BDFC8C62036EBE41BBBC808595CAAECA030790E7@RTITMBSVM07.realtek.com.tw>
 <20190401070424.GA20095@kroah.com>
In-Reply-To: <20190401070424.GA20095@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.103]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVnIGstaCwNCg0KSSBzYXcgdGhlIHBhdGNoIGlzIGFscmVhZHkgaW4gTGludXMncyB0
cmVlDQpCdXQgSSBmb3VuZCBpdCBpcyBub3QgbXkgdjMtcGF0Y2gNCkNhbiB5b3UgaGVscCBtZSB0
byBjaGVjayB0aGlzIHN0YXR1cyBraW5kbHk/DQoNClRoYW5rIHlvdQ0KDQpCUiwNClJpY2t5DQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnIFttYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmddDQo+IFNlbnQ6IE1vbmRh
eSwgQXByaWwgMDEsIDIwMTkgMzowNCBQTQ0KPiBUbzog5ZCz5piK5r6EIFJpY2t5DQo+IENjOiBh
cm5kQGFybmRiLmRlOyBjb2xpbi5raW5nQGNhbm9uaWNhbC5jb207IGF4Ym9lQGtlcm5lbC5kazsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBtaXNjOiBydHN4OiBFbmFibGUgT0NQIGZvciBydHM1MjJhIHJ0czUyNGEgcnRzNTI1YQ0KPiBy
dHM1MjYwDQo+IA0KPiBPbiBNb24sIEFwciAwMSwgMjAxOSBhdCAwNjo0MDoxOUFNICswMDAwLCDl
kLPmmIrmvoQgUmlja3kgd3JvdGU6DQo+ID4gRGVhciBhbGwsDQo+ID4NCj4gPiBNYXkgSSBrbm93
IGhvdyBpcyB0aGlzIHBhdGNoIGdvaW5nIG9uID8NCj4gPiBJcyBpdCB3b3JrIHdlbGwgb24geW91
ciBzaWRlPw0KPiA+IFdlIGhhdmUgc29tZSBndWVzdCB3YW50IHRvIGtub3cgd2hhdCBzdGFnZSBp
cyB0aGlzIHBhdGNoIGdvaW5nIHRvDQo+IA0KPiBUaGlzIHBhdGNoIGlzIGFscmVhZHkgaW4gdGhl
IDUuMS1yYzEgcmVsZWFzZSwgeW91IGNhbiBzZWUgaXQgb24NCj4gZ2l0Lmtlcm5lbC5vcmcgaW4g
TGludXMncyB0cmVlLiAgSXQgd2lsbCBiZSBpbiB0aGUgZmluYWwgNS4xIHJlbGVhc2UNCj4gd2hp
Y2ggc2hvdWxkIGhhcHBlbiBpbiBhIGZldyB3ZWVrcy4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9y
ZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
