Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F96C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F344208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfFGVdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:33:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:50823 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfFGVdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:33:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 14:33:35 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2019 14:33:35 -0700
Date:   Fri, 7 Jun 2019 14:24:20 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-doc@vger.kernel.org, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Documentation: x86: Contiguous cbm isn't all X86
Message-ID: <20190607212419.GA143433@romley-ivt3.sc.intel.com>
References: <20190607151409.15476-1-james.morse@arm.com>
 <20190607151409.15476-2-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607151409.15476-2-james.morse@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:14:06PM +0100, James Morse wrote:
> Since commit 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> resctrl has supported non-contiguous cache bit masks. The interface
> for this is currently try-it-and-see.
> 
> Update the documentation to say Intel CPUs have this requirement,
> instead of X86.
> 
> Cc: Babu Moger <Babu.Moger@amd.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  Documentation/x86/resctrl_ui.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
> index 225cfd4daaee..066f94e53418 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -342,7 +342,7 @@ For cache resources we describe the portion of the cache that is available
>  for allocation using a bitmask. The maximum value of the mask is defined
>  by each cpu model (and may be different for different cache levels). It
>  is found using CPUID, but is also provided in the "info" directory of
> -the resctrl file system in "info/{resource}/cbm_mask". X86 hardware
> +the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
>  requires that these masks have all the '1' bits in a contiguous block. So
>  0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
>  and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
> -- 
> 2.20.1
>
 
Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua Yu
