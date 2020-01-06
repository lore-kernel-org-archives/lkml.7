Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF9C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102B215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gdmqaXuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgAFCLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:11:02 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42135 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbgAFCLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:11:02 -0500
X-UUID: cea53f88ddee40a7b53a34743a0b15f8-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IFuraZzF877J9vJnN3oKRmiXLPR+UaYNdb3VQPcAbDo=;
        b=gdmqaXuKYaoGGuPF3ser2AMo21j8w2Ooty0o/bWUH96XG5skMx24dEOGupWUnViBJDfumpNjgxotmED66lZzu9vStFb+xmbISY1KIy2ynZbyOQ5u8Mi/gb/L0zbT3zLXvDFo4demEG56exgjHGhL4CRPlaJkJdJ/jK8V9557tco=;
X-UUID: cea53f88ddee40a7b53a34743a0b15f8-20200106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1166485976; Mon, 06 Jan 2020 10:10:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 6 Jan
 2020 10:10:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 10:09:53 +0800
Message-ID: <1578276653.21256.12.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] phy: mediatek: Fix Kconfig indentation
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 6 Jan 2020 10:10:53 +0800
In-Reply-To: <20200103164710.4829-1-krzk@kernel.org>
References: <20200103164710.4829-1-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 575598EFCB39BFB786417D543F5955B08556C0148A1349B2183C94FEB2DA7FA32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTAzIGF0IDE3OjQ3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBBZGp1c3QgaW5kZW50YXRpb24gZnJvbSBzcGFjZXMgdG8gdGFiICgrb3B0aW9uYWwg
dHdvIHNwYWNlcykgYXMgaW4NCj4gY29kaW5nIHN0eWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiANCj4gLS0tDQo+IA0KPiBD
aGFuZ2VzIHNpbmNlIHYxOg0KPiAxLiBOb25lDQo+IC0tLQ0KPiAgZHJpdmVycy9waHkvbWVkaWF0
ZWsvS2NvbmZpZyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waHkvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcN
Cj4gaW5kZXggMzc2ZjVkMTg5ZGEwLi43ZDE5MTM0YzZiN2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvS2Nv
bmZpZw0KPiBAQCAtMywxMiArMywxMiBAQA0KPiAgIyBQaHkgZHJpdmVycyBmb3IgTWVkaWF0ZWsg
ZGV2aWNlcw0KPiAgIw0KPiAgY29uZmlnIFBIWV9NVEtfVFBIWQ0KPiAtICAgIHRyaXN0YXRlICJN
ZWRpYVRlayBULVBIWSBEcml2ZXIiDQo+IC0gICAgZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLICYm
IE9GDQo+IC0gICAgc2VsZWN0IEdFTkVSSUNfUEhZDQo+IC0gICAgaGVscA0KPiAtICAgICAgU2F5
ICdZJyBoZXJlIHRvIGFkZCBzdXBwb3J0IGZvciBNZWRpYVRlayBULVBIWSBkcml2ZXIsDQo+IC0g
ICAgICBpdCBzdXBwb3J0cyBtdWx0aXBsZSB1c2IyLjAsIHVzYjMuMCBwb3J0cywgUENJZSBhbmQN
Cj4gKwl0cmlzdGF0ZSAiTWVkaWFUZWsgVC1QSFkgRHJpdmVyIg0KPiArCWRlcGVuZHMgb24gQVJD
SF9NRURJQVRFSyAmJiBPRg0KPiArCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiArCWhlbHANCj4gKwkg
IFNheSAnWScgaGVyZSB0byBhZGQgc3VwcG9ydCBmb3IgTWVkaWFUZWsgVC1QSFkgZHJpdmVyLA0K
PiArCSAgaXQgc3VwcG9ydHMgbXVsdGlwbGUgdXNiMi4wLCB1c2IzLjAgcG9ydHMsIFBDSWUgYW5k
DQo+ICAJICBTQVRBLCBhbmQgbWVhbndoaWxlIHN1cHBvcnRzIHR3byB2ZXJzaW9uIFQtUEhZIHdo
aWNoIGhhdmUNCj4gIAkgIGRpZmZlcmVudCBiYW5rcyBsYXlvdXQsIHRoZSBULVBIWSB3aXRoIHNo
YXJlZCBiYW5rcyBiZXR3ZWVuDQo+ICAJICBtdWx0aS1wb3J0cyBpcyBmaXJzdCB2ZXJzaW9uLCBv
dGhlcndpc2UgaXMgc2Vjb25kIHZlcmlvc24sDQo+IEBAIC0yNSwxMCArMjUsMTAgQEAgY29uZmln
IFBIWV9NVEtfVUZTDQo+ICAJICBzcGVjaWZpZWQgTS1QSFlzLg0KPiAgDQo+ICBjb25maWcgUEhZ
X01US19YU1BIWQ0KPiAtICAgIHRyaXN0YXRlICJNZWRpYVRlayBYUy1QSFkgRHJpdmVyIg0KPiAt
ICAgIGRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyAmJiBPRg0KPiAtICAgIHNlbGVjdCBHRU5FUklD
X1BIWQ0KPiAtICAgIGhlbHANCj4gKwl0cmlzdGF0ZSAiTWVkaWFUZWsgWFMtUEhZIERyaXZlciIN
Cj4gKwlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgJiYgT0YNCj4gKwlzZWxlY3QgR0VORVJJQ19Q
SFkNCj4gKwloZWxwDQo+ICAJICBFbmFibGUgdGhpcyB0byBzdXBwb3J0IHRoZSBTdXBlclNwZWVk
UGx1cyBYUy1QSFkgdHJhbnNjZWl2ZXIgZm9yDQo+ICAJICBVU0IzLjEgR0VOMiBjb250cm9sbGVy
cyBvbiBNZWRpYVRlayBjaGlwcy4gVGhlIGRyaXZlciBzdXBwb3J0cw0KPiAgCSAgbXVsdGlwbGUg
VVNCMi4wLCBVU0IzLjEgR0VOMiBwb3J0cy4NCg0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MNCg0K

