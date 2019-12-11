Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E80C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03162077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cLywASS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLKCeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:34:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:13915 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727702AbfLKCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:34:06 -0500
X-UUID: 436caf869044493cbc549ee552781952-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=03LJQNLf2DKEdnk4krO0zsTLdTXgWHOH5qSyT3/Sd9o=;
        b=cLywASS+SvjGR82qEcnxT0Bj91flL0GlScmUu6JR1Na7AWrcHXuyZBIce9zWqQlJTtmRdamAEOzpLNG5lO84j1ADFxAV0fCGFj6pvD0pCS5oUkHMuONk6x36KuVOsRAL61kHspc2tZ2goi+JJogD28VhTqXQCpeiDu5F6tgrkhQ=;
X-UUID: 436caf869044493cbc549ee552781952-20191211
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 683214143; Wed, 11 Dec 2019 10:33:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 10:33:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 10:33:49 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <weiyi.lu@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v2] arm64: dts: Add m4u and smi-larbs nodes for mt8183
Date:   Wed, 11 Dec 2019 10:33:39 +0800
Message-ID: <1576031619-12229-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5vZGVzIGZvciBNNFUsIHNtaS1jb21tb24sIGFuZCBzbWktbGFyYnMuDQoNClNpZ25lZC1v
ZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQpjaGFuZ2Ugbm90ZXM6
DQoNCnYyOiBSZWJhc2Ugb24gdjUuNS1yYzEgYW5kIHBvd2VyX2RvbWFpbiBub2Rlc1sxXS4NCiAg
IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTE2NDc0Ni8NCg0K
djE6ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTA1NDA5OS8NCi0t
LQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA4NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA4NSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5k
dHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggOTEy
MTdlNGYuLjBmOGY3OGUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5k
dHNpDQpAQCAtOCw2ICs4LDcgQEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTgz
LWNsay5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0t
Z2ljLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5o
Pg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgzLWxhcmItcG9ydC5oPg0KICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaD4NCiAjaW5jbHVkZSAibXQ4
MTgzLXBpbmZ1bmMuaCINCiANCkBAIC0zMzUsNiArMzM2LDE1IEBADQogCQkJY2xvY2stbmFtZXMg
PSAiY2xrMTNtIjsNCiAJCX07DQogDQorCQlpb21tdTogaW9tbXVAMTAyMDUwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW00dSI7DQorCQkJcmVnID0gPDAgMHgxMDIwNTAw
MCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2NiBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KKwkJCW1lZGlhdGVrLGxhcmJzID0gPCZsYXJiMCAmbGFyYjEgJmxhcmIyICZsYXJi
Mw0KKwkJCQkJICAmbGFyYjQgJmxhcmI1ICZsYXJiNj47DQorCQkJI2lvbW11LWNlbGxzID0gPDE+
Ow0KKwkJfTsNCisNCiAJCWF1eGFkYzogYXV4YWRjQDExMDAxMDAwIHsNCiAJCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4My1hdXhhZGMiLA0KIAkJCQkgICAgICJtZWRpYXRlayxtdDgxNzMt
YXV4YWRjIjsNCkBAIC02NTEsOSArNjYxLDI1IEBADQogCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0K
IAkJfTsNCiANCisJCWxhcmIwOiBsYXJiQDE0MDE3MDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1zbWktbGFyYiI7DQorCQkJcmVnID0gPDAgMHgxNDAxNzAwMCAwIDB4MTAw
MD47DQorCQkJbWVkaWF0ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCisJCQljbG9ja3MgPSA8Jm1t
c3lzIENMS19NTV9TTUlfTEFSQjA+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fU01JX0xBUkIwPjsN
CisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsN
CisJCQljbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIjsNCisJCX07DQorDQogCQlzbWlfY29tbW9u
OiBzbWlAMTQwMTkwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXNtaS1j
b21tb24iLCAic3lzY29uIjsNCiAJCQlyZWcgPSA8MCAweDE0MDE5MDAwIDAgMHgxMDAwPjsNCisJ
CQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9TTUlfQ09NTU9OPiwNCisJCQkJIDwmbW1zeXMgQ0xL
X01NX1NNSV9DT01NT04+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FMU19DT01NMD4sDQorCQkJ
CSA8Jm1tc3lzIENMS19NTV9HQUxTX0NPTU0xPjsNCisJCQljbG9jay1uYW1lcyA9ICJhcGIiLCAi
c21pIiwgImdhbHMwIiwgImdhbHMxIjsNCisJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4
MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCiAJCX07DQogDQogCQlpbWdzeXM6IHN5c2NvbkAxNTAy
MDAwMCB7DQpAQCAtNjYyLDE4ICs2ODgsNTcgQEANCiAJCQkjY2xvY2stY2VsbHMgPSA8MT47DQog
CQl9Ow0KIA0KKwkJbGFyYjU6IGxhcmJAMTUwMjEwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLXNtaS1sYXJiIjsNCisJCQlyZWcgPSA8MCAweDE1MDIxMDAwIDAgMHgxMDAw
PjsNCisJCQltZWRpYXRlayxzbWkgPSA8JnNtaV9jb21tb24+Ow0KKwkJCWNsb2NrcyA9IDwmaW1n
c3lzIENMS19JTUdfTEFSQjU+LCA8JmltZ3N5cyBDTEtfSU1HX0xBUkI1PiwNCisJCQkJIDwmbW1z
eXMgQ0xLX01NX0dBTFNfSU1HMk1NPjsNCisJCQljbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIiwg
ImdhbHMiOw0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlO
X0lTUD47DQorCQl9Ow0KKw0KKwkJbGFyYjI6IGxhcmJAMTUwMmYwMDAgew0KKwkJCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTgzLXNtaS1sYXJiIjsNCisJCQlyZWcgPSA8MCAweDE1MDJmMDAw
IDAgMHgxMDAwPjsNCisJCQltZWRpYXRlayxzbWkgPSA8JnNtaV9jb21tb24+Ow0KKwkJCWNsb2Nr
cyA9IDwmaW1nc3lzIENMS19JTUdfTEFSQjI+LCA8JmltZ3N5cyBDTEtfSU1HX0xBUkIyPiwNCisJ
CQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfSVBVMk1NPjsNCisJCQljbG9jay1uYW1lcyA9ICJhcGIi
LCAic21pIiwgImdhbHMiOw0KKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9X
RVJfRE9NQUlOX0lTUD47DQorCQl9Ow0KKw0KIAkJdmRlY3N5czogc3lzY29uQDE2MDAwMDAwIHsN
CiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My12ZGVjc3lzIiwgInN5c2NvbiI7DQog
CQkJcmVnID0gPDAgMHgxNjAwMDAwMCAwIDB4MTAwMD47DQogCQkJI2Nsb2NrLWNlbGxzID0gPDE+
Ow0KIAkJfTsNCiANCisJCWxhcmIxOiBsYXJiQDE2MDEwMDAwIHsNCisJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE4My1zbWktbGFyYiI7DQorCQkJcmVnID0gPDAgMHgxNjAxMDAwMCAwIDB4
MTAwMD47DQorCQkJbWVkaWF0ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCisJCQljbG9ja3MgPSA8
JnZkZWNzeXMgQ0xLX1ZERUNfVkRFQz4sIDwmdmRlY3N5cyBDTEtfVkRFQ19MQVJCMT47DQorCQkJ
Y2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSI7DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lz
IE1UODE4M19QT1dFUl9ET01BSU5fVkRFQz47DQorCQl9Ow0KKw0KIAkJdmVuY3N5czogc3lzY29u
QDE3MDAwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My12ZW5jc3lzIiwg
InN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxNzAwMDAwMCAwIDB4MTAwMD47DQogCQkJI2Nsb2Nr
LWNlbGxzID0gPDE+Ow0KIAkJfTsNCiANCisJCWxhcmI0OiBsYXJiQDE3MDEwMDAwIHsNCisJCQlj
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktbGFyYiI7DQorCQkJcmVnID0gPDAgMHgx
NzAxMDAwMCAwIDB4MTAwMD47DQorCQkJbWVkaWF0ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCisJ
CQljbG9ja3MgPSA8JnZlbmNzeXMgQ0xLX1ZFTkNfTEFSQj4sDQorCQkJCSA8JnZlbmNzeXMgQ0xL
X1ZFTkNfTEFSQj47DQorCQkJY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSI7DQorCQkJcG93ZXIt
ZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fVkVOQz47DQorCQl9Ow0KKw0K
IAkJaXB1X2Nvbm46IHN5c2NvbkAxOTAwMDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtaXB1X2Nvbm4iLCAic3lzY29uIjsNCiAJCQlyZWcgPSA8MCAweDE5MDAwMDAwIDAg
MHgxMDAwPjsNCkBAIC03MDMsNSArNzY4LDI1IEBADQogCQkJcmVnID0gPDAgMHgxYTAwMDAwMCAw
IDB4MTAwMD47DQogCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KIAkJfTsNCisNCisJCWxhcmI2OiBs
YXJiQDFhMDAxMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktbGFy
YiI7DQorCQkJcmVnID0gPDAgMHgxYTAwMTAwMCAwIDB4MTAwMD47DQorCQkJbWVkaWF0ZWssc21p
ID0gPCZzbWlfY29tbW9uPjsNCisJCQljbG9ja3MgPSA8JmNhbXN5cyBDTEtfQ0FNX0xBUkI2Piwg
PCZjYW1zeXMgQ0xLX0NBTV9MQVJCNj4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9HQUxTX0NBTTJN
TT47DQorCQkJY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSIsICJnYWxzIjsNCisJCQlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9DQU0+Ow0KKwkJfTsNCisNCisJ
CWxhcmIzOiBsYXJiQDFhMDAyMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
My1zbWktbGFyYiI7DQorCQkJcmVnID0gPDAgMHgxYTAwMjAwMCAwIDB4MTAwMD47DQorCQkJbWVk
aWF0ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCisJCQljbG9ja3MgPSA8JmNhbXN5cyBDTEtfQ0FN
X0xBUkIzPiwgPCZjYW1zeXMgQ0xLX0NBTV9MQVJCMz4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9H
QUxTX0lQVTEyTU0+Ow0KKwkJCWNsb2NrLW5hbWVzID0gImFwYiIsICJzbWkiLCAiZ2FscyI7DQor
CQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fQ0FNPjsNCisJ
CX07DQogCX07DQogfTsNCi0tIA0KMS45LjENCg==

