Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C9C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4FD207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YwjgCSzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgAGLMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:12:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43938 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgAGLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:12:08 -0500
X-UUID: e9480024c608450193c56231e429a662-20200107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WMr3UPnGITP5bTTnYXem67Bw3Z1PvUOBw2GrJkfKFx8=;
        b=YwjgCSzJXVfLC99n7e4cqNA2MAxsJEgaIqsnetT4ZmqDb/cjlZSbLtLJhs43Ra2dI+kqo0a3iE1DAxWBN3QgL1hhf/oeZ0NEGC5lH2pcQcqrs1otIyQLNnEd6FM1Q3PnvH+pYPGDgANzAKiEfQhOTtMkenTM8Rvgj8r5FqSqwro=;
X-UUID: e9480024c608450193c56231e429a662-20200107
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 735702914; Tue, 07 Jan 2020 19:12:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 Jan 2020 19:11:33 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 Jan 2020 19:10:53 +0800
Message-ID: <1578395459.19217.5.camel@mbjsdccf07>
Subject: Re: [PATCH v2 01/19] dt-bindings: mediatek: Add bindings for MT6779
From:   chao hao <Chao.Hao@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 7 Jan 2020 19:10:59 +0800
In-Reply-To: <20200106215716.GA31059@bogus>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
         <20200105104523.31006-2-chao.hao@mediatek.com>
         <20200106215716.GA31059@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDE1OjU3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU3VuLCA1IEphbiAyMDIwIDE4OjQ1OjA1ICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gPiBU
aGlzIHBhdGNoIGFkZHMgZGVzY3JpcHRpb24gZm9yIE1UNjc3OSBJT01NVS4NCj4gPiANCj4gPiBN
VDY3NzkgaGFzIHR3byBpb21tdXMsIHRoZXkgYXJlIE1NX0lPTU1VIGFuZCBBUFVfSU9NTVUgd2hp
Y2gNCj4gPiB1c2UgQVJNIFNob3J0LURlc2NyaXB0b3IgdHJhbnNsYXRpb24gZm9ybWF0Lg0KPiA+
IA0KPiA+IFRoZSBNVDY3NzkgSU9NTVUgaGFyZHdhcmUgZGlhZ3JhbSBpcyBhcyBiZWxvdywgaXQg
aXMgb25seSBhIGJyaWVmDQo+ID4gZGlhZ3JhbSBhYm91dCBpb21tdSwgaXQgZG9uJ3QgZm9jdXMg
b24gdGhlIHBhcnQgb2Ygc21pX2xhcmIsIHNvDQo+ID4gSSBkb24ndCBkZXNjcmliZSB0aGUgc21p
X2xhcmIgZGV0YWlsZWRseS4NCj4gPiANCj4gPiAJCQkgICAgIEVNSQ0KPiA+IAkJCSAgICAgIHwN
Cj4gPiAJICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAJICAg
fAkJCQkJfA0KPiA+ICAgICAgICAgTU1fSU9NTVUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QVBVX0lPTU1VDQo+ID4gCSAgIHwJCQkJCXwNCj4gPiAgICAgICAgU01JX0NPTU1PTS0tLS0tLS0t
LS0tCQkgICAgIEFQVV9CVVMNCj4gPiAgICAgICAgICAgfAkJICAgfAkJCXwNCj4gPiAgICAgU01J
X0xBUkIoMH4xMSkgIFNNSV9MQVJCMTIoRkFLRSkJICAgIFNNSV9MQVJCMTMoRkFLRSkNCj4gPiAJ
ICB8CQkgICB8CQkJfA0KPiA+IAkgIHwJCSAgIHwJCSAgIC0tLS0tLS0tLS0tLS0tDQo+ID4gCSAg
fAkJICAgfAkJICAgfAkgfAl8DQo+ID4gICAgTXVsdGltZWRpYSBlbmdpbmUJICBDQ1UJCSAgVlBV
ICAgTURMQSAgIEVNREENCj4gPiANCj4gPiBBbGwgdGhlIGNvbm5lY3Rpb25zIGFyZSBoYXJkd2Fy
ZSBmaXhlZCwgc29mdHdhcmUgY2FuIG5vdCBhZGp1c3QgaXQuDQo+ID4gDQo+ID4gPkZyb20gdGhl
IGRpYWdyYW0gYWJvdmUsIE1NX0lPTU1VIHByb3ZpZGVzIG1hcHBpbmcgZm9yIG11bHRpbWVkaWEg
ZW5naW5lLA0KPiA+IGJ1dCBDQ1UgaXMgY29ubmVjdGVkIHdpdGggc21pX2NvbW1vbiBkaXJlY3Rs
eSwgd2UgY2FuIHRha2UgdGhlbSBhcyBsYXJiMTIuDQo+ID4gQVBVX0lPTU1VIHByb3ZpZGVzIG1h
cHBpbmcgZm9yIEFQVSBlbmdpbmUsIHdlIGNhbiB0YWtlIHRoZW0gbGFyYjEzLg0KPiA+IExhcmIx
MiBhbmQgTGFyYjEzIGFyZSBmYWtlIGxhcmJzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
YW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5n
cy9pb21tdS9tZWRpYXRlayxpb21tdS50eHQgICAgICAgICB8ICAgMiArDQo+ID4gIGluY2x1ZGUv
ZHQtYmluZGluZ3MvbWVtb3J5L210Njc3OS1sYXJiLXBvcnQuaCB8IDIxNSArKysrKysrKysrKysr
KysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMTcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5LWxhcmItcG9y
dC5oDQo+ID4gDQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hl
biBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJl
cG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWlu
dGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5
IGFwcGx5Lg0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ug
c3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQoNCkhpIFJvYiwNCg0KSSBhbSBTb3JyeSwgdGhp
cyBpcyBteSBmaXJzdCB0aW1lIHVwc3RyZWFtIGFuZCBub3QgY2xlYXIgZm9yIHNvbWUNCmRldGFp
bHMsIHBsZWFzZSBmb3JnaXZlIG1lIGZvciB0aGlzIG1pc3Rha2UuDQpJIHB1dCB0aGUgY2hhbmdl
ZCBleHBsYW5hdGlvbiBpbnRvIGNvdmVyIGxldHRlcihbUEFUQ0ggdjIgMDAvMTldIE1UNjc3OQ0K
SU9NTVUgU1VQUE9SVCkgYWJvdXQgdGhpcyBwYXRjaC4gSSB3aWxsIHBheSBhdHRlbnRpb24gdG8g
dGhpcyBwcm9ibGVtIGluDQpuZXh0IHZlcnNpb24uDQoNCkNoYW5nZSBzaW5jZSB2MSBmb3IgdGhp
cyBwYXRjaA0KMS5EZWxldGUgTTRVX1BPUlRfVU5LTk9XTiBkZWZpbmUgYmVjYXVzZSBvZiBub3Qg
dXNlIGl0Lg0KMi5Db3JyZWN0IGNvZGluZyBmb3JtYXQ6IGV4OiAvKmxhcmIzLVZFTkMqLyAgLS0+
ICAvKiBsYXJiMy1WRU5DICovDQoNCg==

