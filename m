Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC581C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A75821738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JuKtGs2x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MDVbf3Kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDDHG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:06:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfDDHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:06:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C782660850; Thu,  4 Apr 2019 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554361616;
        bh=RyP/Xei6KM+/uvWb2yUEqkVLcT0HyR44aZdBkCuBsag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JuKtGs2xeipJHsFt/nxAIgJcspQM8zyj3bE0TfcxqV8o/OAKRIymJfAnI9FxyVloA
         LHr8rGjK3bUf8mI8vZ7SzewMe994gaAsyvFDqP0mqrEUwDM/+byvI52ftOsyDa24fw
         aIyvwBo1V+DjhZTyaRZipp8L2VOJ7fOQ/ZqKFeyw=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65FC360850;
        Thu,  4 Apr 2019 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554361615;
        bh=RyP/Xei6KM+/uvWb2yUEqkVLcT0HyR44aZdBkCuBsag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MDVbf3KlIZx+DwtCwWJIcMQUC3oxM3TUA4a7wQ61xDXPKclEP4adhlfBOax7yHb9/
         HHRNz47RJy84egXtsm/MRX75Vs390g4mHvL6CVcmLTmwfDpiVzy+gXY/oQQHvHqsTe
         paceHQCXdCs2OZm+3idMAduDayMyW18csoGulSxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65FC360850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/2] tty: add SPDX identifiers to Kconfig and Makefiles
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>, Rob Herring <robh@kernel.org>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <adbb235f-97bb-e088-0067-34aa806a1bd3@codeaurora.org>
Date:   Thu, 4 Apr 2019 12:36:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402140708.519-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2019 7:37 PM, Greg Kroah-Hartman wrote:
> There were a few Kconfig and Makefiles under drivers/tty/ that were
> missing a SPDX identifier.  Fix that up so that automated tools can
> properly classify all kernel source files.
>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/tty/Kconfig                  | 1 +
>   drivers/tty/hvc/Kconfig              | 1 +
>   drivers/tty/ipwireless/Makefile      | 1 +
>   drivers/tty/serdev/Kconfig           | 1 +
>   drivers/tty/serdev/Makefile          | 1 +
>   drivers/tty/serial/8250/Kconfig      | 1 +
>   drivers/tty/serial/Kconfig           | 1 +
>   drivers/tty/serial/cpm_uart/Makefile | 1 +
>   drivers/tty/serial/jsm/Makefile      | 1 +
>   9 files changed, 9 insertions(+)
>
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index e0a04bfc873e..8034473c54ca 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   config TTY
>   	bool "Enable TTY" if EXPERT
>   	default y
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 4293c172e120..1a910ec9f643 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   if TTY
>   
>   config HVC_DRIVER
> diff --git a/drivers/tty/ipwireless/Makefile b/drivers/tty/ipwireless/Makefile
> index fe2e1730986b..a665d021e24d 100644
> --- a/drivers/tty/ipwireless/Makefile
> +++ b/drivers/tty/ipwireless/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the IPWireless driver
>   #
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index 1dbc8352e027..46ae732bfc68 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Serial bus device driver configuration
>   #
> diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
> index 0cbdb9444d9d..078417e5b068 100644
> --- a/drivers/tty/serdev/Makefile
> +++ b/drivers/tty/serdev/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   serdev-objs := core.o
>   
>   obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 15c2c5463835..296115f6a4d8 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # The 8250/16550 serial drivers.  You shouldn't be in this list unless
>   # you somehow have an implicit or explicit dependency on SERIAL_8250.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 72966bc0ac76..a5032e58c737 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Serial device configuration
>   #
> diff --git a/drivers/tty/serial/cpm_uart/Makefile b/drivers/tty/serial/cpm_uart/Makefile
> index 896a5d57881c..3f3a6ed02ed4 100644
> --- a/drivers/tty/serial/cpm_uart/Makefile
> +++ b/drivers/tty/serial/cpm_uart/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for the Motorola 8xx FEC ethernet controller
>   #
> diff --git a/drivers/tty/serial/jsm/Makefile b/drivers/tty/serial/jsm/Makefile
> index 705d1ff6fdeb..4f2dbada7741 100644
> --- a/drivers/tty/serial/jsm/Makefile
> +++ b/drivers/tty/serial/jsm/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Makefile for Jasmine adapter
>   #
