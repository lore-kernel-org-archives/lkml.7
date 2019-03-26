Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAD220856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfCZNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:02:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbfCZNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:02:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCk7eF028864;
        Tue, 26 Mar 2019 14:02:14 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbhks3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 14:02:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF6B231;
        Tue, 26 Mar 2019 13:02:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA85658BB;
        Tue, 26 Mar 2019 13:02:13 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 14:02:13 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 14:02:12 +0100
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] drm/stm: add sleep power management
Thread-Topic: [PATCH] drm/stm: add sleep power management
Thread-Index: AQHU375K4qOHIsr0JUeGnbM34fOtl6Yd2AEA
Date:   Tue, 26 Mar 2019 13:02:12 +0000
Message-ID: <2ebfb124-08dc-4d5f-9e12-2afc5295c0f6@st.com>
References: <1553156120-13851-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553156120-13851-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66C8DD13FFEDCD49981B4CFA953E1ECF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCsgQmVuamFtaW4pDQoNCkRlYXIgWWFubmljaywNCk1hbnkgdGhhbmtzIGZvciB5b3VyIHBhdGNo
Lg0KQWNrZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNCkRl
YXIgQmVuamFtaW4sDQpNYXkgSSBhc2sgeW91IHBsZWFzZSB0byBtZXJnZSB0aGlzIHBhdGNoICsg
ImRybS9zdG06IGR3X21pcGlfZHNpLXN0bTogDQphZGQgc2xlZXAgcG93ZXIgbWFuYWdlbWVudCIg
b24gZHJtLW1pc2MsIGlmIHlvdSBhZ3JlZSBvZiBjb3Vyc2UgYW5kIHdoZW4gDQp5b3UgdGhpbmsg
aXQgaXMgdGhlIHJpZ2h0IHRpbWUgKG5leHQgd2Vlaz8pDQpCaWcgdGhhbmtzLA0KDQpQaGlsaXBw
ZSA6LSkNCg0KDQpPbiAzLzIxLzE5IDk6MTUgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4g
SW1wbGVtZW50cyBzeXN0ZW0gc2xlZXAgcG93ZXIgbWFuYWdlbWVudCBvcHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9kcnYuYyAgfCAzNSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmggfCAg
MyArKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9k
cnYuYw0KPiBpbmRleCAwYTdmOTMzLi41ODM0ZWY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vc3RtL2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vZHJ2LmMNCj4gQEAg
LTEyOSw2ICsxMjksNDAgQEAgc3RhdGljIHZvaWQgZHJ2X3VubG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldikNCj4gICAJZHJtX21vZGVfY29uZmlnX2NsZWFudXAoZGRldik7DQo+ICAgfQ0KPiAg
IA0KPiArc3RhdGljIF9fbWF5YmVfdW51c2VkIGludCBkcnZfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IGRybV9kZXZpY2UgKmRkZXYgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gKwlzdHJ1Y3QgbHRkY19kZXZpY2UgKmxkZXYgPSBkZGV2LT5kZXZfcHJpdmF0
ZTsNCj4gKwlzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGU7DQo+ICsNCj4gKwlkcm1fa21z
X2hlbHBlcl9wb2xsX2Rpc2FibGUoZGRldik7DQo+ICsJc3RhdGUgPSBkcm1fYXRvbWljX2hlbHBl
cl9zdXNwZW5kKGRkZXYpOw0KPiArCWlmIChJU19FUlIoc3RhdGUpKSB7DQo+ICsJCWRybV9rbXNf
aGVscGVyX3BvbGxfZW5hYmxlKGRkZXYpOw0KPiArCQlyZXR1cm4gUFRSX0VSUihzdGF0ZSk7DQo+
ICsJfQ0KPiArCWxkZXYtPnN1c3BlbmRfc3RhdGUgPSBzdGF0ZTsNCj4gKwlsdGRjX3N1c3BlbmQo
ZGRldik7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIF9fbWF5YmVf
dW51c2VkIGludCBkcnZfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgZHJtX2RldmljZSAqZGRldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBs
dGRjX2RldmljZSAqbGRldiA9IGRkZXYtPmRldl9wcml2YXRlOw0KPiArDQo+ICsJbHRkY19yZXN1
bWUoZGRldik7DQo+ICsJZHJtX2F0b21pY19oZWxwZXJfcmVzdW1lKGRkZXYsIGxkZXYtPnN1c3Bl
bmRfc3RhdGUpOw0KPiArCWRybV9rbXNfaGVscGVyX3BvbGxfZW5hYmxlKGRkZXYpOw0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBkcnZfcG1fb3BzID0gew0KPiArCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKGRydl9zdXNwZW5k
LCBkcnZfcmVzdW1lKQ0KPiArfTsNCj4gKw0KPiAgIHN0YXRpYyBpbnQgc3RtX2RybV9wbGF0Zm9y
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIHsNCj4gICAJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE4Niw2ICsyMjAsNyBAQCBzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBzdG1fZHJtX3BsYXRmb3JtX2RyaXZlciA9IHsNCj4gICAJ
LmRyaXZlciA9IHsNCj4gICAJCS5uYW1lID0gInN0bTMyLWRpc3BsYXkiLA0KPiAgIAkJLm9mX21h
dGNoX3RhYmxlID0gZHJ2X2R0X2lkcywNCj4gKwkJLnBtID0gJmRydl9wbV9vcHMsDQo+ICAgCX0s
DQo+ICAgfTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5j
IGIvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gaW5kZXggYjE3NDFhOS4uMzJmZDZhMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gQEAgLTEwNjIsNiArMTA2MiwzMCBAQCBzdGF0aWMgaW50
IGx0ZGNfZ2V0X2NhcHMoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpDQo+ICAgCXJldHVybiAwOw0K
PiAgIH0NCj4gICANCj4gK3ZvaWQgbHRkY19zdXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2
KQ0KPiArew0KPiArCXN0cnVjdCBsdGRjX2RldmljZSAqbGRldiA9IGRkZXYtPmRldl9wcml2YXRl
Ow0KPiArDQo+ICsJRFJNX0RFQlVHX0RSSVZFUigiXG4iKTsNCj4gKwljbGtfZGlzYWJsZV91bnBy
ZXBhcmUobGRldi0+cGl4ZWxfY2xrKTsNCj4gK30NCj4gKw0KPiAraW50IGx0ZGNfcmVzdW1lKHN0
cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KPiArew0KPiArCXN0cnVjdCBsdGRjX2RldmljZSAqbGRl
diA9IGRkZXYtPmRldl9wcml2YXRlOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlEUk1fREVCVUdf
RFJJVkVSKCJcbiIpOw0KPiArDQo+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGxkZXYtPnBp
eGVsX2Nsayk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlEUk1fRVJST1IoImZhaWxlZCB0byBlbmFi
bGUgcGl4ZWwgY2xvY2sgKCVkKVxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIGludCBsdGRjX2xvYWQoc3RydWN0IGRy
bV9kZXZpY2UgKmRkZXYpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRkZXYtPmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vc3RtL2x0ZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5oDQo+IGluZGV4
IGU0NmY0NzcuLmExYWQwYWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRk
Yy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5oDQo+IEBAIC0zNiw2ICszNiw3
IEBAIHN0cnVjdCBsdGRjX2RldmljZSB7DQo+ICAgCXUzMiBlcnJvcl9zdGF0dXM7DQo+ICAgCXUz
MiBpcnFfc3RhdHVzOw0KPiAgIAlzdHJ1Y3QgZnBzX2luZm8gcGxhbmVfZnBzaVtMVERDX01BWF9M
QVlFUl07DQo+ICsJc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN1c3BlbmRfc3RhdGU7DQo+ICAg
fTsNCj4gICANCj4gICBib29sIGx0ZGNfY3J0Y19zY2Fub3V0cG9zKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsIHVuc2lnbmVkIGludCBwaXBlLA0KPiBAQCAtNDUsNSArNDYsNyBAQCBib29sIGx0ZGNf
Y3J0Y19zY2Fub3V0cG9zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBl
LA0KPiAgIA0KPiAgIGludCBsdGRjX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpOw0KPiAg
IHZvaWQgbHRkY191bmxvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpOw0KPiArdm9pZCBsdGRj
X3N1c3BlbmQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYpOw0KPiAraW50IGx0ZGNfcmVzdW1lKHN0
cnVjdCBkcm1fZGV2aWNlICpkZGV2KTsNCj4gICANCj4gICAjZW5kaWYNCj4g
