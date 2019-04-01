Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3D20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfDAH0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:26:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58686 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:26:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x317QPXY007012, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x317QPXY007012
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Mon, 1 Apr 2019 15:26:25 +0800
Received: from RTITMBSVM07.realtek.com.tw ([fe80::a512:a803:bf1e:b23]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Mon, 1 Apr
 2019 15:26:25 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
Thread-Topic: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a
 rts5260
Thread-Index: AQHU1MpX6lDV9pyCr0mgYIhw2T/y7KYm/w7Q//+DhwCAAIrwIA==
Date:   Mon, 1 Apr 2019 07:26:25 +0000
Message-ID: <BDFC8C62036EBE41BBBC808595CAAECA03079105@RTITMBSVM07.realtek.com.tw>
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

RGVhciBHcmVnIGstaCwNCg0KVmVyeSB0aGFua3MgZm9yIHlvdXIgcmVwbHkga2luZGx5DQoNClJp
Y2t5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmcgW21haWx0bzpncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gU2Vu
dDogTW9uZGF5LCBBcHJpbCAwMSwgMjAxOSAzOjA0IFBNDQo+IFRvOiDlkLPmmIrmvoQgUmlja3kN
Cj4gQ2M6IGFybmRAYXJuZGIuZGU7IGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbTsgYXhib2VAa2Vy
bmVsLmRrOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjNdIG1pc2M6IHJ0c3g6IEVuYWJsZSBPQ1AgZm9yIHJ0czUyMmEgcnRzNTI0YSBydHM1
MjVhDQo+IHJ0czUyNjANCj4gDQo+IE9uIE1vbiwgQXByIDAxLCAyMDE5IGF0IDA2OjQwOjE5QU0g
KzAwMDAsIOWQs+aYiua+hCBSaWNreSB3cm90ZToNCj4gPiBEZWFyIGFsbCwNCj4gPg0KPiA+IE1h
eSBJIGtub3cgaG93IGlzIHRoaXMgcGF0Y2ggZ29pbmcgb24gPw0KPiA+IElzIGl0IHdvcmsgd2Vs
bCBvbiB5b3VyIHNpZGU/DQo+ID4gV2UgaGF2ZSBzb21lIGd1ZXN0IHdhbnQgdG8ga25vdyB3aGF0
IHN0YWdlIGlzIHRoaXMgcGF0Y2ggZ29pbmcgdG8NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgYWxyZWFk
eSBpbiB0aGUgNS4xLXJjMSByZWxlYXNlLCB5b3UgY2FuIHNlZSBpdCBvbg0KPiBnaXQua2VybmVs
Lm9yZyBpbiBMaW51cydzIHRyZWUuICBJdCB3aWxsIGJlIGluIHRoZSBmaW5hbCA1LjEgcmVsZWFz
ZQ0KPiB3aGljaCBzaG91bGQgaGFwcGVuIGluIGEgZmV3IHdlZWtzLg0KPiANCj4gdGhhbmtzLA0K
PiANCj4gZ3JlZyBrLWgNCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1l
bnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
