Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF1C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0365220859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556952837;
	bh=s5pBnyZieQEdTRYkD6W5/3S/hM2RuAtMJl1SGDRyOCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vW2o/zleMshoQEwMYFOZ/+iHSqErUYLZH8EBRe7RNk6BBgZ7OIfG9lQN+TBDVwJ2A
	 fbOFVMUiUAWzDdPwbc7fn3iQxhy8wgRCvLcS9xyTBm/oNTIN6xXWr3A0c+TqF8wp/Y
	 d0zAnB/h5DMr9u53TiunK6kMv8e07fRAgrfSvuGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEDGx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDGxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:53:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D21206BB;
        Sat,  4 May 2019 06:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556952834;
        bh=s5pBnyZieQEdTRYkD6W5/3S/hM2RuAtMJl1SGDRyOCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kygmXcbJxTqSYvxEzO+LS1S5v/HrIzKtoQL5XHszZJ43wO1/DruT8+8/kDVKZJRDl
         CIclpvbQKRkam49K0Qyld4xYxGvNpF0V4txW4d4pf+Vl1c6/I7+lpr31IUJHIbRVJ/
         zUNJw3WWk95I8dFev2jsEme+Qn/OO8ANfooqt3Eo=
Date:   Sat, 4 May 2019 08:53:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 3/7] ABI: testing: Add description of soundwire
 master sysfs files
Message-ID: <20190504065352.GB9770@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 08:00:26PM -0500, Pierre-Louis Bossart wrote:
> The description is directly derived from the MIPI DisCo specification.
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-bus-soundwire-master    | 21 +++++++++++++++++++
>  drivers/soundwire/sysfs.c                     |  1 +
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
> new file mode 100644
> index 000000000000..69cadf31049d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/soundwire/devices/sdw-master-N/revision
> +		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
> +		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
> +		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
> +		/sys/bus/soundwire/devices/sdw-master-N/default_col
> +		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
> +		/sys/bus/soundwire/devices/sdw-master-N/default_row
> +		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
> +		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
> +		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
> +
> +Date:		May 2019
> +
> +Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> +
> +Description:	SoundWire Master-N DisCo properties.
> +		These properties are defined by MIPI DisCo Specification
> +		for SoundWire. They define various properties of the Master
> +		and are used by the bus to configure the Master. clk_stop_modes
> +		is a bitmask for simplifications and combines the
> +		clock-stop-mode0 and clock-stop-mode1 properties.
> diff --git a/drivers/soundwire/sysfs.c b/drivers/soundwire/sysfs.c
> index 734e2c8bc5cd..c2e5b7ad42fb 100644
> --- a/drivers/soundwire/sysfs.c
> +++ b/drivers/soundwire/sysfs.c
> @@ -31,6 +31,7 @@ struct sdw_master_sysfs {
>   *      |---- clk_gears
>   *      |---- default_row
>   *      |---- default_col
> + *      |---- default_frame_shape
>   *      |---- dynamic_shape
>   *      |---- err_threshold
>   */

This last chunk should go in patch 1 of this series, right?

thanks,

greg k-h
