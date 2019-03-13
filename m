Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9822146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCMUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:16:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:44044 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCMUQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:16:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,475,1544515200"; 
   d="scan'208";a="122435730"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2019 13:16:33 -0700
Date:   Wed, 13 Mar 2019 13:16:33 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add KVM selftests to existing KVM entry
Message-ID: <20190313201633.GE4409@linux.intel.com>
References: <20190313195555.6198-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313195555.6198-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:55:55PM -0700, Sean Christopherson wrote:
> It's safe to assume Paolo and Radim are maintaining the KVM selftests
> given that the vast majority of commits have their SOBs.  Play nice
> with get_maintainers and make it official.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8347269aa386..b95f5b69e5be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8295,6 +8295,7 @@ F:	include/linux/kvm*
>  F:	include/kvm/iodev.h
>  F:	virt/kvm/*
>  F:	tools/kvm/
> +F:	tools/testing/selftests/kvm/

Gah, this also needs: tools/testing/selftests/kvm/*/

>  
>  KERNEL VIRTUAL MACHINE FOR AMD-V (KVM/amd)
>  M:	Joerg Roedel <joro@8bytes.org>
> -- 
> 2.21.0
> 
