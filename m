Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D012C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E253220848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RQSMp7T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgAHBwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:39 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58572 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbgAHBwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:37 -0500
X-UUID: bc3b214524474dc1bee9e44eac3f777f-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LJDVcR2SAcZk3iqycmeYvlBCWvpND3jjXyNcWGnWUEM=;
        b=RQSMp7T8ZcIzFBAGzECFR2Ub17ThOSducEc4uDxuDim+m9/6dWEOu8KhcK5lNd+hX6xfsTKaPnRB9LAm5Y2n5FpJKXmjkx9XE+brpXgPO+g8KGyXlaN/f2eLG6YjT/1GCXv3cXrNt4dZ10HUx6bhOTZ30wqaiw7A7fpb9zV8NzE=;
X-UUID: bc3b214524474dc1bee9e44eac3f777f-20200108
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 685291209; Wed, 08 Jan 2020 09:52:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:51:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 04/11] dt-bindings: phy-mtk-tphy: add a new reference clock
Date:   Wed, 8 Jan 2020 09:51:59 +0800
Message-ID: <1578448326-27455-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8EFC1DA0629319F690A31448ABDB0DDE135AE70D460796112408316940711EB32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXN1YWxseSB0aGUgZGlnaXRhbCBhbmQgYW5hbG9nIHBoeXMgdXNlIHRoZSBzYW1lIHJlZmVyZW5j
ZSBjbG9jaywNCmJ1dCBvbiBzb21lIHBsYXRmb3JtcywgdGhleSBhcmUgc2VwYXJhdGVkLCBzbyBh
ZGQgYW5vdGhlciBvcHRpb25hbA0KY2xvY2sgdG8gc3VwcG9ydCBpdC4NCkluIG9yZGVyIHRvIGtl
ZXAgdGhlIGNsb2NrIG5hbWVzIGNvbnNpc3RlbnQgd2l0aCBQSFkgSVAncywgdXNlDQp0aGUgZGFf
cmVmIGZvciBhbmFsb2cgcGh5IGFuZCByZWYgY2xvY2sgZm9yIGRpZ2l0YWwgcGh5Lg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tl
ZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjR+djU6IG5vIGNoYW5n
ZXMNCg0KdjM6IGFkZCBhY2tlZC1ieSBSb2INCg0KdjI6IGZpeCB0eXBvIG9mIGFuYWxvZyBhbmQg
bmVlZGVkDQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1t
dGstdHBoeS50eHQgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRleCA0OGJjMWEyZTkyOTkuLmE4NTli
MGRiNDA1MSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtNDEsOSArNDEsMTIgQEAgT3B0aW9uYWwgcHJv
cGVydGllcyAoUEhZX1RZUEVfVVNCMiBwb3J0IChjaGlsZCkgbm9kZSk6DQogLSBjbG9ja3MJOiBh
IGxpc3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoDQog
CQkgIGVudHJ5IGluIGNsb2NrLW5hbWVzDQogLSBjbG9jay1uYW1lcwk6IG1heSBjb250YWluDQot
CQkgICJyZWYiOiA0OE0gcmVmZXJlbmNlIGNsb2NrIGZvciBIaWdoU3BlZWQgYW5vbG9nIHBoeTsg
YW5kIDI2TQ0KLQkJCXJlZmVyZW5jZSBjbG9jayBmb3IgU3VwZXJTcGVlZCBhbm9sb2cgcGh5LCBz
b21ldGltZXMgaXMNCisJCSAgInJlZiI6IDQ4TSByZWZlcmVuY2UgY2xvY2sgZm9yIEhpZ2hTcGVl
ZCAoZGlnaXRhbCkgcGh5OyBhbmQgMjZNDQorCQkJcmVmZXJlbmNlIGNsb2NrIGZvciBTdXBlclNw
ZWVkIChkaWdpdGFsKSBwaHksIHNvbWV0aW1lcyBpcw0KIAkJCTI0TSwgMjVNIG9yIDI3TSwgZGVw
ZW5kZWQgb24gcGxhdGZvcm0uDQorCQkgICJkYV9yZWYiOiB0aGUgcmVmZXJlbmNlIGNsb2NrIG9m
IGFuYWxvZyBwaHksIHVzZWQgaWYgdGhlIGNsb2Nrcw0KKwkJCW9mIGFuYWxvZyBhbmQgZGlnaXRh
bCBwaHlzIGFyZSBzZXBhcmF0ZWQsIG90aGVyd2lzZSB1c2VzDQorCQkJInJlZiIgY2xvY2sgb25s
eSBpZiBuZWVkZWQuDQogDQogLSBtZWRpYXRlayxleWUtc3JjCTogdTMyLCB0aGUgdmFsdWUgb2Yg
c2xldyByYXRlIGNhbGlicmF0ZQ0KIC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVj
dGlvbiBvZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2UNCi0tIA0KMi4yNC4wDQo=

