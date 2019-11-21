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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99808208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="htVGd3Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKUJOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:14:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726735AbfKUJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:34 -0500
X-UUID: 3aa27ec748014912bf920db9c19455a8-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1mQGb3NQ/giBICy3QiwXzkrXF+db9XVwxMXjZ6LzmMw=;
        b=htVGd3Dh1LX147cEvwWkwAawcSrr1m5623I7iU3j5DLqagifsZaa2i5TzlCuej93Z0ZCW/HDBAPnDK6hHf5W8zhH9q0JDtb4Ab8d9hWHC8grauDUE1IvI0J00ChZfovnlGQoYcCi1owiFUSWS1wrvnslHZy5STW9A2/r3BntXG4=;
X-UUID: 3aa27ec748014912bf920db9c19455a8-20191121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1268957182; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:29 +0800
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
Subject: [PATCH v1 03/12] mailbox: cmdq: support mt6779 gce platform definition
Date:   Thu, 21 Nov 2019 17:12:23 +0800
Message-ID: <1574327552-11806-4-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
eC5jIHwgICAgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jDQppbmRleCBkNTUzNjU2Li5mZDUxOWI2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KQEAgLTU3MiwxMCArNTcyLDEyIEBAIHN0YXRpYyBpbnQg
Y21kcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjIgPSB7LnRocmVhZF9uciA9IDE2LCAuc2hpZnQg
PSAwfTsNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3YzID0gey50aHJl
YWRfbnIgPSAyNCwgLnNoaWZ0ID0gMH07DQorc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBn
Y2VfcGxhdF92NCA9IHsudGhyZWFkX25yID0gMjQsIC5zaGlmdCA9IDN9Ow0KIA0KIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10gPSB7DQogCXsuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxNzMtZ2NlIiwgLmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92Mn0s
DQogCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZ2NlIiwgLmRhdGEgPSAodm9pZCAq
KSZnY2VfcGxhdF92M30sDQorCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktZ2NlIiwg
LmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92NH0sDQogCXt9DQogfTsNCiANCi0tIA0KMS43Ljku
NQ0K

