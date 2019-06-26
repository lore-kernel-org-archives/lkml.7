Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C4C48BD7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA41E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFZCgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:36:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40411 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726623AbfFZCgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:36:42 -0400
X-UUID: f2c90382853b47018fe70e3f259df81e-20190626
X-UUID: f2c90382853b47018fe70e3f259df81e-20190626
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 654526010; Wed, 26 Jun 2019 10:36:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Jun 2019 10:36:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Jun 2019 10:36:26 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] test_power: Add CURRENT and CHARGE_COUNTER properties
Date:   Wed, 26 Jun 2019 10:36:26 +0800
Message-ID: <20190626023626.27603-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190625223537.6dlcooifqfs2rv2b@earth.universe>
References: <20190625223537.6dlcooifqfs2rv2b@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EA14E0A17234A27FDBB97C8C70D467965C7AACC2B838C3E3EB0727BD39C702C42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sebastian,

Thanks for your review and helpful suggestion,
Since our platform is relative simple, I just miss the part you refer to.

I will fix them in patch v2.


Thanks,
	Lecopzer
