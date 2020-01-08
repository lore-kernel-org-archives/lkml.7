Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39693C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1049720848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SKePdRKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAHBwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:33 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46950 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgAHBwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:32 -0500
X-UUID: 013b3fe85fe64c5d9885b544ede2a873-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3nT/zyPqTRXKX+qkYY8Mvpnq2j5E/DAPw3se4gA7isQ=;
        b=SKePdRKDuT5QWhVEZsUCaLkiIW5kk34dALXq2BWnZuno9BC7zdp58CvfKtsVUUUw1QoWCJhzH2LH27DRhhjNP7hNMARcGtntlrrVLV/gKK545/a/KIr8uEQHzMgZ0Dd8SGp/YM5M+rnaKUmVKtK3Le8EXa2juCxG0JdZG7GMsAw=;
X-UUID: 013b3fe85fe64c5d9885b544ede2a873-20200108
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1229779208; Wed, 08 Jan 2020 09:52:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:50:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:52:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 02/11] dt-bindings: phy-mtk-tphy: make the ref clock optional
Date:   Wed, 8 Jan 2020 09:51:57 +0800
Message-ID: <1578448326-27455-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9D839053CFF735E21A66DF2F8599DF469A78D96CCF3DB75A4F64AD6A83A2EE562000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFrZSB0aGUgcmVmIGNsb2NrIG9wdGlvbmFsLCB0aGVuIHdlIG5vIG5lZWQgcmVmZXIgdG8gYSBm
aXhlZC1jbG9jaw0KaW4gRFRTIGFueW1vcmUgd2hlbiB0aGUgY2xvY2sgb2YgVVNCMyBQSFkgY29t
ZXMgZnJvbSBvc2NpbGxhdG9yDQpkaXJlY3RseQ0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCi0tLQ0KdjR+djU6IG5vIGNoYW5nZXMNCg0KdjM6IGFkZCBhY2tlZC1i
eSBSb2INCg0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9waHktbXRrLXRwaHkudHh0ICAgICAgICB8IDEzICsrKysrKystLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRl
eCBjZTZhYmZiZGZiZTEuLjFmNGEzNmRkODBlMCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtMzQsMTIg
KzM0LDYgQEAgT3B0aW9uYWwgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFyZW50KSBub2RlKToN
CiANCiBSZXF1aXJlZCBwcm9wZXJ0aWVzIChwb3J0IChjaGlsZCkgbm9kZSk6DQogLSByZWcJCTog
YWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQgZm9yIHRoZSBwb3J0Lg0KLS0g
Y2xvY2tzCTogYSBsaXN0IG9mIHBoYW5kbGUgKyBjbG9jay1zcGVjaWZpZXIgcGFpcnMsIG9uZSBm
b3IgZWFjaA0KLQkJICBlbnRyeSBpbiBjbG9jay1uYW1lcw0KLS0gY2xvY2stbmFtZXMJOiBtdXN0
IGNvbnRhaW4NCi0JCSAgInJlZiI6IDQ4TSByZWZlcmVuY2UgY2xvY2sgZm9yIEhpZ2hTcGVlZCBh
bmFsb2cgcGh5OyBhbmQgMjZNDQotCQkJcmVmZXJlbmNlIGNsb2NrIGZvciBTdXBlclNwZWVkIGFu
YWxvZyBwaHksIHNvbWV0aW1lcyBpcw0KLQkJCTI0TSwgMjVNIG9yIDI3TSwgZGVwZW5kZWQgb24g
cGxhdGZvcm0uDQogLSAjcGh5LWNlbGxzCTogc2hvdWxkIGJlIDEgKFNlZSBzZWNvbmQgZXhhbXBs
ZSkNCiAJCSAgY2VsbCBhZnRlciBwb3J0IHBoYW5kbGUgaXMgcGh5IHR5cGUgZnJvbToNCiAJCQkt
IFBIWV9UWVBFX1VTQjINCkBAIC00OCw2ICs0MiwxMyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChw
b3J0IChjaGlsZCkgbm9kZSk6DQogCQkJLSBQSFlfVFlQRV9TQVRBDQogDQogT3B0aW9uYWwgcHJv
cGVydGllcyAoUEhZX1RZUEVfVVNCMiBwb3J0IChjaGlsZCkgbm9kZSk6DQorLSBjbG9ja3MJOiBh
IGxpc3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoDQor
CQkgIGVudHJ5IGluIGNsb2NrLW5hbWVzDQorLSBjbG9jay1uYW1lcwk6IG1heSBjb250YWluDQor
CQkgICJyZWYiOiA0OE0gcmVmZXJlbmNlIGNsb2NrIGZvciBIaWdoU3BlZWQgYW5vbG9nIHBoeTsg
YW5kIDI2TQ0KKwkJCXJlZmVyZW5jZSBjbG9jayBmb3IgU3VwZXJTcGVlZCBhbm9sb2cgcGh5LCBz
b21ldGltZXMgaXMNCisJCQkyNE0sIDI1TSBvciAyN00sIGRlcGVuZGVkIG9uIHBsYXRmb3JtLg0K
Kw0KIC0gbWVkaWF0ZWssZXllLXNyYwk6IHUzMiwgdGhlIHZhbHVlIG9mIHNsZXcgcmF0ZSBjYWxp
YnJhdGUNCiAtIG1lZGlhdGVrLGV5ZS12cnQJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgVlJUIHJl
ZmVyZW5jZSB2b2x0YWdlDQogLSBtZWRpYXRlayxleWUtdGVybQk6IHUzMiwgdGhlIHNlbGVjdGlv
biBvZiBIU19UWCBURVJNIHJlZmVyZW5jZSB2b2x0YWdlDQotLSANCjIuMjQuMA0K

