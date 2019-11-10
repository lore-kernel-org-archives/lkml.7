Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3EC17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318F20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573382582;
	bh=7aL13zUH15R2hFu0eyAFiLOwdUoY1pt98aMbLIR0ME0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aKGJGCxJzLx8LRFxxXgQPWa/2DzGpqDIOohmscyHEh0NJNZz3DkroFJNvtYHMNhAM
	 PQGJSkSUwbhtuXqrnAG8sCaNmjUSMPK53ZgUFAfU17kKuxK1AP0vMcnh3OGRDc/FTo
	 cRSIag10dvjmztw/D4yVIfBLCqSBRpqzj3mYCO18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKJKnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfKJKnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:43:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9263620869;
        Sun, 10 Nov 2019 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573382580;
        bh=7aL13zUH15R2hFu0eyAFiLOwdUoY1pt98aMbLIR0ME0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WcnggAABIjSZEHC/BAjwN2atcwxEi+jCfOEJaHNfMrPeLSYwFojMOVHoF45XLvx3V
         p7Ce/YGpoC4C4OgACFcnZ3Pvo0OPClv1l1JcifpFeUFjo9yVj6geQKnC8HsvnUuhWF
         NnXJAyJ7MLXirYzFOvjGxxGOigtXJF1ysUDeSa2s=
Date:   Sun, 10 Nov 2019 10:42:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: documentation: light: Add veml6030 sysfs
 documentation
Message-ID: <20191110104255.17c6299c@archlinux>
In-Reply-To: <1572881968-15583-1-git-send-email-gupt21@gmail.com>
References: <1572881968-15583-1-git-send-email-gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 21:09:28 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> The driver for veml6030 light sensor provides sysfs
> entries like configuring cutoff for interrupt. This
> commit document them.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing to be
ignored by the autobuilders.

Thanks,

Jonathan

> ---
> Changes in v6:
> * in_illuminance_period_available now shows values in seconds 
> 
> Changes in v5:
> * Use ABI/testing/sysfs-bus-iio to document sysfs files for veml6030
> 
> Changes in v4:
> * None
> 
> Changes in v3:
> * Updated Date from September to October
> * Updated KernelVersion from 5.3.1 to 5.4
> * in_illuminance_period_available is now in events directory
> 
> Changes in v2:
> * None
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6804516..faaa216 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -753,6 +753,8 @@ What:		/sys/.../events/in_illuminance0_thresh_falling_value
>  what:		/sys/.../events/in_illuminance0_thresh_rising_value
>  what:		/sys/.../events/in_proximity0_thresh_falling_value
>  what:		/sys/.../events/in_proximity0_thresh_rising_value
> +What:		/sys/.../events/in_illuminance_thresh_rising_value
> +What:		/sys/.../events/in_illuminance_thresh_falling_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -972,6 +974,7 @@ What:		/sys/.../events/in_activity_jogging_thresh_rising_period
>  What:		/sys/.../events/in_activity_jogging_thresh_falling_period
>  What:		/sys/.../events/in_activity_running_thresh_rising_period
>  What:		/sys/.../events/in_activity_running_thresh_falling_period
> +What:		/sys/.../events/in_illuminance_thresh_either_period
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1715,3 +1718,11 @@ Description:
>  		Mass concentration reading of particulate matter in ug / m3.
>  		pmX consists of particles with aerodynamic diameter less or
>  		equal to X micrometers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
> +Date:		November 2019
> +KernelVersion:	5.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of valid periods (in seconds) for which the light intensity
> +		must be above the threshold level before interrupt is asserted.

