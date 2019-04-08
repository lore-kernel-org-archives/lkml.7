Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C6E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDHKmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:42:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54896 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:41:59 -0400
Received: from 79.184.255.221.ipv4.supernova.orange.pl (79.184.255.221) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 0ff1e0eec5394703; Mon, 8 Apr 2019 12:41:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: maple: Remove redundant code from maple_cpufreq_init()
Date:   Mon, 08 Apr 2019 12:41:57 +0200
Message-ID: <4531254.vnb8GhbyUH@kreacher>
In-Reply-To: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
References: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 8, 2019 12:17:06 PM CEST Viresh Kumar wrote:
> The success path and error path both look the same, don't duplicate the
> code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/maple-cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/maple-cpufreq.c
> b/drivers/cpufreq/maple-cpufreq.c index a05f1342ec02..a94355723ef8 100644
> --- a/drivers/cpufreq/maple-cpufreq.c
> +++ b/drivers/cpufreq/maple-cpufreq.c
> @@ -231,10 +231,6 @@ static int __init maple_cpufreq_init(void)
> 
>  	rc = cpufreq_register_driver(&maple_cpufreq_driver);
> 
> -	of_node_put(cpunode);
> -
> -	return rc;
> -
>  bail_noprops:
>  	of_node_put(cpunode);

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm assuming this to land in your tree.



