Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B90C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A71212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfFGVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:38:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:51093 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfFGVij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:38:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 14:38:39 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2019 14:38:39 -0700
Date:   Fri, 7 Jun 2019 14:29:24 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-doc@vger.kernel.org, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Documentation: x86: fix some typos
Message-ID: <20190607212923.GD143433@romley-ivt3.sc.intel.com>
References: <20190607151409.15476-1-james.morse@arm.com>
 <20190607151409.15476-5-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607151409.15476-5-james.morse@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:14:09PM +0100, James Morse wrote:
> These are all obvious typos.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  Documentation/x86/resctrl_ui.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
> index 866b66aa289b..5368cedfb530 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -40,7 +40,7 @@ mount options are:
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>  	bandwidth in MBps
>  
> -L2 and L3 CDP are controlled seperately.
> +L2 and L3 CDP are controlled separately.
>  
>  RDT features are orthogonal. A particular system may support only
>  monitoring, only control, or both monitoring and control.  Cache
> @@ -118,7 +118,7 @@ related to allocation:
>  			      Corresponding region is pseudo-locked. No
>  			      sharing allowed.
>  
> -Memory bandwitdh(MB) subdirectory contains the following files
> +Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  
>  "min_bandwidth":
> @@ -209,7 +209,7 @@ All groups contain the following files:
>  	CPUs to/from this group. As with the tasks file a hierarchy is
>  	maintained where MON groups may only include CPUs owned by the
>  	parent CTRL_MON group.
> -	When the resouce group is in pseudo-locked mode this file will
> +	When the resource group is in pseudo-locked mode this file will
>  	only be readable, reflecting the CPUs associated with the
>  	pseudo-locked region.
>  
> @@ -380,7 +380,7 @@ where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
>  240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
>  threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
>  bandwidth of 100GBps although the percentage value specified is only 50%
> -<< 100%. Hence increasing the bandwidth percentage will not yeild any
> +<< 100%. Hence increasing the bandwidth percentage will not yield any
>  more bandwidth. This is because although the L2 external bandwidth still
>  has capacity, the L3 external bandwidth is fully used. Also note that
>  this would be dependent on number of cores the benchmark is run on.
> @@ -398,7 +398,7 @@ In order to mitigate this and make the interface more user friendly,
>  resctrl added support for specifying the bandwidth in MBps as well.  The
>  kernel underneath would use a software feedback mechanism or a "Software
>  Controller(mba_sc)" which reads the actual bandwidth using MBM counters
> -and adjust the memowy bandwidth percentages to ensure::
> +and adjust the memory bandwidth percentages to ensure::
>  
>  	"actual bandwidth < user specified bandwidth".
>  
> -- 
> 2.20.1
> 

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
