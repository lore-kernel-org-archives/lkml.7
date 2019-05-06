Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC920C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557159888;
	bh=uNCQttmmYYJSvud2cb586tPjuGNdF1u7yrL8bCBjHTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1m89WNniRpYTAbV5kxBl3yTcrMfPgwgqz2Nm1xEtwKtCl5iA3QfmAMfvcel/SqQCl
	 EfYstGnXaP4byI2fSh3xDNlVjDXR7TanAObf3EodIe1xXMQKHDeCvqCQmxOnD0mvq+
	 zvLdICS0pgvhkJWOrwwmLtqbZbMPEfC9P4Vc+YzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEFQYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfEFQYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:24:46 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD9C205C9;
        Mon,  6 May 2019 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557159885;
        bh=uNCQttmmYYJSvud2cb586tPjuGNdF1u7yrL8bCBjHTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcEKdXHk5NZREQ+2HaBsIwwCDKSu5pA9jHfW7LMPcR8Y5ooGtYA2jrNYIpBbBUnVE
         7/8hWIwYi0SjdUfQHoIMRUF3Y5doQVwpMKnEQ8cLek+skIXQmh742mAxnbutf1Kcv8
         znGDI90xhLKur39DLQcVCxnf/x0iKGeNXG2zSwso=
Date:   Mon, 6 May 2019 21:54:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 3/7] ABI: testing: Add description of soundwire
 master sysfs files
Message-ID: <20190506162439.GJ3845@vkoul-mobl.Dlink>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-19, 20:00, Pierre-Louis Bossart wrote:
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

As the author of original code, it would be great if you can add me as a
contact as well.

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

This should be folded into 1st patch

>   *      |---- dynamic_shape
>   *      |---- err_threshold
>   */
> -- 
> 2.17.1

-- 
~Vinod
