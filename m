Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDAB233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566455186;
	bh=rPBSwpnS+cnfcPZ3TBKKII3gNOdcXoeSX+9+ZfKdTOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pg9ifLQIJJhfTVbbxXvQjXXUI1ATj/rUlo58wMMbCeQRwZM90aG1YGcDC63IrnPyO
	 EPyaiqJpLoYqE0iiyG2HolUmxdJCibR5OIy9lO9Z7NfkPyHV/d63L/wu6Gkgchgv2a
	 KFc+HyVXsuRlzBPR0SwHiBn649YlpcRveRlWCIXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfHVG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbfHVG0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:26:24 -0400
Received: from localhost (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A26205ED;
        Thu, 22 Aug 2019 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566455183;
        bh=rPBSwpnS+cnfcPZ3TBKKII3gNOdcXoeSX+9+ZfKdTOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL6yD2PeEptr4pH9jGIbJ5a0drDZUwXzUFuXBX7Ghd5XMQTVbOZfizl2+qo2avInh
         xyIYMx19kGx8mW3WuGZ5LbcRHBKoGnzlb8avvzUethT9xTAKjO/8yxF3osScy0Ivm9
         YBD6SYPbYM1Zimox+JQnKv+ZzqFMbQrXkrMfLhok=
Date:   Thu, 22 Aug 2019 11:55:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: build warning after merge of the soundwire tree
Message-ID: <20190822062512.GL12733@vkoul-mobl.Dlink>
References: <20190822160425.6998054e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822160425.6998054e@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 16:04, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the soundwire tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/soundwire/intel.c: In function 'sdw_master_read_intel_prop':
> drivers/soundwire/intel.c:829:12: warning: unused variable 'i' [-Wunused-variable]
>   int nval, i;
>             ^
> drivers/soundwire/intel.c:829:6: warning: unused variable 'nval' [-Wunused-variable]
>   int nval, i;
>       ^~~~
> 
> Introduced by commit
> 
>   085f4ace103d ("soundwire: intel: read mclk_freq property from firmware")

Thanks Stephen for the report. I have fixed it up by removing these.
Posting the patch now

Thanks
-- 
~Vinod
