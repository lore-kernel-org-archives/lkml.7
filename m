Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E2624672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d6DjRiuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLRIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:13541 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbfLRIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:08 -0500
X-UUID: 3cc03da1b62243c8a91d3e0e6cd7a919-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=k477Yin3YYJsBHpEx1LJG/SeYRoLXIpqmsdtWHjiaaQ=;
        b=d6DjRiukSQROsNcrxpJMxZgrzxpGr5LpZxH5MFYuYPZHa8FE2ldagqjvIzLn0VZeqDs6sUo/plHltXgZmPSKxQc5AWDmXHuvLRSGo6+lruzUBeg4YSlVn8sSkgy7WZ7Wt9bNy9N7F3HqukWtgwzT2BoaMNWcuToGQMmlm2nI/k4=;
X-UUID: 3cc03da1b62243c8a91d3e0e6cd7a919-20191218
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 993556298; Wed, 18 Dec 2019 16:31:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:30:30 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v10 12/12] arm64: dts: Add power-domains properity to mfgcfg
Date:   Wed, 18 Dec 2019 16:30:48 +0800
Message-ID: <1576657848-14711-13-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 22B653AA39A49EDABF3D3E51A972D91CB27FBC86D0294B64370C67F47B81A3532000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWZnY2ZnIGNsb2NrIGlzIHVuZGVyIE1GR19BU1lOQyBwb3dlciBkb21haW4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQpp
bmRleCA5MTIxN2U0Zi4uNDAxNDVkYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLmR0c2kNCkBAIC02NDMsNiArNjQzLDcgQEANCiAJCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4My1tZmdjZmciLCAic3lzY29uIjsNCiAJCQlyZWcgPSA8MCAweDEzMDAwMDAwIDAg
MHgxMDAwPjsNCiAJCQkjY2xvY2stY2VsbHMgPSA8MT47DQorCQkJcG93ZXItZG9tYWlucyA9IDwm
c2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0FTWU5DPjsNCiAJCX07DQogDQogCQltbXN5
czogc3lzY29uQDE0MDAwMDAwIHsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

