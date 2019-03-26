Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11691C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBBB2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfCZMtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:49:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26865 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbfCZMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:49:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCk5sC028854;
        Tue, 26 Mar 2019 13:49:35 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbhhrq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:49:35 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D273A3F;
        Tue, 26 Mar 2019 12:49:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B4FEC5842;
        Tue, 26 Mar 2019 12:49:34 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 13:49:34 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 13:49:34 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] drm/panel: otm8009a: no error msg if probe deferred
Thread-Topic: [PATCH] drm/panel: otm8009a: no error msg if probe deferred
Thread-Index: AQHU37zB0Jnnli1TgEucj5uI0ij+0qYd1HuA
Date:   Tue, 26 Mar 2019 12:49:33 +0000
Message-ID: <c6786083-2832-87bf-9e88-d78108cd05cf@st.com>
References: <1553155484-13460-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553155484-13460-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <955F3ADD6C196143BD108AC345EA01FE@st.com>
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
biAzLzIxLzE5IDk6MDQgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gRG8gbm90IHByaW50
IGFuIGVycm9yIG1lc3NhZ2UgaWYgdGhlIHJlZ3VsYXRvciBmcmFtZXdvcmsNCj4gcmV0dXJucyBF
UFJPQkVfREVGRVIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5p
Y2suZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVs
LW9yaXNldGVjaC1vdG04MDA5YS5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3BhbmVsL3BhbmVsLW9yaXNldGVjaC1vdG04MDA5YS5jIGIvZHJpdmVycy9ncHUvZHJtL3Bh
bmVsL3BhbmVsLW9yaXNldGVjaC1vdG04MDA5YS5jDQo+IGluZGV4IDg3ZmEzMTYuLmFhM2RiMzgg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1vcmlzZXRlY2gtb3Rt
ODAwOWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtb3Jpc2V0ZWNoLW90
bTgwMDlhLmMNCj4gQEAgLTQzMyw3ICs0MzMsOCBAQCBzdGF0aWMgaW50IG90bTgwMDlhX3Byb2Jl
KHN0cnVjdCBtaXBpX2RzaV9kZXZpY2UgKmRzaSkNCj4gICAJY3R4LT5zdXBwbHkgPSBkZXZtX3Jl
Z3VsYXRvcl9nZXQoZGV2LCAicG93ZXIiKTsNCj4gICAJaWYgKElTX0VSUihjdHgtPnN1cHBseSkp
IHsNCj4gICAJCXJldCA9IFBUUl9FUlIoY3R4LT5zdXBwbHkpOw0KPiAtCQlkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byByZXF1ZXN0IHJlZ3VsYXRvcjogJWRcbiIsIHJldCk7DQo+ICsJCWlmIChyZXQg
IT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3Qg
cmVndWxhdG9yOiAlZFxuIiwgcmV0KTsNCj4gICAJCXJldHVybiByZXQ7DQo+ICAgCX0NCj4gICAN
Cj4g
