Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC460C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7F23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567575945;
	bh=sIdRxjWonCnVUCMb6786X+EVPlTc/30bShqQftNt7wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HEJLUCTbATj/4VLFLLqaNkPJl9VyKsIb4GU5iEczYQymwtelXt4q3ECt5XPGO+Qhy
	 iE9Q9KP/O8puOsX2RP7T6lNWbywI5bvo6iT0/mAedJxaYv80wSnA0yrz8Hl7/l4G98
	 O4Fu+e6gOqdcYdkABxni7zebrp41bsPpWhseziM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIDFpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDFpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:45:44 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAA62089F;
        Wed,  4 Sep 2019 05:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567575943;
        bh=sIdRxjWonCnVUCMb6786X+EVPlTc/30bShqQftNt7wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcvJJmbc9ZDfyIH6wpK/4/FwWz3Q0Hs5Zy7Topm9SGxejyz9872WXxKAWYCtl42oS
         CJr13LTkS8pI/OSYxEKmBQi/46UJ21XDbjvGThcQj12HWHBcXjyBqdcc028JqUlGjU
         wYJb551uYTbaIYI/WpUnPSuCbtQBhf3NkG8wuoYI=
Date:   Wed, 4 Sep 2019 11:14:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.co>
Subject: Re: [PATCH] dma: iop-adma.c: fix printk format warning
Message-ID: <20190904054433.GB2672@vkoul-mobl>
References: <1803541f-98a6-7cce-b050-ff1e9a333ab2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1803541f-98a6-7cce-b050-ff1e9a333ab2@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-19, 22:06, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warning in iop-adma.c (seen on x86_64) by using
> %pad:
> 
> ../drivers/dma/iop-adma.c:118:12: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘dma_addr_t {aka long long unsigned int}’ [-Wformat=]

Applied, thanks

-- 
~Vinod
