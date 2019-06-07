Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A572C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E868212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfFGVgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:36:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:56868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfFGVgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:36:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 14:36:00 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2019 14:36:00 -0700
Date:   Fri, 7 Jun 2019 14:26:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-doc@vger.kernel.org, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Documentation: x86: Remove cdpl2 unspported
 statement and fix capitalisation
Message-ID: <20190607212645.GB143433@romley-ivt3.sc.intel.com>
References: <20190607151409.15476-1-james.morse@arm.com>
 <20190607151409.15476-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607151409.15476-3-james.morse@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:14:07PM +0100, James Morse wrote:
> "L2 cache does not support code and data prioritization". This isn't
> true, elsewhere the document says it can be enabled with the cdpl2
> mount option.
> 
> While we're here, these sample strings have lower-case code/data,
> which isn't how the kernel exports them.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  Documentation/x86/resctrl_ui.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
> index 066f94e53418..638cd987937d 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -418,16 +418,22 @@ L3 schemata file details (CDP enabled via mount option to resctrl)
>  When CDP is enabled L3 control is split into two separate resources
>  so you can specify independent masks for code and data like this::
>  
> -	L3data:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> -	L3code:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> +	L3DATA:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> +	L3CODE:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
>  
>  L2 schemata file details
>  ------------------------
> -L2 cache does not support code and data prioritization, so the
> -schemata format is always::
> +CDP is supported at L2 using the 'cdpl2' mount option. The schemata
> +format is either::
>  
>  	L2:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
>  
> +or
> +
> +	L2DATA:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> +	L2CODE:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> +
> +
>  Memory bandwidth Allocation (default mode)
>  ------------------------------------------
>  
> -- 
> 2.20.1
> 

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
