Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908A821473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556512273;
	bh=e6mqkgj6fASOMd9A4trc63E199shlwLkHtmiX4rlw6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgTH5VOyd4nzsSHBKmm7+rXiZBp4lxcjKc3YnKqL+OajG33hj82SlhmU6Be+gEilF
	 y4pKT/KGStiA2mIPDMx0pP1cmlrXs4xDVkRmHMYneZ79KqYDHGd31ba4OQ0GTdptS3
	 fS6+02uRMKRATs5/wcICK5kRP39CgFakivzL5Kqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfD2EbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 00:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfD2EbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:31:12 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC262075E;
        Mon, 29 Apr 2019 04:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556512271;
        bh=e6mqkgj6fASOMd9A4trc63E199shlwLkHtmiX4rlw6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tE346KzyoiyG1REy5RhL3sJb4fR4A0yWSxBCdvQKd+Haz8JoqUsu7EM5QaqcBZ6hV
         YgU7OQw0nB3wLDtfx33u9Cj2/+aJj5Gflm5vGZgKuBBVCnSO5cstwvuwCtriEAn+cl
         fcPrgVG/nPe4zj3l2/AABKP1R7eqx6Svl6pW1WyU=
Date:   Mon, 29 Apr 2019 10:01:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the slave-dma tree
Message-ID: <20190429043106.GB3845@vkoul-mobl.Dlink>
References: <20190428171701.2a96cd3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428171701.2a96cd3c@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-19, 17:17, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   9bd1be60f55b ("dmaengine: stm32-dma: Fix unsigned variable compared with zero")
> 
> Fixes tag
> 
>   Fixes: f4fd2ec08f17: ("dmaengine: stm32-dma: use platform_get_irq()")
> 
> has these problem(s):
> 
>   - The colon following the SHA1 is unexpected
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

Thanks Stephen for the report.

Have fixed it up.

-- 
~Vinod
