Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5584C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876F520820
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfEJX7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 19:59:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:3432 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfEJX7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 19:59:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 16:59:10 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2019 16:59:10 -0700
Date:   Fri, 10 May 2019 16:59:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz, keith.busch@intel.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: Make follow_page_mask static
Message-ID: <20190510235946.GA14927@iweiny-DESK2.sc.intel.com>
References: <20190510190831.GA4061@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510190831.GA4061@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 12:38:32AM +0530, Bharath Vedartham wrote:
> follow_page_mask is only used in gup.c, make it static.
> 
> Tested by compiling and booting. Grepped the source for
> "follow_page_mask" to be sure it is not used else where.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 91819b8..e6f3b7f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -409,7 +409,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>   * an error pointer if there is a mapping to something not represented
>   * by a page descriptor (see also vm_normal_page()).
>   */
> -struct page *follow_page_mask(struct vm_area_struct *vma,
> +static struct page *follow_page_mask(struct vm_area_struct *vma,
>  			      unsigned long address, unsigned int flags,
>  			      struct follow_page_context *ctx)
>  {
> -- 
> 2.7.4
> 
