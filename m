Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D64FC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3C2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PzyU2hwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAHGli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:41:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55915 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbgAHGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:41:38 -0500
X-UUID: 782283684d934d6fab6233754bd171f2-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xgNVawMicDpvGvOC8oJR2aOtTAfe55SaH1croKlcdI4=;
        b=PzyU2hwUI2Unz0yp2NpcpDCZRhZ1ZU6yaaFwZG9RoGMaUCNKpwe2+7EYU0P5zJVZi5E0Nt5NwLD7GoZdDurapq2Yycj6ncobVhZXvdd29aCRXmtkprtBOtcUDRzMVKn4rX/xjRUHwlPtv7X+3pkTfn9XCI7f2exUHl/kJJS0+a4=;
X-UUID: 782283684d934d6fab6233754bd171f2-20200108
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 84154412; Wed, 08 Jan 2020 14:41:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 14:42:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 14:39:59 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 1/3] dt-bindings: mediatek: Add binding for MT6779 SMI
Date:   Wed, 8 Jan 2020 14:41:29 +0800
Message-ID: <1578465691-30692-3-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24gZm9yIE1UNjc3OSBTTUkuDQpUaGVyZSBhcmUgR0FM
UyBpbiBzbWktbGFyYiBidXQgd2l0aG91dCBjbG9jayBvZiBHQUxTIGFsb25lLg0KDQpjaGFuZ2Vs
b2cgc2luY2UgdjI6DQpBZGQgR0FMUyBmb3IgbXQ2Nzc5IGluIHNtaS1jb21tb24udHh0DQoNClNp
Z25lZC1vZmYtYnk6IE1pbmctRmFuIENoZW4gPG1pbmctZmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0K
LS0tDQogLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAg
fCAgICA1ICsrKy0tDQogLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50
eHQgICAgICAgfCAgICAzICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWss
c21pLWNvbW1vbi50eHQNCmluZGV4IGI0NzhhZGUuLmI2NDU3MzYgMTAwNjQ0DQotLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVr
LHNtaS1jb21tb24udHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQpAQCAtNSw3ICs1LDcg
QEAgVGhlIGhhcmR3YXJlIGJsb2NrIGRpYWdyYW0gcGxlYXNlIGNoZWNrIGJpbmRpbmdzL2lvbW11
L21lZGlhdGVrLGlvbW11LnR4dA0KIE1lZGlhdGVrIFNNSSBoYXZlIHR3byBnZW5lcmF0aW9ucyBv
ZiBIVyBhcmNoaXRlY3R1cmUsIGhlcmUgaXMgdGhlIGxpc3QNCiB3aGljaCBnZW5lcmF0aW9uIHRo
ZSBTb0NzIHVzZToNCiBnZW5lcmF0aW9uIDE6IG10MjcwMSBhbmQgbXQ3NjIzLg0KLWdlbmVyYXRp
b24gMjogbXQyNzEyLCBtdDgxNzMgYW5kIG10ODE4My4NCitnZW5lcmF0aW9uIDI6IG10MjcxMiwg
bXQ2Nzc5LCBtdDgxNzMgYW5kIG10ODE4My4NCiANCiBUaGVyZSdzIHNsaWdodCBkaWZmZXJlbmNl
cyBiZXR3ZWVuIHRoZSB0d28gU01JLCBmb3IgZ2VuZXJhdGlvbiAyLCB0aGUNCiByZWdpc3RlciB3
aGljaCBjb250cm9sIHRoZSBpb21tdSBwb3J0IGlzIGF0IGVhY2ggbGFyYidzIHJlZ2lzdGVyIGJh
c2UuIEJ1dA0KQEAgLTE4LDYgKzE4LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBh
dGlibGUgOiBtdXN0IGJlIG9uZSBvZiA6DQogCSJtZWRpYXRlayxtdDI3MDEtc21pLWNvbW1vbiIN
CiAJIm1lZGlhdGVrLG10MjcxMi1zbWktY29tbW9uIg0KKwkibWVkaWF0ZWssbXQ2Nzc5LXNtaS1j
b21tb24iDQogCSJtZWRpYXRlayxtdDc2MjMtc21pLWNvbW1vbiIsICJtZWRpYXRlayxtdDI3MDEt
c21pLWNvbW1vbiINCiAJIm1lZGlhdGVrLG10ODE3My1zbWktY29tbW9uIg0KIAkibWVkaWF0ZWss
bXQ4MTgzLXNtaS1jb21tb24iDQpAQCAtMzUsNyArMzYsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KICAgYW5kIHRoZXNlIDIgb3B0aW9uIGNsb2NrcyBmb3IgZ2VuZXJhdGlvbiAyIHNtaSBIVzoN
CiAgIC0gImdhbHMwIjogdGhlIHBhdGgwIGNsb2NrIG9mIEdBTFMoR2xvYmFsIEFzeW5jIExvY2Fs
IFN5bmMpLg0KICAgLSAiZ2FsczEiOiB0aGUgcGF0aDEgY2xvY2sgb2YgR0FMUyhHbG9iYWwgQXN5
bmMgTG9jYWwgU3luYykuDQotICBIZXJlIGlzIHRoZSBsaXN0IHdoaWNoIGhhcyB0aGlzIEdBTFM6
IG10ODE4My4NCisgIEhlcmUgaXMgdGhlIGxpc3Qgd2hpY2ggaGFzIHRoaXMgR0FMUzogbXQ2Nzc5
IGFuZCBtdDgxODMuDQogDQogRXhhbXBsZToNCiAJc21pX2NvbW1vbjogc21pQDE0MDIyMDAwIHsN
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNv
bnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIudHh0DQppbmRl
eCA0YjM2OWIzLi44ZjE5ZGZlIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQNCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVk
aWF0ZWssc21pLWxhcmIudHh0DQpAQCAtNiw2ICs2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
CiAtIGNvbXBhdGlibGUgOiBtdXN0IGJlIG9uZSBvZiA6DQogCQkibWVkaWF0ZWssbXQyNzAxLXNt
aS1sYXJiIg0KIAkJIm1lZGlhdGVrLG10MjcxMi1zbWktbGFyYiINCisJCSJtZWRpYXRlayxtdDY3
Nzktc21pLWxhcmIiDQogCQkibWVkaWF0ZWssbXQ3NjIzLXNtaS1sYXJiIiwgIm1lZGlhdGVrLG10
MjcwMS1zbWktbGFyYiINCiAJCSJtZWRpYXRlayxtdDgxNzMtc21pLWxhcmIiDQogCQkibWVkaWF0
ZWssbXQ4MTgzLXNtaS1sYXJiIg0KQEAgLTIxLDcgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGll
czoNCiAgIC0gImdhbHMiOiB0aGUgY2xvY2sgZm9yIEdBTFMoR2xvYmFsIEFzeW5jIExvY2FsIFN5
bmMpLg0KICAgSGVyZSBpcyB0aGUgbGlzdCB3aGljaCBoYXMgdGhpcyBHQUxTOiBtdDgxODMuDQog
DQotUmVxdWlyZWQgcHJvcGVydHkgZm9yIG10MjcwMSwgbXQyNzEyIGFuZCBtdDc2MjM6DQorUmVx
dWlyZWQgcHJvcGVydHkgZm9yIG10MjcwMSwgbXQyNzEyLCBtdDY3NzkgYW5kIG10NzYyMzoNCiAt
IG1lZGlhdGVrLGxhcmItaWQgOnRoZSBoYXJkd2FyZSBpZCBvZiB0aGlzIGxhcmIuDQogDQogRXhh
bXBsZToNCi0tIA0KMS43LjkuNQ0K

