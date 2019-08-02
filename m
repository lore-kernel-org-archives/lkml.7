Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54149C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DEC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564765317;
	bh=81WIba1X7p3pWbUBeQ1GQSo1cKlMvDKYNfZuSJQlpfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ujH04CDEKHIZiyTEl50ANARM4JcOLvLS6vtw75ZMV7ZFLdX8jmbxBZemXKkwti2iq
	 yeYG6owR7SMJmu5OURGMzmXiDV+9n7pVe6fSuovIKzYeXRkfRgwJFz+upEiyXpC2Gt
	 5XW3RJFsTBBg4yMByPAL9W8cXvFcsKpjN5OLYMuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbfHBRBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfHBRBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:01:55 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758C820644;
        Fri,  2 Aug 2019 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564765314;
        bh=81WIba1X7p3pWbUBeQ1GQSo1cKlMvDKYNfZuSJQlpfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgSvT5mNd6IHS7jOiMG5utKDfZk/BcTKuetFrApytW53h/bN2xtDct6YokliMjY4M
         5CG8yKquC83P0NGz6vnOCtIX4GkyuZIcLrpgFhFuPbbIGE5BET7lIEeABb0I2jb9rp
         vvYZndGqOEeL8uENEdWhJOXwJomTeZUoEnTf1RT0=
Date:   Fri, 2 Aug 2019 22:30:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 19/40] soundwire: bus: improve dynamic debug comments
 for enumeration
Message-ID: <20190802170041.GW12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-20-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-20-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> update comments to provide better understanding of enumeration flows.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index bca378806d00..2354675ef104 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -483,7 +483,8 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  
>  	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
>  	if (ret < 0) {
> -		dev_err(&slave->dev, "Program device_num failed: %d\n", ret);
> +		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
> +			dev_num, ret);
>  		return ret;
>  	}
>  
> @@ -540,6 +541,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  	do {
>  		ret = sdw_transfer(bus, &msg);
>  		if (ret == -ENODATA) { /* end of device id reads */
> +			dev_dbg(bus->dev, "No more devices to enumerate\n");
>  			ret = 0;
>  			break;
>  		}
> @@ -982,6 +984,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  	int i, ret = 0;
>  
>  	if (status[0] == SDW_SLAVE_ATTACHED) {
> +		dev_err(bus->dev, "Slave attached, programming device number\n");

This should be debug level

-- 
~Vinod
