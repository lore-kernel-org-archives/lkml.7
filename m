Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CEC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC632073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dX8TOOra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLKBzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:55:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:57442 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfLKBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:55:02 -0500
X-UUID: 22224e4927864e1cbfe5f70f261418e9-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lAQh/3jyq3mvyY+gOwkzOpTAME8Gd1I+NZkj+CC0GEg=;
        b=dX8TOOraNVJ0QETa89HU0VjFLTfimmzy2R8Os2o11JrlTDBxEv4LfyQimBIw+xbu46JqAgAT815kJCxjLVSpj3s85m1398sF1EXgP3KXFDLn/D+6kY2yH1h0Oz/m8I1AQrjQt1zaCPszqYjtV8nb5PghDRklba6R4Kw0p5XuRRY=;
X-UUID: 22224e4927864e1cbfe5f70f261418e9-20191211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1094991122; Wed, 11 Dec 2019 09:54:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 09:53:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 09:54:49 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Min Guo <min.guo@mediatek.com>
Subject: [PATCH v9 2/6] arm: dts: mt2701: Add usb2 device nodes
Date:   Wed, 11 Dec 2019 09:54:42 +0800
Message-ID: <20191211015446.11477-3-min.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191211015446.11477-1-min.guo@mediatek.com>
References: <20191211015446.11477-1-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC16D426DBA9743DC58F80509F27FDF9172F803E31924DF38809DE3A7882573C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWluIEd1byA8bWluLmd1b0BtZWRpYXRlay5jb20+DQoNCkFkZCBtdXNiIG5vZGVzIGFu
ZCB1c2IyIHBoeSBub2RlcyBmb3IgTVQyNzAxDQoNClNpZ25lZC1vZmYtYnk6IE1pbiBHdW8gPG1p
bi5ndW9AbWVkaWF0ZWsuY29tPg0KLS0tDQpjaGFuZ2VzIGluIHY5Og0KMS4gQWRkIHVzYi1yb2xl
LXN3aXRjaA0KMi4gUmVtb3ZlIGxhYmVsIG9mIHVzYiBjb25uZWN0b3IgY2hpbGQgbm9kZQ0KMy4g
Q2hhbmdlIHVzYiBjb25uZWN0b3IgY2hpbGQgbm9kZSBjb21wYXRpYmxlIGFzICJncGlvLXVzYi1i
LWNvbm5lY3RvciIsICJ1c2ItYi1jb25uZWN0b3IiOw0KDQpjaGFuZ2VzIGluIHY4Og0KMS4gbm8g
Y2hhbmdlcw0KDQpjaGFuZ2VzIGluIHY3Og0KMS4gQ2hhbmdlIHVzYiBjb25uZWN0b3IgY2hpbGQg
bm9kZSBjb21wYXRpYmxlIGFzICJncGlvLXVzYi1iLWNvbm5lY3RvciIgDQoNCmNoYW5nZXMgaW4g
djY6DQoxLiBNb2RpZnkgdXNiIGNvbm5lY3RvciBjaGlsZCBub2RlDQoNCmNoYW5nZXMgaW4gdjU6
DQoxLiBBZGQgdXNiIGNvbm5lY3RvciBjaGlsZCBub2RlDQoNCmNoYW5nZXMgaW4gdjQ6DQoxLiBu
byBjaGFuZ2VzDQoNCmNoYW5nZXMgaW4gdjM6DQoxLiBubyBjaGFuZ2VzDQoNCmNoYW5nZXMgaW4g
djI6DQoxLiBSZW1vdmUgcGh5LW5hbWVzDQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9tdDI3MDEt
ZXZiLmR0cyB8IDIxICsrKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQy
NzAxLmR0c2kgICAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvbXQyNzAxLWV2Yi5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEtZXZiLmR0cw0K
aW5kZXggYmUwZWRiM2RhZTZjLi44NDRlZDNmOTcxZmUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9tdDI3MDEtZXZiLmR0cw0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQyNzAxLWV2
Yi5kdHMNCkBAIC02LDYgKzYsNyBAQA0KICAqLw0KIA0KIC9kdHMtdjEvOw0KKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCiAjaW5jbHVkZSAibXQyNzAxLmR0c2kiDQogDQogLyB7
DQpAQCAtNjAsNiArNjEsMTUgQEAgYmFja2xpZ2h0X2xjZDogYmFja2xpZ2h0X2xjZCB7DQogCQk+
Ow0KIAkJZGVmYXVsdC1icmlnaHRuZXNzLWxldmVsID0gPDk+Ow0KIAl9Ow0KKw0KKwl1c2JfdmJ1
czogcmVndWxhdG9yQDAgew0KKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KKwkJ
cmVndWxhdG9yLW5hbWUgPSAidXNiX3ZidXMiOw0KKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQg
PSA8NTAwMDAwMD47DQorCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCisJ
CWdwaW8gPSA8JnBpbyA0NSBHUElPX0FDVElWRV9ISUdIPjsNCisJCWVuYWJsZS1hY3RpdmUtaGln
aDsNCisJfTsNCiB9Ow0KIA0KICZhdXhhZGMgew0KQEAgLTIyOSwzICsyMzksMTQgQEAgcGluczEg
ew0KICZ1YXJ0MCB7DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KKw0KKyZ1c2IyIHsNCisJc3Rh
dHVzID0gIm9rYXkiOw0KKwl1c2Itcm9sZS1zd2l0Y2g7DQorCWNvbm5lY3RvcnsNCisJCWNvbXBh
dGlibGUgPSAiZ3Bpby11c2ItYi1jb25uZWN0b3IiLCAidXNiLWItY29ubmVjdG9yIjsNCisJCXR5
cGUgPSAibWljcm8iOw0KKwkJaWQtZ3Bpb3MgPSA8JnBpbyA0NCBHUElPX0FDVElWRV9ISUdIPjsN
CisJCXZidXMtc3VwcGx5ID0gPCZ1c2JfdmJ1cz47DQorCX07DQorfTsNCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL210MjcwMS5k
dHNpDQppbmRleCAxODAzNzdlNTZlZjQuLmE2YjE0MzRlODNmYiAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEu
ZHRzaQ0KQEAgLTY3MCw2ICs2NzAsMzkgQEAgdTNwb3J0MTogdXNiLXBoeUAxYTI0NDkwMCB7DQog
CQl9Ow0KIAl9Ow0KIA0KKwl1c2IyOiB1c2JAMTEyMDAwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MDEtbXVzYiIsDQorCQkJICAgICAibWVkaWF0ZWssbXRrLW11c2IiOw0KKwkJ
cmVnID0gPDAgMHgxMTIwMDAwMCAwIDB4MTAwMD47DQorCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MzIgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCWludGVycnVwdC1uYW1lcyA9ICJtYyI7DQorCQlw
aHlzID0gPCZ1MnBvcnQyIFBIWV9UWVBFX1VTQjI+Ow0KKwkJZHJfbW9kZSA9ICJvdGciOw0KKwkJ
Y2xvY2tzID0gPCZwZXJpY2ZnIENMS19QRVJJX1VTQjA+LA0KKwkJCSA8JnBlcmljZmcgQ0xLX1BF
UklfVVNCMF9NQ1U+LA0KKwkJCSA8JnBlcmljZmcgQ0xLX1BFUklfVVNCX1NMVj47DQorCQljbG9j
ay1uYW1lcyA9ICJtYWluIiwibWN1IiwidW5pdnBsbCI7DQorCQlwb3dlci1kb21haW5zID0gPCZz
Y3BzeXMgTVQyNzAxX1BPV0VSX0RPTUFJTl9JRlJfTVNDPjsNCisJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQorCX07DQorDQorCXUycGh5MDogdXNiLXBoeUAxMTIxMDAwMCB7DQorCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQorCQlyZWcgPSA8MCAweDExMjEwMDAwIDAg
MHgwODAwPjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KKwkJI3NpemUtY2VsbHMgPSA8Mj47
DQorCQlyYW5nZXM7DQorCQlzdGF0dXMgPSAib2theSI7DQorDQorCQl1MnBvcnQyOiB1c2ItcGh5
QDFhMWM0ODAwIHsNCisJCQlyZWcgPSA8MCAweDExMjEwODAwIDAgMHgwMTAwPjsNCisJCQljbG9j
a3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVVNCX1BIWTQ4TT47DQorCQkJY2xvY2stbmFtZXMgPSAi
cmVmIjsNCisJCQkjcGh5LWNlbGxzID0gPDE+Ow0KKwkJCXN0YXR1cyA9ICJva2F5IjsNCisJCX07
DQorCX07DQorDQogCWV0aHN5czogc3lzY29uQDFiMDAwMDAwIHsNCiAJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQyNzAxLWV0aHN5cyIsICJzeXNjb24iOw0KIAkJcmVnID0gPDAgMHgxYjAwMDAw
MCAwIDB4MTAwMD47DQotLSANCjIuMjQuMA0K

