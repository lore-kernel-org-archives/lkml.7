Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB68C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871DE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jpNCkJf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLLFLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:11:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11467 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbfLLFLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:11:40 -0500
X-UUID: 83def09a2acc4589aa8890bf4b8dc3ef-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hYgDknyu2r/mt3htTKSKYIbRrUMLsVNx5WmsGimi8Vw=;
        b=jpNCkJf+xNMF6UdoYNiecf4S+ImFj9CPi9Uvo2aE/E0Hmiy+YQtuFZBjDeqgzCTBe7APze4L24Q5/aDN3nEf+WuVudJlrOTYK7ITtTZZsjIDkksEbDN3p7Umm3z4FTv1QHVwfvIwuXVoUY7+m0F1sbjzoT31V0kVmU6/nM1oXPM=;
X-UUID: 83def09a2acc4589aa8890bf4b8dc3ef-20191212
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 445164787; Thu, 12 Dec 2019 13:11:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 13:11:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 13:10:56 +0800
Message-ID: <1576127492.8315.1.camel@mtksdaap41>
Subject: Re: [PATCH] soc: mediatek: cmdq: delete not used define
From:   CK Hu <ck.hu@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 13:11:32 +0800
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

SGksIE1hdHRoaWFzOg0KDQpPbiBXZWQsIDIwMTktMTItMTEgYXQgMTk6NTkgKzAxMDAsIG1hdHRo
aWFzLmJnZ0BrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYnJ1
Z2dlckBzdXNlLmNvbT4NCj4gDQo+IERlZmluZSBDTURRX0VPQ19DTUQgd2FzIGFjdHVhbGx5IG5l
dmVyIHVzZWQuIERlbGV0ZSBpdC4NCj4gDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1icnVnZ2Vy
QHN1c2UuY29tPg0KPiANCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBi
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDNjODJkZTVm
OTQxNy4uMTEyN2MxOWM0ZTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KPiBAQCAtMTIsOCArMTIsNiBAQA0KPiAgI2RlZmluZSBDTURRX0FSR19BX1dSSVRF
X01BU0sJMHhmZmZmDQo+ICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJQklUKDApDQo+
ICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQo+IC0jZGVmaW5lIENNRFFfRU9DX0NN
RAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwNCj4gLQkJ
CQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gIA0KPiAgc3RhdGljIHZvaWQgY21kcV9jbGll
bnRfdGltZW91dChzdHJ1Y3QgdGltZXJfbGlzdCAqdCkNCj4gIHsNCg0K

