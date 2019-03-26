Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF442C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17142054F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfCZMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:48:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49989 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbfCZMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:48:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCk5J3028846;
        Tue, 26 Mar 2019 13:48:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbhhjf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:48:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7799638;
        Tue, 26 Mar 2019 12:48:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0EBF0583D;
        Tue, 26 Mar 2019 12:48:25 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 13:48:24 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 13:48:24 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] drm/panel: otm8009a: add delay at the end of
 initialization
Thread-Topic: [PATCH] drm/panel: otm8009a: add delay at the end of
 initialization
Thread-Index: AQHU37ywx6OLqOjOCUawP6iAdz647aYd1CIA
Date:   Tue, 26 Mar 2019 12:48:24 +0000
Message-ID: <f027e4d6-7a49-8e1d-c019-e244b2bbc7e6@st.com>
References: <1553155445-13407-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553155445-13407-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <670BA41649868943B1D3ED9D023418FB@st.com>
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
aXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpQaGls
aXBwZQ0KDQpPbiAzLzIxLzE5IDk6MDQgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gQXQg
dGhlIGVuZCBvZiBpbml0aWFsaXphdGlvbiwgYSBkZWxheSBpcyByZXF1aXJlZCBieSB0aGUgcGFu
ZWwuDQo+IFdpdGhvdXQgdGhpcyBkZWxheSwgdGhlIHBhbmVsIGNvdWxkIHJlY2VpdmVkIGEgZnJh
bWUgZWFybHkgJg0KPiBnZW5lcmF0ZSBhIGNyYXNoIG9mIHBhbmVsIChibGFjayBzY3JlZW4pLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0csOpIDx5YW5uaWNrLmZlcnRyZUBzdC5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1vcmlzZXRlY2gtb3Rt
ODAwOWEuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1vcmlzZXRlY2gtb3Rt
ODAwOWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1vcmlzZXRlY2gtb3RtODAwOWEu
Yw0KPiBpbmRleCA4N2ZhMzE2Li41OGNjZjY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcGFuZWwvcGFuZWwtb3Jpc2V0ZWNoLW90bTgwMDlhLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3BhbmVsL3BhbmVsLW9yaXNldGVjaC1vdG04MDA5YS5jDQo+IEBAIC0yNDgsNiArMjQ4LDkg
QEAgc3RhdGljIGludCBvdG04MDA5YV9pbml0X3NlcXVlbmNlKHN0cnVjdCBvdG04MDA5YSAqY3R4
KQ0KPiAgIAkvKiBTZW5kIENvbW1hbmQgR1JBTSBtZW1vcnkgd3JpdGUgKG5vIHBhcmFtZXRlcnMp
ICovDQo+ICAgCWRjc193cml0ZV9zZXEoY3R4LCBNSVBJX0RDU19XUklURV9NRU1PUllfU1RBUlQp
Ow0KPiAgIA0KPiArCS8qIFdhaXQgYSBzaG9ydCB3aGlsZSB0byBsZXQgdGhlIHBhbmVsIGJlIHJl
YWR5IGJlZm9yZSB0aGUgMXN0IGZyYW1lICovDQo+ICsJbWRlbGF5KDEwKTsNCj4gKw0KPiAgIAly
ZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+IA==
