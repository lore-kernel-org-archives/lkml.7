Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66FBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D353E206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfDZCZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:25:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:12843 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDZCZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:25:03 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Apr 2019 11:25:01 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6A4A5180B6F;
        Fri, 26 Apr 2019 11:25:01 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Fri, 26 Apr 2019 11:25:01 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Fri, 26 Apr 2019 11:25:01 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Fri, 26 Apr 2019 11:25:00 +0900
From:   <yamada.masahiro@socionext.com>
To:     <airlied@gmail.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <sam@ravnborg.org>, <David1.Zhou@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <james.qian.wang@arm.com>,
        <bskeggs@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <christian.koenig@amd.com>,
        <alexander.deucher@amd.com>, <freedreno@lists.freedesktop.org>
Subject: RE: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
 $(srctree)/
Thread-Topic: [Intel-gfx] [PATCH v2] drm: prefix header search paths with
 $(srctree)/
Thread-Index: AQHU5iNkiUzKiT+mAU6E3XIaV/Lv/KZNPe2AgAALpgCAAJguoA==
Date:   Fri, 26 Apr 2019 02:25:00 +0000
Message-ID: <8d04d30e86a54b3e9b27b30ac0ab3822@SOC-EX01V.e01.socionext.com>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
 <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com>
In-Reply-To: <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY190117
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2ZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEFp
cmxpZSBbbWFpbHRvOmFpcmxpZWRAZ21haWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDI2
LCAyMDE5IDExOjE5IEFNDQo+IFRvOiBZYW1hZGEsIE1hc2FoaXJvL+WxseeUsCDnnJ/lvJggPHlh
bWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPg0KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPjsNCj4gZHJpLWRldmVs
IDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgbm91dmVhdQ0KPiA8bm91dmVhdUBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+OyBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+OyBE
YXZpZA0KPiAoQ2h1bk1pbmcpIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+OyBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdA0KPiA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBKYW1lcyAoUWlh
bikgV2FuZw0KPiA8amFtZXMucWlhbi53YW5nQGFybS5jb20+OyBCZW4gU2tlZ2dzIDxic2tlZ2dz
QHJlZGhhdC5jb20+Ow0KPiBsaW51eC1hcm0tbXNtIDxsaW51eC1hcm0tbXNtQHZnZXIua2VybmVs
Lm9yZz47IEludGVsIEdyYXBoaWNzDQo+IERldmVsb3BtZW50IDxpbnRlbC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPjsNCj4gaW50ZWwtZ3Z0LWRldkBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExp
bnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBDaHJpc3RpYW4gS8O2bmlnDQo+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+OyBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ow0KPiBmcmVlZHJlbm9AbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtZ2Z4XSBbUEFUQ0ggdjJdIGRybTog
cHJlZml4IGhlYWRlciBzZWFyY2ggcGF0aHMgd2l0aA0KPiAkKHNyY3RyZWUpLw0KPiANCj4gT24g
RnJpLCAyNiBBcHIgMjAxOSBhdCAxMTo0NiwgTWFzYWhpcm8gWWFtYWRhDQo+IDx5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaS4NCj4gPg0KPiA+DQo+ID4g
T24gRnJpLCBNYXIgMjksIDIwMTkgYXQgODozNyBQTSBNYXNhaGlybyBZYW1hZGENCj4gPiA8eWFt
YWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEN1cnJlbnRs
eSwgdGhlIEtidWlsZCBjb3JlIG1hbmlwdWxhdGVzIGhlYWRlciBzZWFyY2ggcGF0aHMgaW4gYSBj
cmF6eQ0KPiA+ID4gd2F5IFsxXS4NCj4gPiA+DQo+ID4gPiBUbyBmaXggdGhpcyBtZXNzLCBJIHdh
bnQgYWxsIE1ha2VmaWxlcyB0byBhZGQgZXhwbGljaXQgJChzcmN0cmVlKS8gdG8NCj4gPiA+IHRo
ZSBzZWFyY2ggcGF0aHMgaW4gdGhlIHNyY3RyZWUuIFNvbWUgTWFrZWZpbGVzIGFyZSBhbHJlYWR5
IHdyaXR0ZW4NCj4gaW4NCj4gPiA+IHRoYXQgd2F5LCBidXQgbm90IGFsbC4gVGhlIGdvYWwgb2Yg
dGhpcyB3b3JrIGlzIHRvIG1ha2UgdGhlIG5vdGF0aW9uDQo+ID4gPiBjb25zaXN0ZW50LCBhbmQg
ZmluYWxseSBnZXQgcmlkIG9mIHRoZSBncm9zcyBoYWNrcy4NCj4gPiA+DQo+ID4gPiBIYXZpbmcg
d2hpdGVzcGFjZXMgYWZ0ZXIgLUkgZG9lcyBub3QgbWF0dGVyIHNpbmNlIGNvbW1pdCA0OGY2ZTNj
ZjViYzYNCj4gPiA+ICgia2J1aWxkOiBkbyBub3QgZHJvcCAtSSB3aXRob3V0IHBhcmFtZXRlciIp
Lg0KPiA+ID4NCj4gPiA+IFsxXTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85
NjMyMzQ3Lw0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8eWFt
YWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogU2FtIFJhdm5i
b3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gSSBwdXQgYWxs
IGdwdS9kcm0gY2hhbmdlcyBpbnRvIGEgc2luZ2xlIHBhdGNoIGJlY2F1c2UNCj4gPiA+IHRoZXkg
YXJlIHRyaXZpYWwgY29udmVyc2lvbi4NCj4gPiA+DQo+ID4gPiBJZiB5b3UgYXJlIGludGVyZXN0
ZWQgaW4gdGhlIGJpZyBwaWN0dXJlIG9mIHRoaXMgd29yaywNCj4gPiA+IHRoZSBmdWxsIHBhdGNo
IHNldCBpcyBhdmFpbGFibGUgYXQgdGhlIGZvbGxvd2luZyBVUkwuDQo+ID4gPg0KPiA+ID4NCj4g
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21hc2FoaXJveS9s
aW51eC1rYnVpbGQuZw0KPiBpdCBidWlsZC10ZXN0DQo+ID4NCj4gPg0KPiA+IElzIHNvbWVib2R5
IHRha2luZyBjYXJlIG9mIHRoaXM/DQo+ID4NCj4gDQo+IEFyZSB5b3UgZXhwZWN0aW5nIHRoaXMg
dG8gYmUgbWVyZ2VkIGluIHRoZSBkcm0gdHJlZT8gaWYgc28gcGxlYXNlDQo+IGluZGljYXRlIHRo
YXQgd2hlbiBwb3N0aW5nLg0KDQoNClNvcnJ5IGZvciB1bmNsZWFybmVzcy4NCg0KQ291bGQgeW91
IGFwcGx5IHRoaXMgdG8geW91ciBkcm0gdHJlZT8NCg0KVGhhbmtzLg0KDQoNCg0KDQo+IEknZCBh
c3N1bWVkIHRoaXMgd291bGQgZ28gdmlhIGtidWlsZCB0cmVlLg0KPiANCj4gSWYgdGhlIGxhdGVy
LA0KPiBBY2tlZC1ieTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4NCj4gRGF2ZS4N
Cg==
