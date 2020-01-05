Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B3C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EEB20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cDtL/3Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAEKqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:65239 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgAEKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:40 -0500
X-UUID: 13e950359c334e42ae8f7cde7c4d863e-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lsBsohNu2b5AhB0kz+Ra/NLbhuyQup0UfX5XN+MeloA=;
        b=cDtL/3ExJBMG2+MyhZKPolD1cAFH/OefMQBiXlnItVvwDxc8SQ6EyT1ninqpUSLEDkYeJk5Qjil1eb6lXxg0U2jSak0w2ASQk77N9xe/dl629bnJ9kRAzhaQG45rVjmV+kTZBB6aCeKtcw3q1tbT9RRiBcSBG3RSCP7s3/fwHZE=;
X-UUID: 13e950359c334e42ae8f7cde7c4d863e-20200105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 682970604; Sun, 05 Jan 2020 18:46:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:10 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:05 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH v2 04/19] iommu/mediatek: Rename offset=0x48 register
Date:   Sun, 5 Jan 2020 18:45:08 +0800
Message-ID: <20200105104523.31006-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGRpZmZlcmVudCBwbGF0Zm9ybXMoZXg6bGF0ZXIgbXQ2Nzc5KSwgb2Zmc2V0PTB4NDggcmVn
aXN0ZXIgd2lsbA0KZXh0ZW5kIG1vcmUgZmVhdHVyZSBieSBkaWZmZXJlbnQgYml0cywgc28gd2Ug
Y2FuIHJlbmFtZSBSRUdfTU1VX01JU0NfQ1RSTC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8g
PGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCA4ICsrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQppbmRleCBmMmQ5NTNmYzA5ZGYuLmJmZmQ0MTdmNDQ0MiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCkBAIC00MSw3ICs0MSw3IEBADQogI2RlZmluZSBGX0lOVkxEX0VOMAkJCQlC
SVQoMCkNCiAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KIA0KLSNkZWZpbmUgUkVHX01N
VV9TVEFOREFSRF9BWElfTU9ERQkJMHgwNDgNCisjZGVmaW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJ
MHgwNDgNCiAjZGVmaW5lIFJFR19NTVVfRENNX0RJUwkJCQkweDA1MA0KIA0KICNkZWZpbmUgUkVH
X01NVV9DVFJMX1JFRwkJCTB4MTEwDQpAQCAtNTg3LDcgKzU4Nyw3IEBAIHN0YXRpYyBpbnQgbXRr
X2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KIAl3cml0
ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCiANCiAJaWYgKGRh
dGEtPnBsYXRfZGF0YS0+cmVzZXRfYXhpKQ0KLQkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFz
ZSArIFJFR19NTVVfU1RBTkRBUkRfQVhJX01PREUpOw0KKwkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0
YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCiANCiAJaWYgKGRldm1fcmVxdWVzdF9pcnEo
ZGF0YS0+ZGV2LCBkYXRhLT5pcnEsIG10a19pb21tdV9pc3IsIDAsDQogCQkJICAgICBkZXZfbmFt
ZShkYXRhLT5kZXYpLCAodm9pZCAqKWRhdGEpKSB7DQpAQCAtNzM1LDcgKzczNSw3IEBAIHN0YXRp
YyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBkYXRhLT5iYXNlOw0KIA0KIAlyZWctPnN0YW5kYXJk
X2F4aV9tb2RlID0gcmVhZGxfcmVsYXhlZChiYXNlICsNCi0JCQkJCSAgICAgICBSRUdfTU1VX1NU
QU5EQVJEX0FYSV9NT0RFKTsNCisJCQkJCSAgICAgICBSRUdfTU1VX01JU0NfQ1RSTCk7DQogCXJl
Zy0+ZGNtX2RpcyA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQogCXJl
Zy0+Y3RybF9yZWcgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0NUUkxfUkVHKTsNCiAJ
cmVnLT5pbnRfY29udHJvbDAgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0lOVF9DT05U
Uk9MMCk7DQpAQCAtNzYwLDcgKzc2MCw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRr
X2lvbW11X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQog
CXdyaXRlbF9yZWxheGVkKHJlZy0+c3RhbmRhcmRfYXhpX21vZGUsDQotCQkgICAgICAgYmFzZSAr
IFJFR19NTVVfU1RBTkRBUkRfQVhJX01PREUpOw0KKwkJICAgICAgIGJhc2UgKyBSRUdfTU1VX01J
U0NfQ1RSTCk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+ZGNtX2RpcywgYmFzZSArIFJFR19NTVVf
RENNX0RJUyk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+Y3RybF9yZWcsIGJhc2UgKyBSRUdfTU1V
X0NUUkxfUkVHKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pbnRfY29udHJvbDAsIGJhc2UgKyBS
RUdfTU1VX0lOVF9DT05UUk9MMCk7DQotLSANCjIuMTguMA0K

