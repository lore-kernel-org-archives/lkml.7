Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B628218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfC2P7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:59:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7305 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728815AbfC2P7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:59:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TFs1wv008936;
        Fri, 29 Mar 2019 16:59:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rh1g8xkj3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 16:59:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20D8331;
        Fri, 29 Mar 2019 15:59:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC5284F01;
        Fri, 29 Mar 2019 15:59:04 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Mar
 2019 16:59:04 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Fri, 29 Mar 2019 16:59:04 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Ohad Ben-Cohen" <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/8] dt-bindings: stm32: add bindings for ML-AHB
 interconnect
Thread-Topic: [PATCH 1/8] dt-bindings: stm32: add bindings for ML-AHB
 interconnect
Thread-Index: AQHU018jzlZ5QeEaF0q3EEQbm/CVpqYgLCkAgAKs/oA=
Date:   Fri, 29 Mar 2019 15:59:04 +0000
Message-ID: <41b7bd91-7c14-9227-381e-f0e751ae4079@st.com>
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
 <1551795849-13672-2-git-send-email-fabien.dessenne@st.com>
 <20190327230722.GA13708@bogus>
In-Reply-To: <20190327230722.GA13708@bogus>
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
Content-ID: <8F829B3D3056E349B3FC617CFC54D063@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpMZXQgbWUgY2xhcmlmeSB0aGUgY29udGV4dCBhbmQgdGhlIHJlYXNvbiBvZiB0
aGUgcHJvcG9zZWQgYXBwcm9hY2guDQoNClRoZSByZW1vdGVwcm9jIGZyYW1ld29yayBkZWFscyB3
aXRoICdjYXJ2ZW91dCcgbWVtb3J5IHJlZ2lvbnMuDQogRnJvbSB0aGUgcmVtb3RlcHJvY19jb3Jl
LmM6DQoNCiDCoCogU29tZSByZW1vdGUgcHJvY2Vzc29ycyB3aWxsIGFzayB1cyB0byBhbGxvY2F0
ZSB0aGVtIHBoeXNpY2FsbHkgY29udGlndW91cw0KIMKgKiBtZW1vcnkgcmVnaW9ucyAod2hpY2gg
d2UgY2FsbCAiY2FydmVvdXRzIiksIGFuZCBtYXAgdGhlbSB0byBzcGVjaWZpYw0KIMKgKiBkZXZp
Y2UgYWRkcmVzc2VzICh3aGljaCBhcmUgaGFyZGNvZGVkIGluIHRoZSBmaXJtd2FyZSkuIFRoZXkg
bWF5IGFsc28gaGF2ZQ0KIMKgKiBkZWRpY2F0ZWQgbWVtb3J5IHJlZ2lvbnMgaW50ZXJuYWwgdG8g
dGhlIHByb2Nlc3NvcnMsIGFuZCB1c2UgdGhlbSBlaXRoZXINCiDCoCogZXhjbHVzaXZlbHkgb3Ig
YWxvbmdzaWRlIGNhcnZlb3V0cy4NCiDCoCoNCiDCoCogVGhleSBtYXkgdGhlbiBhc2sgdXMgdG8g
Y29weSBvYmplY3RzIGludG8gc3BlY2lmaWMgZGV2aWNlIGFkZHJlc3NlcyAoZS5nLg0KIMKgKiBj
b2RlL2RhdGEgc2VjdGlvbnMpIG9yIGV4cG9zZSB1cyBjZXJ0YWluIHN5bWJvbHMgaW4gb3RoZXIg
ZGV2aWNlIGFkZHJlc3MNCiDCoCogKGUuZy4gdGhlaXIgdHJhY2UgYnVmZmVyKS4NCg0KRm9yIHRo
aXMsIHRoZSByZW1vdGVwcm9jIGRyaXZlcnMgaGF2ZSB0byByZWdpc3RlciB0aGVzZSBtZW1vcnkg
cmVnaW9ucw0KcHJvdmlkaW5nIHRoZWlyIG1lbW9yeSBtYXBwaW5nIHJlbW90ZSBwcm9jZXNzb3Ig
dmlldyAvIGxvY2FsIHByb2Nlc3Nvcg0Kdmlldy4gU2VlIHJwcm9jX21lbV9lbnRyeV9pbml0KCkg
YW5kIHJwcm9jX2FkZF9jYXJ2ZW91dCgpLg0KDQpBbiBpbXBsZW1lbnRhdGlvbiBzb2x1dGlvbiBj
b25zaXN0cyBpbiBkZWNsYXJpbmcgdGhlIG1lbW9yeSBtYXBwaW5nIGluc2lkZQ0KdGhlIHJlbW90
ZXByb2MgZHJpdmVyLiAoRXg6IGlteF9ycHJvY19hdHRfaW14N2RbXSBmcm9tIGlteF9ycHJvYy5j
KQ0KDQpGb3IgdGhlIHN0bTMyIHJwcm9jIGRyaXZlciB0aGF0IHdlIGFyZSBpbnRyb2R1Y2luZywg
d2Ugd291bGQgbGlrZSB0byBoYXZlDQpzb21ldGhpbmcgbW9yZSBmbGV4aWJsZSB0aGFuIGhhcmRj
b2RlZCB2YWx1ZXMuDQoNCk9uZSByZWFzb24gZm9yIHRoaXMsIGlzIHRoYXQgc29tZSBtZW1vcnkg
cGFydHMgY2FuIGJlIGFjY2Vzc2VkIHRocm91Z2gNCmRpZmZlcmVudCAyIGJ1cyBwb3J0LCB3aXRo
IGRpZmZlcmVudCBhZGRyZXNzZXMgYW5kIGFjY2VzcyBzcGVlZCwgYW5kIHdlDQp3b3VsZCBsaWtl
IHRvIGxldCB0aGUgdXNlciBjdXN0b21pemUgdGhpcy4NCg0KVXNpbmcgRGV2aWNlVHJlZSAicmFu
Z2VzIiBzZWVtcyB0byBmaXQgd2l0aCB0aGVzZSByZXF1aXJlbWVudHMuDQoNCklmIHlvdSB0aGlu
ayB0aGF0IHRoaXMgaXMgbm90IHRoZSByaWdodCBhcHByb2FjaCwgcGxlYXNlIGxldCBtZSBrbm93
IGlmIHlvdQ0KdGhpbmsgYWJvdXQgc29tZXRoaW5nIGJldHRlci4NCg0KU2VlIGFsc28gYmVsb3cg
bXkgYW5zd2VyIHRvIHlvdXIgc3BlY2lmaWMgcmVtYXJrcw0KDQpCUg0KDQpPbiAyOC8wMy8yMDE5
IDEyOjA3IEFNLCBSb2IgSGVycmluZyB3cm90ZToNCg0KPiBPbiBUdWUsIE1hciAwNSwgMjAxOSBh
dCAwMzoyNDowMlBNICswMTAwLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+PiBEb2N1bWVudCB0
aGUgTUwtQUhCIGludGVyY29ubmVjdCBmb3Igc3RtMzIgU29Dcy4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQo+PiAtLS0NCj4+
ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0bTMyL21sYWhiLnR4dCAgICAgICAgfCAz
MCArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRp
b25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL3N0bTMyL21sYWhiLnR4dA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0bTMyL21sYWhiLnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vc3RtMzIvbWxhaGIudHh0DQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMC4uODgwY2IzOA0KPj4gLS0tIC9kZXYvbnVs
bA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9zdG0zMi9t
bGFoYi50eHQNCj4+IEBAIC0wLDAgKzEsMzAgQEANCj4+ICtNTC1BSEIgaW50ZXJjb25uZWN0IGJp
bmRpbmdzDQo+PiArDQo+PiArVGhlc2UgYmluZGluZ3MgZGVzY3JpYmUgdGhlIFNUTTMyIFNvQ3Mg
TUwtQUhCIGludGVyY29ubmVjdCBidXMgd2hpY2ggY29ubmVjdHMNCj4+ICthIENvcnRleC1NIHN1
YnN5c3RlbSB3aXRoIGRlZGljYXRlZCBtZW1vcmllcy4NCj4+ICsNCj4+ICtSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPj4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJzaW1wbGUtYnVzIg0KPiBBIGJp
bmRpbmcgZm9yIHNpbXBsZS1idXMgd2FzIHRoZSBmaXJzdCB0aGluZyB0aGF0IGxvb2tlZCBvZGQu
DQoNClNpbmNlIHdlIHdhbnQgdG8gdXNlICJyYW5nZXMiIChvciAiZG1hLXJhbmdlcyIpLCB3ZSBu
ZWVkIHRvIGRlZmluZSBhIHBhcmVudC1idXMuDQpUaGlzIGJ1cyBoYXMgbm90aGluZyBzcGVjaWZp
Yywgc28gaXQgaXMgYSAic2ltcGxlLWJ1cyINCg0KPg0KPj4gKy0gcmFuZ2VzOiBkZXNjcmliZXMg
bWVtb3J5IGFkZHJlc3NlcyB0cmFuc2xhdGlvbiBiZXR3ZWVuIHRoZSBsb2NhbCBDUFUgYW5kIHRo
ZQ0KPj4gKwkgICByZW1vdGUgQ29ydGV4LU0gcHJvY2Vzc29yLiBFYWNoIG1lbW9yeSByZWdpb24s
IGlzIGRlY2xhcmVkIHdpdGggMw0KPj4gKwkgICBwYXJhbWV0ZXJzOg0KPj4gKwkJIC0gcGFyYW0g
MTogZGV2aWNlIGJhc2UgYWRkcmVzcyAoQ29ydGV4LU0gcHJvY2Vzc29yIGFkZHJlc3MpDQo+PiAr
CQkgLSBwYXJhbSAyOiBwaHlzaWNhbCBiYXNlIGFkZHJlc3MgKGxvY2FsIENQVSBhZGRyZXNzKQ0K
Pj4gKwkJIC0gcGFyYW0gMzogc2l6ZSBvZiB0aGUgbWVtb3J5IHJlZ2lvbi4NCj4gR2l2ZW4gdGhh
dCB0aGUgZHJpdmVyIGlzIHBhcnNpbmcgcmFuZ2VzIGl0c2VsZiwgdGhpcyBsb29rcyBsaWtlIGFi
dXNlIG9mDQo+IHJhbmdlcy4NCg0KVGhhdCdzIGNvcnJlY3QuIEFzIGV4cGxhaW5lZCBhYm92ZSwg
d2UgbmVlZCB0byBwcm92aWRlIHRoZSByZW1vdGVwcm9jIGZyYW1ld29yaw0Kd2l0aCBjYXJ2ZW91
dCBtYXBwaW5ncy4NCg0KPg0KPiBXaGF0IGV4YWN0bHkgaXMgYWRkcmVzcyAwIHN1cHBvc2VkIHRv
IGJlIGhlcmU/IElmIGl0IGlzIHRoZSBNNCdzIHZpZXcgb2YNCj4gbWVtb3J5LCB0aGVuIGRtYS1y
YW5nZXMgaXMgd2hhdCB5b3Ugd2FudCB0byB1c2UgaGVyZS4NCg0KImRtYS1yYW5nZXMiIGlzIHBy
b2JhYmx5IG1vcmUgYXBwcm9wcmlhdGVkIGhlcmUuIEJ1dCB0aGUgZHJpdmVyIHN0aWxsIG5lZWRz
IHRvDQpwYXJzZSB0aGlzIHByb3BlcnR5Lg0KDQo+DQo+DQo+PiArDQo+PiArVGhlIENvcnRleC1N
IHJlbW90ZSBwcm9jZXNzb3IgYWNjZXNzZWQgdmlhIHRoZSBtbGFoYiBpbnRlcmNvbm5lY3QgaXMg
ZGVzY3JpYmVkDQo+PiArYnkgYSBjaGlsZCBub2RlLg0KPj4gKw0KPj4gK0V4YW1wbGU6DQo+PiAr
bWxhaGI6IG1sYWhiQDAgew0KPiBOb3RlIHRoYXQgdGhlIHVuaXQtYWRkcmVzcyBpcyB3cm9uZyBo
ZXJlIGFzIGl0IHNob3VsZCBiZSAzODAwMDAwMC4NCg0KT0sNCg0KPg0KPj4gKwljb21wYXRpYmxl
ID0gInNpbXBsZS1idXMiOw0KPj4gKwkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJI3NpemUt
Y2VsbHMgPSA8MT47DQo+PiArCXJhbmdlcyA9IDwweDAwMDAwMDAwIDB4MzgwMDAwMDAgMHgxMDAw
MD4sDQo+PiArCQkgPDB4MTAwMDAwMDAgMHgxMDAwMDAwMCAweDYwMDAwPiwNCj4+ICsJCSA8MHgz
MDAwMDAwMCAweDMwMDAwMDAwIDB4NjAwMDA+Ow0KPj4gKw0KPj4gKwltNF9ycHJvYzogbTRAMCB7
DQo+PiArCQkuLi4NCj4+ICsJfTsNCj4+ICt9Ow0KPj4gLS0gDQo+PiAyLjcuNA0KPj4NCj4+
