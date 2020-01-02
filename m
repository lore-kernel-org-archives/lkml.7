Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC31C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AACC20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hb85hflm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgABECY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:22585 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727526AbgABECV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:21 -0500
X-UUID: 856de58812ad4402a162c14f81fdd22f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y+wnhftACJUbMqxqcT6o9ZJKyh318rnGWmRv6biQamY=;
        b=hb85hflm5NBoevuL6pQomkks4Ush40qDzlexG42iIG4W+5nDgGu+5tec8dZuI1b3rVoHGcmWSUDznCKnt8GsLfSjf2NsclV0evZuknF5L6Dmibv6rqya4ULesUdKggZMv3/eIBHKdqZ8cbnCTpylLOWuxJ3ZlvkfFVIkpLTYyvw=;
X-UUID: 856de58812ad4402a162c14f81fdd22f-20200102
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1092311655; Thu, 02 Jan 2020 12:02:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:33 +0800
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
Subject: [PATCH v6, 01/14] arm64: dts: add display nodes for mt8183
Date:   Thu, 2 Jan 2020 12:00:11 +0800
Message-ID: <1577937624-14313-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDEwMyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggOTEyMTdlNGYuLmRl
MWVhMDAgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5k
dHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQpAQCAt
MzAsNiArMzAsMTEgQEANCiAJCWkyYzkgPSAmaTJjOTsNCiAJCWkyYzEwID0gJmkyYzEwOw0KIAkJ
aTJjMTEgPSAmaTJjMTE7DQorCQlvdmwwID0gJm92bDA7DQorCQlvdmxfMmwwID0gJm92bF8ybDA7
DQorCQlvdmxfMmwxID0gJm92bF8ybDE7DQorCQlyZG1hMCA9ICZyZG1hMDsNCisJCXJkbWExID0g
JnJkbWExOw0KIAl9Ow0KIA0KIAljcHVzIHsNCkBAIC02NDgsOSArNjUzLDEwNyBAQA0KIAkJbW1z
eXM6IHN5c2NvbkAxNDAwMDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
bW1zeXMiLCAic3lzY29uIjsNCiAJCQlyZWcgPSA8MCAweDE0MDAwMDAwIDAgMHgxMDAwPjsNCisJ
CQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCiAJ
CQkjY2xvY2stY2VsbHMgPSA8MT47DQogCQl9Ow0KIA0KKwkJb3ZsMDogb3ZsQDE0MDA4MDAwIHsN
CisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLW92bCI7DQorCQkJcmVnID0g
PDAgMHgxNDAwODAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyNSBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNf
UE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfT1ZM
MD47DQorCQkJbWVkaWF0ZWssbGFyYiA9IDwmbGFyYjA+Ow0KKwkJfTsNCisNCisJCW92bF8ybDA6
IG92bEAxNDAwOTAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1v
dmwtMmwiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMDkwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAyMjYgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dlci1kb21haW5z
ID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJCQljbG9ja3MgPSA8Jm1t
c3lzIENMS19NTV9ESVNQX09WTDBfMkw+Ow0KKwkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIwPjsN
CisJCX07DQorDQorCQlvdmxfMmwxOiBvdmxAMTQwMGEwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsLTJsIjsNCisJCQlyZWcgPSA8MCAweDE0MDBhMDAwIDAg
MHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI3IElSUV9UWVBFX0xFVkVMX0xP
Vz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElT
UD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PVkwxXzJMPjsNCisJCQltZWRp
YXRlayxsYXJiID0gPCZsYXJiMD47DQorCQl9Ow0KKw0KKwkJcmRtYTA6IHJkbWFAMTQwMGIwMDAg
ew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtcmRtYSI7DQorCQkJcmVn
ID0gPDAgMHgxNDAwYjAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIy
OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgx
ODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1Bf
UkRNQTA+Ow0KKwkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIwPjsNCisJCQltZWRpYXRlayxyZG1h
X2ZpZm9fc2l6ZSA9IDw1PjsNCisJCX07DQorDQorCQlyZG1hMTogcmRtYUAxNDAwYzAwMCB7DQor
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1yZG1hMSI7DQorCQkJcmVnID0g
PDAgMHgxNDAwYzAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOSBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNf
UE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfUkRN
QTE+Ow0KKwkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIwPjsNCisJCQltZWRpYXRlayxyZG1hX2Zp
Zm9fc2l6ZSA9IDwyPjsNCisJCX07DQorDQorCQljb2xvcjA6IGNvbG9yQDE0MDBlMDAwIHsNCisJ
CQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLWNvbG9yIiwNCisJCQkJICAgICAi
bWVkaWF0ZWssbXQ4MTczLWRpc3AtY29sb3IiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMGUwMDAgMCAw
eDEwMDA+Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMzEgSVJRX1RZUEVfTEVWRUxfTE9X
PjsNCisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQ
PjsNCisJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX0NPTE9SMD47DQorCQl9Ow0KKw0K
KwkJY2NvcnIwOiBjY29yckAxNDAwZjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODMtZGlzcC1jY29yciI7DQorCQkJcmVnID0gPDAgMHgxNDAwZjAwMCAwIDB4MTAwMD47DQor
CQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIzMiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBv
d2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNs
b2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfQ0NPUlIwPjsNCisJCX07DQorDQorCQlhYWwwOiBh
YWxAMTQwMTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtYWFs
IiwNCisJCQkJICAgICAibWVkaWF0ZWssbXQ4MTczLWRpc3AtYWFsIjsNCisJCQlyZWcgPSA8MCAw
eDE0MDEwMDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjMzIElSUV9U
WVBFX0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dF
Ul9ET01BSU5fRElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9BQUwwPjsN
CisJCX07DQorDQorCQlnYW1tYTA6IGdhbW1hQDE0MDExMDAwIHsNCisJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE4My1kaXNwLWdhbW1hIiwNCisJCQkJICAgICAibWVkaWF0ZWssbXQ4MTcz
LWRpc3AtZ2FtbWEiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMTEwMDAgMCAweDEwMDA+Ow0KKwkJCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSAyMzQgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJCQljbG9ja3Mg
PSA8Jm1tc3lzIENMS19NTV9ESVNQX0dBTU1BMD47DQorCQl9Ow0KKw0KKwkJZGl0aGVyMDogZGl0
aGVyQDE0MDEyMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLWRp
dGhlciI7DQorCQkJcmVnID0gPDAgMHgxNDAxMjAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDIzNSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMg
PSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1z
eXMgQ0xLX01NX0RJU1BfRElUSEVSMD47DQorCQl9Ow0KKw0KKwkJbXV0ZXg6IG11dGV4QDE0MDE2
MDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLW11dGV4IjsNCisJ
CQlyZWcgPSA8MCAweDE0MDE2MDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgMjE3IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lz
IE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQorCQl9Ow0KKw0KIAkJc21pX2NvbW1vbjogc21p
QDE0MDE5MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktY29tbW9u
IiwgInN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxNDAxOTAwMCAwIDB4MTAwMD47DQotLSANCjEu
OC4xLjEuZGlydHkNCg==

