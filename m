Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D5C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5693F20869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A54W2jFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0B7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727196AbfK0B7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:21 -0500
X-UUID: d91b3529f38844a18f3ac8a81248834b-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RrZazA43e2Z9PGlJIxFPVpoyYcWFhstD3J9zvrXKVEs=;
        b=A54W2jFnRTHI3KYpjhrOb5/s/0/S0wKx2HTqb1DC487QMr8Pw9f16Mb0o06BqB7Z1g03dFFhI6UVS5kVG9xiMh12GjS9nx4UFQyS48uu8DSUo9+oZI6OUAyk2JHUKRF9yr1F9w2iF8EGwVJ6slTqJ11ZAEy1RNxxxmB+zw8KsWs=;
X-UUID: d91b3529f38844a18f3ac8a81248834b-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 514073050; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:18 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 03/14] mailbox: cmdq: support mt6779 gce platform definition
Date:   Wed, 27 Nov 2019 09:58:46 +0800
Message-ID: <1574819937-6246-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGdjZSB2NCBoYXJkd2FyZSBzdXBwb3J0IHdpdGggZGlmZmVyZW50IHRocmVhZCBudW1iZXIg
YW5kIHNoaWZ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5o
c2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jDQppbmRleCBkNTUzNjU2M2ZjZTEuLmZkNTE5YjZmNTE4YiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCkBAIC01NzIsMTAgKzU3MiwxMiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgY21kcV9wbV9vcHMgPSB7DQogDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92MiA9IHsudGhyZWFkX25yID0gMTYsIC5zaGlm
dCA9IDB9Ow0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjMgPSB7LnRo
cmVhZF9uciA9IDI0LCAuc2hpZnQgPSAwfTsNCitzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0
IGdjZV9wbGF0X3Y0ID0gey50aHJlYWRfbnIgPSAyNCwgLnNoaWZ0ID0gM307DQogDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY21kcV9vZl9pZHNbXSA9IHsNCiAJey5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3Yy
fSwNCiAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1nY2UiLCAuZGF0YSA9ICh2b2lk
ICopJmdjZV9wbGF0X3YzfSwNCisJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1nY2Ui
LCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3Y0fSwNCiAJe30NCiB9Ow0KIA0KLS0gDQoyLjE4
LjANCg==

