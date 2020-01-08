Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB681C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A194A2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rTQ5RrGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgAHBwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:40 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55418 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbgAHBwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:38 -0500
X-UUID: ad7f132509ad4135990c95d54a8d0823-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ftI9/CXYYeZK8CkETnDdr6DuAYoCT6uzVH5tO4lOoCo=;
        b=rTQ5RrGphlYAEksOK66ZbzFzkYDKDi3J6oXAfArJVh2lezPp18Bc1wvR2nvdoecEFgD8Y5XuzGPkRxUJ7oFTJpVyyPlgTbUR6EuV5a3n4QXDfaE2dy3TGR6a1iEQ0lViqSv8qV0HJOoK7/Zpkj2u0Kulahn1RBMaalbjeIsAUpI=;
X-UUID: ad7f132509ad4135990c95d54a8d0823-20200108
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1189719038; Wed, 08 Jan 2020 09:52:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:51:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 09/11] phy: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Wed, 8 Jan 2020 09:52:04 +0800
Message-ID: <1578448326-27455-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D56BD9CF87EF02FC9BE4F567128FB9BA7C3A1980633FF4F4E4127D6AFB5D67A52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHUzcGh5YV9yZWYgY2xvY2sgaXMgYWxyZWFkeSBtb3ZlZCBpbnRvIHN1Yi1ub2RlLCBhbmQN
CnJlbmFtZWQgYXMgcmVmIGNsb2NrLCBubyB1c2VkIGFueW1vcmUgbm93LCBzbyByZW1vdmUgaXQs
DQp0aGlzIGNhbiBhdm9pZCBjb25mdXNpb24gd2hlbiBzdXBwb3J0IG5ldyBwbGF0Zm9ybXMNCg0K
U2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0K
LS0tDQp2Mn52NTogbm8gY2hhbmdlcw0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10
ay10cGh5LmMgfCAxOCAtLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRw
aHkuYyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQppbmRleCA5NmM2MmUz
YTMzMDAuLmM2NDI0ZmQyYTA2ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstdHBoeS5jDQorKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0K
QEAgLTMxMiw4ICszMTIsNiBAQCBzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSB7DQogc3RydWN0IG10
a190cGh5IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAl2b2lkIF9faW9tZW0gKnNpZl9iYXNl
OwkvKiBvbmx5IHNoYXJlZCBzaWYgKi8NCi0JLyogZGVwcmVjYXRlZCwgdXNlIEByZWZfY2xrIGlu
c3RlYWQgaW4gcGh5IGluc3RhbmNlICovDQotCXN0cnVjdCBjbGsgKnUzcGh5YV9yZWY7CS8qIHJl
ZmVyZW5jZSBjbG9jayBvZiB1c2IzIGFub2xvZyBwaHkgKi8NCiAJY29uc3Qgc3RydWN0IG10a19w
aHlfcGRhdGEgKnBkYXRhOw0KIAlzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSAqKnBoeXM7DQogCWlu
dCBucGh5czsNCkBAIC05MjEsMTIgKzkxOSw2IEBAIHN0YXRpYyBpbnQgbXRrX3BoeV9pbml0KHN0
cnVjdCBwaHkgKnBoeSkNCiAJc3RydWN0IG10a190cGh5ICp0cGh5ID0gZGV2X2dldF9kcnZkYXRh
KHBoeS0+ZGV2LnBhcmVudCk7DQogCWludCByZXQ7DQogDQotCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZSh0cGh5LT51M3BoeWFfcmVmKTsNCi0JaWYgKHJldCkgew0KLQkJZGV2X2Vycih0cGh5LT5k
ZXYsICJmYWlsZWQgdG8gZW5hYmxlIHUzcGh5YV9yZWZcbiIpOw0KLQkJcmV0dXJuIHJldDsNCi0J
fQ0KLQ0KIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoaW5zdGFuY2UtPnJlZl9jbGspOw0KIAlp
ZiAocmV0KSB7DQogCQlkZXZfZXJyKHRwaHktPmRldiwgImZhaWxlZCB0byBlbmFibGUgcmVmX2Ns
a1xuIik7DQpAQCAtOTkyLDcgKzk4NCw2IEBAIHN0YXRpYyBpbnQgbXRrX3BoeV9leGl0KHN0cnVj
dCBwaHkgKnBoeSkNCiAJCXUyX3BoeV9pbnN0YW5jZV9leGl0KHRwaHksIGluc3RhbmNlKTsNCiAN
CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGluc3RhbmNlLT5yZWZfY2xrKTsNCi0JY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKHRwaHktPnUzcGh5YV9yZWYpOw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAt
MTEyNywxMSArMTExOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3RwaHlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCiAJCX0NCiAJfQ0KIA0KLQkvKiBpdCdzIGRlcHJlY2F0ZWQsIG1h
a2UgaXQgb3B0aW9uYWwgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgKi8NCi0JdHBoeS0+dTNw
aHlhX3JlZiA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJ1M3BoeWFfcmVmIik7DQotCWlm
IChJU19FUlIodHBoeS0+dTNwaHlhX3JlZikpDQotCQlyZXR1cm4gUFRSX0VSUih0cGh5LT51M3Bo
eWFfcmVmKTsNCi0NCiAJdHBoeS0+c3JjX3JlZl9jbGsgPSBVM1BfUkVGX0NMSzsNCiAJdHBoeS0+
c3JjX2NvZWYgPSBVM1BfU0xFV19SQVRFX0NPRUY7DQogCS8qIHVwZGF0ZSBwYXJhbWV0ZXJzIG9m
IHNsZXcgcmF0ZSBjYWxpYnJhdGUgaWYgZXhpc3QgKi8NCkBAIC0xMTc4LDEwICsxMTY0LDYgQEAg
c3RhdGljIGludCBtdGtfdHBoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IAkJcGh5X3NldF9kcnZkYXRhKHBoeSwgaW5zdGFuY2UpOw0KIAkJcG9ydCsrOw0KIA0KLQkJLyog
aWYgZGVwcmVjYXRlZCBjbG9jayBpcyBwcm92aWRlZCwgaWdub3JlIGluc3RhbmNlJ3Mgb25lICov
DQotCQlpZiAodHBoeS0+dTNwaHlhX3JlZikNCi0JCQljb250aW51ZTsNCi0NCiAJCWluc3RhbmNl
LT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwaHktPmRldiwgInJlZiIpOw0KIAkJ
aWYgKElTX0VSUihpbnN0YW5jZS0+cmVmX2NsaykpIHsNCiAJCQlkZXZfZXJyKGRldiwgImZhaWxl
ZCB0byBnZXQgcmVmX2NsayhpZC0lZClcbiIsIHBvcnQpOw0KLS0gDQoyLjI0LjANCg==

