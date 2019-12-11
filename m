Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BED2214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JmrzCBN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfLKFzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:55:01 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:35000 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725973AbfLKFyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:54:54 -0500
X-UUID: 18846f4ba71044ba9c908b5f9c501de1-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8qhhdoDqZ+CygTdbYi8g0Gw9RSr1TQM9pKMrc5q2zEY=;
        b=JmrzCBN2MdKqL7vvN2PnVdOS+pKcLPb5fHssSPthAL1Aa0MBuif9rkMBB8aKjkobvdBa+guB+PO440BH1Q1rhrHCrOfvOKV5iaqNn0zX+n6pU1N3KzLki5AAMtjKo9gLKfShAXdb6q1FkxyngPl+sGaZZHtqNZjqsgduv2cbI50=;
X-UUID: 18846f4ba71044ba9c908b5f9c501de1-20191211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 974004315; Wed, 11 Dec 2019 13:54:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 13:54:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 13:54:37 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 01/11] dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Date:   Wed, 11 Dec 2019 13:54:13 +0800
Message-ID: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 93C3912FB354FF2DFCC9DDD3570751E44B5EE4DE40033869E5414810FA15E18F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzLCBvbmUgZm9yIHR1bmluZyBKLUsgdm9sdGFnZSBi
eSBJTlRSLA0KYW5vdGhlciBmb3IgZGlzY29ubmVjdCB0aHJlc2hvbGQsIGJvdGggb2YgdGhlbSBh
cmUgcmVsYXRlZCB3aXRoDQpjb25uZWN0IGRldGVjdGlvbg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjU6IGFkZCBhY2tlZC1ieSBSb2INCg0KdjQ6IG5v
IGNoYW5nZXMNCg0KdjM6IGNoYW5nZSBjb21taXQgbG9nDQoNCnYyOiBjaGFuZ2UgZGVzY3JpcHRp
b24NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10
cGh5LnR4dCB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQNCmluZGV4IGE1ZjdhNGYwZGJjMS4uY2U2YWJmYmRmYmUxIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQN
CkBAIC01Miw2ICs1Miw4IEBAIE9wdGlvbmFsIHByb3BlcnRpZXMgKFBIWV9UWVBFX1VTQjIgcG9y
dCAoY2hpbGQpIG5vZGUpOg0KIC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVjdGlv
biBvZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2UNCiAtIG1lZGlhdGVrLGV5ZS10ZXJtCTogdTMyLCB0
aGUgc2VsZWN0aW9uIG9mIEhTX1RYIFRFUk0gcmVmZXJlbmNlIHZvbHRhZ2UNCiAtIG1lZGlhdGVr
LGJjMTIJOiBib29sLCBlbmFibGUgQkMxMiBvZiB1MnBoeSBpZiBzdXBwb3J0IGl0DQorLSBtZWRp
YXRlayxkaXNjdGgJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgZGlzY29ubmVjdCB0aHJlc2hvbGQN
CistIG1lZGlhdGVrLGludHIJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgaW50ZXJuYWwgUiAocmVz
aXN0YW5jZSkNCiANCiBFeGFtcGxlOg0KIA0KLS0gDQoyLjI0LjANCg==

