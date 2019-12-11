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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MpTpSXTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLKFy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:54:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:36903 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbfLKFyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:54:53 -0500
X-UUID: 6a2cd468329b42528c4dd19cdb87b450-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WRAN2giYm5awlJKdEX+2t5uxDIS+988tMTVn0Kf+KS8=;
        b=MpTpSXTfGM1G/nedhcZxM0wgxv3aA4u9zqkKLDkOl/iVYycs4C9YzKrjU2mN3y5RHx/SHKEM+NnzO85xUGhDGG0x3wEWwFd1IHhIQCtLXhtnpIu8FJ7f8OB1vbKOhZqUoeh6/spRwqsM4MIowG+/IrKBM58HWR7kKJUJjyJxiJw=;
X-UUID: 6a2cd468329b42528c4dd19cdb87b450-20191211
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 846537063; Wed, 11 Dec 2019 13:54:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 13:53:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 13:54:39 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 03/11] dt-bindings: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Wed, 11 Dec 2019 13:54:15 +0800
Message-ID: <1576043663-14240-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F9BA5C7845BD98DE13089B856274E7CB4D5EE000FCF4312B15C3188418F45BEF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHUzcGh5YV9yZWYgY2xvY2sgaXMgYWxyZWFkeSBtb3ZlZCBpbnRvIHN1Yi1ub2RlLCBhbmQN
CnJlbmFtZWQgYXMgcmVmIGNsb2NrLCBubyB1c2VkIGFueW1vcmUgbm93LCBzbyByZW1vdmUgaXQN
CnRvIGF2b2lkIGNvbmZ1c2lvbg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCi0tLQ0KdjN+djU6IG5vIGNoYW5nZXMNCg0KdjI6IGFkZCBSZXZpZXdlZC1ieSBS
b2INCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10
cGh5LnR4dCB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRw
aHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRw
aHkudHh0DQppbmRleCAxZjRhMzZkZDgwZTAuLjQ4YmMxYTJlOTI5OSAxMDA2NDQNCi0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0
DQpAQCAtMTMsMTAgKzEzLDYgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFy
ZW50KSBub2RlKToNCiAJCSAgIm1lZGlhdGVrLG10ODE3My11M3BoeSI7DQogCQkgIG1ha2UgdXNl
IG9mICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiIG9uIG10MjcwMSBpbnN0ZWFkIGFuZA0KIAkJ
ICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIiBvbiBtdDI3MTIgaW5zdGVhZC4NCi0gLSBjbG9j
a3MJOiAoZGVwcmVjYXRlZCwgdXNlIHBvcnQncyBjbG9ja3MgaW5zdGVhZCkgYSBsaXN0IG9mIHBo
YW5kbGUgKw0KLQkJICBjbG9jay1zcGVjaWZpZXIgcGFpcnMsIG9uZSBmb3IgZWFjaCBlbnRyeSBp
biBjbG9jay1uYW1lcw0KLSAtIGNsb2NrLW5hbWVzCTogKGRlcHJlY2F0ZWQsIHVzZSBwb3J0J3Mg
b25lIGluc3RlYWQpIG11c3QgY29udGFpbg0KLQkJICAidTNwaHlhX3JlZiI6IGZvciByZWZlcmVu
Y2UgY2xvY2sgb2YgdXNiMy4wIGFuYWxvZyBwaHkuDQogDQogUmVxdWlyZWQgbm9kZXMJOiBhIHN1
Yi1ub2RlIGlzIHJlcXVpcmVkIGZvciBlYWNoIHBvcnQgdGhlIGNvbnRyb2xsZXINCiAJCSAgcHJv
dmlkZXMuIEFkZHJlc3MgcmFuZ2UgaW5mb3JtYXRpb24gaW5jbHVkaW5nIHRoZSB1c3VhbA0KLS0g
DQoyLjI0LjANCg==

