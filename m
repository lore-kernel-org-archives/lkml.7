Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279DC28CBF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A372075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558892449;
	bh=vqVnTEF2+44KSXHzhAVJzSN6+ZF8bB4yeWV0VNhLVpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yI1qpPkxNDFhqTW4x4w3fnC61CfYulgM1HwctBfDDn8bfp39kWiiH7CCv1WkGUpTp
	 WYGN6ES7nc96djoVNIxJ4yAaKKP5y/u4tNgPxOuaH3+EufCSkdKFz9rBgG9n4/NB8E
	 jMyZClTgxppBSv/VwEFspLoOcl2n/Sbau0q7eUbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfEZRks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 13:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfEZRks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:40:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4639A2054F;
        Sun, 26 May 2019 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558892447;
        bh=vqVnTEF2+44KSXHzhAVJzSN6+ZF8bB4yeWV0VNhLVpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fe1myetdB2QEWgIDOfyAE+OTBnkKw7pizON85OOemGDZzXy/n4DgoPGpfE5yHXkdo
         1zKyFy1tXlaFr7zn+mzDskh4k0hfUPNR6m+9M/LtvHSgHe9eqsWGmSMy+R4jQ7qQOv
         2NfTLGcF2eEYEiqJA4EkGFCplROLG5A/YMRsmsyA=
Date:   Sun, 26 May 2019 18:40:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] docs: iio: add precision about
 sampling_frequency_available
Message-ID: <20190526184016.11a56ee0@archlinux>
In-Reply-To: <c1c56310da539b6af66811084bd69806622e1903.1558601329.git.fabien.lahoudere@collabora.com>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
        <c1c56310da539b6af66811084bd69806622e1903.1558601329.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 11:07:37 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> The documentation give some exemple on what format can be expected
> from sampling_frequency_available sysfs attribute
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Great.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to completely ignore ;)

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6aef7dbbde44..680451695422 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -61,8 +61,11 @@ What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		When the internal sampling clock can only take a small
> -		discrete set of values, this file lists those available.
> +		When the internal sampling clock can only take a specific set of
> +		frequencies, we can specify the available values with:
> +		- a small discrete set of values like "0 2 4 6 8"
> +		- a range with minimum, step and maximum frequencies like
> +		  "[min step max]"
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio
>  KernelVersion:	2.6.38

