Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF11EC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888922075E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ThreE4OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLXCS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:18:29 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:19244 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726871AbfLXCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:18:29 -0500
X-UUID: 68d03087cf124cfab8760666283b9195-20191224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=16xFo3KU0nEDG/VMlRzWi955Bc53HVQ+4UJtznpAulY=;
        b=ThreE4OMvAalHXCr/SLWnwH7JIHxbD+yUdQULfJNCq6eNae3E6jaSQIKsLnRTCJZxTaryXr+hqTPZysf6juHUE7HOu1GetG49BW8hhnV+0aFnRc4E2zyt4GmTOk/dx3KtHnHZ/KNKipwMgZ0t6CS7xONYKo582eIwfqNYza4jII=;
X-UUID: 68d03087cf124cfab8760666283b9195-20191224
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1929636635; Tue, 24 Dec 2019 10:18:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 24 Dec 2019 10:17:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 24 Dec 2019 10:17:22 +0800
Message-ID: <1577153898.15019.0.camel@mtksdaap41>
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
Date:   Tue, 24 Dec 2019 10:18:18 +0800
In-Reply-To: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 038CC378C24033B372078724DE10872FC6D2686BD2692C93E805E6EC8F9A94AA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDE5LTEyLTEzIGF0IDE1OjI4ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtc2VwYXJhdGUgZ2FtbWEg
cGF0Y2gNCj4gLXJlbW92ZSBjbWRxIHN1cHBvcnQgZm9yIGN0bSBzZXR0aW5nDQo+IA0KDQpGb3Ig
dGhpcyBzZXJpZXMsIGFwcGxpZWQgdG8gbWVkaWF0ZWstZHJtLW5leHQtNS42IFsxXSwgdGhhbmtz
Lg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9ja2h1LW1lZGlhdGVrL2xpbnV4LmdpdC10YWdz
L2NvbW1pdHMvbWVkaWF0ZWstZHJtLW5leHQtNS42DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBZ
b25ncWlhbmcgTml1ICgyKToNCj4gICBkcm0vbWVkaWF0ZWs6IEZpeCBnYW1tYSBjb3JyZWN0aW9u
IGlzc3VlDQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgY3RtIHByb3BlcnR5IHN1cHBvcnQNCj4gDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgMTggKysrKysr
Ky0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgNjIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmggfCAgOSArKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA4NSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg0K

