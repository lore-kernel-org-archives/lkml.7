Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F6BC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D508221873
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558724199;
	bh=mDq/DWwgp3UM71BT18cgNx7A9Iyxv2hOHPkkrxaLreY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DGLE4B7tjedHFqmWZKC+1jn8+8IUfILG6BaE2EVnofjYNFKYvSFusSGSOHWUMcBXI
	 2ZzmxkhbEc2zjNvD011Ve51V4NKvs/i3kGQ5I5iL3H5KsnU0Ev0CcQ0rPBHCPLAZGT
	 K6QQG7Fd/fE/CWmNkh5asP1dWcPMnIud1fmG+kew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfEXS4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfEXS4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:56:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E262184E;
        Fri, 24 May 2019 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558724197;
        bh=mDq/DWwgp3UM71BT18cgNx7A9Iyxv2hOHPkkrxaLreY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkL5oanR0C4pERFmmeGAEx005S21NpvisgZIXizHIlgfhFI5z9XQqxOmiAcorXohw
         ktqNZQYGo62yjCX2ADIFb2diz51G0Pz2LHOkL4e7je7dY7rsIF0ahZ8hrCIt0XRbAe
         OzdADpJAFitmnOYrmYa29LnFFGZIm8oDXZ1k4YmM=
Date:   Fri, 24 May 2019 20:56:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 3/4] firmware: rsu: document sysfs interface
Message-ID: <20190524185635.GA13200@kroah.com>
References: <1558616610-499-1-git-send-email-richard.gong@linux.intel.com>
 <1558616610-499-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558616610-499-4-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:03:29AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Describe Intel Stratix10 Remote System Update (RSU) device attributes
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Alan Tull <atull@kernel.org>
> ---
> v2: changed to use tab everywhere and wrap lines at 72 colums
>     s/soc:firmware:svc:rsu/stratix10-rsu.0
>     added for watchdog
> v3: s/KernelVersion:5.2/KernelVersion:5.3
> ---
>  .../testing/sysfs-devices-platform-stratix10-rsu   | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> new file mode 100644
> index 0000000..73ebaf2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> @@ -0,0 +1,100 @@
> +		Intel Stratix10 Remote System Update (RSU) device attributes
> +
> +What:		/sys/devices/platform/stratix10-rsu.0/current_image
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the address of image currently running in flash.
> +
> +What:		/sys/devices/platform/stratix10-rsu.0/fail_image
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the address of failed image in flash.
> +
> +What:		/sys/devices/platform/stratix10-rsu.0/state
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the state of RSU system.
> +		The state field has two parts: major error code in upper 16 bits and
> +		minor error code in lower 16 bits.
> +
> +		Major error code:
> +			0xF001	bitstream error
> +			0xF002	hardware access failure
> +			0xF003	bitstream corruption
> +			0xF004	internal error
> +			0xF005	device error
> +			0xF006	CPU watchdog timeout
> +			0xF007	internal unknown error
> +		Minor error code:
> +			Currently used only when major error is 0xF006
> +			(CPU watchdog timeout), in which case the minor
> +			error code is the value reported by CPU to
> +			firmware through the RSU notify command before
> +			the watchdog timeout occurs.
> +
> +What:		/sys/devices/platform/stratix10-rsu.0/fail_image
> +Date:           May 2019
> +KernelVersion:  5.3
> +Contact:        Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the version number of RSU firmware.
> +
> +What:		/sys/devices/platform/stratix10-rsu.0/error_location
> +Date:           May 2019
> +KernelVersion:  5.3
> +Contact:        Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the error offset inside the image that failed.
> +

You are mixing tabs and spaces in this file.  Please always just use
tabs.

thanks,

greg k-h
