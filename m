Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C5C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FDA2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558933627;
	bh=JU1NrVbdht/wgDt/mN5PmE1t+0SNrC2HHFhP9dHU4dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aucM2p+mDl2H3mqY8chqONQTwQCp5bskYKJTeCPf+26LqVxQYCVNW6zr0R2Mq4rpj
	 dWHaN6YJdf9iZ+I+YKBoXE6buIfPRSU060tZX0AfZ2JboPbqz4dow9evbwgWOWnKEK
	 Dh4XwG4J8GMuvVXOGmPBfNvxCF536Yzm1y02aHYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfE0FHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 01:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0FHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:07:05 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FD720657;
        Mon, 27 May 2019 05:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558933625;
        bh=JU1NrVbdht/wgDt/mN5PmE1t+0SNrC2HHFhP9dHU4dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJA1dKIlPMCK82jlEMJLUp9jpNO+VOImlzaJJ9hLvBL+jsSl6Dt8jJFUFggEQxWWb
         9z14N2UB7wBAhSjep/iJCqB/0UW8F7PuxHYqgLylKiM9mvUsDEmt+kUnVNqqiex2WK
         PQcq9+Q+LPlqN6e16LnGtxVZMIQOGNK9NXLSKKDo=
Date:   Mon, 27 May 2019 10:37:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on arm64
Message-ID: <20190527050701.GZ15118@vkoul-mobl>
References: <20190404081221.341-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 09:12, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
> 
> readl and writel are undefined.
> This patch fixes that by including io.h.

Applied, thanks

-- 
~Vinod
