Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F0F21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uDAN/pNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLTFAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:00:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbfLTFAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:00:11 -0500
X-UUID: 9a6e4969495e4a7b88d861aebb104cec-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WQ5D1NliONHbgSeHA/ensVa+Zzp3vnZWnc4pqGSWPUw=;
        b=uDAN/pNxhdKe9XGXXUwNa7a1NYu7DeVduCU4gxumljaMxBE82SU0MlM/hPSry2BNGuzzPKB3r+iIcsXYWE0pHd4m6woFnp7R+Tiu8gXenAJjIFzru2Yq9t7v8sh4snQj+TNCzLkYCw1JlCkR1ZGwRI2jMu1EKUKKmLVf43jsF/M=;
X-UUID: 9a6e4969495e4a7b88d861aebb104cec-20191220
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1691604696; Fri, 20 Dec 2019 13:00:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 12:59:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 12:59:24 +0800
Message-ID: <1576818001.8410.16.camel@mtksdaap41>
Subject: Re: [PATCH v11 05/10] soc: mediatek: Remove infracfg misc driver
 support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Fri, 20 Dec 2019 13:00:01 +0800
In-Reply-To: <CANMq1KBLuugcoWb1o=rUkBR7oY5Cf5rX=DCvpVP5D_6FJ8jipw@mail.gmail.com>
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
         <1576813564-23927-6-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KBLuugcoWb1o=rUkBR7oY5Cf5rX=DCvpVP5D_6FJ8jipw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTIwIGF0IDEyOjExICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDIwLCAyMDE5IGF0IDExOjQ2IEFNIFdlaXlpIEx1IDx3ZWl5aS5sdUBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gcHJldmlvdXMgcGF0Y2hlcywgd2UgaW50
