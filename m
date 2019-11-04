Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A2CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F2220869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572880658;
	bh=vLv3UOi/SngTRvl7gzNmmsDbqRgqMxbFhwwLSk46fTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x7/7vmPhWXDkNhoCjf/+inWj40I+fqueJh242ldDS6w8WYrqDXC7XcxoYa9OfaLm4
	 th0Y44Hk/slFyBFtDxOjvB6AOW+bJp+2F0G8Ma58tS9Hgv9h+h5wozm2xOBPoGqeqO
	 NH/Xv5dtB3kHsWUY8xKsriXgl5H8Cx9U176HfxW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfKDPRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDPRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:17:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7229820663;
        Mon,  4 Nov 2019 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572880656;
        bh=vLv3UOi/SngTRvl7gzNmmsDbqRgqMxbFhwwLSk46fTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rE9XrtOVyOmKggacqYMCqtsNCUE0Pwxwo6+vx8ZGSnO8VEupIseNrIUZNyWpvmw7j
         zsi8M3QqZ4Mm6aEjAcZyotc8OaZGzgLQi+HCJMVuf8PGZo+nP7CGpzcvSGuRGOHZj3
         c/zekPiSwe9eRGFgFOdBsF2B/8UKQP+m5GV0+BFY=
Date:   Mon, 4 Nov 2019 15:17:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
Subject: Re: [PATCH v5 0/7] Improve tlb range flush
Message-ID: <20191104151729.GC24909@willie-the-truck>
References: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:01:01PM +0800, Yong Wu wrote:
> This patchset mainly fixes a tlb flush timeout issue and use the new
> iommu_gather to re-implement the tlb flush flow. and several clean up
> patches about the tlb_flush.
> 
> change note:
> 
> v5: No code change. Only update the commit message of the last patch[7/7]
>     suggested from Tomasz in the internal review.

I'm assuming Joerg will pick this up for 5.5.

Will
