Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE3922D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfHZJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:20:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:20:24 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 2b9292fac4598eca; Mon, 26 Aug 2019 11:20:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove redundant assignment to ret
Date:   Mon, 26 Aug 2019 11:20:21 +0200
Message-ID: <2250924.CPEEF64KPg@kreacher>
In-Reply-To: <20190819065814.333kowws4mpw3qfx@vireshk-i7>
References: <20190813122121.28160-1-colin.king@canonical.com> <20190819065814.333kowws4mpw3qfx@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 19, 2019 8:58:14 AM CEST Viresh Kumar wrote:
> On 13-08-19, 13:21, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Variable ret is initialized to a value that is never read and it is
> > re-assigned later. The initialization is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index c28ebf2810f1..26d82e0a2de5 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2140,7 +2140,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
> >  			  unsigned int target_freq,
> >  			  unsigned int relation)
> >  {
> > -	int ret = -EINVAL;
> > +	int ret;
> >  
> >  	down_write(&policy->rwsem);
> >  
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied, thanks!




