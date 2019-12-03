Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BCC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F12D2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FgzhNmvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCI0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:26:04 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51070 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfLCI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:26:04 -0500
X-UUID: 0eacfa51b8664429b9008ecda088dff9-20191203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Q2EnrRAMwmQvs3z2Y9NW1LlhZHGyGeQTCplIkYb1FCo=;
        b=FgzhNmvWLLUteopNz/qfaJxCw2Tdnt4zKRMCeAhIUKFGHHoaWvo8+BZ8Q+dsOvNIw8lwpaUGhzCfnXKaa4b3hndvj+ZiwmwqAQfR8R4fIQzDVsH2pmR3rxM/pOc7GPy0ppf5MzVZF31aGATlMvsPagek2xc7axZOCAiXtUjekCs=;
X-UUID: 0eacfa51b8664429b9008ecda088dff9-20191203
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1439469269; Tue, 03 Dec 2019 16:25:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Dec 2019 16:25:42 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Dec 2019 16:25:25 +0800
Message-ID: <1575361546.17950.1.camel@mtksdaap41>
Subject: Re: [PATCH v1, 1/2] drm/mediatek: Fixup external display black
 screen issue
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 3 Dec 2019 16:25:46 +0800
In-Reply-To: <1575359027.10160.2.camel@mhfsdcap03>
References: <1574817475-22378-1-git-send-email-yongqiang.niu@mediatek.com>
         <1574817475-22378-2-git-send-email-yongqiang.niu@mediatek.com>
         <1575352101.2457.8.camel@mtksdaap41> <1575359027.10160.2.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5C730EAB590D19C2DF8D014B791E170B5ADEEEA52FF9340D2E16167DCF71586A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDE5LTEyLTAzIGF0IDE1OjQzICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBPbiBUdWUsIDIwMTktMTItMDMgYXQgMTM6NDggKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDE5LTEx
