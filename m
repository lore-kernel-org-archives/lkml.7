Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA476C17449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937D321A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I5PhNk/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKLIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29741 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbfKLIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:09 -0500
X-UUID: 6fc0a0991d3f4a58870216b642d1d489-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YDyC4vE1LT6UGA9FokW0xuntnFb/lqIksmsfb1iEmGo=;
        b=I5PhNk/JL48bqjvsBqnycqcDqaM+/B8GoMQ4hHfi4S8xPckq0RVPut8HS/z2QSAoWSlUqnmE4FIsNmyp5KfzcIeNs80ukaOCclomGoweF1LZPHciOGG0RzNOrJlNcvKk9Bg5P9s21sUr1Md7sZJHMC4Fg7pFDUbLLgiD700oECo=;
X-UUID: 6fc0a0991d3f4a58870216b642d1d489-20191112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1868335630; Tue, 12 Nov 2019 16:37:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:57 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 05/11] dt-bindings: phy-mtk-tphy: add the properties about address mapping
Date:   Tue, 12 Nov 2019 16:36:30 +0800
Message-ID: <1573547796-29566-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D837A91406C3E759364983B3845125D4B80AF8610B8E41D50E5E5F4FA87F14902000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRocmVlIHJlcXVpcmVkIHByb3BlcnRpZXMgYWJvdXQgdGhlIGFkZHJlc3MgbWFwcGluZywg
aW5jbHVkaW5nDQonI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIGFuZCAncmFuZ2VzJw0K
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjN+djQ6
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
YmUNCi0tIA0KMi4yMy4wDQo=

