Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723DBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB372071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lOgT7J/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKUJNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727031AbfKUJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:36 -0500
X-UUID: f3939e8f201a48d0976a3dd1a459161a-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M0/jFbrUiFwtCpckhKu99j+5mZTWrtHEB9VPejkugS8=;
        b=lOgT7J/pILDMsGeQSDIE3dNm699gcjTAH4Nts/fSIZ/nRrmieQkFg2l4qtMTaNMSsLgjakW6mIQuEqbzuKtE8vPBP48w2/20eCQnS60ObYLkqqNCWEwp2+YtHx5r6jnWwSe7Xk5bvARuRfEzyUQ8lMXjGoWbQ/SurW4AbKweHgw=;
X-UUID: f3939e8f201a48d0976a3dd1a459161a-20191121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2085495678; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:06 +0800
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
Subject: [PATCH v1 05/12] arm64: dts: add gce node for mt6779
Date:   Thu, 21 Nov 2019 17:12:25 +0800
Message-ID: <1574327552-11806-6-git-send-email-dennis-yc.hsieh@mediatek.com>
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

YWRkIGdjZSBkZXZpY2Ugbm9kZSBmb3IgbXQ2Nzc5DQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZ
QyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgfCAgIDEwICsrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ2Nzc5LmR0c2kNCmluZGV4IGRhYTI1YjcuLjEwZDU5MzggMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Njc3OS5kdHNpDQpAQCAtOCw2ICs4LDcgQEANCiAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svbXQ2Nzc5LWNsay5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5
LWdjZS5oPg0KIA0KIC8gew0KIAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OSI7DQpAQCAt
MTU5LDYgKzE2MCwxNSBAQA0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCiAJCX07DQogDQorCQln
Y2U6IG1haWxib3hAMTAyMjgwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5
LWdjZSI7DQorCQkJcmVnID0gPDAgMHgxMDIyODAwMCAwIDB4NDAwMD47DQorCQkJaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDE4NSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCSNtYm94LWNlbGxzID0g
PDM+Ow0KKwkJCWNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0dDRT47DQorCQkJY2xv
Y2stbmFtZXMgPSAiZ2NlIjsNCisJCX07DQorDQogCQl1YXJ0MDogc2VyaWFsQDExMDAyMDAwIHsN
CiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS11YXJ0IiwNCiAJCQkJICAgICAibWVk
aWF0ZWssbXQ2NTc3LXVhcnQiOw0KLS0gDQoxLjcuOS41DQo=

