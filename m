Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A30C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E74624659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="je2GzQ3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLFECz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:02:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:25935 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfLFECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:02:54 -0500
X-UUID: 8487336daf2a4aed89f6773565c8ce34-20191206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xM1L7Jfwq/gv/BGLE5pId5BVEEmzAIvJRnTMFQtcXVo=;
        b=je2GzQ3w3wIwOGnb46+d1zPcyyvWnRWZMqZfYDE8fPemc+HUV6fCuras15LohSMUMJncbRVFqO7f28eTDB2OLKvZabOlwoT2Rh0mvtOEqPn/fwwIOfBSpRsgkaG8nk88xB4jr2DyGptKNOxZuHFYexnGYp757QUS91gCIlYQFzI=;
X-UUID: 8487336daf2a4aed89f6773565c8ce34-20191206
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1295145907; Fri, 06 Dec 2019 12:02:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Dec 2019 12:02:33 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Dec 2019 12:02:32 +0800
Message-ID: <1575604966.6151.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 06/14] soc: mediatek: cmdq: return send msg error code
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 6 Dec 2019 12:02:46 +0800
In-Reply-To: <1574819937-6246-8-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-8-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6
DQo+IFJldHVybiBlcnJvciBjb2RlIHRvIGNsaWVudCBpZiBzZW5kIG1lc3NhZ2UgZmFpbCwNCj4g
c28gdGhhdCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGluZy4NCj4gDQpUaGlzIHBh
dGNoZXMgc2VlbXMgbGlrZSBhIGZpeCBwYXRjaC4NClBsZWFzZSBhZGQgZml4ZXMsIHRoYW5rcy4N
Cg0KQmliYnkNCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNp
ZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMN
Cj4gaW5kZXggMjc0ZjZmMzExZDA1Li44NDIxYjQwOTAzMDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0zNTMsMTEgKzM1MywxMSBAQCBpbnQgY21k
cV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGNtZHFfYXN5bmNfZmx1c2hf
Y2IgY2IsDQo+ICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVudC0+bG9jaywgZmxhZ3Mp
Ow0KPiAgCX0NCj4gIA0KPiAtCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsN
Cj4gKwllcnIgPSBtYm94X3NlbmRfbWVzc2FnZShjbGllbnQtPmNoYW4sIHBrdCk7DQo+ICAJLyog
V2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQgaW1tZWRpYXRlbHksIHNvIGp1c3QgY2FsbCB0eGRvbmUu
ICovDQo+ICAJbWJveF9jbGllbnRfdHhkb25lKGNsaWVudC0+Y2hhbiwgMCk7DQo+ICANCj4gLQly
ZXR1cm4gMDsNCj4gKwlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF9mbHVzaF9hc3luYyk7DQo+ICANCg0K

