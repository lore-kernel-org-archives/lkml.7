Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE687FA372E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D7520820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408225AbfJQIYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:24:37 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:58852 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfJQIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:24:36 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 2BE8A80315A;
        Thu, 17 Oct 2019 10:24:28 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 17 Oct
 2019 10:24:27 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 17 Oct 2019 10:24:27 +0200
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
Thread-Index: AQHVhDNGmnCbI2WJmkisIF0qUQi7cqdeW9UAgAAC0AA=
Date:   Thu, 17 Oct 2019 08:24:27 +0000
Message-ID: <6e6f9cf4-85b3-35e3-1238-11e39855bc08@kontron.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191017081422.65m5dtqznsanfftp@pengutronix.de>
In-Reply-To: <20191017081422.65m5dtqznsanfftp@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA37A90C250EE84C8A16A2B38DF077EF@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2BE8A80315A.ADCFA
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

SGkgTWFyY28sDQoNCk9uIDE3LjEwLjE5IDEwOjE0LCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+IEhp
IEZyaWVkZXIsDQo+IA0KPiBPbiAxOS0xMC0xNiAxNTowNiwgU2NocmVtcGYgRnJpZWRlciB3cm90
ZToNCj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5k
ZT4NCj4+DQo+PiBJbiBvcmRlciB0byBzdXBwb3J0IG1vcmUgb2YgdGhlIGkuTVg2VUwvVUxMLWJh
c2VkIFNvTXMgYW5kIGJvYXJkcyBieQ0KPj4gS29udHJvbiBFbGVjdHJvbmljcyBHbWJILCB3ZSBy
ZXN0cnVjdHVyZSB0aGUgZGV2aWNldHJlZXMgdG8gc2hhcmUgY29tbW9uDQo+PiBwYXJ0cyBhbmQg
YWRkIG5ldyBkZXZpY2V0cmVlcyBmb3IgdGhlIG1pc3NpbmcgYm9hcmRzLg0KPj4NCj4+IEN1cnJl
bnRseSB0aGVyZSBhcmUgdGhlIGZvbGxvd2luZyBTb00gZmxhdm9yczoNCj4+ICAgICogTjYzMTA6
IFNvTSB3aXRoIGkuTVg2VUwtMiwgMjU2TUIgUkFNLCAyNTZNQiBTUEkgTkFORA0KPj4gICAgKiBO
NjMxMTogU29NIHdpdGggaS5NWDZVTC0yLCA1MTJNQiBSQU0sIDUxMk1CIFNQSSBOQU5EIChuZXcp
DQo+PiAgICAqIE42NDExOiBTb00gd2l0aCBpLk1YNlVMTCwgNTEyTUIgUkFNLCA1MTJNQiBTUEkg
TkFORCAobmV3KQ0KPj4NCj4+IEVhY2ggb2YgdGhlIFNvTXMgYWxzbyBmZWF0dXJlcyAxTUIgU1BJ
IE5PUiBhbmQgYW4gRXRoZXJuZXQgUEhZLiBUaGUgY2Fycmllcg0KPj4gYm9hcmQgZm9yIHRoZSBl
dmFsa2l0IGlzIHRoZSBzYW1lIGZvciBhbGwgU29Ncy4NCj4+DQo+PiBGcmllZGVyIFNjaHJlbXBm
ICgxMCk6DQo+PiAgICBBUk06IGR0czogaW14NnVsLWtvbnRyb24tbjYzMTA6IE1vdmUgY29tbW9u
IFNvTSBub2RlcyB0byBhIHNlcGFyYXRlDQo+PiAgICAgIGZpbGUNCj4+ICAgIEFSTTogZHRzOiBB
ZGQgc3VwcG9ydCBmb3IgdHdvIG1vcmUgS29udHJvbiBTb01zIE42MzExIGFuZCBONjQxMQ0KPj4g
ICAgQVJNOiBkdHM6IGlteDZ1bC1rb250cm9uLW42MzEwLXM6IE1vdmUgY29tbW9uIG5vZGVzIHRv
IGEgc2VwYXJhdGUgZmlsZQ0KPj4gICAgQVJNOiBkdHM6IEFkZCBzdXBwb3J0IGZvciB0d28gbW9y
ZSBLb250cm9uIGV2YWxraXQgYm9hcmRzICdONjMxMSBTJw0KPj4gICAgICBhbmQgJ042NDExIFMn
DQo+PiAgICBBUk06IGR0czogaW14NnVsLWtvbnRyb24tbjZ4MXg6IEFkZCAnY2hvc2VuJyBub2Rl
IHdpdGggJ3N0ZG91dC1wYXRoJw0KPj4gICAgQVJNOiBkdHM6IGlteDZ1bC1rb250cm9uLW42eDF4
LXM6IFNwZWNpZnkgYnVzLXdpZHRoIGZvciBTRCBjYXJkIGFuZA0KPj4gICAgICBlTU1DDQo+PiAg
ICBBUk06IGR0czogaW14NnVsLWtvbnRyb24tbjZ4MXgtczogQWRkIHZidXMtc3VwcGx5IGFuZCBv
dmVyY3VycmVudA0KPj4gICAgICBwb2xhcml0eSB0byB1c2Igbm9kZXMNCj4+ICAgIEFSTTogZHRz
OiBpbXg2dWwta29udHJvbi1uNngxeC1zOiBSZW1vdmUgYW4gb2Jzb2xldGUgY29tbWVudCBhbmQg
Zml4DQo+PiAgICAgIGluZGVudGF0aW9uDQo+PiAgICBkdC1iaW5kaW5nczogYXJtOiBmc2w6IEFk
ZCBtb3JlIEtvbnRyb24gaS5NWDZVTC9VTEwgY29tcGF0aWJsZXMNCj4+ICAgIE1BSU5UQUlORVJT
OiBBZGQgYW4gZW50cnkgZm9yIEtvbnRyb24gRWxlY3Ryb25pY3MgQVJNIGJvYXJkIHN1cHBvcnQN
Cj4gDQo+IERpZCB5b3Ugc2VuZCBhbGwgcGF0Y2hlcyB0byBzYW1lIFRvOiBhbmQgQ2M6Pw0KDQpO
bywgSSBoYXZlIGEgc2NyaXB0IHRoYXQgcnVucyBnZXRfbWFpbnRhaW5lci5wbCBmb3IgZWFjaCBw
YXRjaC4gU28gdGhlIA0KcmVjaXBpZW50cyBtaWdodCBkaWZmZXIuIEkgb25seSBoYWQgS3J6eXN6
dG9mIGFuZCBSb2IgYXMgaGFyZC1jb2RlZCANCnJlY2lwaWVudHMgZm9yIHRoZSB3aG9sZSBzZXJp
ZXMuDQoNCkRvIHlvdSB0aGluayBJIHNob3VsZCBjaGFuZ2UgdGhpcyBzbyBlYWNoIHJlY2lwaWVu
dCByZWNlaXZlcyB0aGUgd2hvbGUgDQpzZXJpZXM/DQoNClRoYW5rcywNCkZyaWVkZXINCg0KPiAN
Cj4gUmVnYXJkcywNCj4gICAgTWFyY28NCj4gDQo+Pg0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vZnNsLnlhbWwgICAgICAgICAgfCAgMTQgKw0KPj4gICBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPj4gICBhcmNoL2FybS9ib290
L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zLmR0cyAgfCA0MDUgKy0tLS0tLS0tLS0tLS0tLS0N
Cj4+ICAgLi4uL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEwLXNvbS5kdHNpICAgIHwgIDk1
ICstLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTEtcy5kdHMg
IHwgIDE2ICsNCj4+ICAgLi4uL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzExLXNvbS5kdHNp
ICAgIHwgIDQwICsrDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42eDF4
LXMuZHRzaSB8IDQyMiArKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2R0cy9pbXg2dWwta29u
dHJvbi1uNngxeC1zb20tY29tbW9uLmR0c2kgIHwgMTI5ICsrKysrKw0KPj4gICBhcmNoL2FybS9i
b290L2R0cy9pbXg2dWxsLWtvbnRyb24tbjY0MTEtcy5kdHMgfCAgMTYgKw0KPj4gICAuLi4vYm9v
dC9kdHMvaW14NnVsbC1rb250cm9uLW42NDExLXNvbS5kdHNpICAgfCAgNDAgKysNCj4+ICAgMTAg
ZmlsZXMgY2hhbmdlZCwgNjg1IGluc2VydGlvbnMoKyksIDQ5OCBkZWxldGlvbnMoLSkNCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEx
LXMuZHRzDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwt
a29udHJvbi1uNjMxMS1zb20uZHRzaQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjZ4MXgtcy5kdHNpDQo+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zb20tY29tbW9uLmR0
c2kNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwta29u
dHJvbi1uNjQxMS1zLmR0cw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnVsbC1rb250cm9uLW42NDExLXNvbS5kdHNpDQo+Pg0KPj4gLS0gDQo+PiAyLjE3LjEN
Cj4+DQo+Pg0KPiA=
