Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE9C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AA021783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="POpeMltb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKLIhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9135 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbfKLIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:05 -0500
X-UUID: 2c9261e88f8a40ce8cd92550d62731e9-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Twkjyz0ZIfeNx6oKrnQY1V49AHMl70pMpGX6V2Z1dso=;
        b=POpeMltb/ZJC79rkT808V0C8AtQ5jmQmRKP+qvlOKre1kBBOyPEsFX3QfnR0qWojRlcScYrpz3ucTXHL31sEI5Nwo61NAFBH0NmMfW6MDdQK2g0OqpRILTZC5swhMU+e+DyuCxgP3c7VgtL3eJTrw/C6+f9fQpLKtILS56FyrB8=;
X-UUID: 2c9261e88f8a40ce8cd92550d62731e9-20191112
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 301320607; Tue, 12 Nov 2019 16:36:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:48 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 04/11] dt-bindings: phy-mtk-tphy: add a new reference clock
Date:   Tue, 12 Nov 2019 16:36:29 +0800
Message-ID: <1573547796-29566-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 16BD9300C6C8A83051F05D9F0A1BA6ED17B9D1F96C18D1FBE63E6C69C933ECC82000:8
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
ZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjQ6IG5vIGNoYW5nZXMN
Cg0KdjM6IGFkZCBhY2tlZC1ieSBSb2INCg0KdjI6IGZpeCB0eXBvIG9mIGFuYWxvZyBhbmQgbmVl
ZGVkDQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGst
dHBoeS50eHQgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRleCA0OGJjMWEyZTkyOTkuLmE4NTliMGRi
NDA1MSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtNDEsOSArNDEsMTIgQEAgT3B0aW9uYWwgcHJvcGVy
dGllcyAoUEhZX1RZUEVfVVNCMiBwb3J0IChjaGlsZCkgbm9kZSk6DQogLSBjbG9ja3MJOiBhIGxp
c3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoDQogCQkg
IGVudHJ5IGluIGNsb2NrLW5hbWVzDQogLSBjbG9jay1uYW1lcwk6IG1heSBjb250YWluDQotCQkg
ICJyZWYiOiA0OE0gcmVmZXJlbmNlIGNsb2NrIGZvciBIaWdoU3BlZWQgYW5vbG9nIHBoeTsgYW5k
IDI2TQ0KLQkJCXJlZmVyZW5jZSBjbG9jayBmb3IgU3VwZXJTcGVlZCBhbm9sb2cgcGh5LCBzb21l
dGltZXMgaXMNCisJCSAgInJlZiI6IDQ4TSByZWZlcmVuY2UgY2xvY2sgZm9yIEhpZ2hTcGVlZCAo
ZGlnaXRhbCkgcGh5OyBhbmQgMjZNDQorCQkJcmVmZXJlbmNlIGNsb2NrIGZvciBTdXBlclNwZWVk
IChkaWdpdGFsKSBwaHksIHNvbWV0aW1lcyBpcw0KIAkJCTI0TSwgMjVNIG9yIDI3TSwgZGVwZW5k
ZWQgb24gcGxhdGZvcm0uDQorCQkgICJkYV9yZWYiOiB0aGUgcmVmZXJlbmNlIGNsb2NrIG9mIGFu
YWxvZyBwaHksIHVzZWQgaWYgdGhlIGNsb2Nrcw0KKwkJCW9mIGFuYWxvZyBhbmQgZGlnaXRhbCBw
aHlzIGFyZSBzZXBhcmF0ZWQsIG90aGVyd2lzZSB1c2VzDQorCQkJInJlZiIgY2xvY2sgb25seSBp
ZiBuZWVkZWQuDQogDQogLSBtZWRpYXRlayxleWUtc3JjCTogdTMyLCB0aGUgdmFsdWUgb2Ygc2xl
dyByYXRlIGNhbGlicmF0ZQ0KIC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVjdGlv
biBvZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2UNCi0tIA0KMi4yMy4wDQo=

