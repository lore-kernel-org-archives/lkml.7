Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F3FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB24206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411171;
	bh=qI8ahNpD1iQyrJrO5dS7vs1MPbfhBAltyfK6bwpyVu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EAwnrPQq9wxLHzRGaSHAzkYQsQb/K6o2DL+28gF4Pqmz20LkQPbw/fBK9y7UVzxf1
	 qG8/AUHTFXeaGvzcNYPpStiI/szW/XMB5/02+JJC0SOaS5HL7kKfPKSwz8obmqtkjT
	 05P13pvUW+xjYKQTKPvXyLUZjK3zeLfgdz5i+ibg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfDPKj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfDPKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:39:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207AC20693;
        Tue, 16 Apr 2019 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555411168;
        bh=qI8ahNpD1iQyrJrO5dS7vs1MPbfhBAltyfK6bwpyVu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdsSlEaEBENZI8YcQxGV9E4STnKlmLWL4nTHNz3Y8/Ju6IPxMBfaCuMxcjWK69Anb
         zy0T0g+dGD/h3tQXaQx74ugGMvckFOOj0nMSr8+nyKAJ+YfJa5sYVwhOkJk1VA9v7H
         Wmxy8xm4nsGe1uZpBHdjjp/ZZ4VuttPOPbYYrOrA=
Date:   Tue, 16 Apr 2019 12:30:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.1 -rc
Message-ID: <20190416103059.GA8292@kroah.com>
References: <20190403044353.21620-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403044353.21620-1-kishon@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:13:53AM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.1 -rc cycle below.
> 
> It fixes PHY programming sequence in phy-ti-pipe3 driver to align with
> TRM, requests IRQ only for OTG in phy-rcar-gen3-usb2 and a bunch of
> other linker errors and compilation warnings seen in randconfig.
> 
> Please see the complete list of changes in the tag message below and let
> me know if I have to make any modifications.
> 
> Thanks
> Kishon
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.1-rc
> 
> for you to fetch changes up to d5d60c3f25ab52de7c5dfd31f584f190b754629e:
> 
>   phy: fix platform_no_drv_owner.cocci warnings (2019-04-03 10:02:20 +0530)
> 
> ----------------------------------------------------------------
> phy: for 5.1-rc
> 
>   *) Follow TRM sequence in phy-ti-pipe3 driver to ensure DPLL & PHY
>      operates correctly over the entire temperature range
>   *) Fix missing bit-wise 'OR' operator in ti-pipe3 driver
>   *) Fix to request IRQ only for OTG in phy-rcar-gen3-usb2 driver
>   *) Fix linker errors and compilation warnings got with randconfig
>   *) Fix sparse warnings and .cocci warnings
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ----------------------------------------------------------------
> Arnd Bergmann (3):
>       phy: allwinner: allow compile testing
>       phy: ti: usb2: fix OMAP_CONTROL_PHY dependency
>       phy: mapphone-mdm6600: add gpiolib dependency
> 
> Colin Ian King (1):
>       phy: ti-pipe3: fix missing bit-wise or operator when assigning val
> 
> Fabrizio Castro (1):
>       phy: renesas: rcar-gen3-usb2: No need to request IRQ for non-OTG
> 
> Roger Quadros (4):
>       phy: ti-pipe3: Introduce mode property in driver data
>       phy: ti-pipe3: improve DPLL stability for SATA & USB
>       phy: ti-pipe3: Fix SATA & USB PHY power up sequence
>       phy: ti-pipe3: Fix PCIe power up sequence
> 
> Tony Lindgren (1):
>       phy: phy-twl4030-usb: Fix cable state handling
> 
> YueHaibing (3):
>       phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
>       phy: qcom-ufs: Make ufs_qcom_phy_disable_iface_clk static
>       phy: fix platform_no_drv_owner.cocci warnings
> 
>  drivers/phy/allwinner/Kconfig              |   9 ++--
>  drivers/phy/marvell/phy-mvebu-a3700-utmi.c |   1 -
>  drivers/phy/motorola/Kconfig               |   2 +-
>  drivers/phy/qualcomm/phy-qcom-ufs.c        |   2 +-
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c   |  27 ++++++------
>  drivers/phy/rockchip/phy-rockchip-typec.c  |   4 +-
>  drivers/phy/ti/Kconfig                     |   2 +-
>  drivers/phy/ti/phy-ti-pipe3.c              | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------

That's a lot of changes so late in the release cycle for one driver.
Are you sure those are not 5.2-rc1 things?

thanks,

greg k-h
