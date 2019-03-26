Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C942070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfCZMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:50:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28086 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731267AbfCZMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:50:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCkGtN018629;
        Tue, 26 Mar 2019 13:50:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhta2v9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:50:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A06EB43;
        Tue, 26 Mar 2019 12:50:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 764FF5168;
        Tue, 26 Mar 2019 12:50:07 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 13:50:07 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 13:50:06 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] drm/panel: rm68200: no error msg if probe deferred
Thread-Topic: [PATCH] drm/panel: rm68200: no error msg if probe deferred
Thread-Index: AQHU37zfUIdBMHosa0i61P1eGjDgEqYd1KIA
Date:   Tue, 26 Mar 2019 12:50:06 +0000
Message-ID: <d1f0a8d5-e8c6-a72d-f426-f2b314752d1c@st.com>
References: <1553155535-13555-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553155535-13555-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <05B07A0CC47E954B8F0E4172A0382975@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KTWFueSB0aGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNClJldmlld2VkLWJ5
OiBQaGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpQaGlsaXBwZSA6LSkN
Cg0KDQpPbiAzLzIxLzE5IDk6MDUgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gRG8gbm90
IHByaW50IGFuIGVycm9yIG1lc3NhZ2UgaWYgdGhlIHJlZ3VsYXRvciBmcmFtZXdvcmsNCj4gcmV0
dXJucyBFUFJPQkVfREVGRVIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kg
PHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3BhbmVs
L3BhbmVsLXJheWRpdW0tcm02ODIwMC5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3BhbmVsL3BhbmVsLXJheWRpdW0tcm02ODIwMC5jIGIvZHJpdmVycy9ncHUvZHJtL3Bh
bmVsL3BhbmVsLXJheWRpdW0tcm02ODIwMC5jDQo+IGluZGV4IDc3NTkzNTMuLjE0MTg2ODIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1yYXlkaXVtLXJtNjgyMDAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtcmF5ZGl1bS1ybTY4MjAwLmMN
Cj4gQEAgLTM4Myw3ICszODMsOCBAQCBzdGF0aWMgaW50IHJtNjgyMDBfcHJvYmUoc3RydWN0IG1p
cGlfZHNpX2RldmljZSAqZHNpKQ0KPiAgIAljdHgtPnN1cHBseSA9IGRldm1fcmVndWxhdG9yX2dl
dChkZXYsICJwb3dlciIpOw0KPiAgIAlpZiAoSVNfRVJSKGN0eC0+c3VwcGx5KSkgew0KPiAgIAkJ
cmV0ID0gUFRSX0VSUihjdHgtPnN1cHBseSk7DQo+IC0JCWRldl9lcnIoZGV2LCAiY2Fubm90IGdl
dCByZWd1bGF0b3I6ICVkXG4iLCByZXQpOw0KPiArCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIp
DQo+ICsJCQlkZXZfZXJyKGRldiwgImNhbm5vdCBnZXQgcmVndWxhdG9yOiAlZFxuIiwgcmV0KTsN
Cj4gICAJCXJldHVybiByZXQ7DQo+ICAgCX0NCj4gICANCj4g
