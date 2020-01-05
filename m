Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E4C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D5E2467D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GC2QuZEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgAEQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 11:21:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726212AbgAEQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 11:21:58 -0500
X-UUID: 1c4584dc076e48ba9fe56e4ce46a89de-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MzAzWbVEUq48P3SOZR+RXx8/tm9pMvJf+JHH3AnJI74=;
        b=GC2QuZEpl6mxXTsYrsmFPIC252dkMGDfS6EGrTc3yWUAuHzsH88eml2TcnHytuG2hN1lbtGMF7j2HCY4TKZb1lmLvqjzL2jN4PrVLXrx+LqWZ/EEPwY6QhBfxdeSuo3ctDGDEkj+96Dy/PqzzQ9yslIoWw3rvRy/t5aK3aSaBVM=;
X-UUID: 1c4584dc076e48ba9fe56e4ce46a89de-20200106
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1812103755; Mon, 06 Jan 2020 00:21:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 6 Jan 2020 00:21:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 00:20:51 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <yong.liang@mediatek.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <p.zabel@pengutronix.de>,
        <matthias.bgg@gmail.com>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <chang-an.chen@mediatek.com>, <freddy.hsin@mediatek.com>
CC:     <yingjoe.chen@mediatek.com>, <sboyd@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v9 1/2] dt-bindings: mediatek: mt8183: Add #reset-cells
Date:   Mon, 6 Jan 2020 00:21:40 +0800
Message-ID: <1578241301-14618-2-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578241301-14618-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1578241301-14618-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICNyZXNldC1jZWxscyBwcm9wZXJ0eSBhbmQgdXBkYXRlIGV4YW1wbGUNCg0KU2lnbmVkLW9m
Zi1ieTogeW9uZy5saWFuZyA8eW9uZy5saWFuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBKaWF4aW4gWXUgPGppYXhpbi55dUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogWWluZ2pv
ZSBDaGVuIDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHAg
WmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQotLS0NCiAuLi4vcmVzZXQtY29udHJvbGxl
ci9tdDI3MTItcmVzZXRzLmggICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrDQogLi4u
L3Jlc2V0LWNvbnRyb2xsZXIvbXQ4MTgzLXJlc2V0cy5oICAgICAgICAgIHwgMTcgKysrKysrKysr
KysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC1jb250cm9sbGVyL210MjcxMi1yZXNldHMu
aA0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC1jb250cm9sbGVyL210
MjcxMi1yZXNldHMuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQtY29udHJvbGxlci9tdDI3
MTItcmVzZXRzLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLjll
N2VlNzYyZjA3Ng0KLS0tIC9kZXYvbnVsbA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNl
dC1jb250cm9sbGVyL210MjcxMi1yZXNldHMuaA0KQEAgLTAsMCArMSwyMiBAQA0KKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQorLyoNCisgKiBDb3B5cmlnaHQgKGMpIDIw
MTkgTWVkaWFUZWsgSW5jLg0KKyAqIEF1dGhvcjogWW9uZyBMaWFuZyA8eW9uZy5saWFuZ0BtZWRp
YXRlay5jb20+DQorICovDQorDQorI2lmbmRlZiBfRFRfQklORElOR1NfUkVTRVRfQ09OVFJPTExF
Ul9NVDI3MTINCisjZGVmaW5lIF9EVF9CSU5ESU5HU19SRVNFVF9DT05UUk9MTEVSX01UMjcxMg0K
Kw0KKyNkZWZpbmUgTVQyNzEyX1RPUFJHVV9JTkZSQV9TV19SU1QJCQkJMA0KKyNkZWZpbmUgTVQy
NzEyX1RPUFJHVV9NTV9TV19SU1QJCQkJCTENCisjZGVmaW5lIE1UMjcxMl9UT1BSR1VfTUZHX1NX
X1JTVAkJCQkyDQorI2RlZmluZSBNVDI3MTJfVE9QUkdVX1ZFTkNfU1dfUlNUCQkJCTMNCisjZGVm
aW5lIE1UMjcxMl9UT1BSR1VfVkRFQ19TV19SU1QJCQkJNA0KKyNkZWZpbmUgTVQyNzEyX1RPUFJH
VV9JTUdfU1dfUlNUCQkJCTUNCisjZGVmaW5lIE1UMjcxMl9UT1BSR1VfSU5GUkFfQU9fU1dfUlNU
CQkJCTgNCisjZGVmaW5lIE1UMjcxMl9UT1BSR1VfVVNCX1NXX1JTVAkJCQk5DQorI2RlZmluZSBN
VDI3MTJfVE9QUkdVX0FQTUlYRURfU1dfUlNUCQkJCTEwDQorDQorI2RlZmluZSBNVDI3MTJfVE9Q
UkdVX1NXX1JTVF9OVU0JCQkJMTENCisNCisjZW5kaWYgIC8qIF9EVF9CSU5ESU5HU19SRVNFVF9D
T05UUk9MTEVSX01UMjcxMiAqLw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVz
ZXQtY29udHJvbGxlci9tdDgxODMtcmVzZXRzLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0
LWNvbnRyb2xsZXIvbXQ4MTgzLXJlc2V0cy5oDQppbmRleCA4ODA0ZTM0ZWJkZDQuLmExYmJkNDFl
MGQxMiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQtY29udHJvbGxlci9t
dDgxODMtcmVzZXRzLmgNCisrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQtY29udHJvbGxl
ci9tdDgxODMtcmVzZXRzLmgNCkBAIC03OCw0ICs3OCwyMSBAQA0KICNkZWZpbmUgTVQ4MTgzX0lO
RlJBQ0ZHX0FPX0kyQzdfU1dfUlNUCQkJCTEyNg0KICNkZWZpbmUgTVQ4MTgzX0lORlJBQ0ZHX0FP
X0kyQzhfU1dfUlNUCQkJCTEyNw0KIA0KKyNkZWZpbmUgTVQ4MTgzX0lORlJBQ0ZHX1NXX1JTVF9O
VU0JCQkJMTI4DQorDQorI2RlZmluZSBNVDgxODNfVE9QUkdVX01NX1NXX1JTVAkJCQkJMQ0KKyNk
ZWZpbmUgTVQ4MTgzX1RPUFJHVV9NRkdfU1dfUlNUCQkJCTINCisjZGVmaW5lIE1UODE4M19UT1BS
R1VfVkVOQ19TV19SU1QJCQkJMw0KKyNkZWZpbmUgTVQ4MTgzX1RPUFJHVV9WREVDX1NXX1JTVAkJ
CQk0DQorI2RlZmluZSBNVDgxODNfVE9QUkdVX0lNR19TV19SU1QJCQkJNQ0KKyNkZWZpbmUgTVQ4
MTgzX1RPUFJHVV9NRF9TV19SU1QJCQkJCTcNCisjZGVmaW5lIE1UODE4M19UT1BSR1VfQ09OTl9T
V19SU1QJCQkJOQ0KKyNkZWZpbmUgTVQ4MTgzX1RPUFJHVV9DT05OX01DVV9TV19SU1QJCQkJMTIN
CisjZGVmaW5lIE1UODE4M19UT1BSR1VfSVBVMF9TV19SU1QJCQkJMTQNCisjZGVmaW5lIE1UODE4
M19UT1BSR1VfSVBVMV9TV19SU1QJCQkJMTUNCisjZGVmaW5lIE1UODE4M19UT1BSR1VfQVVESU9f
U1dfUlNUCQkJCTE3DQorI2RlZmluZSBNVDgxODNfVE9QUkdVX0NBTVNZU19TV19SU1QJCQkJMTgN
CisNCisjZGVmaW5lIE1UODE4M19UT1BSR1VfU1dfUlNUX05VTQkJCQkxOQ0KKw0KICNlbmRpZiAg
LyogX0RUX0JJTkRJTkdTX1JFU0VUX0NPTlRST0xMRVJfTVQ4MTgzICovDQotLSANCjIuMTguMA0K

