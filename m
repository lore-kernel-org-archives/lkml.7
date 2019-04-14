Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D89C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6E920850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555235933;
	bh=8v/01mepEUMvTMFUZjSNXAzXXG8RMPXeuxjXVLbL9LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ta3BXqpotw5Dsh7jeqlm1Ol4AQLsRNHpASgwtRXGpR2TjTQSh00YewG4Qf/Zll9a
	 Bhpv4kw0zH1CdG93ESx7fmbaaVOUwmEZAi2LeCsJd8o5SOwYdtLH7/rQ4m+xoCi9uk
	 Zjrw0cJJLCnBgyU7a7ad+NsXqcLjE3/tPJiS2I/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfDNJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 05:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfDNJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 05:58:48 -0400
Received: from localhost (unknown [106.199.53.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FA820850;
        Sun, 14 Apr 2019 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555235927;
        bh=8v/01mepEUMvTMFUZjSNXAzXXG8RMPXeuxjXVLbL9LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7psuBytH1ciOWetY676fOJNEd016DOlvu/Rtz8afblUU/QwM0feVwP1ZuLbLz7mn
         a1zT/i1itoR+RIiL2kxJg/DbPGYrs7QQSo+kH6tX7YPAVIRBhZ1VZm7xgEH+nSZ3U6
         7RR4FXzdkakB8hUVfI6JcOAIDV7ySdxkvj40zN0o=
Date:   Sun, 14 Apr 2019 15:28:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v3 2/5] soundwire: fix style issues
Message-ID: <20190414095839.GG28103@vkoul-mobl>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
> Visual inspections confirmed by checkpatch.pl --strict expose a number
> of style issues, specifically parameter alignment is inconsistent as
> if different contributors used different styles. Before we restart
> support for SoundWire with Sound Open Firmware on Intel platforms,
> let's clean all this.
> 
> Fix Kconfig help, spelling, SPDX format, alignment, spurious
> parentheses, bool comparisons to true/false, macro argument
> protection.

Thanks for the cleanup Pierre :)

> 
> No new functionality added.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Kconfig          |   2 +-
>  drivers/soundwire/bus.c            |  87 ++++++++--------
>  drivers/soundwire/bus.h            |  16 +--
>  drivers/soundwire/bus_type.c       |   4 +-
>  drivers/soundwire/cadence_master.c |  87 ++++++++--------
>  drivers/soundwire/cadence_master.h |  22 ++--
>  drivers/soundwire/intel.c          |  87 ++++++++--------
>  drivers/soundwire/intel.h          |   4 +-
>  drivers/soundwire/intel_init.c     |  12 +--
>  drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
>  drivers/soundwire/slave.c          |  10 +-
>  drivers/soundwire/stream.c         | 161 +++++++++++++++--------------

I would prefer this to be a patch per module. It doesnt help to have a
single patch for all the files!

It would be great to have cleanup done per logical group, for example
typos in a patch, aligns in another etc...

>  12 files changed, 313 insertions(+), 295 deletions(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 19c8efb9a5ee..84876a74874f 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -4,7 +4,7 @@
>  
>  menuconfig SOUNDWIRE
>  	bool "SoundWire support"
> -	---help---
> +	help

Not sure if this is a style issue, kernel seems to have 2990 instances
of this!

>  	if (msg->page)
>  		sdw_reset_page(bus, msg->dev_num);
> @@ -243,7 +244,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>   * Caller needs to hold the msg_lock lock while calling this
>   */
>  int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
> -				struct sdw_defer *defer)
> +		       struct sdw_defer *defer)

this does not seem aligned to me!

>  int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
> -		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
> +		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)

this one too

> @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  		mutex_unlock(&slave->bus->bus_lock);
>  		if (dev_num < 0) {
>  			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> -								dev_num);
> +				dev_num);

It might read better if we move the log to second line along with
dev_num...

>  int sdw_configure_dpn_intr(struct sdw_slave *slave,
> -			int port, bool enable, int mask)
> +			   int port, bool enable, int mask)

not aligned

>  void sdw_extract_slave_id(struct sdw_bus *bus,
> -			u64 addr, struct sdw_slave_id *id);
> +			  u64 addr, struct sdw_slave_id *id);
>  

Not aligned
 
>  enum sdw_command_response
>  cdns_xfer_msg_defer(struct sdw_bus *bus,
> -		struct sdw_msg *msg, struct sdw_defer *defer)
> +		    struct sdw_msg *msg, struct sdw_defer *defer)

this one too..

>  static int cdns_port_params(struct sdw_bus *bus,
> -		struct sdw_port_params *p_params, unsigned int bank)
> +			    struct sdw_port_params *p_params, unsigned int bank)

here as well.. (and giving up on rest)

-- 
~Vinod
