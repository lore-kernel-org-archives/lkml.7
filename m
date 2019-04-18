Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB920835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfDRN5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:57:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57298 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:57:03 -0400
Received: from 79.184.254.18.ipv4.supernova.orange.pl (79.184.254.18) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 04777e2c5748a5fc; Thu, 18 Apr 2019 15:57:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     daniel.lezcano@linaro.org, benh@kernel.crashing.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date:   Thu, 18 Apr 2019 15:57:00 +0200
Message-ID: <4392665.MNVv1Oa0lS@kreacher>
In-Reply-To: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
References: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 17, 2019 4:52:34 PM CEST Mohan Kumar wrote:
> Use pr_debug instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
> dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe..7cf9835 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
>  	powernv_cpuidle_driver_init();
>  	retval = cpuidle_register(&powernv_idle_driver, NULL);
>  	if (retval) {
> -		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
> +		pr_debug("Registration of powernv driver failed.\n");
>  		return retval;
>  	}
>  
> @@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
>  					   "cpuidle/powernv:dead", NULL,
>  					   powernv_cpuidle_cpu_dead);
>  	WARN_ON(retval < 0);
> -	printk(KERN_DEBUG "powernv_idle_driver registered\n");
> +	pr_debug("powernv_idle_driver registered\n");
>  	return 0;
>  }
>  
> 

Recently, you've sent two different patches against two different drivers with the same subject.

IMO it is fair enough to call that "confusing".

Moreover, pr_debug() is not a direct replacement for printk(KERN_DEBUG ) as the latter does
not require dynamic debug to be enabled and I'm not really sure if you are aware of that
difference.




