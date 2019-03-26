Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97579C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C252070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfCZMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:50:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25196 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbfCZMud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:50:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCkHJD018646;
        Tue, 26 Mar 2019 13:50:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhta2wp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:50:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C601541;
        Tue, 26 Mar 2019 12:50:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A84C85802;
        Tue, 26 Mar 2019 12:50:25 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 13:50:25 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 13:50:25 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] drm/panel: otm8009a: set clock to 29.70 Mhz
Thread-Topic: [PATCH] drm/panel: otm8009a: set clock to 29.70 Mhz
Thread-Index: AQHU370k9VV5tczKr0yii95GrFrBpKYd1LcA
Date:   Tue, 26 Mar 2019 12:50:24 +0000
Message-ID: <a9072186-51ac-ac76-c544-02785c726846@st.com>
References: <1553155646-13636-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553155646-13636-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF4B9318A558D549823A25F09EEEC97E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KTWFueSB0aGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNClJldmlld2VkLWJ5
OiBQaGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KVGVzdGVkLWJ5OiBQaGls
aXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpQaGlsaXBwZSA6LSkNCg0KDQpP
biAzLzIxLzE5IDk6MDcgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gVGhlIHBhbmVsIGRv
ZXMgbm90IHN1cHBvcnQgY2xvY2sgZnJlcXVlbmN5IG92ZXIgMzAuNzQgTWh6Lg0KPiBUaGUgY2xv
Y2sgcmF0ZSBoYXMgYmVlbiByZWR1Y2VkIHRvIDI5LjcwIE1oeiAmIG5ldyB0aW1pbmdzIGhhdmUN
Cj4gYmVlbiBjb21wdXRlZCB0byBnZXQgYSBmcmFtZXJhdGUgb2YgNTBmcHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLW9yaXNldGVjaC1vdG04MDA5YS5jIHwg
MTQgKysrKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9w
YW5lbC1vcmlzZXRlY2gtb3RtODAwOWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1v
cmlzZXRlY2gtb3RtODAwOWEuYw0KPiBpbmRleCA4N2ZhMzE2Li5mNzE1YmJlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtb3Jpc2V0ZWNoLW90bTgwMDlhLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLW9yaXNldGVjaC1vdG04MDA5YS5jDQo+
IEBAIC02NywxNSArNjcsMTUgQEAgc3RydWN0IG90bTgwMDlhIHsNCj4gICB9Ow0KPiAgIA0KPiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSBkZWZhdWx0X21vZGUgPSB7DQo+
IC0JLmNsb2NrID0gMzI3MjksDQo+ICsJLmNsb2NrID0gMjk3MDAsDQo+ICAgCS5oZGlzcGxheSA9
IDQ4MCwNCj4gLQkuaHN5bmNfc3RhcnQgPSA0ODAgKyAxMjAsDQo+IC0JLmhzeW5jX2VuZCA9IDQ4
MCArIDEyMCArIDYzLA0KPiAtCS5odG90YWwgPSA0ODAgKyAxMjAgKyA2MyArIDEyMCwNCj4gKwku
aHN5bmNfc3RhcnQgPSA0ODAgKyA5OCwNCj4gKwkuaHN5bmNfZW5kID0gNDgwICsgOTggKyAzMiwN
Cj4gKwkuaHRvdGFsID0gNDgwICsgOTggKyAzMiArIDk4LA0KPiAgIAkudmRpc3BsYXkgPSA4MDAs
DQo+IC0JLnZzeW5jX3N0YXJ0ID0gODAwICsgMTIsDQo+IC0JLnZzeW5jX2VuZCA9IDgwMCArIDEy
ICsgMTIsDQo+IC0JLnZ0b3RhbCA9IDgwMCArIDEyICsgMTIgKyAxMiwNCj4gKwkudnN5bmNfc3Rh
cnQgPSA4MDAgKyAxNSwNCj4gKwkudnN5bmNfZW5kID0gODAwICsgMTUgKyAxMCwNCj4gKwkudnRv
dGFsID0gODAwICsgMTUgKyAxMCArIDE0LA0KPiAgIAkudnJlZnJlc2ggPSA1MCwNCj4gICAJLmZs
YWdzID0gMCwNCj4gICAJLndpZHRoX21tID0gNTIsDQo+IA==
