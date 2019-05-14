Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A19C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCB820862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfENVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:33:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54025 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENVdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:33:39 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 653687329530d137; Tue, 14 May 2019 23:33:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Update MAINTAINERS to include schedutil governor
Date:   Tue, 14 May 2019 23:33:36 +0200
Message-ID: <55648738.2dPUYNdNxi@kreacher>
In-Reply-To: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
References: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 13, 2019 9:10:33 AM CEST Viresh Kumar wrote:
> List cpufreq maintainers as well for schedutil governor apart from
> scheduler maintainers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4244dd341eb7..7d4417d862a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4093,7 +4093,9 @@ F:	Documentation/admin-guide/pm/intel_pstate.rst
>  F:	Documentation/cpu-freq/
>  F:	Documentation/devicetree/bindings/cpufreq/
>  F:	drivers/cpufreq/
> +F:	kernel/sched/cpufreq*.c
>  F:	include/linux/cpufreq.h
> +F:	include/linux/sched/cpufreq.h
>  F:	tools/testing/selftests/cpufreq/
>  
>  CPU FREQUENCY DRIVERS - ARM BIG LITTLE
> 

Applied, thanks!