LTI3IGF0IDA5OjE3ICswODAwLCB5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbSB3cm90ZToNCj4g
PiA+IEZyb206IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gDQo+ID4gPiBQcm9ibGVtOg0KPiA+ID4gb3ZlcmxheSBoYW5ndXAgd2hlbiBleHRlcm5hbCBk
aXNwbGF5IGhvdHBsdXQgdGVzdA0KPiA+ID4gDQo+ID4gPiBGaXg6DQo+ID4gPiBkaXNhYmxlIG92
ZXJsYXkgd2hlbiBjcnRjIGRpc2FibGUNCj4gPiANCj4gPiBJIHRoaW5rIHlvdSBkbyB0d28gdGhp
bmdzIGluIHRoaXMgcGF0Y2guIFRoZSBmaXJzdCBpcyB0byBjb25maWcgbGF5ZXINCj4gPiBiZWZv
cmUgY29tcG9uZW50IHN0YXJ0LCBhbmQgdGhlIHNlY29uZCBpcyBkaXNhYmxlIGxheWVyIHdoZW4g
Y3J0Yw0KPiA+IGRpc2FibGUuIFNvIHNlcGFyYXRlIHRvIHR3byBwYXRjaGVzLg0KPiA+IA0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1l
ZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4g
aW5kZXggNGZiMzQ2Yy4uN2VjYTAyZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gPiBAQCAtMzY5LDYgKzM2OSwyMCBAQCBzdGF0aWMg
aW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0K
PiA+ID4gIAltdGtfZGlzcF9tdXRleF9hZGRfY29tcChtdGtfY3J0Yy0+bXV0ZXgsIG10a19jcnRj
LT5kZHBfY29tcFtpXS0+aWQpOw0KPiA+ID4gIAltdGtfZGlzcF9tdXRleF9lbmFibGUobXRrX2Ny
dGMtPm11dGV4KTsNCj4gPiA+ICANCj4gPiA+ICsJLyogSW5pdGlhbGx5IGNvbmZpZ3VyZSBhbGwg
cGxhbmVzICovDQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJfbnI7IGkr
Kykgew0KPiA+ID4gKwkJc3RydWN0IGRybV9wbGFuZSAqcGxhbmUgPSAmbXRrX2NydGMtPnBsYW5l
c1tpXTsNCj4gPiA+ICsJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlOw0KPiA+
ID4gKwkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcDsNCj4gPiA+ICsJCXVuc2lnbmVkIGludCBs
b2NhbF9sYXllcjsNCj4gPiA+ICsNCj4gPiA+ICsJCXBsYW5lX3N0YXRlID0gdG9fbXRrX3BsYW5l
X3N0YXRlKHBsYW5lLT5zdGF0ZSk7DQo+ID4gPiArCQljb21wID0gbXRrX2RybV9kZHBfY29tcF9m
b3JfcGxhbmUoY3J0YywgcGxhbmUsICZsb2NhbF9sYXllcik7DQo+ID4gPiArCQlpZiAoY29tcCkN
Cj4gPiA+ICsJCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAsIGxvY2FsX2xheWVyLA0K
PiA+ID4gKwkJCQkJCSAgcGxhbmVfc3RhdGUsIE5VTEwpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+
ID4gPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0KPiA+
ID4gIAkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRjLT5kZHBfY29tcFtpXTsN
Cj4gPiA+ICAJCWVudW0gbXRrX2RkcF9jb21wX2lkIHByZXY7DQo+ID4gPiBAQCAtMzg1LDIwICsz
OTksNiBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJtX2Ny
dGMgKm10a19jcnRjKQ0KPiA+ID4gIAkJbXRrX2RkcF9jb21wX3N0YXJ0KGNvbXApOw0KPiA+ID4g
IAl9DQo+ID4gPiAgDQo+ID4gPiAtCS8qIEluaXRpYWxseSBjb25maWd1cmUgYWxsIHBsYW5lcyAq
Lw0KPiA+ID4gLQlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspIHsNCj4g
PiA+IC0JCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lID0gJm10a19jcnRjLT5wbGFuZXNbaV07DQo+
ID4gPiAtCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpwbGFuZV9zdGF0ZTsNCj4gPiA+IC0JCXN0
cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXA7DQo+ID4gPiAtCQl1bnNpZ25lZCBpbnQgbG9jYWxfbGF5
ZXI7DQo+ID4gPiAtDQo+ID4gPiAtCQlwbGFuZV9zdGF0ZSA9IHRvX210a19wbGFuZV9zdGF0ZShw
bGFuZS0+c3RhdGUpOw0KPiA+ID4gLQkJY29tcCA9IG10a19kcm1fZGRwX2NvbXBfZm9yX3BsYW5l
KGNydGMsIHBsYW5lLCAmbG9jYWxfbGF5ZXIpOw0KPiA+ID4gLQkJaWYgKGNvbXApDQo+ID4gPiAt
CQkJbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhjb21wLCBsb2NhbF9sYXllciwNCj4gPiA+IC0J
CQkJCQkgIHBsYW5lX3N0YXRlLCBOVUxMKTsNCj4gPiA+IC0JfQ0KPiA+ID4gLQ0KPiA+ID4gIAly
ZXR1cm4gMDsNCj4gPiA+ICANCj4gPiA+ICBlcnJfbXV0ZXhfdW5wcmVwYXJlOg0KPiA+ID4gQEAg
LTYwNywxMCArNjA3LDIxIEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZGlzYWJs
ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ID4gPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0
Yy0+bGF5ZXJfbnI7IGkrKykgew0KPiA+ID4gIAkJc3RydWN0IGRybV9wbGFuZSAqcGxhbmUgPSAm
bXRrX2NydGMtPnBsYW5lc1tpXTsNCj4gPiA+ICAJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBs
YW5lX3N0YXRlOw0KPiA+ID4gKwkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRj
LT5kZHBfY29tcFswXTsNCj4gPiA+ICsJCXVuc2lnbmVkIGludCBjb21wX2xheWVyX25yID0gbXRr
X2RkcF9jb21wX2xheWVyX25yKGNvbXApOw0KPiA+ID4gKwkJdW5zaWduZWQgaW50IGxvY2FsX2xh
eWVyOw0KPiA+ID4gIA0KPiA+ID4gIAkJcGxhbmVfc3RhdGUgPSB0b19tdGtfcGxhbmVfc3RhdGUo
cGxhbmUtPnN0YXRlKTsNCj4gPiA+ICAJCXBsYW5lX3N0YXRlLT5wZW5kaW5nLmVuYWJsZSA9IGZh
bHNlOw0KPiA+ID4gIAkJcGxhbmVfc3RhdGUtPnBlbmRpbmcuY29uZmlnID0gdHJ1ZTsNCj4gPiA+
ICsNCj4gPiA+ICsJCWlmIChpID49IGNvbXBfbGF5ZXJfbnIpIHsNCj4gPiA+ICsJCQljb21wID0g
bXRrX2NydGMtPmRkcF9jb21wWzFdOw0KPiA+ID4gKwkJCWxvY2FsX2xheWVyID0gaSAtIGNvbXBf
bGF5ZXJfbnI7DQo+ID4gPiArCQl9IGVsc2UNCj4gPiA+ICsJCQlsb2NhbF9sYXllciA9IGk7DQo+
ID4gPiArCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAsIGxvY2FsX2xheWVyLA0KPiA+
ID4gKwkJCQkJICBwbGFuZV9zdGF0ZSwgTlVMTCk7DQo+ID4gDQo+ID4gSSdtIGNvbmZ1c2VkIHdp
dGggdGhpcyBwYXJ0LiBUaGUgZGVzaWduIG9mIHRoaXMgbG9vcCBpcyB0byBzZXQNCj4gPiBwbGFu
ZV9zdGF0ZS0+cGVuZGluZy5lbmFibGUgPSBmYWxzZSBhbmQgd2FpdCBmb3IgaXJxIGhhbmRsZXIg
dG8gd3JpdGUNCj4gPiByZWdpc3Rlci4gV2h5IGRvIHlvdSBkaXJlY3RseSB3cml0ZSByZWdpc3Rl
cj8NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+IA0KPiB3aGVuIGNtZHEgZW5hYmxlLCBt
dGtfY3J0Yy0+Y21kcV9jbGllbnQgd2lsbCBiZSBhbHdheXMgdHJ1ZSB3aGVuIGNydGMNCj4gY3Jl
YXRlLCB0aGVyZSBpcyBubyBjaGFuY2UgZm9yIG10a19jcnRjX2RkcF9jb25maWcgcHJvY2VzcyBp
biBkZHAgaXJxIA0KPiBjYWxsYmFjayBmdW5jdGlvbg0KDQpJIHRoaW5rIHRoaXMgaXMgYSBidWcg
b2YgcGF0Y2ggWzFdIHdoaWNoIGhhcyBub3QgYmVlbiB1cHN0cmVhbSB5ZXQuIFNvDQp0aGlzIHBh
cnQgc2hvdWxkIGJlIG1vdmVkIHRvIHRoYXQgcGF0Y2guDQoNClsxXSBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzExMjcwNjM3Lw0KDQo+ID4gDQo+ID4gPiAgCX0NCj4gPiA+ICAJ
bXRrX2NydGMtPnBlbmRpbmdfcGxhbmVzID0gdHJ1ZTsNCj4gPiA+ICANCj4gPiANCj4gPiANCj4g
DQo+IA0KDQo=

