Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7266C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2192084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wq935/nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUByT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53041 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbfKUByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:19 -0500
X-UUID: c79dc9a874874a53beb0dfba4b59e64b-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wu5rr5U2mAIPhNRV+bhj5GJhAm/WdnBsgnKTUZtLDxQ=;
        b=Wq935/nKG4KBO0sq6SffejsESSwSYFANftAzmL0M+SPTC76gCfSgS4JwIGlUCVUIP9xTi0AeN9k1L/kWvWKnWYcNF6SOwxl82TxmKoBdIruEDxUODVPrm8aO0xvJZKsBeXlZJ3F5gsRUdb3AmtYH+JWLsIoQLPKBpBx6pYcGTao=;
X-UUID: c79dc9a874874a53beb0dfba4b59e64b-20191121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 519577978; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:54:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:17 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v17 6/6] arm64: dts: add gce node for mt8183
Date:   Thu, 21 Nov 2019 09:54:10 +0800
Message-ID: <20191121015410.18852-7-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGdjZSBkZXZpY2Ugbm9kZSBmb3IgbXQ4MTgzDQoNClNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhz
aWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE4My5kdHNpIHwgMTAgKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE4My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRz
aQ0KaW5kZXggNmNiYmQ3NzI2ZDM2Li45NTRiY2Q3NjZjOTcgMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQpAQCAtOSw2ICs5LDcgQEANCiAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmg+DQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2djZS9tdDgx
ODMtZ2NlLmg+DQogI2luY2x1ZGUgIm10ODE4My1waW5mdW5jLmgiDQogDQogLyB7DQpAQCAtMzM2
LDYgKzMzNywxNSBAQA0KIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQl9Ow0KIA0KKwkJZ2Nl
OiBtYWlsYm94QDEwMjM4MDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1n
Y2UiOw0KKwkJCXJlZyA9IDwwIDB4MTAyMzgwMDAgMCAweDQwMDA+Ow0KKwkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAxNjIgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQkjbWJveC1jZWxscyA9IDwz
PjsNCisJCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9HQ0U+Ow0KKwkJCWNsb2NrLW5h
bWVzID0gImdjZSI7DQorCQl9Ow0KKw0KIAkJdWFydDA6IHNlcmlhbEAxMTAwMjAwMCB7DQogCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtdWFydCIsDQogCQkJCSAgICAgIm1lZGlhdGVr
LG10NjU3Ny11YXJ0IjsNCi0tIA0KMi4xOC4wDQo=

