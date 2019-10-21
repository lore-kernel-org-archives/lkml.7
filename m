Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D7CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7D214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJUMYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:24:51 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:39718 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:24:50 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id D14ED601DAF;
        Mon, 21 Oct 2019 14:24:39 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 21 Oct
 2019 14:24:39 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 21 Oct 2019 14:24:39 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/10] Add support for more Kontron i.MX6UL/ULL SoMs and
 boards
Thread-Topic: [PATCH 00/10] Add support for more Kontron i.MX6UL/ULL SoMs and
 boards
Thread-Index: AQHVhDNGmnCbI2WJmkisIF0qUQi7cqdeW9UAgAAC0ACABoDlgIAAC4sA
Date:   Mon, 21 Oct 2019 12:24:39 +0000
Message-ID: <76484360-c868-a784-11f2-7fec696e3061@kontron.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191017081422.65m5dtqznsanfftp@pengutronix.de>
 <6e6f9cf4-85b3-35e3-1238-11e39855bc08@kontron.de>
 <20191021114319.krrhdtvycu7zxxie@pengutronix.de>
In-Reply-To: <20191021114319.krrhdtvycu7zxxie@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD73DCB632EB64AA83D2754D99E78A7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D14ED601DAF.A2522
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aisheng.dong@nxp.com, andrew.smirnov@gmail.com,
        davem@davemloft.net, devicetree@vger.kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, jonathan.cameron@huawei.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, m.felsch@pengutronix.de,
        manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, paulmck@linux.ibm.com,
        robh+dt@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY28sDQoNCk9uIDIxLjEwLjE5IDEzOjQzLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+IEhp
