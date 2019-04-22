Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E3C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF8120859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555943124;
	bh=5nSfIPuXhIxZMd1/sE6RfjUEMUkXFM2u7bt6cz3MRq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zhRHodeuufbNaQ9I8vuHUWBgdTSch9f+cDb8YtGrMwyctlpgisJTa4BrNzJXBewmC
	 lj7KplUZUwxH3E+t7V6adXHA7WJ+qJw0o2C2STu/HjuZTE3EPP7mLOhKoTvAas8D/d
	 NkbCnt9TM9lJ53Qy4i+jFEl/xmaFmC7TStQ3k8Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfDVOZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:25:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1670320693;
        Mon, 22 Apr 2019 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555943120;
        bh=5nSfIPuXhIxZMd1/sE6RfjUEMUkXFM2u7bt6cz3MRq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OSizqNjXJ2pWS0LXWyczDJZLCJc4mF05jog++sLRe4OG04ejGSm0g4R1nXDQUZTfT
         vqq2A3/OqmRyGOrIbo0LWvnR/Se8uBy9NzOFCAHeExHQ1xI3u/y3ejuqum8w62iqrf
         X4+evgY7oa2IbF4MVKmWkEdx5W8T7bhB2bUVzMPc=
Date:   Mon, 22 Apr 2019 15:25:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 63/79] docs: iio: convert to ReST
Message-ID: <20190422152515.403d0858@archlinux>
In-Reply-To: <41bbbddf74ffb1e557ac6c924dac5054d6650950.1555938376.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <41bbbddf74ffb1e557ac6c924dac5054d6650950.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 10:27:52 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Rename the iio documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Thanks Mauro,

