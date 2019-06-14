Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FE21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560491364;
	bh=FESF3oWjtlfGp5YHypGT3YoUEo0yLRez1gMxgzKPF2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jVhbt9QD1B1MopPrIbeFJT3nnMmASS9M3bAcf9CQrk2IaXtcfEdHpQiOjmBA7vCoI
	 xT+bAOA5Yhg61g5f5G+pyhj23VwldJ+xOn/0i6hmUlQKEF9AasImSSO1GFkd2/AOhk
	 nuuib3kBSPh4/4KqGeI+axU0ipicwB8FkMGIW7XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFNFtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNFtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:49:23 -0400
Received: from localhost (unknown [106.201.34.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D1D21473;
        Fri, 14 Jun 2019 05:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560491362;
        bh=FESF3oWjtlfGp5YHypGT3YoUEo0yLRez1gMxgzKPF2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1we4frlaEHalYp7oQhyNpSM/Izb2bQirr1KTsQuJnAKbF1iMnyCN7VXET7ajF4rF9
         nfUlfVO9fO+1LZ0tthGagcA2WXripcihEBdMGFmhsfdyjCaprAfYSomMXajpa4HCcA
         hKvslBWlWdG7sHLmhPQTlj3McT2w8n4Ni3YrhK3k=
Date:   Fri, 14 Jun 2019 11:16:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dma: amba-pl08x: no need to cast away call to
 debugfs_create_file()
Message-ID: <20190614054613.GB2962@vkoul-mobl>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612122557.24158-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-19, 14:25, Greg Kroah-Hartman wrote:
> No need to check the return value of debugfs_create_file(), so no need
> to provide a fake "cast away" of the return value either.

Applied all after fixing the subsystem tag (dmaengine), thanks

-- 
~Vinod
