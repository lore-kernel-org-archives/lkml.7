Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FB22077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ep7xk4GY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLKFyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:54:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51650 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfLKFyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:54:53 -0500
X-UUID: fa859dbc91484c9badb1c2a04c8b2ee8-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bGOiBo8UsCQP2pWWgLyPzgbBIX20HC4dwHtdo02etrI=;
        b=ep7xk4GYDsyKD9xp3Z+EExpku2RPOkckb+99ivOgNZFshjCYD3RXUP5nZhlL3twSey6DpN22xDriUkZELY18G1MDk98/2yLBhBenpiwNi3UPwN1ZplJ0r6j8/w7QdiwgFVCeW/VVfX2pgKCsyOKt693ycuEVDUH6kv5CQmJANDU=;
X-UUID: fa859dbc91484c9badb1c2a04c8b2ee8-20191211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 942036857; Wed, 11 Dec 2019 13:54:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 13:54:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 13:54:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 05/11] dt-bindings: phy-mtk-tphy: add the properties about address mapping
Date:   Wed, 11 Dec 2019 13:54:17 +0800
Message-ID: <1576043663-14240-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B460AA0BFF4E72BC7B7F8C602940F06412E8EBCBAB5A88572525C73B5F0966292000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRocmVlIHJlcXVpcmVkIHByb3BlcnRpZXMgYWJvdXQgdGhlIGFkZHJlc3MgbWFwcGluZywg
aW5jbHVkaW5nDQonI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIGFuZCAncmFuZ2VzJw0K
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjN+djU6
IG5vIGNoYW5nZXMNCg0KdjI6IGFkZCBSZXZpZXdlZC1ieSBSb2INCi0tLQ0KIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dCB8IDEwICsrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRl
eCBhODU5YjBkYjQwNTEuLmRkNzViNjc2YjcxZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtMTQsNiAr
MTQsMTYgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFyZW50KSBub2RlKToN
CiAJCSAgbWFrZSB1c2Ugb2YgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSIgb24gbXQyNzAxIGlu
c3RlYWQgYW5kDQogCQkgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiIG9uIG10MjcxMiBpbnN0
ZWFkLg0KIA0KKy0gI2FkZHJlc3MtY2VsbHM6CXRoZSBudW1iZXIgb2YgY2VsbHMgdXNlZCB0byBy
ZXByZXNlbnQgcGh5c2ljYWwNCisJCWJhc2UgYWRkcmVzc2VzLg0KKy0gI3NpemUtY2VsbHM6CXRo
ZSBudW1iZXIgb2YgY2VsbHMgdXNlZCB0byByZXByZXNlbnQgdGhlIHNpemUgb2YgYW4gYWRkcmVz
cy4NCistIHJhbmdlczoJdGhlIGFkZHJlc3MgbWFwcGluZyByZWxhdGlvbnNoaXAgdG8gdGhlIHBh
cmVudCwgZGVmaW5lZCB3aXRoDQorCQktIGVtcHR5IHZhbHVlOiBpZiBvcHRpb25hbCAncmVnJyBp
cyB1c2VkLg0KKwkJLSBub24tZW1wdHkgdmFsdWU6IGlmIG9wdGlvbmFsICdyZWcnIGlzIG5vdCB1
c2VkLiBzaG91bGQgc2V0DQorCQkJdGhlIGNoaWxkJ3MgYmFzZSBhZGRyZXNzIHRvIDAsIHRoZSBw
aHlzaWNhbCBhZGRyZXNzDQorCQkJd2l0aGluIHBhcmVudCdzIGFkZHJlc3Mgc3BhY2UsIGFuZCB0
aGUgbGVuZ3RoIG9mDQorCQkJdGhlIGFkZHJlc3MgbWFwLg0KKw0KIFJlcXVpcmVkIG5vZGVzCTog
YSBzdWItbm9kZSBpcyByZXF1aXJlZCBmb3IgZWFjaCBwb3J0IHRoZSBjb250cm9sbGVyDQogCQkg
IHByb3ZpZGVzLiBBZGRyZXNzIHJhbmdlIGluZm9ybWF0aW9uIGluY2x1ZGluZyB0aGUgdXN1YWwN
CiAJCSAgJ3JlZycgcHJvcGVydHkgaXMgdXNlZCBpbnNpZGUgdGhlc2Ugbm9kZXMgdG8gZGVzY3Jp
YmUNCi0tIA0KMi4yNC4wDQo=

