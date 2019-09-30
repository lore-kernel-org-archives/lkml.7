Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DEC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03C1215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyyV4qTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfI3POX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:14:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfI3POW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5y/dmJ3DJ9NLDMojok3FKYPh6QBxBwOUiuYN5BkP9rQ=; b=UyyV4qTwHrKM6kZtt9P7Z+uca
        GKNkDiVcEw8O1w1tuQ8fjfQzfPxD9OtoUo0UfunOvwo6Qv8sEsu8gIApDDnfED1US+z2NpCx5bmMA
        I3Se6QFQPY2gNviJE3c5hhrlmdXTYBm9YmInh1uKQtjpzdhgdweY4gsz2jFEmf+rYd/HCDzr175kR
        KkyfqWDJ5+pIDHLaGn8+8rrn9IHqpv2ihPYoJsCieUAc2OBxektv/NM/+NhlOItfpQZP0eB0o6D7D
        r2Eo+kJjWGLxD030FMFlkiIroVhyQiCpfsW/xSN1hw/Wyf37HfzNxPoSDICgL1ePsGxuClnGacFaS
        00RWspgbQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iExNW-0007P0-2b; Mon, 30 Sep 2019 15:14:22 +0000
Subject: Re: [PATCH] ktest: Fix some typos in sample.conf
To:     Masanari Iida <standby24x7@gmail.com>, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
References: <20190930124925.20250-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e357165c-abea-34cd-1312-f083468a8981@infradead.org>
Date:   Mon, 30 Sep 2019 08:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930124925.20250-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 5:49 AM, Masanari Iida wrote:
> This patch fixes some spelling typo in sample.conf
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/ktest/sample.conf | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
> index c3bc933d437b..10af34819642 100644
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
> @@ -972,7 +972,7 @@
>  #
>  #  PATCHCHECK_START is required and is the first patch to
>  #   test (the SHA1 of the commit). You may also specify anything
> -#   that git checkout allows (branch name, tage, HEAD~3).
> +#   that git checkout allows (branch name, tag, HEAD~3).
>  #
>  #  PATCHCHECK_END is the last patch to check (default HEAD)
>  #
> @@ -994,7 +994,7 @@
>  #     IGNORE_WARNINGS is set for the given commit's sha1
>  #
>  #   IGNORE_WARNINGS can be used to disable the failure of patchcheck
> -#     on a particuler commit (SHA1). You can add more than one commit
> +#     on a particular commit (SHA1). You can add more than one commit
>  #     by adding a list of SHA1s that are space delimited.
>  #
>  #   If BUILD_NOCLEAN is set, then make mrproper will not be run on
> @@ -1093,7 +1093,7 @@
>  #   whatever reason. (Can't reboot, want to inspect each iteration)
>  #   Doing a BISECT_MANUAL will have the test wait for you to
>  #   tell it if the test passed or failed after each iteration.
> -#   This is basicall the same as running git bisect yourself
> +#   This is basically the same as running git bisect yourself
>  #   but ktest will rebuild and install the kernel for you.
>  #
>  # BISECT_CHECK = 1 (optional, default 0)
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
