Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0DCC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E007208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577430018;
	bh=1z8mayJa999Z2o7h/Q4jAKny+evFFOv8o8wb9X4zdj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YUvHuCHEahTgfrKIzT/+ERxYvgrrMKvfRdMiIyYKMgmk0Tcu62pOBebS/ziZwd4ck
	 nAuNiIghp+77t3IyOPibhMyGt9+1WNh7botc7QOkeKmO33yOP9hNGCeYa4tFAGyTdQ
	 04KEYht18IkETQzKPzF/KmEccgTLpEUjEKp5DBkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL0HAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0HAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:00:16 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18451206CB;
        Fri, 27 Dec 2019 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577430015;
        bh=1z8mayJa999Z2o7h/Q4jAKny+evFFOv8o8wb9X4zdj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilvXcicEtRtE7JkYp5OrXXn91OeqUCIPAqvQnsreM0llMjHsWFAx82Dq5TCwWTYVk
         wnj1sI77OdEsich8EewqKSXz12tklUzWn+bqEZeLJW8NY34R2ELhWIAHY/T9Q8j3iu
         hCmdrvmGjO5jD9xxX/UH5ir1owYIjzm4424MTETc=
Date:   Fri, 27 Dec 2019 12:30:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 03/17] soundwire: rename drv_to_sdw_slave_driver macro
Message-ID: <20191227070011.GJ3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217210314.20410-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> Align with previous renames and shorten macro
> 
> No functionality change
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c       | 9 ++++-----
>  include/linux/soundwire/sdw_type.h | 3 ++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index c0585bcc8a41..2b2830b622fa 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
>  static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
>  {
>  	struct sdw_slave *slave = to_sdw_slave_device(dev);
> -	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
> +	struct sdw_driver *drv = to_sdw_slave_driver(ddrv);

so patch 1 does:

-       struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+       struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);

and here we move drv_to_sdw_slave_driver to to_sdw_slave_driver... why
not do this in first patch and save step1... or did i miss something??

-- 
~Vinod
