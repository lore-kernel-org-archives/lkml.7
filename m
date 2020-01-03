Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8FC32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416BC2464B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z/1dIcoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgACDMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21160 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727220AbgACDMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:42 -0500
X-UUID: 31fb82bffcc34d23806bff134ece1770-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=orKJ3lD5eoygsfmvTkj/+8hB2VHcMMOk4prxsozRjkE=;
        b=Z/1dIcoJlayunT+RMA7WCGoubVSfqr7oDdz5brT3TENV7UWVjFnIjUlYCuQyMgzOb1m/auhq5v8z2dIgUNI+/OiqxNy4huwvvJvh7AJDZ1HE6DnS3nlSFovbWGrAz5AEWDQo673yWOIfzE6Flsx06v/5KVENrrB6+G90lR2Eats=;
X-UUID: 31fb82bffcc34d23806bff134ece1770-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1695416825; Fri, 03 Jan 2020 11:12:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:05 +0800
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
Subject: [RESEND PATCH v6 02/17] arm64: dts: add display nodes for mt8183
Date:   Fri, 3 Jan 2020 11:12:13 +0800
Message-ID: <1578021148-32413-3-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDk4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQppbmRleCA5MTIxN2U0Zi4uMjhi
ZWIxZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0
c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCkBAIC0z
MCw2ICszMCwxMSBAQA0KIAkJaTJjOSA9ICZpMmM5Ow0KIAkJaTJjMTAgPSAmaTJjMTA7DQogCQlp
MmMxMSA9ICZpMmMxMTsNCisJCW92bDAgPSAmb3ZsMDsNCisJCW92bF8ybDAgPSAmb3ZsXzJsMDsN
CisJCW92bF8ybDEgPSAmb3ZsXzJsMTsNCisJCXJkbWEwID0gJnJkbWEwOw0KKwkJcmRtYTEgPSAm
cmRtYTE7DQogCX07DQogDQogCWNwdXMgew0KQEAgLTY0OCw5ICs2NTMsMTAyIEBADQogCQltbXN5
czogc3lzY29uQDE0MDAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1t
bXN5cyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTQwMDAwMDAgMCAweDEwMDA+Ow0KKwkJ
CXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KIAkJ
CSNjbG9jay1jZWxscyA9IDwxPjsNCiAJCX07DQogDQorCQlvdmwwOiBvdmxAMTQwMDgwMDAgew0K
KwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsIjsNCisJCQlyZWcgPSA8
MCAweDE0MDA4MDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI1IElS
UV9UWVBFX0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19Q
T1dFUl9ET01BSU5fRElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PVkww
PjsNCisJCX07DQorDQorCQlvdmxfMmwwOiBvdmxAMTQwMDkwMDAgew0KKwkJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsLTJsIjsNCisJCQlyZWcgPSA8MCAweDE0MDA5MDAw
IDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI2IElSUV9UWVBFX0xFVkVM
X0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5f
RElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PVkwwXzJMPjsNCisJCX07
DQorDQorCQlvdmxfMmwxOiBvdmxAMTQwMGEwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLWRpc3Atb3ZsLTJsIjsNCisJCQlyZWcgPSA8MCAweDE0MDBhMDAwIDAgMHgxMDAw
PjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI3IElSUV9UWVBFX0xFVkVMX0xPVz47DQor
CQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQor
CQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PVkwxXzJMPjsNCisJCX07DQorDQorCQly
ZG1hMDogcmRtYUAxNDAwYjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
ZGlzcC1yZG1hIjsNCisJCQlyZWcgPSA8MCAweDE0MDBiMDAwIDAgMHgxMDAwPjsNCisJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMjI4IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9t
YWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47DQorCQkJY2xvY2tzID0g
PCZtbXN5cyBDTEtfTU1fRElTUF9SRE1BMD47DQorCQkJbWVkaWF0ZWsscmRtYV9maWZvX3NpemUg
PSA8NTEyMD47DQorCQl9Ow0KKw0KKwkJcmRtYTE6IHJkbWFAMTQwMGMwMDAgew0KKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtcmRtYSI7DQorCQkJcmVnID0gPDAgMHgxNDAw
YzAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOSBJUlFfVFlQRV9M
RVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9N
QUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfUkRNQTE+Ow0KKwkJ
CW1lZGlhdGVrLHJkbWFfZmlmb19zaXplID0gPDIwNDg+Ow0KKwkJfTsNCisNCisJCWNvbG9yMDog
Y29sb3JAMTQwMGUwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3At
Y29sb3IiLA0KKwkJCQkgICAgICJtZWRpYXRlayxtdDgxNzMtZGlzcC1jb2xvciI7DQorCQkJcmVn
ID0gPDAgMHgxNDAwZTAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIz
MSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgx
ODNfUE9XRVJfRE9NQUlOX0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1Bf
Q09MT1IwPjsNCisJCX07DQorDQorCQljY29ycjA6IGNjb3JyQDE0MDBmMDAwIHsNCisJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kaXNwLWNjb3JyIjsNCisJCQlyZWcgPSA8MCAweDE0
MDBmMDAwIDAgMHgxMDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjMyIElSUV9UWVBF
X0xFVkVMX0xPVz47DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9E
T01BSU5fRElTUD47DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9DQ09SUjA+Ow0K
KwkJfTsNCisNCisJCWFhbDA6IGFhbEAxNDAxMDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtZGlzcC1hYWwiLA0KKwkJCQkgICAgICJtZWRpYXRlayxtdDgxNzMtZGlzcC1h
YWwiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMTAwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAyMzMgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dlci1kb21haW5zID0g
PCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJCQljbG9ja3MgPSA8Jm1tc3lz
IENMS19NTV9ESVNQX0FBTDA+Ow0KKwkJfTsNCisNCisJCWdhbW1hMDogZ2FtbWFAMTQwMTEwMDAg
ew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtZ2FtbWEiLA0KKwkJCQkg
ICAgICJtZWRpYXRlayxtdDgxNzMtZGlzcC1nYW1tYSI7DQorCQkJcmVnID0gPDAgMHgxNDAxMTAw
MCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIzNCBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlO
X0RJU1A+Ow0KKwkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfR0FNTUEwPjsNCisJCX07
DQorDQorCQlkaXRoZXIwOiBkaXRoZXJAMTQwMTIwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLWRpc3AtZGl0aGVyIjsNCisJCQlyZWcgPSA8MCAweDE0MDEyMDAwIDAgMHgx
MDAwPjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjM1IElSUV9UWVBFX0xFVkVMX0xPVz47
DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47
DQorCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9ESVRIRVIwPjsNCisJCX07DQorDQor
CQltdXRleDogbXV0ZXhAMTQwMTYwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTgzLWRpc3AtbXV0ZXgiOw0KKwkJCXJlZyA9IDwwIDB4MTQwMTYwMDAgMCAweDEwMDA+Ow0KKwkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSAyMTcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQlwb3dl
ci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJCX07DQor
DQogCQlzbWlfY29tbW9uOiBzbWlAMTQwMTkwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLXNtaS1jb21tb24iLCAic3lzY29uIjsNCiAJCQlyZWcgPSA8MCAweDE0MDE5MDAw
IDAgMHgxMDAwPjsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

