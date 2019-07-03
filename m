Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1332184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562176772;
	bh=qcjf0F/KpOBz3u3VNKEDbRvTWFQxOBmG4BLXbKgdmno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gaMqYsnwEgKUwaMDp9hJZZ6AcqXP2HEhAr+qJKtCn3lDwHUHZlRnCYad0PB6BaL/l
	 32uAMHDm6a9Z9L2WXX7IwXWjuAAYx0SAbLylbcIlImDC+AkhXQJnF05L+mTNztW7gw
	 ysA4pl84ikVKTPZDho4D4u0Mx0dClobGin7tRxAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGCR7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCR7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:59:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6CC2184C;
        Wed,  3 Jul 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176769;
        bh=qcjf0F/KpOBz3u3VNKEDbRvTWFQxOBmG4BLXbKgdmno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnc0EhpUR85NpjNg03Y17RSy22nOvxYf5/oKjt+VqUurePVrE1TCcCNPYHoQ7b6d7
         TpyEuLxUZ0ket7+q0uCdntXXzUGEqQl/1Cz1eoe7cmXXdCj5tGvfDBl9sZxFnYMCOS
         HJMn1xsXgYM1x8lqdsmg2FHr629S1ayYnakdXVZ4=
Date:   Wed, 3 Jul 2019 19:59:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
Message-ID: <20190703175926.GA14649@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-6-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004951.6202-6-mdf@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 05:49:41PM -0700, Moritz Fischer wrote:
> From: Wu Hao <hao.wu@intel.com>
> 
> This patch adds virtualization support description for DFL based
> FPGA devices (based on PCIe SRIOV), and introductions to new
> interfaces added by new dfl private feature drivers.
> 
> [mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)

This doesn't apply to my tree, where is this file created?

thanks,

greg k-h
