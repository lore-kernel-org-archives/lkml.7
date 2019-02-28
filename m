Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A732171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfB1IyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:54:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53341 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfB1IyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:54:14 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S8kUN6006542;
        Thu, 28 Feb 2019 09:53:43 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtxbk62-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 09:53:43 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3159434;
        Thu, 28 Feb 2019 08:53:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E24752AFE;
        Thu, 28 Feb 2019 08:53:41 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb
 2019 09:53:41 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 28 Feb 2019 09:53:42 +0100
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Thread-Topic: [PATCH v4 1/9] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Thread-Index: AQHUzn+7ctlJbELl/ka5VHobvW4qYaX0QhmAgACWWIA=
Date:   Thu, 28 Feb 2019 08:53:42 +0000
Message-ID: <c54c4fd8-b97f-a70b-4805-fd3d217f5050@st.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-2-git-send-email-amelie.delaunay@st.com>
 <20190227235535.GA24395@bogus>
In-Reply-To: <20190227235535.GA24395@bogus>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CB0BFA4FFC6546A2026BD7801F867B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yOC8xOSAxMjo1NSBBTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgMjcgRmVi
IDIwMTkgMTA6MzQ6NDYgKzAxMDAsIEFtZWxpZSBEZWxhdW5heSB3cm90ZToNCj4+IFRoaXMgcGF0
Y2ggYWRkcyBkb2N1bWVudGF0aW9uIG9mIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUNCj4+
IFNUTWljcm9lbGVjdHJvbmljcyBNdWx0aS1GdW5jdGlvbiBlWHBhbmRlciAoU1RNRlgpIE1GRCBj
b3JlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFtZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1
bmF5QHN0LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+DQo+PiBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZmQvc3RtZngudHh0IHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdG1meC50eHQNCj4+DQo+IA0KPiBQ
bGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJz
aW9ucy4gSG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5
KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhh
dCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gSWYg
YSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0
IGNoYW5nZWQuDQo+IA0KDQpJJ20gc29ycnkgUm9iLCBJIGZvcmdvdCB0byBhZGQgeW91ciBSZXZp
ZXdlZC1ieSBvbiB0aGlzIHBhdGNoLCB3aGljaCBpcyANCmlkZW50aWNhbCB0byB2My4NCg0KSSBy
ZXBvc3RlZCB0aGUgd2hvbGUgc2VyaWVzLCBkdWUgdG8gY2hhbmdlcyBpbiBNRkQgZHJpdmVyIHdp
dGggc2lkZSANCmVmZmVjdCBpbiBwaW5jdHJsIGRyaXZlciwgYnV0IGJpbmRpbmdzIChNRkQgYW5k
IHBpbmN0cmwpIGRpZG4ndCBjaGFuZ2UgDQpiZXR3ZWVuIHRoZSB0d28gdmVyc2lvbnMuIEkgc3Rh
dGVkIHRoZSBjaGFuZ2VzIGluIGNvdmVyIGxldHRlci4NCg0KU2hvdWxkIEkgaGF2ZSByZW1vdmVk
IHRoZSBiaW5kaW5ncyBwYXRjaGVzIGZyb20gdGhlIHNlcmllcyA/
