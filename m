Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24427C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181020896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560272646;
	bh=axRT5JjYKSXByd3Jz+2a0rbOsJIBRVP+DrKJgM5vAQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ovf5xKWkE2Qyw2JF/AYiVMpIc03xvWruo5ypUbKExYDk40QKEHYsLIKWeBgYpH9VK
	 Z8xJ4CWO7W0Gsh0MKKvC/P2ufLuD4S5WkH44yQPxKGrOfuHIRk9gozDKXOCw/SX4Sh
	 XT8KLxz13d16KyWQjBv8TUjHFZXjND/CMCpRTuWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405804AbfFKREF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405787AbfFKREE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:04:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD6820896;
        Tue, 11 Jun 2019 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560272643;
        bh=axRT5JjYKSXByd3Jz+2a0rbOsJIBRVP+DrKJgM5vAQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VntXkSI14TcPpPRJ8+KMneY8ceW0MOfhaGoB4PIwtAh1wcPgjUhQDfLBwBLgfw1Lg
         MNfdQXia1Mzs7wBgwyrMe1QpGv1SGA9vOJPDDgIWKY8TwaGLMqvNoZRm1Y2oHILAtC
         XFkM7XWPgw6BbJJY+L2RsV2oj+x48LTlDHTFimT0=
Date:   Tue, 11 Jun 2019 19:04:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: for 5.2-rc
Message-ID: <20190611170401.GA23216@kroah.com>
References: <20190611140122.9429-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611140122.9429-1-kishon@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:31:22PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.2 -rc cycle.
> 
> The major fix being moving supplies powering PLLs used by USB, SATA,
> PCIe to tegra-xusb driver fixing initialization failure.
> 
> Others are minor fixes. Please see the tag message below for more
> details.
> 
> Consider merging it in this -rc cycle and let me know if you want me
> to make any changes.
> 
> Thanks
> Kishon
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2-rc
> 
> for you to fetch changes up to ada28f7b3a97fa720864c86504a7c426ee6f91c1:
> 
>   phy: tegra: xusb: Add Tegra210 PLL power supplies (2019-06-07 15:58:34 +0530)
> 
> ----------------------------------------------------------------
> phy: for 5.2-rc
> 
>   *) Move Tegra124 PLL power supplies to be enabled by xusb-tegra124
>   *) Move Tegra210 PLL power supplies to be enabled by xusb-tegra210
>   *) Minor fixes: fix memory leaks at error path, fix sparse warnings
>      and addresses coverity.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable
> 
> Florian Fainelli (1):
>       phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal
> 
> Thierry Reding (3):
>       dt-bindings: phy: tegra-xusb: List PLL power supplies
>       phy: tegra: xusb: Add Tegra124 PLL power supplies
>       phy: tegra: xusb: Add Tegra210 PLL power supplies
> 
> Yoshihiro Shimoda (1):
>       phy: renesas: rcar-gen2: Fix memory leak at error paths
> 
> YueHaibing (1):
>       phy: ti: am654-serdes: Make serdes_am654_xlate() static

sparse fixes are not for the -rc cycle, unless they fix an actual bug.

Care to send these as a patch series and I can queue up the real
bugfixes for -final and take the others for 5.3-rc1?

thanks,

greg k-h
