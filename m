Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1FC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37487214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ccNhwmDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMHt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:49:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49823 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbfLMHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:49:57 -0500
X-UUID: 24697eb6d00d4ee3bc3cc0d3f9472e60-20191213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sGCRslRMxKd4+sopLgy6QPoZUbVrNbm1Aabm9JQ7Fiw=;
        b=ccNhwmDeAqop99pkVHs4JJD6zlqiDalwPWox+0bRHC4tv5JSARi8nuo4roFS0RoLn53d6/WyXAgUfbR+5fTdKaROMHDkB8D9dxQjw/gAVZ4W1VjO0BVbHK7E9FaxiXk2gt+rGuqh1vfJG5VGtDqAWbKETMicIx8C2wuD6Ks8NBk=;
X-UUID: 24697eb6d00d4ee3bc3cc0d3f9472e60-20191213
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1559566732; Fri, 13 Dec 2019 15:49:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 15:49:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 15:49:40 +0800
Message-ID: <1576223390.9817.4.camel@mtksdaap41>
Subject: Re: [PATCH v2, 0/2] drm/mediatek: Add ctm property support
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 13 Dec 2019 15:49:50 +0800
In-Reply-To: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B532F401A64E730E8B148E727DA995610D1CD9CB4E6643715A43734C63D673E82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDE5LTEyLTEzIGF0IDE1OjI4ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtc2VwYXJhdGUgZ2FtbWEg
cGF0Y2gNCj4gLXJlbW92ZSBjbWRxIHN1cHBvcnQgZm9yIGN0bSBzZXR0aW5nDQoNCklmIHRoaXMg
c2VyaWVzIGRlcGVuZCBvbiBvdGhlciBwYXRjaCBvciBzZXJpZXMsIHBsZWFzZSBkZXNjcmliZSBp
dC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IA0KPiBZb25ncWlhbmcgTml1ICgyKToNCj4gICBk
cm0vbWVkaWF0ZWs6IEZpeCBnYW1tYSBjb3JyZWN0aW9uIGlzc3VlDQo+ICAgZHJtL21lZGlhdGVr
OiBBZGQgY3RtIHByb3BlcnR5IHN1cHBvcnQNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgMTggKysrKysrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAg
OSArKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCg0K

