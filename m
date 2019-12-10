Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2203C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B9206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fAflTWvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLJGr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:47:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbfLJGrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:47:23 -0500
X-UUID: 1301cc9bbfc84fb08a8bde23361cee54-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8fJ1n9GNh1269+8WlMysRs5Tc78IArLSr9qB40brFFI=;
        b=fAflTWvUKY+7sdRfNQ1OZrvZyvR2iLnz2Sg+UXsWzcmKAo2ZHCWszEpPssrNmYpzaggQpT8U+vnCHqJD5AaObnivhC3pOUqdOlScZbxrF6gUtZ+XOP2NJjzUG6Gp4FjRNueybyLincQE2DKkxC3pu41yC5QUcxUAbn8AIMDXs28=;
X-UUID: 1301cc9bbfc84fb08a8bde23361cee54-20191210
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 973163123; Tue, 10 Dec 2019 14:47:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 14:46:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 14:47:16 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v9 1/9] dt-bindings: mediatek: Add property to mt8183 smi-common
Date:   Tue, 10 Dec 2019 14:46:45 +0800
Message-ID: <1575960413-6900-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E2733B1780DD061AB6C4EE6E332443FD217E84FFE31A36BC4844478A94A2AF072000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNjcHN5cyBkcml2ZXIgdXNpbmcgcmVnbWFwIGJhc2VkIHN5c2NvbiBkcml2ZXIgQVBJLg0K
DQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1j
b21tb24udHh0ICAgICAgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxz
bWktY29tbW9uLnR4dA0KaW5kZXggYjQ3OGFkZS4uMDE3NDRlYyAxMDA2NDQNCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWss
c21pLWNvbW1vbi50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQNCkBAIC0yMCw3ICsyMCw3
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogCSJtZWRpYXRlayxtdDI3MTItc21pLWNvbW1vbiIN
CiAJIm1lZGlhdGVrLG10NzYyMy1zbWktY29tbW9uIiwgIm1lZGlhdGVrLG10MjcwMS1zbWktY29t
bW9uIg0KIAkibWVkaWF0ZWssbXQ4MTczLXNtaS1jb21tb24iDQotCSJtZWRpYXRlayxtdDgxODMt
c21pLWNvbW1vbiINCisJIm1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uIiwgInN5c2NvbiINCiAt
IHJlZyA6IHRoZSByZWdpc3RlciBhbmQgc2l6ZSBvZiB0aGUgU01JIGJsb2NrLg0KIC0gcG93ZXIt
ZG9tYWlucyA6IGEgcGhhbmRsZSB0byB0aGUgcG93ZXIgZG9tYWluIG9mIHRoaXMgbG9jYWwgYXJi
aXRlci4NCiAtIGNsb2NrcyA6IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBp
biBjbG9jay1uYW1lcy4NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