IEZyaWVkZXIsDQo+IA0KPiBPbiAxOS0xMC0xNyAwODoyNCwgU2NocmVtcGYgRnJpZWRlciB3cm90
ZToNCj4+IEhpIE1hcmNvLA0KPj4NCj4+IE9uIDE3LjEwLjE5IDEwOjE0LCBNYXJjbyBGZWxzY2gg
d3JvdGU6DQo+Pj4gSGkgRnJpZWRlciwNCj4+Pg0KPj4+IE9uIDE5LTEwLTE2IDE1OjA2LCBTY2hy
ZW1wZiBGcmllZGVyIHdyb3RlOg0KPj4+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVy
LnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4+DQo+Pj4+IEluIG9yZGVyIHRvIHN1cHBvcnQgbW9y
ZSBvZiB0aGUgaS5NWDZVTC9VTEwtYmFzZWQgU29NcyBhbmQgYm9hcmRzIGJ5DQo+Pj4+IEtvbnRy
b24gRWxlY3Ryb25pY3MgR21iSCwgd2UgcmVzdHJ1Y3R1cmUgdGhlIGRldmljZXRyZWVzIHRvIHNo
YXJlIGNvbW1vbg0KPj4+PiBwYXJ0cyBhbmQgYWRkIG5ldyBkZXZpY2V0cmVlcyBmb3IgdGhlIG1p
c3NpbmcgYm9hcmRzLg0KPj4+Pg0KPj4+PiBDdXJyZW50bHkgdGhlcmUgYXJlIHRoZSBmb2xsb3dp
bmcgU29NIGZsYXZvcnM6DQo+Pj4+ICAgICAqIE42MzEwOiBTb00gd2l0aCBpLk1YNlVMLTIsIDI1
Nk1CIFJBTSwgMjU2TUIgU1BJIE5BTkQNCj4+Pj4gICAgICogTjYzMTE6IFNvTSB3aXRoIGkuTVg2
VUwtMiwgNTEyTUIgUkFNLCA1MTJNQiBTUEkgTkFORCAobmV3KQ0KPj4+PiAgICAgKiBONjQxMTog
U29NIHdpdGggaS5NWDZVTEwsIDUxMk1CIFJBTSwgNTEyTUIgU1BJIE5BTkQgKG5ldykNCj4+Pj4N
Cj4+Pj4gRWFjaCBvZiB0aGUgU29NcyBhbHNvIGZlYXR1cmVzIDFNQiBTUEkgTk9SIGFuZCBhbiBF
dGhlcm5ldCBQSFkuIFRoZSBjYXJyaWVyDQo+Pj4+IGJvYXJkIGZvciB0aGUgZXZhbGtpdCBpcyB0
aGUgc2FtZSBmb3IgYWxsIFNvTXMuDQo+Pj4+DQo+Pj4+IEZyaWVkZXIgU2NocmVtcGYgKDEwKToN
Cj4+Pj4gICAgIEFSTTogZHRzOiBpbXg2dWwta29udHJvbi1uNjMxMDogTW92ZSBjb21tb24gU29N
IG5vZGVzIHRvIGEgc2VwYXJhdGUNCj4+Pj4gICAgICAgZmlsZQ0KPj4+PiAgICAgQVJNOiBkdHM6
IEFkZCBzdXBwb3J0IGZvciB0d28gbW9yZSBLb250cm9uIFNvTXMgTjYzMTEgYW5kIE42NDExDQo+
Pj4+ICAgICBBUk06IGR0czogaW14NnVsLWtvbnRyb24tbjYzMTAtczogTW92ZSBjb21tb24gbm9k
ZXMgdG8gYSBzZXBhcmF0ZSBmaWxlDQo+Pj4+ICAgICBBUk06IGR0czogQWRkIHN1cHBvcnQgZm9y
IHR3byBtb3JlIEtvbnRyb24gZXZhbGtpdCBib2FyZHMgJ042MzExIFMnDQo+Pj4+ICAgICAgIGFu
ZCAnTjY0MTEgUycNCj4+Pj4gICAgIEFSTTogZHRzOiBpbXg2dWwta29udHJvbi1uNngxeDogQWRk
ICdjaG9zZW4nIG5vZGUgd2l0aCAnc3Rkb3V0LXBhdGgnDQo+Pj4+ICAgICBBUk06IGR0czogaW14
NnVsLWtvbnRyb24tbjZ4MXgtczogU3BlY2lmeSBidXMtd2lkdGggZm9yIFNEIGNhcmQgYW5kDQo+
Pj4+ICAgICAgIGVNTUMNCj4+Pj4gICAgIEFSTTogZHRzOiBpbXg2dWwta29udHJvbi1uNngxeC1z
OiBBZGQgdmJ1cy1zdXBwbHkgYW5kIG92ZXJjdXJyZW50DQo+Pj4+ICAgICAgIHBvbGFyaXR5IHRv
IHVzYiBub2Rlcw0KPj4+PiAgICAgQVJNOiBkdHM6IGlteDZ1bC1rb250cm9uLW42eDF4LXM6IFJl
bW92ZSBhbiBvYnNvbGV0ZSBjb21tZW50IGFuZCBmaXgNCj4+Pj4gICAgICAgaW5kZW50YXRpb24N
Cj4+Pj4gICAgIGR0LWJpbmRpbmdzOiBhcm06IGZzbDogQWRkIG1vcmUgS29udHJvbiBpLk1YNlVM
L1VMTCBjb21wYXRpYmxlcw0KPj4+PiAgICAgTUFJTlRBSU5FUlM6IEFkZCBhbiBlbnRyeSBmb3Ig
S29udHJvbiBFbGVjdHJvbmljcyBBUk0gYm9hcmQgc3VwcG9ydA0KPj4+DQo+Pj4gRGlkIHlvdSBz
ZW5kIGFsbCBwYXRjaGVzIHRvIHNhbWUgVG86IGFuZCBDYzo/DQo+Pg0KPj4gTm8sIEkgaGF2ZSBh
IHNjcmlwdCB0aGF0IHJ1bnMgZ2V0X21haW50YWluZXIucGwgZm9yIGVhY2ggcGF0Y2guIFNvIHRo
ZQ0KPj4gcmVjaXBpZW50cyBtaWdodCBkaWZmZXIuIEkgb25seSBoYWQgS3J6eXN6dG9mIGFuZCBS
b2IgYXMgaGFyZC1jb2RlZA0KPj4gcmVjaXBpZW50cyBmb3IgdGhlIHdob2xlIHNlcmllcy4NCj4+
DQo+PiBEbyB5b3UgdGhpbmsgSSBzaG91bGQgY2hhbmdlIHRoaXMgc28gZWFjaCByZWNpcGllbnQg
cmVjZWl2ZXMgdGhlIHdob2xlDQo+PiBzZXJpZXM/DQo+IA0KPiBJIGRvIGl0IHRoYXQgd2F5IGJl
Y2F1c2Ugc29tZXRpbWVzIGl0IGlzIGJldHRlciBmb3IgdGhlIHJldmlld2VyIHRvIHNlZQ0KPiB0
aGUgd2hvbGUgY29udGV4dC4NCg0KU291bmRzIHJlYXNvbmFibGUuIFRoYW5rcyBmb3IgdGhlIGZl
ZWRiYWNrLg0KU29tZXRpbWVzIGl0IGp1c3QgZmVlbHMgbGlrZSBpdCB3aWxsIGNhdXNlIGEgbG90
IG9mIHVzZWxlc3MgbWFpbCB0cmFmZmljIA0Kd2hlbiBzZW5kaW5nIGFsbCBwYXRjaGVzIHRvIGFs
bCBwZW9wbGUgc3VnZ2VzdGVkIGJ5IGdldF9tYWludGFpbmVyLnBsLCANCmJ1dCBpbiBnZW5lcmFs
IEkgYWdyZWUsIGl0IGlzIGRlZmluaXRlbHkgdXNlZnVsIHRvIHJlY2VpdmUgYWxsIHRoZSANCmNv
bnRleHQuIEkgbWlnaHQgaGF2ZSB0byB0d2VhayBteSBnZXRfbWFpbnRhaW5lciBhcmd1bWVudHMs
IHRvIHRyaW0gdGhlIA0KbGlzdCBvZiByZWNpcGllbnRzIGFuZCB0aGVuIHNlbmQgdGhlIHdob2xl
IHNlcmllcyB0byB0aGVzZSBwZW9wbGUuDQoNClRoYW5rcywNCkZyaWVkZXI=
