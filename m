Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4847EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7E620716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VTL5CDPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfLQNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:17:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727152AbfLQNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:17:03 -0500
X-UUID: 29d7776f26054b5184dffc385b15fbcb-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aC80HxRMBV0tY5Zddqx1ty1wteHBFoyprQsy+llvVXw=;
        b=VTL5CDPz2OeBi8/qtDysQEzNHNs7TC0Fc9RMhdi1zN9Bw0KEsZJX4KdqHQGooADrQavzoyfrVW4C+6eFlg1CUGYrqahLnS+E5O/H5X5lpv+5eTWbcfRD2Wu7yPNjiu/QcMPzEV+HfUWGQZmz9w3YcmNz9nIO+lNQgX0iNK0ICW8=;
X-UUID: 29d7776f26054b5184dffc385b15fbcb-20191217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 763470494; Tue, 17 Dec 2019 21:16:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 17 Dec 2019 21:16:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Dec 2019 21:16:32 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [v2,1/1] arm: dts: mediatek: add mt7629 pwm support
Date:   Tue, 17 Dec 2019 21:16:53 +0800
Message-ID: <1576588613-11530-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576588613-11530-1-git-send-email-sam.shih@mediatek.com>
References: <1576588613-11530-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHB3bSBzdXBwb3J0IGZvciBNVDc2MjkuDQpVc2VkOg0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMTE2MDg1MS8NCg0KQ2hhbmdlIHNpbmNlIHYxOg0KcmVtb3Zl
IHVudXNlZCBwcm9wZXJ0eSBudW0tcHdtDQoNClNpZ25lZC1vZmYtYnk6IFNhbSBTaGloIDxzYW0u
c2hpaEBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaSB8
IDE0ICsrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpIGIvYXJjaC9hcm0vYm9v
dC9kdHMvbXQ3NjI5LmR0c2kNCmluZGV4IDg2N2I4ODEwM2I5ZC4uY2UyYTMwYTI0MDE3IDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL210NzYyOS5kdHNpDQpAQCAtMjQxLDYgKzI0MSwyMCBAQA0KIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQogCQl9Ow0KIA0KKwkJcHdtOiBwd21AMTEwMDYwMDAgew0KKwkJCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ3NjI5LXB3bSI7DQorCQkJcmVnID0gPDB4MTEwMDYwMDAgMHgxMDAw
PjsNCisJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJ
CQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfUFdNX1NFTD4sDQorCQkJCSA8JnBlcmljZmcg
Q0xLX1BFUklfUFdNX1BEPiwNCisJCQkJIDwmcGVyaWNmZyBDTEtfUEVSSV9QV00xX1BEPjsNCisJ
CQljbG9jay1uYW1lcyA9ICJ0b3AiLCAibWFpbiIsICJwd20xIjsNCisJCQlhc3NpZ25lZC1jbG9j
a3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfUFdNX1NFTD47DQorCQkJYXNzaWduZWQtY2xvY2stcGFy
ZW50cyA9DQorCQkJCQk8JnRvcGNrZ2VuIENMS19UT1BfVU5JVlBMTDJfRDQ+Ow0KKwkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KIAkJaTJjOiBpMmNAMTEwMDcwMDAgew0KIAkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjI5LWkyYyIsDQogCQkJCSAgICAgIm1lZGlhdGVrLG10
MjcxMi1pMmMiOw0KLS0gDQoyLjE3LjENCg==

