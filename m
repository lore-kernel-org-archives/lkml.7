Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A92C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FED02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tdZKaSRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfFXHUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:20:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5746 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727835AbfFXHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:20:53 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O7Gm0F007581;
        Mon, 24 Jun 2019 09:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=yIONWFSs1oKdCqvaOndtOK2au6DElgx93gHb16N6pdA=;
 b=tdZKaSReLQWq+x145acXGNzuTOxthCpcU6H+wKus6fEiLuo8dTGtEONv2HRoSTSBe1ci
 m8rW0Vuqxwm0wV2Lg82xGZEX/vCVXbpcQmia3Lr5MjyM7DSKstaRFUfhReidzZg1a7xu
 LYO75tyU3+iSDt5cmM+irMvvYIybQGvigSX8FN+5BUYL7tzSpf7OTcHHHGPJ6JhLIG0N
 SrubZ601lzVMyIDo4lFAnLck9Q8cuc9J4ETRgVjKFBqCABp76XQvaFnBObVn8c1jCToA
 kAirryQ+WWkhztroKEOxlTVe4F+Mrz8qE8J4U1/VBGZESIGYNA+LGoxwL9R1lf2GLCG3 Lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t9d2w9jav-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Jun 2019 09:20:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5484734;
        Mon, 24 Jun 2019 07:20:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3359F15AA;
        Mon, 24 Jun 2019 07:20:41 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 24 Jun
 2019 09:20:40 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Mon, 24 Jun 2019 09:20:40 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Denis Efremov <efremov@linux.com>,
        Nathan Chancellor <natechancellor@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: stmfx.h: typo in the header guard
Thread-Topic: [PATCH] mfd: stmfx.h: typo in the header guard
Thread-Index: AQHVKdJKyJAGS3v5qEa3Gl2UX5YQFKaqRXsA
Date:   Mon, 24 Jun 2019 07:20:40 +0000
Message-ID: <3d00e9cd-ba4d-73d1-a486-0b4f2c511c9c@st.com>
References: <20190623144459.21608-1-efremov@linux.com>
In-Reply-To: <20190623144459.21608-1-efremov@linux.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFE614BF5A257D43A03D62C054DEF94C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMy8xOSA0OjQ0IFBNLCBEZW5pcyBFZnJlbW92IHdyb3RlOg0KPiBUaGUgZ3VhcmQgbWFj
cm8gTUZYX1NUTUZYX0ggaW4gdGhlIGhlYWRlciBzdG1meC5oDQo+IGRvZXNuJ3QgbWF0Y2ggdGhl
ICNpZm5kZWYgbWFjcm8gTUZEX1NUTUZYX0guIFRoZSBwYXRjaA0KPiBmaXhlcyB0aGUgdHlwby4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IERlbmlzIEVmcmVtb3YgPGVmcmVtb3ZAbGludXguY29tPg0K
PiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4L21mZC9zdG1meC5oIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvbWZkL3N0bWZ4LmggYi9pbmNsdWRlL2xpbnV4L21mZC9zdG1meC5oDQo+
IGluZGV4IGQ4OTA1OTViODliNi4uM2M2Nzk4MzY3OGVjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21mZC9zdG1meC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWZkL3N0bWZ4LmgNCj4g
QEAgLTUsNyArNSw3IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2lmbmRlZiBNRkRfU1RNRlhfSA0K
PiAtI2RlZmluZSBNRlhfU1RNRlhfSA0KPiArI2RlZmluZSBNRkRfU1RNRlhfSA0KPiAgIA0KPiAg
ICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gICANCj4gDQoNCkhpIERlbmlzLA0KDQpUaGFu
a3MgZm9yIHlvdXIgcGF0Y2guIE5hdGhhbiBhbHJlYWR5IHNlbnQgYSBmaXggZm9yIHRoYXQ6IA0K
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNS8xMC83NzcuDQoNClJlZ2FyZHMsDQpBbWVsaWU=
