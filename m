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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B321A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bZMnuaGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKLIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:25 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:38078 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727016AbfKLIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:21 -0500
X-UUID: 472b7d5323fb4648b487eef62010c345-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eo41Hk6NfJK40ondI+wYfMr+Hsh/lHFcZwA0UHDjo6U=;
        b=bZMnuaGsl6nSOgsJYLMoc8XA6rlU+F4A1WgJm90fmCZI+BUjAEJXy47tf9yJLJUxtCnRt8EL1xpcnBSD8R6mEC7d56wBfUqt1t6+GpO//PbQWiNdYt8S9VMEkqLON5+UdpirgXvESKwY9gmgLnqNCj/Dfic7953HbRTouAFdHMU=;
X-UUID: 472b7d5323fb4648b487eef62010c345-20191112
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1313391296; Tue, 12 Nov 2019 16:37:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:37:08 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:37:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 11/11] arm64: dts: mt2712: use non-empty ranges for usb-phy
Date:   Tue, 12 Nov 2019 16:36:36 +0800
Message-ID: <1573547796-29566-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2E745E3DDCE992EF50B56428F573B0FD93A0D02624A7401E01D78D984B4516CD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIG5vbi1lbXB0eSByYW5nZXMgZm9yIHVzYi1waHkgdG8gbWFrZSB0aGUgbGF5b3V0IG9mDQpp
dHMgcmVnaXN0ZXJzIGNsZWFyZXI7DQpSZXBsYWNlIGRlcHJlY2F0ZWQgY29tcGF0aWJsZSBieSBn
ZW5lcmljDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KdjN+djQ6IG5vIGNoYW5nZXMNCg0KdjI6IHVzZSBnZW5lcmljIGNvbXBh
dGlibGUNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpIHwg
NDIgKysrKysrKysrKysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgMjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210MjcxMmUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQy
NzEyZS5kdHNpDQppbmRleCA0MzMwN2JhZDNmMGQuLmUyNGYyZjJmNjAwNCAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQorKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaQ0KQEAgLTY5NywzMCArNjk3LDMxIEBA
DQogCX07DQogDQogCXUzcGh5MDogdXNiLXBoeUAxMTI5MDAwMCB7DQotCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10MjcxMi11M3BoeSI7DQotCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCi0JCSNz
aXplLWNlbGxzID0gPDI+Ow0KLQkJcmFuZ2VzOw0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDI3MTItdHBoeSIsDQorCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCisJCSNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MT47DQorCQlyYW5nZXMgPSA8
MCAwIDB4MTEyOTAwMDAgMHg5MDAwPjsNCiAJCXN0YXR1cyA9ICJva2F5IjsNCiANCi0JCXUycG9y
dDA6IHVzYi1waHlAMTEyOTAwMDAgew0KLQkJCXJlZyA9IDwwIDB4MTEyOTAwMDAgMCAweDcwMD47
DQorCQl1MnBvcnQwOiB1c2ItcGh5QDAgew0KKwkJCXJlZyA9IDwweDAgMHg3MDA+Ow0KIAkJCWNs
b2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2Vs
bHMgPSA8MT47DQogCQkJc3RhdHVzID0gIm9rYXkiOw0KIAkJfTsNCiANCi0JCXUycG9ydDE6IHVz
Yi1waHlAMTEyOTgwMDAgew0KLQkJCXJlZyA9IDwwIDB4MTEyOTgwMDAgMCAweDcwMD47DQorCQl1
MnBvcnQxOiB1c2ItcGh5QDgwMDAgew0KKwkJCXJlZyA9IDwweDgwMDAgMHg3MDA+Ow0KIAkJCWNs
b2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2Vs
bHMgPSA8MT47DQogCQkJc3RhdHVzID0gIm9rYXkiOw0KIAkJfTsNCiANCi0JCXUzcG9ydDA6IHVz
Yi1waHlAMTEyOTg3MDAgew0KLQkJCXJlZyA9IDwwIDB4MTEyOTg3MDAgMCAweDkwMD47DQorCQl1
M3BvcnQwOiB1c2ItcGh5QDg3MDAgew0KKwkJCXJlZyA9IDwweDg3MDAgMHg5MDA+Ow0KIAkJCWNs
b2NrcyA9IDwmY2xrMjZtPjsNCiAJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KIAkJCSNwaHktY2Vs
bHMgPSA8MT47DQpAQCAtNzYwLDMwICs3NjEsMzEgQEANCiAJfTsNCiANCiAJdTNwaHkxOiB1c2It
cGh5QDExMmUwMDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyLXUzcGh5IjsN
Ci0JCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KLQkJI3NpemUtY2VsbHMgPSA8Mj47DQotCQlyYW5n
ZXM7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi10cGh5IiwNCisJCQkgICAgICJt
ZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkj
c2l6ZS1jZWxscyA9IDwxPjsNCisJCXJhbmdlcyA9IDwwIDAgMHgxMTJlMDAwMCAweDkwMDA+Ow0K
IAkJc3RhdHVzID0gIm9rYXkiOw0KIA0KLQkJdTJwb3J0MjogdXNiLXBoeUAxMTJlMDAwMCB7DQot
CQkJcmVnID0gPDAgMHgxMTJlMDAwMCAwIDB4NzAwPjsNCisJCXUycG9ydDI6IHVzYi1waHlAMCB7
DQorCQkJcmVnID0gPDB4MCAweDcwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNs
b2NrLW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCiAJCQlzdGF0dXMgPSAi
b2theSI7DQogCQl9Ow0KIA0KLQkJdTJwb3J0MzogdXNiLXBoeUAxMTJlODAwMCB7DQotCQkJcmVn
ID0gPDAgMHgxMTJlODAwMCAwIDB4NzAwPjsNCisJCXUycG9ydDM6IHVzYi1waHlAODAwMCB7DQor
CQkJcmVnID0gPDB4ODAwMCAweDcwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNs
b2NrLW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCiAJCQlzdGF0dXMgPSAi
b2theSI7DQogCQl9Ow0KIA0KLQkJdTNwb3J0MTogdXNiLXBoeUAxMTJlODcwMCB7DQotCQkJcmVn
ID0gPDAgMHgxMTJlODcwMCAwIDB4OTAwPjsNCisJCXUzcG9ydDE6IHVzYi1waHlAODcwMCB7DQor
CQkJcmVnID0gPDB4ODcwMCAweDkwMD47DQogCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KIAkJCWNs
b2NrLW5hbWVzID0gInJlZiI7DQogCQkJI3BoeS1jZWxscyA9IDwxPjsNCi0tIA0KMi4yMy4wDQo=

