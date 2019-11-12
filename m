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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D2C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1558821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LS0EIrDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:36:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17835 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbfKLIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:36:47 -0500
X-UUID: 429dcf9d88e949cf9cd77e1c58cc6801-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wOiJ/ZV6AQNxGxk6gds5DgISbMKwGhSMX9TJ3owZE4M=;
        b=LS0EIrDcpmfYjEICUNiS8CFBaBVQwHpDf/Aqak8j4SjoAGz50hyeFOsF1ZvX52aGP6Yo60eJexwrquPfP2xQeFHodxtGGn2VozpmrGtwZboVquJ4pIVIJH4CQr5tee5uJLcixUx1J6AAiUhqZy4+jSSRqsVRZe+4Lf0DdbgdAJQ=;
X-UUID: 429dcf9d88e949cf9cd77e1c58cc6801-20191112
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1148378184; Tue, 12 Nov 2019 16:36:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:37 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 01/11] dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Date:   Tue, 12 Nov 2019 16:36:26 +0800
Message-ID: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C4F3494EE8EF55C3D6A970A8D060227C9FCF13636542444D1B1EFA63D29410A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzLCBvbmUgZm9yIHR1bmluZyBKLUsgdm9sdGFnZSBi
eSBJTlRSLA0KYW5vdGhlciBmb3IgZGlzY29ubmVjdCB0aHJlc2hvbGQsIGJvdGggb2YgdGhlbSBh
cmUgcmVsYXRlZCB3aXRoDQpjb25uZWN0IGRldGVjdGlvbg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnY0OiBubyBjaGFuZ2Vz
DQoNCnYzOiBjaGFuZ2UgY29tbWl0IGxvZw0KDQp2MjogY2hhbmdlIGRlc2NyaXB0aW9uDQotLS0N
CiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQg
fCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpp
bmRleCBhNWY3YTRmMGRiYzEuLmNlNmFiZmJkZmJlMSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtNTIs
NiArNTIsOCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzIChQSFlfVFlQRV9VU0IyIHBvcnQgKGNoaWxk
KSBub2RlKToNCiAtIG1lZGlhdGVrLGV5ZS12cnQJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgVlJU
IHJlZmVyZW5jZSB2b2x0YWdlDQogLSBtZWRpYXRlayxleWUtdGVybQk6IHUzMiwgdGhlIHNlbGVj
dGlvbiBvZiBIU19UWCBURVJNIHJlZmVyZW5jZSB2b2x0YWdlDQogLSBtZWRpYXRlayxiYzEyCTog
Ym9vbCwgZW5hYmxlIEJDMTIgb2YgdTJwaHkgaWYgc3VwcG9ydCBpdA0KKy0gbWVkaWF0ZWssZGlz
Y3RoCTogdTMyLCB0aGUgc2VsZWN0aW9uIG9mIGRpc2Nvbm5lY3QgdGhyZXNob2xkDQorLSBtZWRp
YXRlayxpbnRyCTogdTMyLCB0aGUgc2VsZWN0aW9uIG9mIGludGVybmFsIFIgKHJlc2lzdGFuY2Up
DQogDQogRXhhbXBsZToNCiANCi0tIA0KMi4yMy4wDQo=

