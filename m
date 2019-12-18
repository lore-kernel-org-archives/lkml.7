Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96335C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668E0218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DIhSvp3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLRIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:65506 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726695AbfLRIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:09 -0500
X-UUID: dd0818de3ee445d381dc589853ece6cc-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=71LTUrp3pf9bXQ3diJtb3X5tIs0vCbA342jebiH0HbM=;
        b=DIhSvp3qKqqTWlQ7OUDxOMtvr5z/U6spNktoMw5xnVdQPp2XdSzPUsmJ4QiB/EQkAr1oKMHsY2k3BNhk/2JPTPxZ7763QD17z2jZbNw6wnPvGeiJd5cNbhx1IQ9xWSfqa5N71xnbotva+qAwvfiuV3i4HpsHIdupStSzqhfFaTc=;
X-UUID: dd0818de3ee445d381dc589853ece6cc-20191218
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 72313621; Wed, 18 Dec 2019 16:31:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:41 +0800
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
Subject: [PATCH v10 11/12] arm64: dts: Add power controller device node of MT8183
Date:   Wed, 18 Dec 2019 16:30:47 +0800
Message-ID: <1576657848-14711-12-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGNvbnRyb2xsZXIgbm9kZSBhbmQgc21pLWNvbW1vbiBub2RlIGZvciBNVDgxODMN
CkluIHNjcHN5cyBub2RlLCBpdCBjb250YWlucyBjbG9ja3MgYW5kIHJlZ21hcHBpbmcgb2YNCmlu
ZnJhY2ZnIGFuZCBzbWktY29tbW9uIGZvciBidXMgcHJvdGVjdGlvbi4NCg0KU2lnbmVkLW9mZi1i
eTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggMTBiMzI0Ny4uOTEyMTdlNGYgMTAw
NjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQorKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQpAQCAtOCw2ICs4LDcg
QEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTgzLWNsay5oPg0KICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQogI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KKyNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaD4NCiAjaW5jbHVkZSAibXQ4MTgzLXBpbmZ1bmMu
aCINCiANCiAvIHsNCkBAIC0yNTMsNiArMjU0LDYyIEBADQogCQkJI2ludGVycnVwdC1jZWxscyA9
IDwyPjsNCiAJCX07DQogDQorCQlzY3BzeXM6IHN5c2NvbkAxMDAwNjAwMCB7DQorCQkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc2Nwc3lzIiwgInN5c2NvbiI7DQorCQkJI3Bvd2VyLWRv
bWFpbi1jZWxscyA9IDwxPjsNCisJCQlyZWcgPSA8MCAweDEwMDA2MDAwIDAgMHgxMDAwPjsNCisJ
CQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0FVRF9JTlRCVVM+LA0KKwkJCQkgPCZp
bmZyYWNmZyBDTEtfSU5GUkFfQVVESU8+LA0KKwkJCQkgPCZpbmZyYWNmZyBDTEtfSU5GUkFfQVVE
SU9fMjZNX0JDTEs+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9NRkc+LA0KKwkJCQkg
PCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9NTT4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVY
X0NBTT4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0lNRz4sDQorCQkJCSA8JnRvcGNr
Z2VuIENMS19UT1BfTVVYX0lQVV9JRj4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0RT
UD4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0RTUDE+LA0KKwkJCQkgPCZ0b3Bja2dl
biBDTEtfVE9QX01VWF9EU1AyPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX1NNSV9DT01NT04+LA0K
KwkJCQkgPCZtbXN5cyBDTEtfTU1fU01JX0xBUkIwPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX1NN
SV9MQVJCMT4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9HQUxTX0NPTU0wPiwNCisJCQkJIDwmbW1z
eXMgQ0xLX01NX0dBTFNfQ09NTTE+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FMU19DQ1UyTU0+
LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FMU19JUFUxMk1NPiwNCisJCQkJIDwmbW1zeXMgQ0xL
X01NX0dBTFNfSU1HMk1NPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfQ0FNMk1NPiwNCisJ
CQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfSVBVMk1NPiwNCisJCQkJIDwmaW1nc3lzIENMS19JTUdf
TEFSQjU+LA0KKwkJCQkgPCZpbWdzeXMgQ0xLX0lNR19MQVJCMj4sDQorCQkJCSA8JmNhbXN5cyBD
TEtfQ0FNX0xBUkI2PiwNCisJCQkJIDwmY2Ftc3lzIENMS19DQU1fTEFSQjM+LA0KKwkJCQkgPCZj
YW1zeXMgQ0xLX0NBTV9TRU5JTkY+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9DQU1TVjA+LA0K
KwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9DQU1TVjE+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9D
QU1TVjI+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9DQ1U+LA0KKwkJCQkgPCZpcHVfY29ubiBD
TEtfSVBVX0NPTk5fSVBVPiwNCisJCQkJIDwmaXB1X2Nvbm4gQ0xLX0lQVV9DT05OX0FIQj4sDQor
CQkJCSA8JmlwdV9jb25uIENMS19JUFVfQ09OTl9BWEk+LA0KKwkJCQkgPCZpcHVfY29ubiBDTEtf
SVBVX0NPTk5fSVNQPiwNCisJCQkJIDwmaXB1X2Nvbm4gQ0xLX0lQVV9DT05OX0NBTV9BREw+LA0K
KwkJCQkgPCZpcHVfY29ubiBDTEtfSVBVX0NPTk5fSU1HX0FETD47DQorCQkJY2xvY2stbmFtZXMg
PSAiYXVkaW8iLCAiYXVkaW8xIiwgImF1ZGlvMiIsDQorCQkJCSAgICAgICJtZmciLCAibW0iLCAi
Y2FtIiwNCisJCQkJICAgICAgImlzcCIsICJ2cHUiLCAidnB1MSIsDQorCQkJCSAgICAgICJ2cHUy
IiwgInZwdTMiLCAibW0tMCIsDQorCQkJCSAgICAgICJtbS0xIiwgIm1tLTIiLCAibW0tMyIsDQor
CQkJCSAgICAgICJtbS00IiwgIm1tLTUiLCAibW0tNiIsDQorCQkJCSAgICAgICJtbS03IiwgIm1t
LTgiLCAibW0tOSIsDQorCQkJCSAgICAgICJpc3AtMCIsICJpc3AtMSIsICJjYW0tMCIsDQorCQkJ
CSAgICAgICJjYW0tMSIsICJjYW0tMiIsICJjYW0tMyIsDQorCQkJCSAgICAgICJjYW0tNCIsICJj
YW0tNSIsICJjYW0tNiIsDQorCQkJCSAgICAgICJ2cHUtMCIsICJ2cHUtMSIsICJ2cHUtMiIsDQor
CQkJCSAgICAgICJ2cHUtMyIsICJ2cHUtNCIsICJ2cHUtNSI7DQorCQkJaW5mcmFjZmcgPSA8Jmlu
ZnJhY2ZnPjsNCisJCQlzbWlfY29tbSA9IDwmc21pX2NvbW1vbj47DQorCQl9Ow0KKw0KIAkJYXBt
aXhlZHN5czogc3lzY29uQDEwMDBjMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My1hcG1peGVkc3lzIiwgInN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxMDAwYzAwMCAwIDB4
MTAwMD47DQpAQCAtNTk0LDYgKzY1MSwxMSBAQA0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCiAJ
CX07DQogDQorCQlzbWlfY29tbW9uOiBzbWlAMTQwMTkwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTgzLXNtaS1jb21tb24iLCAic3lzY29uIjsNCisJCQlyZWcgPSA8MCAweDE0
MDE5MDAwIDAgMHgxMDAwPjsNCisJCX07DQorDQogCQlpbWdzeXM6IHN5c2NvbkAxNTAyMDAwMCB7
DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtaW1nc3lzIiwgInN5c2NvbiI7DQog
CQkJcmVnID0gPDAgMHgxNTAyMDAwMCAwIDB4MTAwMD47DQotLSANCjEuOC4xLjEuZGlydHkNCg==

