Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18825C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D7B206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="txOmdagw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKLIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:36:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14389 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbfKLIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:36:48 -0500
X-UUID: 096888d9f5794db2b5fd520f9c15cf19-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T6ot9cCH0cM+/lAHdg7vZI+9l7UZXA+4n8Iu/we7TGk=;
        b=txOmdagw3jugLpJKm2nKj/tmRcz4zNKgky4Mhd0bZzzC6Tsyq54UiUhyde/pcq1dNwNyGtwZJ/vofZ+x3+l6plpV8VEUKaAKIF+3va6VvffGkpH97dOg7Zk/7Z7WxPUvONf4L0uacxvRpyt+miGcqpka2nitDR2Ml+oPduY7i6Q=;
X-UUID: 096888d9f5794db2b5fd520f9c15cf19-20191112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1147598016; Tue, 12 Nov 2019 16:36:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 02/11] dt-bindings: phy-mtk-tphy: make the ref clock optional
Date:   Tue, 12 Nov 2019 16:36:27 +0800
Message-ID: <1573547796-29566-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C11182870F47A7612632FF5A2FE9C41B656E0432068AACC381D8790691D3551D2000:8
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
YmhAa2VybmVsLm9yZz4NCi0tLQ0KdjQ6IG5vIGNoYW5nZXMNCg0KdjM6IGFkZCBhY2tlZC1ieSBS
b2INCg0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9w
aHktbXRrLXRwaHkudHh0ICAgICAgICB8IDEzICsrKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRleCBj
ZTZhYmZiZGZiZTEuLjFmNGEzNmRkODBlMCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtMzQsMTIgKzM0
LDYgQEAgT3B0aW9uYWwgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFyZW50KSBub2RlKToNCiAN
CiBSZXF1aXJlZCBwcm9wZXJ0aWVzIChwb3J0IChjaGlsZCkgbm9kZSk6DQogLSByZWcJCTogYWRk
cmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQgZm9yIHRoZSBwb3J0Lg0KLS0gY2xv
Y2tzCTogYSBsaXN0IG9mIHBoYW5kbGUgKyBjbG9jay1zcGVjaWZpZXIgcGFpcnMsIG9uZSBmb3Ig
ZWFjaA0KLQkJICBlbnRyeSBpbiBjbG9jay1uYW1lcw0KLS0gY2xvY2stbmFtZXMJOiBtdXN0IGNv
bnRhaW4NCi0JCSAgInJlZiI6IDQ4TSByZWZlcmVuY2UgY2xvY2sgZm9yIEhpZ2hTcGVlZCBhbmFs
b2cgcGh5OyBhbmQgMjZNDQotCQkJcmVmZXJlbmNlIGNsb2NrIGZvciBTdXBlclNwZWVkIGFuYWxv
ZyBwaHksIHNvbWV0aW1lcyBpcw0KLQkJCTI0TSwgMjVNIG9yIDI3TSwgZGVwZW5kZWQgb24gcGxh
dGZvcm0uDQogLSAjcGh5LWNlbGxzCTogc2hvdWxkIGJlIDEgKFNlZSBzZWNvbmQgZXhhbXBsZSkN
CiAJCSAgY2VsbCBhZnRlciBwb3J0IHBoYW5kbGUgaXMgcGh5IHR5cGUgZnJvbToNCiAJCQktIFBI
WV9UWVBFX1VTQjINCkBAIC00OCw2ICs0MiwxMyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChwb3J0
IChjaGlsZCkgbm9kZSk6DQogCQkJLSBQSFlfVFlQRV9TQVRBDQogDQogT3B0aW9uYWwgcHJvcGVy
dGllcyAoUEhZX1RZUEVfVVNCMiBwb3J0IChjaGlsZCkgbm9kZSk6DQorLSBjbG9ja3MJOiBhIGxp
c3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoDQorCQkg
IGVudHJ5IGluIGNsb2NrLW5hbWVzDQorLSBjbG9jay1uYW1lcwk6IG1heSBjb250YWluDQorCQkg
ICJyZWYiOiA0OE0gcmVmZXJlbmNlIGNsb2NrIGZvciBIaWdoU3BlZWQgYW5vbG9nIHBoeTsgYW5k
IDI2TQ0KKwkJCXJlZmVyZW5jZSBjbG9jayBmb3IgU3VwZXJTcGVlZCBhbm9sb2cgcGh5LCBzb21l
dGltZXMgaXMNCisJCQkyNE0sIDI1TSBvciAyN00sIGRlcGVuZGVkIG9uIHBsYXRmb3JtLg0KKw0K
IC0gbWVkaWF0ZWssZXllLXNyYwk6IHUzMiwgdGhlIHZhbHVlIG9mIHNsZXcgcmF0ZSBjYWxpYnJh
dGUNCiAtIG1lZGlhdGVrLGV5ZS12cnQJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgVlJUIHJlZmVy
ZW5jZSB2b2x0YWdlDQogLSBtZWRpYXRlayxleWUtdGVybQk6IHUzMiwgdGhlIHNlbGVjdGlvbiBv
ZiBIU19UWCBURVJNIHJlZmVyZW5jZSB2b2x0YWdlDQotLSANCjIuMjMuMA0K

