Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B6C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABB52080A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n32hK4ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHBwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:9701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727095AbgAHBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:40 -0500
X-UUID: 53a31effcb9145db83c47b03f7994e1f-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XON1V6tySuKrrDd+LZuRUKWj6qe9V3o3++228yp8h3k=;
        b=n32hK4uepg8xny5iSYNAA4s0iMkd8NmhhDkL6xamLTo5Eo/UUNrssKgDj/OfxxKR+QMHdvVjLc9GxXuUXYlrWDapp7+t6AYO/IkneTfyT6qxRo5arv4jYpR96FanLnQcbRrgL+cAU2ybW8/SiDkQ5X2VfPbQ3eM938t854WFazI=;
X-UUID: 53a31effcb9145db83c47b03f7994e1f-20200108
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 141265865; Wed, 08 Jan 2020 09:52:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:50:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 11/11] arm64: dts: mt2712: use non-empty ranges for usb-phy
Date:   Wed, 8 Jan 2020 09:52:06 +0800
Message-ID: <1578448326-27455-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 32088C3A5289AA2B75F197998577605D9ED7203238422932856D68F6EB9315852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIG5vbi1lbXB0eSByYW5nZXMgZm9yIHVzYi1waHkgdG8gbWFrZSB0aGUgbGF5b3V0IG9mDQpp
dHMgcmVnaXN0ZXJzIGNsZWFyZXI7DQpSZXBsYWNlIGRlcHJlY2F0ZWQgY29tcGF0aWJsZSBieSBn
ZW5lcmljDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KdjN+djU6IG5vIGNoYW5nZXMNCg0KdjI6IHVzZSBnZW5lcmljIGNvbXBh
dGlibGUNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpIHwg
NDIgKysrKysrKysrKysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgMjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210MjcxMmUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQy
NzEyZS5kdHNpDQppbmRleCA0MzMwN2JhZDNmMGQuLmUyNGYyZjJmNjAwNCAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQorKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaQ0KQEAgLTY5NywzMCArNjk3LDMxIEBA
IHVzYl9ob3N0MDogeGhjaUAxMTI3MDAwMCB7DQogCX07DQogDQogCXUzcGh5MDogdXNiLXBoeUAx
MTI5MDAwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi11M3BoeSI7DQotCQkj
YWRkcmVzcy1jZWxscyA9IDwyPjsNCi0JCSNzaXplLWNlbGxzID0gPDI+Ow0KLQkJcmFuZ2VzOw0K
KwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdHBoeSIsDQorCQkJICAgICAibWVkaWF0
ZWssZ2VuZXJpYy10cGh5LXYyIjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3NpemUt
Y2VsbHMgPSA8MT47DQorCQlyYW5nZXMgPSA8MCAwIDB4MTEyOTAwMDAgMHg5MDAwPjsNCiAJCXN0
YXR1cyA9ICJva2F5IjsNCiANCi0JCXUycG9ydDA6IHVzYi1waHlAMTEyOTAwMDAgew0KLQkJCXJl
ZyA9IDwwIDB4MTEyOTAwMDAgMCAweDcwMD47DQorCQl1MnBvcnQwOiB1c2ItcGh5QDAgew0KKwkJ
CXJlZyA9IDwweDAgMHg3MDA+Ow0KIAkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1u
YW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2VsbHMgPSA8MT47DQogCQkJc3RhdHVzID0gIm9rYXki
Ow0KIAkJfTsNCiANCi0JCXUycG9ydDE6IHVzYi1waHlAMTEyOTgwMDAgew0KLQkJCXJlZyA9IDww
IDB4MTEyOTgwMDAgMCAweDcwMD47DQorCQl1MnBvcnQxOiB1c2ItcGh5QDgwMDAgew0KKwkJCXJl
ZyA9IDwweDgwMDAgMHg3MDA+Ow0KIAkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1u
YW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2VsbHMgPSA8MT47DQogCQkJc3RhdHVzID0gIm9rYXki
Ow0KIAkJfTsNCiANCi0JCXUzcG9ydDA6IHVzYi1waHlAMTEyOTg3MDAgew0KLQkJCXJlZyA9IDww
IDB4MTEyOTg3MDAgMCAweDkwMD47DQorCQl1M3BvcnQwOiB1c2ItcGh5QDg3MDAgew0KKwkJCXJl
ZyA9IDwweDg3MDAgMHg5MDA+Ow0KIAkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1u
YW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2VsbHMgPSA8MT47DQpAQCAtNzYwLDMwICs3NjEsMzEg
QEAgdXNiX2hvc3QxOiB4aGNpQDExMmMwMDAwIHsNCiAJfTsNCiANCiAJdTNwaHkxOiB1c2ItcGh5
QDExMmUwMDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyLXUzcGh5IjsNCi0J
CSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KLQkJI3NpemUtY2VsbHMgPSA8Mj47DQotCQlyYW5nZXM7
DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi10cGh5IiwNCisJCQkgICAgICJtZWRp
YXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkjc2l6
ZS1jZWxscyA9IDwxPjsNCisJCXJhbmdlcyA9IDwwIDAgMHgxMTJlMDAwMCAweDkwMDA+Ow0KIAkJ
c3RhdHVzID0gIm9rYXkiOw0KIA0KLQkJdTJwb3J0MjogdXNiLXBoeUAxMTJlMDAwMCB7DQotCQkJ
cmVnID0gPDAgMHgxMTJlMDAwMCAwIDB4NzAwPjsNCisJCXUycG9ydDI6IHVzYi1waHlAMCB7DQor
CQkJcmVnID0gPDB4MCAweDcwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNsb2Nr
LW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCiAJCQlzdGF0dXMgPSAib2th
eSI7DQogCQl9Ow0KIA0KLQkJdTJwb3J0MzogdXNiLXBoeUAxMTJlODAwMCB7DQotCQkJcmVnID0g
PDAgMHgxMTJlODAwMCAwIDB4NzAwPjsNCisJCXUycG9ydDM6IHVzYi1waHlAODAwMCB7DQorCQkJ
cmVnID0gPDB4ODAwMCAweDcwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNsb2Nr
LW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCiAJCQlzdGF0dXMgPSAib2th
eSI7DQogCQl9Ow0KIA0KLQkJdTNwb3J0MTogdXNiLXBoeUAxMTJlODcwMCB7DQotCQkJcmVnID0g
PDAgMHgxMTJlODcwMCAwIDB4OTAwPjsNCisJCXUzcG9ydDE6IHVzYi1waHlAODcwMCB7DQorCQkJ
cmVnID0gPDB4ODcwMCAweDkwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNsb2Nr
LW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCi0tIA0KMi4yNC4wDQo=

