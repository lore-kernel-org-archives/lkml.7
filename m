Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE2C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F22084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="d5hQVDNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfFNHjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:39:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61904 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfFNHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:39:45 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E7asaD020061;
        Fri, 14 Jun 2019 09:39:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=WnBJiL3yLXib/3hyU89WJ3ADaCZVb5cHV2S7IUcVmG8=;
 b=d5hQVDNSjEe3/rSaKwOUDiXx1sfXNGQJMBOrTR7+nNma3iYoaulYBv02GV2z7dXa21++
 8YQ8vK9HbOhfIcSDBeLESRTlC/w4XSzsYSpwG34Q83l8jOYiXCQxoIQFpesSXIrAz24H
 BnDFxqg/UEfaaK9avM3Nue63kiRa3XhqGiPToCvxwGdHGByk3tEJQFr+oBQoXiwHbijD
 Vibc+Ycpx618ZEkwSWO0vRdfd8eQLeY+5sy1+sMA9SIk1I2t3pMvTTdvQmkip+CU+NBN
 bJckRzlTtFQlpvoJCb7+FkHLds7hG4VhYLO8pDAtzM4/2OYcYgtCZ52M/Yaic4Usqjym Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t2f8c8ear-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Jun 2019 09:39:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B07D3A;
        Fri, 14 Jun 2019 07:39:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AAFF1807;
        Fri, 14 Jun 2019 07:39:25 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Jun
 2019 09:39:24 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 14 Jun 2019 09:39:24 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
CC:     Wei Xu <xuwei5@hisilicon.com>, Daniel Mack <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] ARM: dts: STi: Switch to SPDX header
Thread-Topic: [PATCH 1/6] ARM: dts: STi: Switch to SPDX header
Thread-Index: AQHVICdybxhZw6uCRkCvwJXJ6Jt2RKaapruA
Date:   Fri, 14 Jun 2019 07:39:24 +0000
Message-ID: <95148f1a-c48b-95a3-77ab-4420f7cf7de2@st.com>
References: <20190611072921.2979446-1-lkundrak@v3.sk>
 <20190611072921.2979446-2-lkundrak@v3.sk>
