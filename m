Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0C42133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556775151;
	bh=iTQiL4LvMH0l1z4GfH2eWic6igDsZT3xNziA83eKMz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D4bQcgJ2Qlwzo75YkeLoO4ABLJMB+z6ZX2JT05ctKfAXfjdPXGDIMPvy27yiiWmlg
	 XQ/nwMYfhnu3ybak2ggDhWYgoFlNDSrdFUkvGS+PAMWNqd/xOKTvM6jxxIMrJbgZTJ
	 8mvai4O7qxH/PqM8EhHpsbzQi5I9ZwYsy3T3u/+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBFca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfEBFca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:32:30 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01202085A;
        Thu,  2 May 2019 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556775149;
        bh=iTQiL4LvMH0l1z4GfH2eWic6igDsZT3xNziA83eKMz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2w1SqOqXtg5zSQGVl4R9VNW1JPfDT4d8saIAFFxwkUKzvM2Z89BOZ7f/drPoAuYP
         Af/Sm7/8osejfkVf+O4mKhZe+BBdXi+ZYs3bTocRSCrvw6SYSMiBvR259c1RLPgdfN
         V7g6j8HiLPvYe7bpJlnXU3Fw1hSKD6HmDgq7jUJM=
Date:   Thu, 2 May 2019 11:02:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 06/22] soundwire: bus: remove useless parentheses
Message-ID: <20190502053220.GC3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> and make the code more readable

Well patch subject and log are not meant to be read as a continuous
statement, It would nice to have a proper lines for this

> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index efdcefc62e1a..423dc6d17999 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -415,10 +415,10 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
>  static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
>  {
>  
> -	if ((slave->id.unique_id != id.unique_id) ||
> -	    (slave->id.mfg_id != id.mfg_id) ||
> -	    (slave->id.part_id != id.part_id) ||
> -	    (slave->id.class_id != id.class_id))
> +	if (slave->id.unique_id != id.unique_id ||
> +	    slave->id.mfg_id != id.mfg_id ||
> +	    slave->id.part_id != id.part_id ||
> +	    slave->id.class_id != id.class_id)
>  		return -ENODEV;
>  
>  	return 0;
> @@ -896,8 +896,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  		}
>  
>  		/* Update the Slave driver */
> -		if (slave_notify && (slave->ops) &&
> -					(slave->ops->interrupt_callback)) {
> +		if (slave_notify && slave->ops &&
> +		    slave->ops->interrupt_callback) {
>  			slave_intr.control_port = clear;
>  			memcpy(slave_intr.port, &port_status,
>  			       sizeof(slave_intr.port));
> @@ -955,7 +955,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  static int sdw_update_slave_status(struct sdw_slave *slave,
>  				   enum sdw_slave_status status)
>  {
> -	if ((slave->ops) && (slave->ops->update_status))
> +	if (slave->ops && slave->ops->update_status)
>  		return slave->ops->update_status(slave, status);
>  
>  	return 0;
> -- 
> 2.17.1

-- 
~Vinod
