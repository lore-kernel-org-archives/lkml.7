Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6494CC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3787222CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566301518;
	bh=0lT4v0LX5pXjxpd6d87L+ufuAZo4ezWjtwt8ULNdJPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YhWorzlFLs1+ogAtni9A/4oIF6vJYxsNziKa1/oLcVhtGaHBJK2RXIZ1GVB3qbEWl
	 3cF+Wt5x8xv/RnCFHtwBSpZxhOn6tK6+k529m9wrU7wsV3CJMh4Snk8KiA8lkEA7TR
	 28h0b3KyrHJC1Mo69LErH7vVMBKcsPoOj2CgFZBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfHTLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfHTLpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:45:17 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD5C22CE3;
        Tue, 20 Aug 2019 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301516;
        bh=0lT4v0LX5pXjxpd6d87L+ufuAZo4ezWjtwt8ULNdJPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDMllfagwKR8/yMdUxTCr+elQziywK4erQs3BAm7X1MV4qGn5c4YYxwVNB79ZxSt1
         fGQxFMaJMOKTxT3jVgRlowh/ueYII+COBETOpzG2HRuXis4+qF3TSeRHI/juwti0jp
         Bxoiih4+OKFKAyQnhv7Jl7N5tu0KkSjElIyPf/ac=
Date:   Tue, 20 Aug 2019 17:14:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()
Message-ID: <20190820114405.GY12733@vkoul-mobl.Dlink>
References: <1565938570-7528-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565938570-7528-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-19, 01:56, Wenwen Wang wrote:
> If devm_request_irq() fails to disable all interrupts, no cleanup is
> performed before retuning the error. To fix this issue, invoke
> omap_dma_free() to do the cleanup.

Applied, thanks

-- 
~Vinod
