Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEDC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376A22075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kQ0Sie/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHGli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:41:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726087AbgAHGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:41:38 -0500
X-UUID: aea1d051c22e4a95a939507d355defac-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Yu9NqwYbodwJATiMDbCNRoEDTSoP+9XjHOc4EfpOpn0=;
        b=kQ0Sie/52dNaJXZ/7rfuo0PNFOzvE1mknbuO4RFwmFV2vDZWw0mN1DW0+cqtdFsf/TKljYtRE6ERWiJzWrGCe/VZHqzdCZ7MUfis3Gt/q5L1sWkhMjUgggGvaG5WYc7cmckk3JVAbgeaR0N6ZxAH8GeydAKQ31DAW2UxEn8ML6s=;
X-UUID: aea1d051c22e4a95a939507d355defac-20200108
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 692530218; Wed, 08 Jan 2020 14:41:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 14:41:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 14:39:59 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 0/3] memory: mtk-smi: Add bandwidth initial golden setting
Date:   Wed, 8 Jan 2020 14:41:28 +0800
Message-ID: <1578465691-30692-2-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KioqIEJMVVJCIEhFUkUgKioqDQoNCk1pbmctRmFuIENoZW4gKDMpOg0KICBkdC1iaW5kaW5nczog
bWVkaWF0ZWs6IEFkZCBiaW5kaW5nIGZvciBNVDY3NzkgU01JDQogIG1lbW9yeTogbXRrLXNtaTog
QWRkIGJhc2ljIHN1cHBvcnQgZm9yIE1UNjc3OQ0KICBtZW1vcnk6IG10ay1zbWk6IEFkZCBiYW5k
d2lkdGggaW5pdGlhbCBnb2xkZW4gc2V0dGluZw0KDQogLi4uL21lbW9yeS1jb250cm9sbGVycy9t
ZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgICA1ICstDQogLi4uL21lbW9yeS1jb250cm9s
bGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgICAgICAgfCAgICAzICstDQogZHJpdmVycy9tZW1v
cnkvbXRrLXNtaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQwICsrKysrKysrKysr
KysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAxNDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KLS0gDQoxLjcuOS41DQo=

