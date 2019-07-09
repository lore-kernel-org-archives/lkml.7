Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E0C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ADA20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfGIVSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:18:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGIVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:18:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17C41141FD118;
        Tue,  9 Jul 2019 14:18:20 -0700 (PDT)
Date:   Tue, 09 Jul 2019 14:18:19 -0700 (PDT)
Message-Id: <20190709.141819.2176127473515467438.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     joabreu@synopsys.com, andrew@lunn.ch, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com,
        jianguo.zhang@mediatek.com, boon.leong.ong@intel.com
Subject: Re: [PATCH 0/2 net-next] fix out-of-boundary issue and add taller
 hash table support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190709023623.8358-1-biao.huang@mediatek.com>
References: <20190709023623.8358-1-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 09 Jul 2019 14:18:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Tue, 9 Jul 2019 10:36:21 +0800

> Fix mac address out-of-boundary issue in net-next tree.
> and resend the patch which was discussed in
> https://lore.kernel.org/patchwork/patch/1082117
> but with no further progress.

Series applied, thanks.
