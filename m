Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1670FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E42083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571029422;
	bh=mS3CctfHD5469kRjRuKvd4vU4oRhuSk3zV0oFGa4ofA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=penDLeGRn7v+7BPUH+NJD2WcmmvwMyhhC096i0h+3Yk85Su1PzqwCDI3o1TKW3FuB
	 P8GG26EnN0e2cLs1XglMYUNjFEQkNxSuOogzes8PXNtEIjzch7gZLXjarJfapMEiHh
	 Mv52nkTmi5KETdLpGE5C1uIQjDNizi+CrTxWq1jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfJNFDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfJNFDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:03:19 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088582083B;
        Mon, 14 Oct 2019 05:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571029398;
        bh=mS3CctfHD5469kRjRuKvd4vU4oRhuSk3zV0oFGa4ofA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbJ9AGyAQP8GZ230tH1AG7Q+XwfKF/s5qTtLar9YnWluOrL9C77A7pwWqlTaLufPc
         VlYpkRbD+uJaciceRpH7QjnUAvITd67hF44RNJBmyfaCxG5VwjOI9YsQI3jCcouyF5
         jb1S7qh+8XUws3v6TYsdGvS4K6pD/iIA9pvUV6pk=
Date:   Mon, 14 Oct 2019 10:33:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com
Subject: Re: [PATCH] dmaengine: sprd: Fix the link-list pointer register
 configuration issue
Message-ID: <20191014050313.GG27950@vkoul-mobl>
References: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-19, 13:47, Baolin Wang wrote:
> From: Zhenfang Wang <zhenfang.wang@unisoc.com>
> 
> We will set the link-list pointer register point to next link-list
> configuration's physical address, which can load DMA configuration
> from the link-list node automatically.
> 
> But the link-list node's physical address can be larger than 32bits,
> and now Spreadtrum DMA driver only supports 32bits physical address,
> which may cause loading a incorrect DMA configuration when starting
> the link-list transfer mode. According to the DMA datasheet, we can
> use SRC_BLK_STEP register (bit28 - bit31) to save the high bits of the
> link-list node's physical address to fix this issue.

Applied, thanks

-- 
~Vinod
