Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B088C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A8E20721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XHXrEsGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLIGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:20:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26952 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbfLIGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:27 -0500
X-UUID: b0f516bf36a541aaa54f36a3f52b339b-20191209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oJ3nyvNQJTsh/vc7Bk6COSatobmBzCxtpcpC/pj/BJk=;
        b=XHXrEsGDeabcwIYgJgCLXSmnM5XsV2wJGKNk7wuM05H++guS+zAKMEla/v0geP33m3w60XwHyoSdP2GhoMzq2kbgH0fE64ie/isHtvLuihgp6kIOejid04Xhk94poYKZLyMarKDg/gP8HyvM3Df+V29ooY1X90flWhW8msS3p7E=;
X-UUID: b0f516bf36a541aaa54f36a3f52b339b-20191209
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 598845321; Mon, 09 Dec 2019 14:20:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Dec 2019 14:20:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Dec 2019 14:20:11 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add binding for MT6779 SMI
Date:   Mon, 9 Dec 2019 14:19:30 +0800
Message-ID: <1575872371-671-3-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGVzY3JpcHRpb24gZm9yIE1UNjc3OSBTTUkuDQoNClNpZ25lZC1vZmYt
Ynk6IE1pbmctRmFuIENoZW4gPG1pbmctZmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgICA1ICsr
Ky0tDQogLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgICAgICAg
fCAgICAzICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1v
bi50eHQNCmluZGV4IGI0NzhhZGUuLmI2NDU3MzYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21t
b24udHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNv
bnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQpAQCAtNSw3ICs1LDcgQEAgVGhlIGhh
cmR3YXJlIGJsb2NrIGRpYWdyYW0gcGxlYXNlIGNoZWNrIGJpbmRpbmdzL2lvbW11L21lZGlhdGVr
LGlvbW11LnR4dA0KIE1lZGlhdGVrIFNNSSBoYXZlIHR3byBnZW5lcmF0aW9ucyBvZiBIVyBhcmNo
aXRlY3R1cmUsIGhlcmUgaXMgdGhlIGxpc3QNCiB3aGljaCBnZW5lcmF0aW9uIHRoZSBTb0NzIHVz
ZToNCiBnZW5lcmF0aW9uIDE6IG10MjcwMSBhbmQgbXQ3NjIzLg0KLWdlbmVyYXRpb24gMjogbXQy
NzEyLCBtdDgxNzMgYW5kIG10ODE4My4NCitnZW5lcmF0aW9uIDI6IG10MjcxMiwgbXQ2Nzc5LCBt
dDgxNzMgYW5kIG10ODE4My4NCiANCiBUaGVyZSdzIHNsaWdodCBkaWZmZXJlbmNlcyBiZXR3ZWVu
IHRoZSB0d28gU01JLCBmb3IgZ2VuZXJhdGlvbiAyLCB0aGUNCiByZWdpc3RlciB3aGljaCBjb250
cm9sIHRoZSBpb21tdSBwb3J0IGlzIGF0IGVhY2ggbGFyYidzIHJlZ2lzdGVyIGJhc2UuIEJ1dA0K
QEAgLTE4LDYgKzE4LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGUgOiBt
dXN0IGJlIG9uZSBvZiA6DQogCSJtZWRpYXRlayxtdDI3MDEtc21pLWNvbW1vbiINCiAJIm1lZGlh
dGVrLG10MjcxMi1zbWktY29tbW9uIg0KKwkibWVkaWF0ZWssbXQ2Nzc5LXNtaS1jb21tb24iDQog
CSJtZWRpYXRlayxtdDc2MjMtc21pLWNvbW1vbiIsICJtZWRpYXRlayxtdDI3MDEtc21pLWNvbW1v
biINCiAJIm1lZGlhdGVrLG10ODE3My1zbWktY29tbW9uIg0KIAkibWVkaWF0ZWssbXQ4MTgzLXNt
aS1jb21tb24iDQpAQCAtMzUsNyArMzYsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KICAgYW5k
IHRoZXNlIDIgb3B0aW9uIGNsb2NrcyBmb3IgZ2VuZXJhdGlvbiAyIHNtaSBIVzoNCiAgIC0gImdh
bHMwIjogdGhlIHBhdGgwIGNsb2NrIG9mIEdBTFMoR2xvYmFsIEFzeW5jIExvY2FsIFN5bmMpLg0K
ICAgLSAiZ2FsczEiOiB0aGUgcGF0aDEgY2xvY2sgb2YgR0FMUyhHbG9iYWwgQXN5bmMgTG9jYWwg
U3luYykuDQotICBIZXJlIGlzIHRoZSBsaXN0IHdoaWNoIGhhcyB0aGlzIEdBTFM6IG10ODE4My4N
CisgIEhlcmUgaXMgdGhlIGxpc3Qgd2hpY2ggaGFzIHRoaXMgR0FMUzogbXQ2Nzc5IGFuZCBtdDgx
ODMuDQogDQogRXhhbXBsZToNCiAJc21pX2NvbW1vbjogc21pQDE0MDIyMDAwIHsNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1sYXJiLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIudHh0DQppbmRleCA0YjM2OWIz
Li44ZjE5ZGZlIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQNCisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21p
LWxhcmIudHh0DQpAQCAtNiw2ICs2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBh
dGlibGUgOiBtdXN0IGJlIG9uZSBvZiA6DQogCQkibWVkaWF0ZWssbXQyNzAxLXNtaS1sYXJiIg0K
IAkJIm1lZGlhdGVrLG10MjcxMi1zbWktbGFyYiINCisJCSJtZWRpYXRlayxtdDY3Nzktc21pLWxh
cmIiDQogCQkibWVkaWF0ZWssbXQ3NjIzLXNtaS1sYXJiIiwgIm1lZGlhdGVrLG10MjcwMS1zbWkt
bGFyYiINCiAJCSJtZWRpYXRlayxtdDgxNzMtc21pLWxhcmIiDQogCQkibWVkaWF0ZWssbXQ4MTgz
LXNtaS1sYXJiIg0KQEAgLTIxLDcgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAgIC0g
ImdhbHMiOiB0aGUgY2xvY2sgZm9yIEdBTFMoR2xvYmFsIEFzeW5jIExvY2FsIFN5bmMpLg0KICAg
SGVyZSBpcyB0aGUgbGlzdCB3aGljaCBoYXMgdGhpcyBHQUxTOiBtdDgxODMuDQogDQotUmVxdWly
ZWQgcHJvcGVydHkgZm9yIG10MjcwMSwgbXQyNzEyIGFuZCBtdDc2MjM6DQorUmVxdWlyZWQgcHJv
cGVydHkgZm9yIG10MjcwMSwgbXQyNzEyLCBtdDY3NzkgYW5kIG10NzYyMzoNCiAtIG1lZGlhdGVr
LGxhcmItaWQgOnRoZSBoYXJkd2FyZSBpZCBvZiB0aGlzIGxhcmIuDQogDQogRXhhbXBsZToNCi0t
IA0KMS43LjkuNQ0K

