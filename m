Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B3CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F179215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572759013;
	bh=9oqXe3JHVRI89OqTwF0y1fkMeszReKpL2VFA38BTlXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bSXdsGX80X7HbuFA0gXtKsec/D2ooDdrC1Bp3HpEEtQudqaj9pKhJc0hI8AE+USfI
	 l2My72Bmww7/RB7KPEkDKR/QDArFHMl2ScsTjf3j+VlArkeJKlPijfruVxXB7FgWsd
	 M05ZZL3LRorcqDwWYshI9eWDkjgDPlihycqdDy/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKCFaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 01:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfKCFaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:30:12 -0400
Received: from localhost (unknown [106.206.115.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C69214D8;
        Sun,  3 Nov 2019 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572759011;
        bh=9oqXe3JHVRI89OqTwF0y1fkMeszReKpL2VFA38BTlXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjDLVTeMMZD4pw16JgzV5sc6WawxToDl0wHuKA2iOd+3d/yxqsedyBk1bJNeRhSb+
         PKpyZJR2PKIzFkJTpcMUBdKuHFcr7PtpZNolj5UFLoVJHT+N6Ww1uK3AtGGd2kJe0F
         JtRu1o/h9CLriPHA6v3lqF61Lv1+KpN97N+Zf7Dg=
Date:   Sun, 3 Nov 2019 11:00:03 +0530
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
Subject: Re: [PATCH 04/14] soundwire: bus_type: rename sdw_drv_ to
 sdw_slave_drv
Message-ID: <20191103053003.GH2695@vkoul-mobl.Dlink>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023212823.608-5-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
> Before we add master driver support, make sure there is no ambiguity
> and no occirrences of sdw_drv_ functions.
        ^^^^^^^^^^^
typo

> 
> No functionality change.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 2b2830b622fa..9a0fd3ee1014 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -67,7 +67,7 @@ struct bus_type sdw_bus_type = {
>  };
>  EXPORT_SYMBOL_GPL(sdw_bus_type);
>  
> -static int sdw_drv_probe(struct device *dev)
> +static int sdw_slave_drv_probe(struct device *dev)
>  {
>  	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
> @@ -113,7 +113,7 @@ static int sdw_drv_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int sdw_drv_remove(struct device *dev)
> +static int sdw_slave_drv_remove(struct device *dev)
>  {
>  	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
> @@ -127,7 +127,7 @@ static int sdw_drv_remove(struct device *dev)
>  	return ret;
>  }
>  
> -static void sdw_drv_shutdown(struct device *dev)
> +static void sdw_slave_drv_shutdown(struct device *dev)
>  {
>  	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
> @@ -155,13 +155,13 @@ int __sdw_register_slave_driver(struct sdw_driver *drv,
>  	}
>  
>  	drv->driver.owner = owner;
> -	drv->driver.probe = sdw_drv_probe;
> +	drv->driver.probe = sdw_slave_drv_probe;
>  
>  	if (drv->remove)
> -		drv->driver.remove = sdw_drv_remove;
> +		drv->driver.remove = sdw_slave_drv_remove;
>  
>  	if (drv->shutdown)
> -		drv->driver.shutdown = sdw_drv_shutdown;
> +		drv->driver.shutdown = sdw_slave_drv_shutdown;
>  
>  	return driver_register(&drv->driver);
>  }
> -- 
> 2.20.1

-- 
~Vinod
