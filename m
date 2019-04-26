Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3145C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48F2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556277719;
	bh=UTTAxG+Jg2VAeqcLpeFJKIEKlZAfzGGDG25z5H78rAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sG1yqamLhnixXORFEKAJzvz+OP1Empq7TUVmM1YbEEtagilM/pglZ8y/CAOr/yh6T
	 ZvYP5xXxKC9qrUAco0MamW00wZBde2Ytk+AJjwrpsu5UQlawe3dcvevAUdbsWEoUKI
	 b/iCPqkXNDhzIObV14gwI5GeLGgzClIYTLx6elPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDZLV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:21:58 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3C4206C1;
        Fri, 26 Apr 2019 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556277717;
        bh=UTTAxG+Jg2VAeqcLpeFJKIEKlZAfzGGDG25z5H78rAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+6KkdQqRKDBxuQwEWECujbYKroyxMsUN1ZGCNldId/wYNBxex9hZZXZn2uJKXoRU
         3vJAtRYLJFg7/3fvBkY2lkHFdXFIlVzUUk+NOrKPvpv1zWCvMWKhnNGVbVMj1QJPIS
         7MAHS3/Z9G0fs1D+9HoIpeYne2/hwhOjoncJtc/g=
Date:   Fri, 26 Apr 2019 16:51:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org,
        linux-rockchip@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: _stop: clear interrupt status
Message-ID: <20190426112151.GQ28103@vkoul-mobl>
References: <1554289582-43695-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554289582-43695-1-git-send-email-sugar.zhang@rock-chips.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-19, 19:06, Sugar Zhang wrote:
> This patch kill instructs the DMAC to immediately terminate
> execution of a thread. and then clear the interrupt status,
> at last, stop generating interrupts for DMA_SEV. to guarantee
> the next dma start is clean. otherwise, one interrupt maybe leave
> to next start and make some mistake.

Applied, thanks

-- 
~Vinod
