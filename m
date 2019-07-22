Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A14C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556B021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ptbE/AU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfGVWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:20:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfGVWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sZifZkdWiMoDS5H0vZ/kocr9T/G1B0sj9s4WKblGNYA=; b=ptbE/AU6XdOAqTfH5ncVYCSqP2
        bENxJtL+uq+yCV0LTG0izVe27LmGrwuNLTHmS2lIOwqIb6FT1U85QWp9ePSUdzx2Ok3pkpMAfCaZS
        Tki3rDKirh70Cg9MQ/U7dLmkrhCHmEFFWyMHZssemNVWJ99vnyHa1k4wqw2HAlrtKDSjCR2l3mf4Q
        0rUJpmxnsnyrYlwAWLqZdligGteb/uW2on9u/LZce93CxaTC+0fUwORDvFtFtNPpbTj2qBK7oTguI
        iLfqXy9WonPH2bKcfYMmxKxvKtc8y3nWfWw4pFKo2rmHjYMTNJUWDd7U35jnkpS5deZXbXf6YqMMt
        GY3bSGBQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpgff-0007n8-PX; Mon, 22 Jul 2019 22:20:39 +0000
Subject: Re: Resend: [PATCH] ktest: Fix typos in sample.conf
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20190722221734.28122-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59cfabb9-e687-62ee-75d4-24074c457700@infradead.org>
Date:   Mon, 22 Jul 2019 15:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722221734.28122-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 3:17 PM, Masanari Iida wrote:
> This patch fixes some spelling typos in sample.conf.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/ktest/sample.conf | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
> index c3bc933d437b..f31d6dcf2f99 100644
> --- a/tools/testing/ktest/sample.conf
> +++ b/tools/testing/ktest/sample.conf
> @@ -10,7 +10,7 @@
>  #
>  
>  # Options set in the beginning of the file are considered to be
> -# default options. These options can be overriden by test specific
> +# default options. These options can be overridden by test specific
>  # options, with the following exceptions:
>  #
>  #  LOG_FILE
> @@ -204,7 +204,7 @@
>  #
>  # This config file can also contain "config variables".
>  # These are assigned with ":=" instead of the ktest option
> -# assigment "=".
> +# assignment "=".
>  #
>  # The difference between ktest options and config variables
>  # is that config variables can be used multiple times,
> @@ -263,7 +263,7 @@
>  #### Using options in other options ####
>  #
>  # Options that are defined in the config file may also be used
> -# by other options. All options are evaulated at time of
> +# by other options. All options are evaluated at time of
>  # use (except that config variables are evaluated at config
>  # processing time).
>  #
> @@ -707,7 +707,7 @@
>  
>  # Line to define a successful boot up in console output.
>  # This is what the line contains, not the entire line. If you need
> -# the entire line to match, then use regural expression syntax like:
> +# the entire line to match, then use regular expression syntax like:
>  #  (do not add any quotes around it)
>  #
>  #  SUCCESS_LINE = ^MyBox Login:$
> @@ -839,7 +839,7 @@
>  # (ignored if POWEROFF_ON_SUCCESS is set)
>  #REBOOT_ON_SUCCESS = 1
>  
> -# In case there are isses with rebooting, you can specify this
> +# In case there are issues with rebooting, you can specify this
>  # to always powercycle after this amount of time after calling
>  # reboot.
>  # Note, POWERCYCLE_AFTER_REBOOT = 0 does NOT disable it. It just
> @@ -848,7 +848,7 @@
>  # (default undefined)
>  #POWERCYCLE_AFTER_REBOOT = 5
>  
> -# In case there's isses with halting, you can specify this
> +# In case there's issues with halting, you can specify this
>  # to always poweroff after this amount of time after calling
>  # halt.
>  # Note, POWEROFF_AFTER_HALT = 0 does NOT disable it. It just
> @@ -1093,7 +1093,7 @@
>  #   whatever reason. (Can't reboot, want to inspect each iteration)
>  #   Doing a BISECT_MANUAL will have the test wait for you to
>  #   tell it if the test passed or failed after each iteration.
> -#   This is basicall the same as running git bisect yourself
> +#   This is basically the same as running git bisect yourself
>  #   but ktest will rebuild and install the kernel for you.
>  #
>  # BISECT_CHECK = 1 (optional, default 0)
> @@ -1124,13 +1124,13 @@
>  #
>  # BISECT_RET_GOOD = 0 (optional, default undefined)
>  #
> -#   In case the specificed test returns something other than just
> +#   In case the specified test returns something other than just
>  #   0 for good, and non-zero for bad, you can override 0 being
>  #   good by defining BISECT_RET_GOOD.
>  #
>  # BISECT_RET_BAD = 1 (optional, default undefined)
>  #
> -#   In case the specificed test returns something other than just
> +#   In case the specified test returns something other than just
>  #   0 for good, and non-zero for bad, you can override non-zero being
>  #   bad by defining BISECT_RET_BAD.
>  #
> @@ -1239,7 +1239,7 @@
>  #
>  # CONFIG_BISECT_EXEC (optional)
>  #  The config bisect is a separate program that comes with ktest.pl.
> -#  By befault, it will look for:
> +#  By default, it will look for:
>  #    `pwd`/config-bisect.pl # the location ktest.pl was executed from.
>  #  If it does not find it there, it will look for:
>  #    `dirname <ktest.pl>`/config-bisect.pl # The directory that holds ktest.pl
> 


-- 
~Randy
