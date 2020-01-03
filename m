Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664F7C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3942B22525
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CmeQoMzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgACDN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727506AbgACDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:55 -0500
X-UUID: 6fa65873473a4d7cb512313931cf8a06-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bItQ8dbHWeF2biFbRzZGiGcS7MlmRSJ9A2yrqLVmNC0=;
        b=CmeQoMzvAOvDr+twPwrzHS9BHQc5SIZ+ZHq0jd0qjnJPRw2V9xMMrio0mpq5ydz0CIjcgpVSisuwIwI7yk2i+OWm7NBuwN9lqUOa7edFDhgMtYWMsKwruf4IJsth7YMhyWFpf7ONz4biBHeoiKmtnteTcy2KMHbkwbRLynhevkM=;
X-UUID: 6fa65873473a4d7cb512313931cf8a06-20200103
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 545255735; Fri, 03 Jan 2020 11:12:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:16 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v6 14/17] drm/mediatek: add connection from DITHER0 to DSI0
Date:   Fri, 3 Jan 2020 11:12:25 +0800
Message-ID: <1578021148-32413-15-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIERJVEhFUjAgdG8gRFNJMA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXgg
NTY3NTBiYS4uODFkOTFmNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
Yw0KQEAgLTM1LDEwICszNSwxMiBAQA0KIA0KICNkZWZpbmUgTVQ4MTgzX0RJU1BfT1ZMMF8yTF9N
T1VUX0VOCQkweGYwNA0KICNkZWZpbmUgTVQ4MTgzX0RJU1BfT1ZMMV8yTF9NT1VUX0VOCQkweGYw
OA0KKyNkZWZpbmUgTVQ4MTgzX0RJU1BfRElUSEVSMF9NT1VUX0VOCQkweGYwYw0KICNkZWZpbmUg
TVQ4MTgzX0RJU1BfUEFUSDBfU0VMX0lOCQkweGYyNA0KIA0KICNkZWZpbmUgT1ZMMF8yTF9NT1VU
X0VOX0RJU1BfUEFUSDAJCQlCSVQoMCkNCiAjZGVmaW5lIE9WTDFfMkxfTU9VVF9FTl9SRE1BMQkJ
CQlCSVQoNCkNCisjZGVmaW5lIERJVEhFUjBfTU9VVF9JTl9EU0kwCQkJCUJJVCgwKQ0KICNkZWZp
bmUgRElTUF9QQVRIMF9TRUxfSU5fT1ZMMF8yTAkJCTB4MQ0KIA0KICNkZWZpbmUgTVQyNzAxX0RJ
U1BfTVVURVgwX01PRDAJCQkweDJjDQpAQCAtMzI0LDYgKzMyNiw5IEBAIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgbXRrX2RkcF9tb3V0X2VuKGNvbnN0IHN0cnVjdCBtdGtfbW1zeXNfcmVnX2RhdGEgKmRh
dGEsDQogCQkgICBuZXh0ID09IEREUF9DT01QT05FTlRfUkRNQTEpIHsNCiAJCSphZGRyID0gTVQ4
MTgzX0RJU1BfT1ZMMV8yTF9NT1VUX0VOOw0KIAkJdmFsdWUgPSBPVkwxXzJMX01PVVRfRU5fUkRN
QTE7DQorCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfRElUSEVSICYmIG5leHQgPT0g
RERQX0NPTVBPTkVOVF9EU0kwKSB7DQorCQkqYWRkciA9IE1UODE4M19ESVNQX0RJVEhFUjBfTU9V
VF9FTjsNCisJCXZhbHVlID0gRElUSEVSMF9NT1VUX0lOX0RTSTA7DQogCX0gZWxzZSB7DQogCQl2
YWx1ZSA9IDA7DQogCX0NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

