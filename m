Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B4C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E87222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="de+DJUBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKMDjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:39:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24567 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727319AbfKMDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:39:32 -0500
X-UUID: d637a89128f84bc18ee8e7b76ca9e33f-20191113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bfRQ0Dzw2bXkHJSpdBAaflQgVggmHGlR1uabujVny0c=;
        b=de+DJUBGAzxk2cLrk8w0YUgyK7sdZmXC85wUysWQYOJQ/srVgguIXQB4oNfWcFMRJQVTA0b9OOSd8AgJkKjxU0ts//f1jdz9D07MnqGQhfWiTrt6oxHzAlVS+YY8BN1o4a4FXsBQS3zFGdYSsxBrPQsniVcdp8n+t8RWBeHa11I=;
X-UUID: d637a89128f84bc18ee8e7b76ca9e33f-20191113
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 912691054; Wed, 13 Nov 2019 11:39:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Nov 2019 11:39:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Nov 2019 11:39:24 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Evan Green <evgreen@chromium.org>, Joerg Roedel <jroedel@suse.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v1 1/2] dt-bindings: mediatek: Add binding for MT6779 SMI
Date:   Wed, 13 Nov 2019 11:39:21 +0800
Message-ID: <1573616362-2557-2-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1573616362-2557-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1573616362-2557-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18B0C01BE9F437EA852D0133948A87BA80A87B372A75DD0B5CDA87B20C5DC0AF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24gZm9yIE1UNjc3OSBTTUkuDQoNClNpZ25lZC1vZmYt
Ynk6IE1pbmctRmFuIENoZW4gPG1pbmctZmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgICAzICsr
LQ0KIC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIudHh0ICAgICAgIHwg
ICAgMyArKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1v
cnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24u
dHh0DQppbmRleCBiNDc4YWRlLi5hNWE3MjczIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9u
LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250
cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0KQEAgLTUsNyArNSw3IEBAIFRoZSBoYXJk
d2FyZSBibG9jayBkaWFncmFtIHBsZWFzZSBjaGVjayBiaW5kaW5ncy9pb21tdS9tZWRpYXRlayxp
b21tdS50eHQNCiBNZWRpYXRlayBTTUkgaGF2ZSB0d28gZ2VuZXJhdGlvbnMgb2YgSFcgYXJjaGl0
ZWN0dXJlLCBoZXJlIGlzIHRoZSBsaXN0DQogd2hpY2ggZ2VuZXJhdGlvbiB0aGUgU29DcyB1c2U6
DQogZ2VuZXJhdGlvbiAxOiBtdDI3MDEgYW5kIG10NzYyMy4NCi1nZW5lcmF0aW9uIDI6IG10Mjcx
MiwgbXQ4MTczIGFuZCBtdDgxODMuDQorZ2VuZXJhdGlvbiAyOiBtdDI3MTIsIG10Njc3OSwgbXQ4
MTczIGFuZCBtdDgxODMuDQogDQogVGhlcmUncyBzbGlnaHQgZGlmZmVyZW5jZXMgYmV0d2VlbiB0
aGUgdHdvIFNNSSwgZm9yIGdlbmVyYXRpb24gMiwgdGhlDQogcmVnaXN0ZXIgd2hpY2ggY29udHJv
bCB0aGUgaW9tbXUgcG9ydCBpcyBhdCBlYWNoIGxhcmIncyByZWdpc3RlciBiYXNlLiBCdXQNCkBA
IC0xOCw2ICsxOCw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlIDogbXVz
dCBiZSBvbmUgb2YgOg0KIAkibWVkaWF0ZWssbXQyNzAxLXNtaS1jb21tb24iDQogCSJtZWRpYXRl
ayxtdDI3MTItc21pLWNvbW1vbiINCisJIm1lZGlhdGVrLG10Njc3OS1zbWktY29tbW9uIg0KIAki
bWVkaWF0ZWssbXQ3NjIzLXNtaS1jb21tb24iLCAibWVkaWF0ZWssbXQyNzAxLXNtaS1jb21tb24i
DQogCSJtZWRpYXRlayxtdDgxNzMtc21pLWNvbW1vbiINCiAJIm1lZGlhdGVrLG10ODE4My1zbWkt
Y29tbW9uIg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50
eHQNCmluZGV4IDRiMzY5YjMuLjhmMTlkZmUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4
dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9s
bGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQNCkBAIC02LDYgKzYsNyBAQCBSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KIC0gY29tcGF0aWJsZSA6IG11c3QgYmUgb25lIG9mIDoNCiAJCSJtZWRpYXRlayxt
dDI3MDEtc21pLWxhcmIiDQogCQkibWVkaWF0ZWssbXQyNzEyLXNtaS1sYXJiIg0KKwkJIm1lZGlh
dGVrLG10Njc3OS1zbWktbGFyYiINCiAJCSJtZWRpYXRlayxtdDc2MjMtc21pLWxhcmIiLCAibWVk
aWF0ZWssbXQyNzAxLXNtaS1sYXJiIg0KIAkJIm1lZGlhdGVrLG10ODE3My1zbWktbGFyYiINCiAJ
CSJtZWRpYXRlayxtdDgxODMtc21pLWxhcmIiDQpAQCAtMjEsNyArMjIsNyBAQCBSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KICAgLSAiZ2FscyI6IHRoZSBjbG9jayBmb3IgR0FMUyhHbG9iYWwgQXN5bmMg
TG9jYWwgU3luYykuDQogICBIZXJlIGlzIHRoZSBsaXN0IHdoaWNoIGhhcyB0aGlzIEdBTFM6IG10
ODE4My4NCiANCi1SZXF1aXJlZCBwcm9wZXJ0eSBmb3IgbXQyNzAxLCBtdDI3MTIgYW5kIG10NzYy
MzoNCitSZXF1aXJlZCBwcm9wZXJ0eSBmb3IgbXQyNzAxLCBtdDI3MTIsIG10Njc3OSBhbmQgbXQ3
NjIzOg0KIC0gbWVkaWF0ZWssbGFyYi1pZCA6dGhlIGhhcmR3YXJlIGlkIG9mIHRoaXMgbGFyYi4N
CiANCiBFeGFtcGxlOg0KLS0gDQoxLjcuOS41DQo=

