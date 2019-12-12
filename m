Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C538C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210752077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r0mYpAn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLLBge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:36:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63871 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727536AbfLLBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:36:33 -0500
X-UUID: 915dbb02af824e83b9b447db489d569a-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9dmLvvMzX2gtv8uuQt32TCADineHY3exyLfiwrU7QvA=;
        b=r0mYpAn8n4j5Tsfn+1X5YIWD7uJrUvNqAEg877U4Aok5QyETXICHfYEJCJ4b14wlutXfQ0Y+T1L1CK4AuASETy4a8q29ld/ii3i0e6bs1YZMvI40AKYvpXOsJyxHOdQ9w9gyVqLE7MVkiDXPEIJubSS+bS7ylN5FZ5eBO04tXMw=;
X-UUID: 915dbb02af824e83b9b447db489d569a-20191212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2140265179; Thu, 12 Dec 2019 09:36:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:36:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Dec
 2019 09:36:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:36:24 +0800
Message-ID: <1576114588.11280.1.camel@mtksdaap41>
Subject: Re: [PATCH] soc: mediatek: cmdq: delete not used define
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Dec 2019 09:36:28 +0800
In-Reply-To: <20191211185950.31358-1-matthias.bgg@kernel.org>
References: <20191211185950.31358-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTExIGF0IDE5OjU5ICswMTAwLCBtYXR0aGlhcy5iZ2dAa2VybmVsLm9y
ZyB3cm90ZToNCj4gRnJvbTogTWF0dGhpYXMgQnJ1Z2dlciA8bWJydWdnZXJAc3VzZS5jb20+DQo+
IA0KPiBEZWZpbmUgQ01EUV9FT0NfQ01EIHdhcyBhY3R1YWxseSBuZXZlciB1c2VkLiBEZWxldGUg
aXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYnJ1Z2dlckBzdXNl
LmNvbT4NCg0KVGhhbmtzLiA6RA0KDQpSZXZpZXdlZC1ieTogQmliYnkgSHNpZWggPGJpYmJ5Lmhz
aWVoQG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4
IDNjODJkZTVmOTQxNy4uMTEyN2MxOWM0ZTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMTIsOCArMTIsNiBAQA0KPiAgI2RlZmluZSBDTURRX0FS
R19BX1dSSVRFX01BU0sJMHhmZmZmDQo+ICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJ
QklUKDApDQo+ICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQo+IC0jZGVmaW5lIENN
RFFfRU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkp
IFwNCj4gLQkJCQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gIA0KPiAgc3RhdGljIHZvaWQg
Y21kcV9jbGllbnRfdGltZW91dChzdHJ1Y3QgdGltZXJfbGlzdCAqdCkNCj4gIHsNCg0K

