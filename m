Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A4B2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfB1O7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:59:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfB1O7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:59:44 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SEuWdV020935;
        Thu, 28 Feb 2019 15:59:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3wke0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 15:59:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EB8A31;
        Thu, 28 Feb 2019 14:59:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 291FC5AA8;
        Thu, 28 Feb 2019 14:59:27 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb
 2019 15:59:27 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 28 Feb 2019 15:59:27 +0100
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
Thread-Index: AQHUzn+7ctlJbELl/ka5VHobvW4qYaX0QhmAgACWWICAAGFEgIAABOwA
Date:   Thu, 28 Feb 2019 14:59:26 +0000
Message-ID: <8a5cdf64-343c-1a91-00ef-11af8d81b549@st.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-2-git-send-email-amelie.delaunay@st.com>
 <20190227235535.GA24395@bogus> <c54c4fd8-b97f-a70b-4805-fd3d217f5050@st.com>
 <CAL_JsqJ+orZUitUvMtKJ8ww4hnn9eacy5Xak+oTO_MGrgSGJpw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ+orZUitUvMtKJ8ww4hnn9eacy5Xak+oTO_MGrgSGJpw@mail.gmail.com>
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
Content-ID: <48665CFC00064F4BBEF2936F11C9F455@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yOC8xOSAzOjQxIFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBGZWIgMjgs
IDIwMTkgYXQgMjo1NCBBTSBBbWVsaWUgREVMQVVOQVkgPGFtZWxpZS5kZWxhdW5heUBzdC5jb20+
IHdyb3RlOg0KPj4NCj4+IE9uIDIvMjgvMTkgMTI6NTUgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0K
Pj4+IE9uIFdlZCwgMjcgRmViIDIwMTkgMTA6MzQ6NDYgKzAxMDAsIEFtZWxpZSBEZWxhdW5heSB3
cm90ZToNCj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGRvY3VtZW50YXRpb24gb2YgZGV2aWNlIHRyZWUg
YmluZGluZ3MgZm9yIHRoZQ0KPj4+PiBTVE1pY3JvZWxlY3Ryb25pY3MgTXVsdGktRnVuY3Rpb24g
ZVhwYW5kZXIgKFNUTUZYKSBNRkQgY29yZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQW1l
bGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPg0KPj4+PiBSZXZpZXdlZC1ieTog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPj4+PiBBY2tlZC1mb3It
TUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPj4+PiAtLS0NCj4+Pj4g
ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdG1meC50eHQgfCAyOCAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNl
cnRpb25zKCspDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL3N0bWZ4LnR4dA0KPj4+Pg0KPj4+DQo+Pj4gUGxlYXNlIGFkZCBB
Y2tlZC1ieS9SZXZpZXdlZC1ieSB0YWdzIHdoZW4gcG9zdGluZyBuZXcgdmVyc2lvbnMuIEhvd2V2
ZXIsDQo+Pj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQg
dGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPj4+IG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZvciBh
Y2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+Pj4NCj4+PiBJZiBhIHRh
ZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hh
bmdlZC4NCj4+Pg0KPj4NCj4+IEknbSBzb3JyeSBSb2IsIEkgZm9yZ290IHRvIGFkZCB5b3VyIFJl
dmlld2VkLWJ5IG9uIHRoaXMgcGF0Y2gsIHdoaWNoIGlzDQo+PiBpZGVudGljYWwgdG8gdjMuDQo+
Pg0KPj4gSSByZXBvc3RlZCB0aGUgd2hvbGUgc2VyaWVzLCBkdWUgdG8gY2hhbmdlcyBpbiBNRkQg
ZHJpdmVyIHdpdGggc2lkZQ0KPj4gZWZmZWN0IGluIHBpbmN0cmwgZHJpdmVyLCBidXQgYmluZGlu
Z3MgKE1GRCBhbmQgcGluY3RybCkgZGlkbid0IGNoYW5nZQ0KPj4gYmV0d2VlbiB0aGUgdHdvIHZl
cnNpb25zLiBJIHN0YXRlZCB0aGUgY2hhbmdlcyBpbiBjb3ZlciBsZXR0ZXIuDQo+Pg0KPj4gU2hv
dWxkIEkgaGF2ZSByZW1vdmVkIHRoZSBiaW5kaW5ncyBwYXRjaGVzIGZyb20gdGhlIHNlcmllcyA/
DQo+IA0KPiBObywgYXMgdGhlIHNlcmllcyBzaG91bGQgYmUgYXBwbGllZCB0b2dldGhlci4gWW91
IGp1c3QgbmVlZCB0byBhZGQgdGhlDQo+IFJldmlld2VkLWJ5IHNvIEkgY2FuIGlnbm9yZSBpdC4N
Cj4gDQo+IFJvYg0KPiANCg0KTm90ZWQuIEkgd2lsbCBlbnN1cmUgbm90IHRvIGZvcmdldCBhbnkg
dGFnIG5leHQgdGltZS4NCg0KUmVnYXJkcywNCkFtZWxpZQ==
