Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF113CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9722B21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504159AbfJRGBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:01:33 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55498 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390743AbfJRGBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:01:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6036832D;
        Thu, 17 Oct 2019 23:01:07 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28B6F3F68E;
        Thu, 17 Oct 2019 23:03:51 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:00:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 4/5] cpufreq: vexpress-spc: remove lots of debug
 messages
Message-ID: <20191018060054.GE31836@e107533-lin.cambridge.arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-5-sudeep.holla@arm.com>
 <20191018055720.za3a5zeqdzcupc4h@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018055720.za3a5zeqdzcupc4h@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:27:20AM +0530, Viresh Kumar wrote:
> On 17-10-19, 13:35, Sudeep Holla wrote:
> > This driver have been used and tested for year now and the extensive
> > debug/log messages in the driver are not really required anymore.
> > Get rid of those unnecessary log messages.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 72 +++++---------------------
> >  1 file changed, 13 insertions(+), 59 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> >  static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
> > @@ -324,11 +296,9 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
> >  
> >  	for_each_present_cpu(i) {
> >  		struct device *cdev = get_cpu_device(i);
> > -		if (!cdev) {
> > -			pr_err("%s: failed to get cpu%d device\n", __func__, i);
> > -			return;
> > -		}
> >  
> > +		if (!cdev)
> > +			return;
> 
> We had a blank line after this, which isn't there in your version
> anymore. Please keep that here and few more places below.
>

Ah, this one is spurious change when doing in bulk not intended. I will
add back the blank line.

--
Regards,
Sudeep

