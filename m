Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2563BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB62C2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDAJUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:20:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54512 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfDAJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:20:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3191naZ018299;
        Mon, 1 Apr 2019 11:20:28 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rjee2734y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 11:20:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 213BE3D;
        Mon,  1 Apr 2019 09:20:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0D3717F4;
        Mon,  1 Apr 2019 09:20:19 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Apr
 2019 11:20:19 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 1 Apr 2019 11:20:19 +0200
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
Subject: Re: [PATCH] drm/stm: ltdc: use DRM_WARN for fifo & transfer error
 messages
Thread-Topic: [PATCH] drm/stm: ltdc: use DRM_WARN for fifo & transfer error
 messages
Thread-Index: AQHU5kbzbCkOIQfYm0uqy0PLvRD2cqYm6ikA
Date:   Mon, 1 Apr 2019 09:20:19 +0000
Message-ID: <ef8aa4e8-ebf9-ea01-d8db-fbf7740bc765@st.com>
References: <1553874548-31366-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553874548-31366-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <4BE8B68090AAA843823458F06BFB8752@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KRnVsbHkgYWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLA0KDQpBY2tlZC1i
eTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0p
DQoNCk9uIDMvMjkvMTkgNDo0OSBQTSwgWWFubmljayBGZXJ0csOpIHdyb3RlOg0KPiBGcm9tOiBQ
aGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KPiANCj4gVXNlIERSTV9XQVJO
KCkgaW5zdGVhZCBvZiBEUk1fREVCVUdfRFJJVkVSKCkgdG8gYmV0dGVyDQo+IGluZm9ybSB0aGUg
dXNlciBpbiBjYXNlIG9mIGZpZm8gdW5kZXJydW5zIG9yDQo+IHRyYW5zZmVyIGVycm9ycy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgNCArKy0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0v
bHRkYy5jDQo+IGluZGV4IGIxNzQxYTkuLjE1ZDhhMDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+
IEBAIC04MjIsMTEgKzgyMiwxMSBAQCBzdGF0aWMgdm9pZCBsdGRjX3BsYW5lX2F0b21pY191cGRh
dGUoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsDQo+ICAgDQo+ICAgCW11dGV4X2xvY2soJmxkZXYt
PmVycl9sb2NrKTsNCj4gICAJaWYgKGxkZXYtPmVycm9yX3N0YXR1cyAmIElTUl9GVUlGKSB7DQo+
IC0JCURSTV9ERUJVR19EUklWRVIoIkZpZm8gdW5kZXJydW5cbiIpOw0KPiArCQlEUk1fV0FSTigi
bHRkYyBmaWZvIHVuZGVycnVuOiBwbGVhc2UgdmVyaWZ5IGRpc3BsYXkgbW9kZVxuIik7DQo+ICAg
CQlsZGV2LT5lcnJvcl9zdGF0dXMgJj0gfklTUl9GVUlGOw0KPiAgIAl9DQo+ICAgCWlmIChsZGV2
LT5lcnJvcl9zdGF0dXMgJiBJU1JfVEVSUklGKSB7DQo+IC0JCURSTV9ERUJVR19EUklWRVIoIlRy
YW5zZmVyIGVycm9yXG4iKTsNCj4gKwkJRFJNX1dBUk4oImx0ZGMgdHJhbnNmZXIgZXJyb3JcbiIp
Ow0KPiAgIAkJbGRldi0+ZXJyb3Jfc3RhdHVzICY9IH5JU1JfVEVSUklGOw0KPiAgIAl9DQo+ICAg
CW11dGV4X3VubG9jaygmbGRldi0+ZXJyX2xvY2spOw0KPiA=