In-Reply-To: <20190611072921.2979446-2-lkundrak@v3.sk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F57771CFAF48BE4AB6A55DC764223446@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVib21pcg0KDQpPbiA2LzExLzE5IDk6MjkgQU0sIEx1Ym9taXIgUmludGVsIHdyb3RlOg0K
PiBUaGUgb3JpZ2luYWwgbGljZW5zZSB0ZXh0IGhhZCBhIHR5cG8gKCJwdWJsaXNoaGVkIikgd2hp
Y2ggd291bGQgYmUNCj4gbGlrZWx5IHRvIGNvbmZ1c2UgYXV0b21hdGVkIGxpY2Vuc2luZyBhdWRp
dGluZyB0b29scy4gTGV0J3MganVzdCBzd2l0Y2gNCj4gdG8gU1BEWCBpbnN0ZWFkIG9mIGZpeGlu
ZyB0aGUgd29yZGluZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTHVib21pciBSaW50ZWwgPGxrdW5k
cmFrQHYzLnNrPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0
c2kgIHwgNSArLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1waW5jdHJsLmR0c2kg
fCA1ICstLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9zdGloNDA3LmR0c2kgICAgICAgICB8IDUg
Ky0tLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtcGluY3RybC5kdHNpIHwgNSArLS0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC5kdHNpICAgICAgICAgfCA1ICstLS0tDQo+
ICBhcmNoL2FybS9ib290L2R0cy9zdGloNDE4LmR0c2kgICAgICAgICB8IDUgKy0tLS0NCj4gIDYg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpDQo+IGluZGV4IDllMjlhNDQ5OTkzOC4uMmZm
MjU0MmJmMzM1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWZhbWls
eS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kNCj4g
QEAgLTEsMTAgKzEsNyBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gIC8qDQo+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTQgU1RNaWNyb2VsZWN0cm9uaWNzIExpbWl0
ZWQuDQo+ICAgKiBBdXRob3I6IEdpdXNlcHBlIENhdmFsbGFybyA8cGVwcGUuY2F2YWxsYXJvQHN0
LmNvbT4NCj4gLSAqDQo+IC0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPiAtICogaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCj4gLSAqIHB1
Ymxpc2hoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4NCj4gICAqLw0KPiAgI2lu
Y2x1ZGUgInN0aWg0MDctcGluY3RybC5kdHNpIg0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21m
ZC9zdC1scGMuaD4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctcGlu
Y3RybC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1waW5jdHJsLmR0c2kNCj4gaW5k
ZXggZTM5MzUxOWZiODRjLi5kYjE3NDAxOTYyNmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL3N0aWg0MDctcGluY3RybC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0
aWg0MDctcGluY3RybC5kdHNpDQo+IEBAIC0xLDEwICsxLDcgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IChDKSAyMDE0IFNU
TWljcm9lbGVjdHJvbmljcyBMaW1pdGVkLg0KPiAgICogQXV0aG9yOiBHaXVzZXBwZSBDYXZhbGxh
cm8gPHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+DQo+IC0gKg0KPiAtICogVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4g
LSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
dmVyc2lvbiAyIGFzDQo+IC0gKiBwdWJsaXNoaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb24uDQo+ICAgKi8NCj4gICNpbmNsdWRlICJzdC1waW5jZmcuaCINCj4gICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zdGlo
NDA3LmR0c2kNCj4gaW5kZXggNWI3OTUxZmZjMzUwLi4yNDJhYzcyZTRkNGEgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDcuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9zdGloNDA3LmR0c2kNCj4gQEAgLTEsMTAgKzEsNyBAQA0KPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gIC8qDQo+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTUgU1RN
aWNyb2VsZWN0cm9uaWNzIExpbWl0ZWQuDQo+ICAgKiBBdXRob3I6IEdhYnJpZWwgRmVybmFuZGV6
IDxnYWJyaWVsLmZlcm5hbmRlekBsaW5hcm8ub3JnPg0KPiAtICoNCj4gLSAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
DQo+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIHZlcnNpb24gMiBhcw0KPiAtICogcHVibGlzaGhlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLg0KPiAgICovDQo+ICAjaW5jbHVkZSAic3RpaDQwNy1jbG9jay5kdHNpIg0KPiAg
I2luY2x1ZGUgInN0aWg0MDctZmFtaWx5LmR0c2kiDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9zdGloNDEwLXBpbmN0cmwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAt
cGluY3RybC5kdHNpDQo+IGluZGV4IDVhZTFmZDY2YzBiOC4uODUzMmFlM2Y2MWU4IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLXBpbmN0cmwuZHRzaQ0KPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9zdGloNDEwLXBpbmN0cmwuZHRzaQ0KPiBAQCAtMSwxMCArMSw3IEBA
DQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAgLyoNCj4gICAqIENv
cHlyaWdodCAoQykgMjAxNCBTVE1pY3JvZWxlY3Ryb25pY3MgTGltaXRlZC4NCj4gICAqIEF1dGhv
cjogUGV0ZXIgR3JpZmZpbiA8cGV0ZXIuZ3JpZmZpbkBsaW5hcm8ub3JnPg0KPiAtICoNCj4gLSAq
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KPiAtICogcHVibGlzaGhlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KPiAgICovDQo+ICAjaW5jbHVkZSAic3QtcGluY2ZnLmgi
DQo+ICAvIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAuZHRzaSBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAuZHRzaQ0KPiBpbmRleCA4ODg1NDhlYTliNWMuLjIz
YjQ5NGExM2M0NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC5kdHNp
DQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAuZHRzaQ0KPiBAQCAtMSwxMCArMSw3
IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAgLyoNCj4gICAq
IENvcHlyaWdodCAoQykgMjAxNCBTVE1pY3JvZWxlY3Ryb25pY3MgTGltaXRlZC4NCj4gICAqIEF1
dGhvcjogUGV0ZXIgR3JpZmZpbiA8cGV0ZXIuZ3JpZmZpbkBsaW5hcm8ub3JnPg0KPiAtICoNCj4g
LSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KPiAtICogcHVibGlzaGhlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KPiAgICovDQo+ICAjaW5jbHVkZSAic3RpaDQxMC1j
bG9jay5kdHNpIg0KPiAgI2luY2x1ZGUgInN0aWg0MDctZmFtaWx5LmR0c2kiDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDE4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9z
dGloNDE4LmR0c2kNCj4gaW5kZXggMGVmYjNjZDZhODZlLi5mM2YwYTBlMGYyM2MgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTguZHRzaQ0KPiArKysgYi9hcmNoL2FybS9i
b290L2R0cy9zdGloNDE4LmR0c2kNCj4gQEAgLTEsMTAgKzEsNyBAQA0KPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gIC8qDQo+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTQg
U1RNaWNyb2VsZWN0cm9uaWNzIExpbWl0ZWQuDQo+ICAgKiBBdXRob3I6IFBldGVyIEdyaWZmaW4g
PHBldGVyLmdyaWZmaW5AbGluYXJvLm9yZz4NCj4gLSAqDQo+IC0gKiBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPiAt
ICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2
ZXJzaW9uIDIgYXMNCj4gLSAqIHB1Ymxpc2hoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4NCj4gICAqLw0KPiAgI2luY2x1ZGUgInN0aWg0MTgtY2xvY2suZHRzaSINCj4gICNpbmNs
dWRlICJzdGloNDA3LWZhbWlseS5kdHNpIg0KDQpBY2tlZC1ieTogUGF0cmljZSBDaG90YXJkIDxw
YXRyaWNlLmNob3RhcmRAc3QuY29tPg0KDQpUaGFua3MNCg==
