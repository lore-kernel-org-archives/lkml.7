Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0771C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970352080A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lp3YNNSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgAHBwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33587 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbgAHBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:34 -0500
X-UUID: 773a676843304cc49b48ee5f61fce5d0-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bGOiBo8UsCQP2pWWgLyPzgbBIX20HC4dwHtdo02etrI=;
        b=Lp3YNNSvku1REfvKcdlpexuPe+R6Sdzn7z8j9K/fmqLgrBtj3qXC4xXzPKE/9Xf31au0NufCMtPAjTv6/6pQsNz5c8aYJf+4QwhBKdMXWP/ar25ydxUJlkSw1qKb2w7s2I1nsst4AljQz45DqNJoQUIu/LanIuYVyTQ8uSVopL4=;
X-UUID: 773a676843304cc49b48ee5f61fce5d0-20200108
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1381830873; Wed, 08 Jan 2020 09:52:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:50:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 05/11] dt-bindings: phy-mtk-tphy: add the properties about address mapping
Date:   Wed, 8 Jan 2020 09:52:00 +0800
Message-ID: <1578448326-27455-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E7AD8DAC7C6F2045B14EF4CC6E078C9256E7C003A7D15FF2034D30DC13356E7B2000:8
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

