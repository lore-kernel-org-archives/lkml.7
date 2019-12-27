Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20597208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q39g+fsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfL0Bnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:43:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10440 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0Bnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:43:50 -0500
X-UUID: c6e18140a4b74ef9bbbcb995494a1ef6-20191227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iVUBPxdAAmqV9kehzbTw6Znseih6f2Me+aVvtfsmplg=;
        b=q39g+fsc6DWoiqAOrrJp0Ah4JWGFl0RMD9oXy5KPx47+ot+Y+6OnbqpmNKSlT50LN6wbSfg5cV5tUP41DrFXJuT/5zag65PCbpicTctG/sXHGf/0S99Fo5kHQuMXs5z7NcMU+pZZUyvfbsbWqtvijjFSuB7qmJY6JWwuydhbRzE=;
X-UUID: c6e18140a4b74ef9bbbcb995494a1ef6-20191227
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2009527558; Fri, 27 Dec 2019 09:43:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Dec 2019 09:42:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Dec 2019 09:42:28 +0800
Message-ID: <1577411015.12599.0.camel@mtksdaap41>
Subject: Re: [PATCH v11 00/10] Mediatek MT8183 scpsys support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 27 Dec 2019 09:43:35 +0800
In-Reply-To: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 414ECEE29448B676CBD7514817D06CBDD641650F67A9872F26187195874D08222000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMTItMjAgYXQgMTE6NDUgKzA4MDAsIFdlaXlpIEx1IHdyb3RlOg0KDQpI
aSBNYXR0aGlhcywNCkp1c3QgZ2VudGxlIHBpbmcuIE1hbnkgdGhhbmtzLg0KDQoNCj4gVGhpcyBz
ZXJpZXMgaXMgYmFzZWQgb24gdjUuNS1yYzENCj4gDQo+IGNoYW5nZXMgc2luY2UgdjEwOg0KPiAt
IHNxdWFzaCBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlvdXMgcGF0
Y2gNCj4gLSBhZGQgImlnbm9yZV9jbHJfYWNrIiBmb3IgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVj
dGlvbiBjb250cm9sIHRvIGhhdmUgYSBjbGVhbiBkZWZpbml0aW9uIG9mIHBvd2VyIGRvbWFpbiBk
YXRhDQo+IC0ga2VlcCB0aGUgbWFzayByZWdpc3RlciBiaXQgZGVmaW5pdGlvbnMgYW5kIGRvIHRo
ZSBzYW1lIGZvciBNVDgxODMNCj4gDQo+IGNoYW5nZXMgc2luY2Ugdjk6DQo+IC0gYWRkIG5ldyBQ
QVRDSCAwNCBhbmQgUEFUQ0ggMDYgdG8gcmVwbGFjZSBieSBuZXcgbWV0aG9kIGZvciBhbGwgY29t
cGF0aWJsZXMNCj4gLSBhZGQgbmV3IFBBVENIIDA3IHRvIHJlbW92ZSBpbmZyYWNmZyBtaXNjIGRy
aXZlcg0KPiAtIG1pbm9yIGNvZGluZyBzeXRsZSBmaXgNCj4gDQo+IGNoYW5nZXMgc2luY2Ugdjc6
DQo+IC0gcmV3b3JkIGluIGJpbmRpbmcgZG9jdW1lbnQgW1BBVENIIDAyLzE0XQ0KPiAtIGZpeCBl
cnJvciByZXR1cm4gY2hlY2tpbmcgYnVnIGluIHN1YnN5cyBjbG9jayBjb250cm9sIFtQQVRDSCAx
MC8xNF0NCj4gLSBhZGQgcG93ZXIgZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnIHBhdGNoIFtQ
QVRDSCAxNC8xNF0gZnJvbQ0KPiAgIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTExMjYxOTkvDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY2Og0KPiAtIHJlbW92ZSB0aGUgcGF0Y2gg
b2YgU1BEWCBsaWNlbnNlIGlkZW50aWZpZXIgYmVjYXVzZSBpdCdzIGFscmVhZHkgZml4ZWQNCj4g
DQo+IGNoYW5nZXMgc2luY2UgdjU6DQo+IC0gZml4IGRvY3VtZW50YXRpb24gaW4gW1BBVENIIDA0
LzE0XQ0KPiAtIHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlIGNoZWNraW5nIGFuZCByZXVzZSBBUEkg
b2YgY2xvY2sgY29udHJvbCBpbiBbUEFUQ0ggMDYvMTRdDQo+IC0gY29kaW5nIHN0eWxlIGZpeCBv
ZiBidXMgcHJvdGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAwOC8xNF0NCj4gLSBmaXggbmFtaW5n
IG9mIG5ldyBhZGRlZCBkYXRhIGluIFtQQVRDSCAwOS8xNF0NCj4gLSBzbWFsbCByZWZhY3RvciBv
ZiBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgaW4gW1BBVENIIDEwLzE0XQ0K
PiANCj4gY2hhbmdlcyBzaW5jZSB2NDoNCj4gLSBhZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNtaS1j
b21tb24NCj4gLSBzZXBlcmF0ZSByZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRkIGZ1bmN0aW9u
DQo+IC0gYWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUNCj4gDQo+IFdlaXlpIEx1ICgx
MCk6DQo+ICAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNt
aS1jb21tb24NCj4gICBkdC1iaW5kaW5nczogc29jOiBBZGQgTVQ4MTgzIHBvd2VyIGR0LWJpbmRp
bmdzDQo+ICAgc29jOiBtZWRpYXRlazogQWRkIGJhc2ljX2Nsa19uYW1lIHRvIHNjcF9wb3dlcl9k
YXRhDQo+ICAgc29jOiBtZWRpYXRlazogQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24g
Y29udHJvbA0KPiAgIHNvYzogbWVkaWF0ZWs6IFJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlciBz
dXBwb3J0DQo+ICAgc29jOiBtZWRpYXRlazogQWRkIHN1YnN5cyBjbG9jayBjb250cm9sIGZvciBi
dXMgcHJvdGVjdGlvbg0KPiAgIHNvYzogbWVkaWF0ZWs6IEFkZCBleHRyYSBzcmFtIGNvbnRyb2wN
Cj4gICBzb2M6IG1lZGlhdGVrOiBBZGQgTVQ4MTgzIHNjcHN5cyBzdXBwb3J0DQo+ICAgYXJtNjQ6
IGR0czogQWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUgb2YgTVQ4MTgzDQo+ICAgYXJt
NjQ6IGR0czogQWRkIHBvd2VyLWRvbWFpbnMgcHJvcGVyaXR5IHRvIG1mZ2NmZw0KPiANCj4gIC4u
Li9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgIHwgICAyICst
DQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICB8
ICAyMCArLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAg
ICAgICAgfCAgNjMgKysrDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMCAtDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWluZnJhY2ZnLmMgICAgICAgICAgICAgICAgfCAgNzkgLS0tDQo+ICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstc2Nwc3lzLWV4dC5jICAgICAgICAgICAgICB8IDEwMSArKysrDQo+ICBkcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgICAgICAgICAgICAgICAgICB8IDU3OCArKysrKysr
KysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL3NjcHN5cy1leHQuaCAgICAg
ICAgICAgICAgICAgIHwgIDk1ICsrKysNCj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4
MTgzLXBvd2VyLmggICAgICAgICAgIHwgIDI2ICsNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL2luZnJhY2ZnLmggICAgICAgICAgICAgIHwgIDM5IC0tDQo+ICAxMSBmaWxlcyBjaGFuZ2Vk
LCA3MzYgaW5zZXJ0aW9ucygrKSwgMjgwIGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1pbmZyYWNmZy5jDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy1leHQuYw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL3NjcHN5cy1leHQuaA0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgNCj4gIGRl
bGV0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo+
IA0KDQoNCg==

