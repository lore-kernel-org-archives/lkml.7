Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67047206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfDDT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:29:03 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:59963 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727398AbfDDT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:29:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E1EDCC1DC92;
        Thu,  4 Apr 2019 19:29:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: event20_142cee4eede3d
X-Filterd-Recvd-Size: 2309
Received: from XPS-9350 (unknown [172.58.19.18])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Apr 2019 19:28:58 +0000 (UTC)
Message-ID: <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
Subject: Re: [PATCH 1/3] soundwire: fix style issues
From:   Joe Perches <joe@perches.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Date:   Thu, 04 Apr 2019 12:28:28 -0700
In-Reply-To: <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
         <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-04 at 13:22 -0500, Pierre-Louis Bossart wrote:
> Visual inspections confirmed by checkpatch.pl --strict expose a number
> of style issues, specifically parameter alignment is inconsistent as
> if different contributors used different styles. Before we restart
> support for SoundWire with Sound Open Firmware on Intel platforms,
> let's clean all this.
> 
> Fix Kconfig help, spelling, SPDX format, alignment, spurious
> parentheses, bool comparisons to true/false, macro argument
> protection.
> 
> No new functionality added.

[]

> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
[]
> @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  		mutex_unlock(&slave->bus->bus_lock);
>  		if (dev_num < 0) {
>  			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> -								dev_num);
> +				dev_num);

You could also add the missing terminating '\n' to these formats like:

 			dev_err(slave->bus->dev, "Get dev_num failed: %d\n",

>  			return dev_num;
>  		}
>  	} else {
>  		dev_info(slave->bus->dev,
> -				"Slave already registered dev_num:%d",
> -				slave->dev_num);
> +			 "Slave already registered dev_num:%d",
> +			 slave->dev_num);

etc...