cm9kdWNlIHNjcHN5cy1leHQgZHJpdmVyIHRoYXQgY292ZXJzDQo+ID4gdGhlIGZ1bmN0aW9ucyB3
aGljaCBpbmZyYWNmZyBtaXNjIGRyaXZlciBwcm92aWRlZC4NCj4gPiBBbmQgdGhlbiByZXBsYWNl
IGJ1c19wcm90X21hc2sgd2l0aCBicF90YWJsZSBvZiBhbGwgY29tcGF0aWJsZXMuDQo+ID4gTm93
LCB3ZSdyZSBnb2luZyB0byByZW1vdmUgaW5mcmFjZmcgbWlzYyBkcnZpZXIgd2hpY2ggaXMgbm8g
bG9uZ2VyDQo+ID4gYmVpbmcgdXNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlh
dGVrL0tjb25maWcgICAgICAgICAgfCAxMCAtLS0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9NYWtlZmlsZSAgICAgICAgIHwgIDMgKy0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWluZnJhY2ZnLmMgICB8IDc5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggfCAzOSAtLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMzAgZGVsZXRp
b25zKC0pDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
aW5mcmFjZmcuYw0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvaW5mcmFjZmcuaA0KPiA+IFtzbmlwXQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
aW5mcmFjZmcuaA0KPiA+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IGZkMjVm
MDEuLjAwMDAwMDANCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNm
Zy5oDQo+ID4gKysrIC9kZXYvbnVsbA0KPiA+IEBAIC0xLDM5ICswLDAgQEANCj4gPiAtLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiAtI2lmbmRlZiBfX1NPQ19NRURJ
QVRFS19JTkZSQUNGR19IDQo+ID4gLSNkZWZpbmUgX19TT0NfTUVESUFURUtfSU5GUkFDRkdfSA0K
PiA+IC0NCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX01DSV9NMiAgICAgICAg
ICBCSVQoMCkNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX01NX00wICAgICAg
ICAgICBCSVQoMSkNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX01NX00xICAg
ICAgICAgICBCSVQoMikNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX01NQVBC
X1MgICAgICAgICBCSVQoNikNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX0wy
Q19NMiAgICAgICAgICBCSVQoOSkNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VO
X0wyU1NfU01JICAgICAgICAgICAgICAgIEJJVCgxMSkNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9Q
X0FYSV9QUk9UX0VOX0wyU1NfQUREICAgICAgICAgICAgICAgIEJJVCgxMikNCj4gPiAtI2RlZmlu
ZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX0NDSV9NMiAgICAgICAgICBCSVQoMTMpDQo+ID4gLSNk
ZWZpbmUgTVQ4MTczX1RPUF9BWElfUFJPVF9FTl9NRkdfUyAgICAgICAgICAgQklUKDE0KQ0KPiA+
IC0jZGVmaW5lIE1UODE3M19UT1BfQVhJX1BST1RfRU5fUEVSSV9NMCAgICAgICAgIEJJVCgxNSkN
Cj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VOX1BFUklfTTEgICAgICAgICBCSVQo
MTYpDQo+ID4gLSNkZWZpbmUgTVQ4MTczX1RPUF9BWElfUFJPVF9FTl9ERUJVR1NZUyAgICAgICAg
ICAgICAgICBCSVQoMTcpDQo+ID4gLSNkZWZpbmUgTVQ4MTczX1RPUF9BWElfUFJPVF9FTl9DUV9E
TUEgICAgICAgICAgQklUKDE4KQ0KPiA+IC0jZGVmaW5lIE1UODE3M19UT1BfQVhJX1BST1RfRU5f
R0NQVSAgICAgICAgICAgIEJJVCgxOSkNCj4gPiAtI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9U
X0VOX0lPTU1VICAgICAgICAgICBCSVQoMjApDQo+ID4gLSNkZWZpbmUgTVQ4MTczX1RPUF9BWElf
UFJPVF9FTl9NRkdfTTAgICAgICAgICAgQklUKDIxKQ0KPiA+IC0jZGVmaW5lIE1UODE3M19UT1Bf
QVhJX1BST1RfRU5fTUZHX00xICAgICAgICAgIEJJVCgyMikNCj4gPiAtI2RlZmluZSBNVDgxNzNf
VE9QX0FYSV9QUk9UX0VOX01GR19TTk9PUF9PVVQgICBCSVQoMjMpDQo+ID4gLQ0KPiA+IC0jZGVm
aW5lIE1UMjcwMV9UT1BfQVhJX1BST1RfRU5fTU1fTTAgICAgICAgICAgIEJJVCgxKQ0KPiA+IC0j
ZGVmaW5lIE1UMjcwMV9UT1BfQVhJX1BST1RfRU5fQ09OTl9NICAgICAgICAgIEJJVCgyKQ0KPiA+
IC0jZGVmaW5lIE1UMjcwMV9UT1BfQVhJX1BST1RfRU5fQ09OTl9TICAgICAgICAgIEJJVCg4KQ0K
PiA+IC0NCj4gPiAtI2RlZmluZSBNVDc2MjJfVE9QX0FYSV9QUk9UX0VOX0VUSFNZUyAgICAgICAg
ICAoQklUKDMpIHwgQklUKDE3KSkNCj4gPiAtI2RlZmluZSBNVDc2MjJfVE9QX0FYSV9QUk9UX0VO
X0hJRjAgICAgICAgICAgICAoQklUKDI0KSB8IEJJVCgyNSkpDQo+ID4gLSNkZWZpbmUgTVQ3NjIy
X1RPUF9BWElfUFJPVF9FTl9ISUYxICAgICAgICAgICAgKEJJVCgyNikgfCBCSVQoMjcpIHwgXA0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVQo
MjgpKQ0KPiA+IC0jZGVmaW5lIE1UNzYyMl9UT1BfQVhJX1BST1RfRU5fV0IgICAgICAgICAgICAg
IChCSVQoMikgfCBCSVQoNikgfCBcDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJJVCg3KSB8IEJJVCg4KSkNCj4gDQo+IEVyciB3YWl0LCBkb24n
dCB5b3UgbmVlZCB0aGVzZSB2YWx1ZXMgaW4gcGF0Y2ggMDQvMTA/DQo+IA0KDQpBY3R1YWxseSBJ
IGFscmVhZHkgZHVwbGljYXRlZCB0aG9zZSBiZWluZyB1c2VkIGludG8gc2Nwc3lzLWV4dC5oIGFu
ZA0KdGhlbiByZXBsYWNlIHRoZSBoZWFkZXIgZmlsZSBpbiBwYXRjaCAwNC8xMA0KDQotLS0gYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1zY3BzeXMuYw0KQEAgLTExLDcgKzExLDcgQEAgDQotI2luY2x1ZGUgPGxpbnV4L3Nv
Yy9tZWRpYXRlay9pbmZyYWNmZy5oPg0KKyNpbmNsdWRlICJzY3BzeXMtZXh0LmgiDQoNCnNvIEkg
cmVtb3ZlIHRoZSBpbmZyYWNmZy5oIGRpcmVjdGx5IGluIHRoaXMgcGF0Y2ggYW5kIGFkZCB0aG9z
ZSBuZXcgZm9yDQpNVDgxODMgaW4gc2Nwc3lzLWV4dC5oDQoNCj4gPiAtDQo+ID4gLWludCBtdGtf
aW5mcmFjZmdfc2V0X2J1c19wcm90ZWN0aW9uKHN0cnVjdCByZWdtYXAgKmluZnJhY2ZnLCB1MzIg
bWFzaywNCj4gPiAtICAgICAgICAgICAgICAgYm9vbCByZWdfdXBkYXRlKTsNCj4gPiAtaW50IG10
a19pbmZyYWNmZ19jbGVhcl9idXNfcHJvdGVjdGlvbihzdHJ1Y3QgcmVnbWFwICppbmZyYWNmZywg
dTMyIG1hc2ssDQo+ID4gLSAgICAgICAgICAgICAgIGJvb2wgcmVnX3VwZGF0ZSk7DQo+ID4gLSNl
bmRpZiAvKiBfX1NPQ19NRURJQVRFS19JTkZSQUNGR19IICovDQo+ID4gLS0NCj4gPiAxLjguMS4x
LmRpcnR5DQoNCg==

