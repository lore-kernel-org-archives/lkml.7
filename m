Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CAD2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDAJTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:19:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfDAJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:19:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31915xD032373;
        Mon, 1 Apr 2019 11:18:55 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhy3x9nd0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 11:18:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6321A42;
        Mon,  1 Apr 2019 09:18:54 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39A4D23E2;
        Mon,  1 Apr 2019 09:18:54 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Apr
 2019 11:18:53 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 1 Apr 2019 11:18:53 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: disable hw interrupts before its handler
 init
Thread-Topic: [PATCH] drm/stm: ltdc: disable hw interrupts before its handler
 init
Thread-Index: AQHU5kbfiZFpMDEVSU6br4Pl5P9NMKYm6cSA
Date:   Mon, 1 Apr 2019 09:18:53 +0000
Message-ID: <d63b7a3e-3162-7823-fa42-81a1aeccb5ff@st.com>
References: <1553874485-31259-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553874485-31259-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E97CCE9AB40C2F4698FFAE03E95C1BB3@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzLzI5LzE5IDQ6NDggUE0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gSW50ZXJydXB0
IHJlZ2lzdGVyIG11c3QgYmUgZGlzYWJsZWQgYmVmb3JlIGNhbGwgb2YNCj4gZGV2bV9yZXF1ZXN0
X3RocmVhZGVkX2lycSBmdW5jdGlvbiB0byBhdm9pZCBkdW1teSBpbnRlcnJ1cHRpb24uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCA4ICsrKystLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9z
dG0vbHRkYy5jDQo+IGluZGV4IGIxNzQxYTkuLmVmNWI0ZDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5j
DQo+IEBAIC0xMTE4LDYgKzExMTgsMTAgQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldikNCj4gICAJCWdvdG8gZXJyOw0KPiAgIAl9DQo+ICAgDQo+ICsJLyogRGlzYWJsZSBp
bnRlcnJ1cHRzICovDQo+ICsJcmVnX2NsZWFyKGxkZXYtPnJlZ3MsIExURENfSUVSLA0KPiArCQkg
IElFUl9MSUUgfCBJRVJfUlJJRSB8IElFUl9GVUlFIHwgSUVSX1RFUlJJRSk7DQo+ICsNCj4gICAJ
Zm9yIChpID0gMDsgaSA8IE1BWF9JUlE7IGkrKykgew0KPiAgIAkJaXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCBpKTsNCj4gICAJCWlmIChpcnEgPCAwKQ0KPiBAQCAtMTEzOCwxMCArMTE0Miw2
IEBAIGludCBsdGRjX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpDQo+ICAgCQlyZXNldF9j
b250cm9sX2RlYXNzZXJ0KHJzdGMpOw0KPiAgIAl9DQo+ICAgDQo+IC0JLyogRGlzYWJsZSBpbnRl
cnJ1cHRzICovDQo+IC0JcmVnX2NsZWFyKGxkZXYtPnJlZ3MsIExURENfSUVSLA0KPiAtCQkgIElF
Ul9MSUUgfCBJRVJfUlJJRSB8IElFUl9GVUlFIHwgSUVSX1RFUlJJRSk7DQo+IC0NCg0KRGVhciBZ
YW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpBY2tlZC1ieTogUGhpbGlwcGUg
Q29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCj4gICAJcmV0
ID0gbHRkY19nZXRfY2FwcyhkZGV2KTsNCj4gICAJaWYgKHJldCkgew0KPiAgIAkJRFJNX0VSUk9S
KCJoYXJkd2FyZSBpZGVudGlmaWVyICgweCUwOHgpIG5vdCBzdXBwb3J0ZWQhXG4iLA0KPiA=
