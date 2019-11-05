Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B507CCA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3CE20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572935413;
	bh=Em+PlRARY0EOPr2Xtx+fuuFMQLq6VHBOOyMuBJZ15I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0OC1AFlVlP0ZpDr/rZQp+XrM+85dC4YoLQCjh4Tl+NY+Z3RC0GEIWIdcV7RPa/B1B
	 xHciJdcEnbr4cZxLahsPUMXrgyZrehV8UOmvIYNoy3KtF49kBhZv7iue+7OK8Ee3Ju
	 giB336QCmLnVpell26QynWFzDhbeXH++DGnp0COg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfKEGaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:30:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:43610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfKEGaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:30:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E26A2B1E4;
        Tue,  5 Nov 2019 06:30:09 +0000 (UTC)
Date:   Tue, 5 Nov 2019 07:30:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, stable@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH 1/2] docs: admin-guide: Fix min value of threads-max in
 kernel.rst
Message-ID: <20191105063008.GC22672@dhcp22.suse.cz>
References: <20191101040438.6029-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101040438.6029-1-standby24x7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-11-19 13:04:37, Masanari Iida wrote:
> Since following patch was merged 5.4-rc3, minimum value for
> threads-max changed to 1.
> 
> kernel/sysctl.c: do not override max_threads provided by userspace
> b0f53dbc4bc4c371f38b14c391095a3bb8a0bb40
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 032c7cd3cede..38e0f10d7d9f 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1101,7 +1101,7 @@ During initialization the kernel sets this value such that even if the
>  maximum number of threads is created, the thread structures occupy only
>  a part (1/8th) of the available RAM pages.
>  
> -The minimum value that can be written to threads-max is 20.
> +The minimum value that can be written to threads-max is 1.
>  
>  The maximum value that can be written to threads-max is given by the
>  constant FUTEX_TID_MASK (0x3fffffff).
> -- 
> 2.24.0.rc1

-- 
Michal Hocko
SUSE Labs
