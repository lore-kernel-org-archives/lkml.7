Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C0F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfC2ItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:49:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29475 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729073AbfC2ItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:49:19 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T8kDsY023908;
        Fri, 29 Mar 2019 09:49:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhc3pgq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 09:49:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 712FA31;
        Fri, 29 Mar 2019 08:49:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 162741E06;
        Fri, 29 Mar 2019 08:49:00 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Mar
 2019 09:48:59 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Fri, 29 Mar 2019 09:48:59 +0100
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v4 0/9] Introduce STMFX I2C Multi-Function eXpander
Thread-Topic: [PATCH v4 0/9] Introduce STMFX I2C Multi-Function eXpander
Thread-Index: AQHUzn+6ZNlJXXnTsEqvZWg6Bq7UJaYiar2A
Date:   Fri, 29 Mar 2019 08:48:59 +0000
Message-ID: <b3cdddb0-8177-600c-7108-9a16e9067190@st.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D8CEF54348AF443B719CFC0712D73C2@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkEgZ2VudGxlIHBpbmcgb24gdGhpcyBzZXJpZXMgKG1mZCArIHBpbmN0cmwgcGF0Y2hl
cywgRFQgcGF0Y2hlcyB3aWxsIGJlIA0KdGFrZW4gaW4gU1RNMzIgc29jIHRyZWUpLg0KDQpSZWdh
cmRzLA0KQW1lbGllDQoNCk9uIDIvMjcvMTkgMTA6MzQgQU0sIEFtZWxpZSBEZWxhdW5heSB3cm90
ZToNCj4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBTVE1pY3JvZWxlY3Ryb25pY3MgTXVs
dGktRnVuY3Rpb24gZVhwYW5kZXINCj4gKFNUTUZYKSwgdXNlZCBvbiBzb21lIFNUTTMyIGRpc2Nv
dmVyeSBhbmQgZXZhbHVhdGlvbiBib2FyZHMuDQo+IA0KPiBTVE1GWCBpcyBhbiBTVE0zMkwxNTIg
c2xhdmUgY29udHJvbGxlciB3aG9zZSBmaXJtd2FyZSBlbWJlZHMgdGhlIGZvbGxvd2luZw0KPiBm
ZWF0dXJlczoNCj4gLSBJL08gZXhwYW5kZXIgKDE2IEdQSU9zICsgOCBleHRyYSBpZiB0aGUgb3Ro
ZXIgZmVhdHVyZXMgYXJlIG5vdCBlbmFibGVkKSwNCj4gLSByZXNpc3RpdmUgdG91Y2hzY3JlZW4g
Y29udHJvbGxlciwNCj4gLSBJREQgbWVhc3VyZW1lbnQuDQo+IA0KPiBJMkMgc3R1ZmYgYW5kIGNo
aXAgaW5pdGlhbGl6YXRpb24gaXMgYmFzZWQgb24gYW4gTUZEIHBhcmVudCBkcml2ZXIsIHdoaWNo
DQo+IHJlZ2lzdGVycyBTVE1GWCBmZWF0dXJlcyBNRkQgY2hpbGRyZW4uDQo+IA0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiB2NDoNCj4gLSBtZmQ6IG1vdmUgcmVnaXN0ZXJzICNkZWZpbmUgaW50byB0aGUg
aGVhZGVyDQo+IC0gbWZkOiBtZXJnZSBzdG1meCBhbmQgc3RtZnhfZGRhdGEgc3RydWN0dXJlcyBp
bnRvIG9uZSBzdG1meCBzdHJ1Y3R1cmUNCj4gLSBtZmQ6IGNoYW5nZSBzdG1meF9jaGlwX2luaXQv
ZXhpdCBhbmQgc3RtZnhfaXJxX2luaXQvZXhpdCBhcmdzOiB1c2UNCj4gICAgaTJjX2NsaWVudCBz
dHJ1Y3QgYW5kIGkyY19nZXRfY2xpZW50ZGF0YQ0KPiAtIG1mZDogZml4IHR5cG9zDQo+IC0gbWZk
OiBhZGQgTUZEIGNlbGxzIGZvciBJREQgYW5kIFRTIGZlYXR1cmVzDQo+IC0gcGluY3RybDogcmV3
b3JrIHJlZ2lzdGVycyAjZGVmaW5lDQo+IC0gZHRzOiBhZGQgU1RNRlggc3VwcG9ydCBvbiBzdG0z
Mm1wMTU3Yy1ldjENCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBmaXggTUZEIGludGVycnVwdCBiaW5k
aW5ncw0KPiAtIGZpeCBkcml2ZXJzL21mZC9zdG1meC5jOjEwMzo4OiB3YXJuaW5nOiAnbWFzaycg
bWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZA0KPiAgICBpbiB0aGlzIGZ1bmN0aW9uDQo+IENoYW5n
ZXMgaW4gdjI6DQo+IC0gbW92ZSB0byBNRkQgcGFyZW50IGRyaXZlciBmb3IgaTJjIHN0dWZmIGFu
ZCBjaGlwIGluaXRpYWxpemF0aW9uDQo+IC0gaW1wcm92ZSByZWdtYXAgY29uZmlndXJhdGlvbg0K
PiAtIHRha2UgYWR2YW50YWdlIG9mIHRoZSB1c2Ugb2YgZ3Bpby1yYW5nZXMNCj4gDQo+IEFtZWxp
ZSBEZWxhdW5heSAoOSk6DQo+ICAgIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBTVCBNdWx0aS1GdW5j
dGlvbiBlWHBhbmRlciAoU1RNRlgpIGNvcmUgYmluZGluZ3MNCj4gICAgbWZkOiBBZGQgU1QgTXVs
dGktRnVuY3Rpb24gZVhwYW5kZXIgKFNUTUZYKSBjb3JlIGRyaXZlcg0KPiAgICBkdC1iaW5kaW5n
czogcGluY3RybDogZG9jdW1lbnQgdGhlIFNUTUZYIHBpbmN0cmwgYmluZGluZ3MNCj4gICAgcGlu
Y3RybDogQWRkIFNUTUZYIEdQSU8gZXhwYW5kZXIgUGluY3RybC9HUElPIGRyaXZlcg0KPiAgICBB
Uk06IGR0czogc3RtMzI6IGFkZCBTVE1GWCBzdXBwb3J0IG9uIHN0bTMyNzQ2Zy1ldmFsDQo+ICAg
IEFSTTogZHRzOiBzdG0zMjogYWRkIGpveXN0aWNrIHN1cHBvcnQgb24gc3RtMzI3NDZnLWV2YWwN
Cj4gICAgQVJNOiBkdHM6IHN0bTMyOiBhZGQgb3JhbmdlIGFuZCBibHVlIGxlZHMgb24gc3RtMzI3
NDZnLWV2YWwNCj4gICAgQVJNOiBkdHM6IHN0bTMyOiBhZGQgU1RNRlggc3VwcG9ydCBvbiBzdG0z
Mm1wMTU3Yy1ldjENCj4gICAgQVJNOiBkdHM6IHN0bTMyOiBhZGQgam95c3RpY2sgc3VwcG9ydCBv
biBzdG0zMm1wMTU3Yy1ldjENCj4gDQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9zdG1meC50eHQgICAgfCAgMjggKw0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BpbmN0cmwvcGluY3RybC1zdG1meC50eHQgIHwgMTE2ICsrKw0KPiAgIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N0bTMyNzQ2Zy1ldmFsLmR0cyAgICAgICAgICAgICAgIHwgIDY2ICsrDQo+ICAgYXJjaC9h
cm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZXYxLmR0cyAgICAgICAgICAgICAgfCAgNjAgKysNCj4g
ICBkcml2ZXJzL21mZC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MyArDQo+ICAgZHJpdmVycy9tZmQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDIgKy0NCj4gICBkcml2ZXJzL21mZC9zdG1meC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDU2OCArKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvcGluY3RybC9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEyICsNCj4gICBkcml2ZXJzL3BpbmN0
cmwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtc3RtZnguYyAgICAgICAgICAgICAgICAgICAgfCA4MjAgKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51eC9tZmQvc3RtZnguaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMjMgKysrKw0KPiAgIDExIGZpbGVzIGNoYW5nZWQsIDE4MDggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3N0bWZ4LnR4dA0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9waW5jdHJs
LXN0bWZ4LnR4dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC9zdG1meC5jDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXN0bWZ4LmMNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvc3RtZnguaA0KPiA=
