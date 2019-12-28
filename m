Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A56C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E59B20748
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577534660;
	bh=nAcNpTNwE94ZE6qLrbAe9iLlYcvIuBdnUhjb4+mionA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7iBhrSqEeeB0P7j8cohggCJICY0zcsDk6H5G6cEecFoPGtCnOakVYr6TZBbtja5N
	 V6YDta33PJ+inRYWFkL0g7z/Uut8ZUvTZTPJTlKRpVLD5h0gms6eIs48ma6Oz+MO/T
	 C/wa/5iLLTyXqjkpnReMaGBn0YHYAsBXzZTTAjUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL1MDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 07:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1MDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 07:03:22 -0500
Received: from localhost (unknown [122.178.200.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2304B20748;
        Sat, 28 Dec 2019 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577534601;
        bh=nAcNpTNwE94ZE6qLrbAe9iLlYcvIuBdnUhjb4+mionA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj4/KAEksEWCS6TdxoU68rLxGYpm0PUGUqWQjGsxnnDr2UqZvQmQ2daZWCnWwg6Yc
         Zn2hX5zA2Zad75QOxNYP5BPFC1n2SZeDWupteYxSrWJJR/wLxDP/ynw+lqNBz3AjKF
         8pHagNtsEcVIkiDkmWgnOZqx/H4dgITSdZgkURwM=
Date:   Sat, 28 Dec 2019 17:33:17 +0530
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
Subject: Re: [alsa-devel] [PATCH v5 03/17] soundwire: rename
 drv_to_sdw_slave_driver macro
Message-ID: <20191228120317.GP3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-4-pierre-louis.bossart@linux.intel.com>
 <20191227070011.GJ3006@vkoul-mobl>
 <e5b45832-6a7e-1538-8069-ef366b87a8b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b45832-6a7e-1538-8069-ef366b87a8b7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-19, 17:23, Pierre-Louis Bossart wrote:
> 
> 
> On 12/27/19 1:00 AM, Vinod Koul wrote:
> > On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> > > Align with previous renames and shorten macro
> > > 
> > > No functionality change
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/bus_type.c       | 9 ++++-----
> > >   include/linux/soundwire/sdw_type.h | 3 ++-
> > >   2 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> > > index c0585bcc8a41..2b2830b622fa 100644
> > > --- a/drivers/soundwire/bus_type.c
> > > +++ b/drivers/soundwire/bus_type.c
> > > @@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> > >   static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
> > >   {
> > >   	struct sdw_slave *slave = to_sdw_slave_device(dev);
> > > -	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
> > > +	struct sdw_driver *drv = to_sdw_slave_driver(ddrv);
> > 
> > so patch 1 does:
> > 
> > -       struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> > +       struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
> > 
> > and here we move drv_to_sdw_slave_driver to to_sdw_slave_driver... why
> > not do this in first patch and save step1... or did i miss something??
> 
> because patch1 introduces replaces 'sdw_' by 'sdw_slave_' in several places,
> not just for drv_to_sdw_driver()
> 
> I can squash all these patches if you want to but then you'll tell me one
> step at a time...

Yes but that does not mean we add an intermediate step just to remove it
later... So please remove the instances of drv_to_sdw_slave_driver() in
patch1 and move them to patch3 (this) and convert to
to_sdw_slave_driver()

Thanks
-- 
~Vinod
