Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA362C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799842087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553489918;
	bh=cTSsNXr2mDcbg+U/K+8FAwTOUBIWOlY4eTKtXjbrcmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g5LiL6OVGV8MOkuhBSMhj3Hy3wARQ46xnvcvh4vaV9JeBFFSBUnjdZG0gvC1LRP7X
	 YZ+E+znEvUWVRooofegQXOUW186pgRX7YS/gIB9drtvl1AIDnUqC3Opbq7qFVuaZCy
	 CEpyHKSllz1SniF2A5Tkm+0igBjkKFLPaTsOG+s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfCYE6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfCYE6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:58:36 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981C82087F;
        Mon, 25 Mar 2019 04:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553489916;
        bh=cTSsNXr2mDcbg+U/K+8FAwTOUBIWOlY4eTKtXjbrcmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHP8Rjm8iVx8fiJSozTnUQuJPv9bvu3gDBV8BcDHZj6Wyteqg79gPIYuOQtzdZOmJ
         /28wa+WCi77CQVrXIdQ2WXe1M4GjIXMTgawaRlSQ3TQdl9zY9JzdYI2ZqE932X22AG
         YwWi/4yqiX21rtc4oURF/LWAjhg4ABZmQJHlN6I8=
Date:   Mon, 25 Mar 2019 10:28:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: pl330: introduce debugfs interface
Message-ID: <20190325045830.GI5348@vkoul-mobl>
References: <20190317100306.18405-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317100306.18405-1-katsuhiro@katsuster.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-03-19, 19:03, Katsuhiro Suzuki wrote:
> This patch adds debugfs interface to show the relationship between
> DMA threads (hardware resource for transferring data) and DMA
> channel ID of DMA slave.
> 
> Typically, PL330 has many slaves than number of DMA threads.
> So sometimes PL330 cannot allocate DMA threads for all slaves even
> if a user specify DMA channel ID in devicetree. This interface will
> be useful for checking that DMA threads are allocated or not.
> 
> Below is an output sample:
> 
> $ sudo cat /sys/kernel/debug/ff1f0000.dmac
> PL330 physical channels:
> THREAD:         CHANNEL:
> --------        -----
> 0               8
> 1               9
> 2               11
> 3               12
> 4               14
> 5               15
> 6               10
> 7               --
> 

Applied, thanks

-- 
~Vinod
