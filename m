Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E04C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB4D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDAJSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:18:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54333 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725859AbfDAJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:18:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3191na0018299;
        Mon, 1 Apr 2019 11:18:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rjee272v8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 11:18:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D8C034;
        Mon,  1 Apr 2019 09:18:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFB2023E7;
        Mon,  1 Apr 2019 09:18:30 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Apr
 2019 11:18:30 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 1 Apr 2019 11:18:30 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: fix data enable polarity
Thread-Topic: [PATCH] drm/stm: ltdc: fix data enable polarity
Thread-Index: AQHU5kckMbYFJt3bfkKEH1iJSp7VA6YjEI6AgAPZGgA=
Date:   Mon, 1 Apr 2019 09:18:30 +0000
Message-ID: <aeb9a5b0-0ad7-7bd1-eaf3-d037c2fb39cf@st.com>
References: <1553874620-31468-1-git-send-email-yannick.fertre@st.com>
 <98a9609b-138b-fc5b-c2b2-46f465c88bab@codeaurora.org>
In-Reply-To: <98a9609b-138b-fc5b-c2b2-46f465c88bab@codeaurora.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <37347E0861637D438254199CCA1D99F1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjkvMTkgMTA6MzIgUE0sIE11a2VzaCBPamhhIHdyb3RlOg0KPiANCj4gT24gMy8y
OS8yMDE5IDk6MjAgUE0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4+IFdyb25nIERJU1BMQVlf
RkxBR1MgdXNlZCB0byBzZXQgdGhlIGRhdGEgZW5hYmxlIHBvbGFyaXR5Lg0KPiBVc2VkIG9yIGNo
ZWNrZWQ/DQo+IENhbiB5b3UgYWxzbyBleHBsYWluIGhvdyBpdCBpcyB3cm9uZyB0byBjaGVjayBh
Z2FpbnN0IHRoaXMgRkxBRyBpbiBjb21taXQ/DQoNCkRlYXIgWWFubmljaywNCk1hbnkgdGhhbmtz
IGZvciB5b3VyIHBhdGNoLA0KDQpEZWFyIE11a2VzaCwNCk1hbnkgdGhhbmtzIGZvciB5b3VyIGNv
bW1lbnQsDQoNCkxvb2tpbmcgZGVlcGVyIGluIHRoZSBzdG0zMiBMVERDIFJlZiBtYW4gY2hhcHRl
ciwgd2UgY2FuIHJlYWQ6DQoNCkJpdCAzMCBWU1BPTDogdmVydGljYWwgc3luY2hyb25pemF0aW9u
IHBvbGFyaXR5DQpUaGlzIGJpdCBpcyBzZXQgYW5kIGNsZWFyZWQgYnkgc29mdHdhcmUuDQowOiB2
ZXJ0aWNhbCBzeW5jaHJvbml6YXRpb24gaXMgYWN0aXZlIGxvdy4NCjE6IHZlcnRpY2FsIHN5bmNo
cm9uaXphdGlvbiBpcyBhY3RpdmUgaGlnaC4NCg0KQml0IDI5IERFUE9MOiBub3QgZGF0YSBlbmFi
bGUgcG9sYXJpdHkNClRoaXMgYml0IGlzIHNldCBhbmQgY2xlYXJlZCBieSBzb2Z0d2FyZS4NCjA6
IG5vdCBkYXRhIGVuYWJsZSBwb2xhcml0eSBpcyBhY3RpdmUgbG93Lg0KMTogbm90IGRhdGEgZW5h
YmxlIHBvbGFyaXR5IGlzIGFjdGl2ZSBoaWdoLg0KDQpTbyBJIHN1Z2dlc3QgdGhlIGZvbGxvd2lu
ZyBjb21taXQgbWVzc2FnZToNCiJBY2NvcmRpbmcgdG8gdGhlIFNUTTMyIExUREMgZG9jdW1lbnRh
dGlvbiwgR0NSX0RFUE9MIGJpdCBuZWVkIHRvIGJlIHNldCANCndpdGggRElTUExBWV9GTEFHU19E
RV9MT1cgYnV0IG5vdCB3aXRoIERJU1BMQVlfRkxBR1NfREVfSElHSC4iDQoNCldpdGggdGhhdCBv
ciBzb21ldGhpbmcgc2ltaWxhcg0KDQpBY2tlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBl
LmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFlhbm5pY2sgRmVydHLDqSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPj4gLS0tDQo+PiAgICBk
cml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyB8IDIgKy0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+PiBpbmRl
eCBiMTc0MWE5Li42YmEzMjZhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3N0bS9s
dGRjLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+PiBAQCAtNTU1LDcg
KzU1NSw3IEBAIHN0YXRpYyB2b2lkIGx0ZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1f
Y3J0YyAqY3J0YykNCj4+ICAgIAlpZiAodm0uZmxhZ3MgJiBESVNQTEFZX0ZMQUdTX1ZTWU5DX0hJ
R0gpDQo+PiAgICAJCXZhbCB8PSBHQ1JfVlNQT0w7DQo+PiAgICANCj4+IC0JaWYgKHZtLmZsYWdz
ICYgRElTUExBWV9GTEFHU19ERV9ISUdIKQ0KPj4gKwlpZiAodm0uZmxhZ3MgJiBESVNQTEFZX0ZM
QUdTX0RFX0xPVykNCj4+ICAgIAkJdmFsIHw9IEdDUl9ERVBPTDsNCj4+ICAgIA0KPj4gICAgCWlm
ICh2bS5mbGFncyAmIERJU1BMQVlfRkxBR1NfUElYREFUQV9ORUdFREdFKQ==