Looks good to me.
At somepoint, we should figure out how to fit these elements into
the main IIO docs, but this is a good intermediate step.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../iio/{ep93xx_adc.txt => ep93xx_adc.rst}    | 15 +++++-
>  .../{iio_configfs.txt => iio_configfs.rst}    | 52 +++++++++++--------
>  Documentation/iio/index.rst                   | 12 +++++
>  drivers/iio/Kconfig                           |  2 +-
>  4 files changed, 56 insertions(+), 25 deletions(-)
>  rename Documentation/iio/{ep93xx_adc.txt => ep93xx_adc.rst} (71%)
>  rename Documentation/iio/{iio_configfs.txt => iio_configfs.rst} (73%)
>  create mode 100644 Documentation/iio/index.rst
> 
> diff --git a/Documentation/iio/ep93xx_adc.txt b/Documentation/iio/ep93xx_adc.rst
> similarity index 71%
> rename from Documentation/iio/ep93xx_adc.txt
> rename to Documentation/iio/ep93xx_adc.rst
> index 23053e7817bd..4fd8dea3f6b8 100644
> --- a/Documentation/iio/ep93xx_adc.txt
> +++ b/Documentation/iio/ep93xx_adc.rst
> @@ -1,12 +1,16 @@
> -Cirrus Logic EP93xx ADC driver.
> +==============================
> +Cirrus Logic EP93xx ADC driver
> +==============================
>  
>  1. Overview
> +===========
>  
>  The driver is intended to work on both low-end (EP9301, EP9302) devices with
>  5-channel ADC and high-end (EP9307, EP9312, EP9315) devices with 10-channel
>  touchscreen/ADC module.
>  
>  2. Channel numbering
> +====================
>  
>  Numbering scheme for channels 0..4 is defined in EP9301 and EP9302 datasheets.
>  EP9307, EP9312 and EP9312 have 3 channels more (total 8), but the numbering is
> @@ -17,13 +21,20 @@ Assuming ep93xx_adc is IIO device0, you'd find the following entries under
>  
>    +-----------------+---------------+
>    | sysfs entry     | ball/pin name |
> -  +-----------------+---------------+
> +  +=================+===============+
>    | in_voltage0_raw | YM            |
> +  +-----------------+---------------+
>    | in_voltage1_raw | SXP           |
> +  +-----------------+---------------+
>    | in_voltage2_raw | SXM           |
> +  +-----------------+---------------+
>    | in_voltage3_raw | SYP           |
> +  +-----------------+---------------+
>    | in_voltage4_raw | SYM           |
> +  +-----------------+---------------+
>    | in_voltage5_raw | XP            |
> +  +-----------------+---------------+
>    | in_voltage6_raw | XM            |
> +  +-----------------+---------------+
>    | in_voltage7_raw | YP            |
>    +-----------------+---------------+
> diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.rst
> similarity index 73%
> rename from Documentation/iio/iio_configfs.txt
> rename to Documentation/iio/iio_configfs.rst
> index 4e5f101837a8..ecbfdb3afef7 100644
> --- a/Documentation/iio/iio_configfs.txt
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -1,6 +1,9 @@
> +===============================
>  Industrial IIO configfs support
> +===============================
>  
>  1. Overview
> +===========
>  
>  Configfs is a filesystem-based manager of kernel objects. IIO uses some
>  objects that could be easily configured using configfs (e.g.: devices,
> @@ -10,20 +13,22 @@ See Documentation/filesystems/configfs/configfs.txt for more information
>  about how configfs works.
>  
>  2. Usage
> +========
>  
>  In order to use configfs support in IIO we need to select it at compile
>  time via CONFIG_IIO_CONFIGFS config option.
>  
> -Then, mount the configfs filesystem (usually under /config directory):
> +Then, mount the configfs filesystem (usually under /config directory)::
>  
> -$ mkdir /config
> -$ mount -t configfs none /config
> +  $ mkdir /config
> +  $ mount -t configfs none /config
>  
>  At this point, all default IIO groups will be created and can be accessed
>  under /config/iio. Next chapters will describe available IIO configuration
>  objects.
>  
>  3. Software triggers
> +====================
>  
>  One of the IIO default configfs groups is the "triggers" group. It is
>  automagically accessible when the configfs is mounted and can be found
> @@ -31,40 +36,40 @@ under /config/iio/triggers.
>  
>  IIO software triggers implementation offers support for creating multiple
>  trigger types. A new trigger type is usually implemented as a separate
> -kernel module following the interface in include/linux/iio/sw_trigger.h:
> +kernel module following the interface in include/linux/iio/sw_trigger.h::
>  
> -/*
> - * drivers/iio/trigger/iio-trig-sample.c
> - * sample kernel module implementing a new trigger type
> - */
> -#include <linux/iio/sw_trigger.h>
> +  /*
> +   * drivers/iio/trigger/iio-trig-sample.c
> +   * sample kernel module implementing a new trigger type
> +   */
> +  #include <linux/iio/sw_trigger.h>
>  
>  
> -static struct iio_sw_trigger *iio_trig_sample_probe(const char *name)
> -{
> +  static struct iio_sw_trigger *iio_trig_sample_probe(const char *name)
> +  {
>  	/*
>  	 * This allocates and registers an IIO trigger plus other
>  	 * trigger type specific initialization.
>  	 */
> -}
> +  }
>  
> -static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
> -{
> +  static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
> +  {
>  	/*
>  	 * This undoes the actions in iio_trig_sample_probe
>  	 */
> -}
> +  }
>  
> -static const struct iio_sw_trigger_ops iio_trig_sample_ops = {
> +  static const struct iio_sw_trigger_ops iio_trig_sample_ops = {
>  	.probe		= iio_trig_sample_probe,
>  	.remove		= iio_trig_sample_remove,
> -};
> +  };
>  
> -static struct iio_sw_trigger_type iio_trig_sample = {
> +  static struct iio_sw_trigger_type iio_trig_sample = {
>  	.name = "trig-sample",
>  	.owner = THIS_MODULE,
>  	.ops = &iio_trig_sample_ops,
> -};
> +  };
>  
>  module_iio_sw_trigger_driver(iio_trig_sample);
>  
> @@ -73,21 +78,24 @@ iio-trig-sample module will create 'trig-sample' trigger type directory
>  /config/iio/triggers/trig-sample.
>  
>  We support the following interrupt sources (trigger types):
> +
>  	* hrtimer, uses high resolution timers as interrupt source
>  
>  3.1 Hrtimer triggers creation and destruction
> +---------------------------------------------
>  
>  Loading iio-trig-hrtimer module will register hrtimer trigger types allowing
>  users to create hrtimer triggers under /config/iio/triggers/hrtimer.
>  
> -e.g:
> +e.g::
>  
> -$ mkdir /config/iio/triggers/hrtimer/instance1
> -$ rmdir /config/iio/triggers/hrtimer/instance1
> +  $ mkdir /config/iio/triggers/hrtimer/instance1
> +  $ rmdir /config/iio/triggers/hrtimer/instance1
>  
>  Each trigger can have one or more attributes specific to the trigger type.
>  
>  3.2 "hrtimer" trigger types attributes
> +--------------------------------------
>  
>  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
>  It does introduce the sampling_frequency attribute to trigger directory.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> new file mode 100644
> index 000000000000..0593dca89a94
> --- /dev/null
> +++ b/Documentation/iio/index.rst
> @@ -0,0 +1,12 @@
> +:orphan:
> +
> +==============
> +Industrial I/O
> +==============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   iio_configfs
> +
> +   ep93xx_adc
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 014006d1cbb6..c1aa87db19ff 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -28,7 +28,7 @@ config IIO_CONFIGFS
>  	help
>  	  This allows configuring various IIO bits through configfs
>  	  (e.g. software triggers). For more info see
> -	  Documentation/iio/iio_configfs.txt.
> +	  Documentation/iio/iio_configfs.rst.
>  
>  config IIO_TRIGGER
>  	bool "Enable triggered sampling support"

