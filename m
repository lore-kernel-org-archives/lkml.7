Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB792083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfFGVh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:37:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:56948 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfFGVh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:37:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 14:37:25 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2019 14:37:25 -0700
Date:   Fri, 7 Jun 2019 14:28:10 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-doc@vger.kernel.org, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Documentation: x86: Clarify MBA takes MB as
 referring to mba_sc
Message-ID: <20190607212809.GC143433@romley-ivt3.sc.intel.com>
References: <20190607151409.15476-1-james.morse@arm.com>
 <20190607151409.15476-4-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607151409.15476-4-james.morse@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:14:08PM +0100, James Morse wrote:
> "If the MBA is specified in MB then user can enter the max b/w in MB"
> is a tautology. How can the user know if the schemata takes a percentage
> or a MB/s value?
> 
> This is referring to whether the software controller is interpreting
> the schemata's value. Make this clear.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  Documentation/x86/resctrl_ui.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
> index 638cd987937d..866b66aa289b 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -677,8 +677,8 @@ allocations can overlap or not. The allocations specifies the maximum
>  b/w that the group may be able to use and the system admin can configure
>  the b/w accordingly.
>  
> -If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
> -rather than the percentage values.
> +If resctrl is using the software controller (mba_sc) then user can enter the
> +max b/w in MB rather than the percentage values.
>  ::
>  
>    # echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
> -- 
> 2.20.1
> 

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
