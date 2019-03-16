Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E890C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CEA218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552761641;
	bh=zePg1cL2hR453Cb0JSH6OkW92+wEpS8wFii8ylP5UEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=juClKSdteTPM+DdksoQsvw0KEjT+PYCw1Ip0iitDmk9lcXVWPMYd1lUtpjWic9ih4
	 46jR6bmKN8yypxc6MAfy60IwQ/NnbHfSp424tnCoXWB8GDjeJbthRnLWllx3znzEJ9
	 dUUcs/AEPuMHnmOmWhf/+ZGlnCSgnGYu6ojJny0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfCPSkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:40:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E51218A1;
        Sat, 16 Mar 2019 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552761639;
        bh=zePg1cL2hR453Cb0JSH6OkW92+wEpS8wFii8ylP5UEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6sQglm695sOlpIvWsw3OJqDxW+ka4rZg0o/ITrf+8CTaquRYTHEOynX3nmwHWM6n
         1PUgl5beOvlwdmVhG31alUEP5PoN34J7yum1UqprlrvZUtSqGd1r8sqKslNPCEJZxr
         2kdiLOAhWeE1C6vGXsg557EADd+wMGuyKZutNxgU=
Date:   Sat, 16 Mar 2019 18:40:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 5/7] staging: iio: ad5933: add ABI documentation
Message-ID: <20190316184034.7ad29cf6@archlinux>
In-Reply-To: <20190316150732.umr64uwhi2j4qi7k@smtp.gmail.com>
References: <20190316150732.umr64uwhi2j4qi7k@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 12:07:32 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add an ABI documentation for the ad5933 driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Some stray whitespace in here. I cleaned it up.

Thanks,

Jonathan

> ---
>  .../sysfs-bus-iio-impedance-analyzer-ad5933   | 35 +++++++++++++++++++
>  .../sysfs-bus-iio-impedance-analyzer-ad5933   | 30 ----------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
> new file mode 100644
> index 000000000000..a50aada68e1e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
> @@ -0,0 +1,35 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_start
> +Date:		March 2019
> +KernelVersion:	3.1.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Frequency sweep start frequency in Hz.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_increment
> +Date:		March 2019
> +KernelVersion:	3.1.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Frequency increment in Hz (step size) between consecutive
> +		frequency points along the sweep.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_points
> +Date:		March 2019
> +KernelVersion:	3.1.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of frequency points (steps) in the frequency sweep.
> +		This value, in conjunction with the
> +		out_altvoltageY_frequency_start and the	
> +		out_altvoltageY_frequency_increment, determines the frequency 
> +		sweep range for the sweep operation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_settling_cycles
> +Date:		March 2019
> +KernelVersion:	3.1.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of output excitation cycles (settling time cycles)
> +		that are allowed to pass through the unknown impedance,
> +		after each frequency increment, and before the ADC is triggered
> +		to perform a conversion sequence of the response signal.
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933 b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
> deleted file mode 100644
> index 79c7e88c64cd..000000000000
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_start
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Frequency sweep start frequency in Hz.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_increment
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Frequency increment in Hz (step size) between consecutive
> -		frequency points along the sweep.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_points
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Number of frequency points (steps) in the frequency sweep.
> -		This value, in conjunction with the outY_freq_start and the
> -		outY_freq_increment, determines the frequency sweep range
> -		for the sweep operation.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/outY_settling_cycles
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Number of output excitation cycles (settling time cycles)
> -		that are allowed to pass through the unknown impedance,
> -		after each frequency increment, and before the ADC is triggered
> -		to perform a conversion sequence of the response signal.

