Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72411CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484DC20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572935433;
	bh=V9WFCm9YBti+ItUaNZMgrfSzuU6a9dbQGe9OwI1Srlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M6nKg+woUIOPt1QAQ5x4v3xrkyqofpqnX9J1uA2FTB13XhQiYb/Tljd+Akyrg91Lq
	 Tn+7l7tpwqK00j6GMWssfKbn+aZAJUlUnM1KCRFP3qjMkyW9/cIBwuguV3R6vcsdtg
	 qHrwp/8qXhYmPiYqAEqagv8PqUs0Tr5HgT4WqIr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfKEGac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:30:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfKEGac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:30:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E902AC82;
        Tue,  5 Nov 2019 06:30:30 +0000 (UTC)
Date:   Tue, 5 Nov 2019 07:30:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, stable@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH 2/2] docs: admin-guide: Remove threads-max auto-tuning
Message-ID: <20191105063029.GD22672@dhcp22.suse.cz>
References: <20191101040438.6029-1-standby24x7@gmail.com>
 <20191101040438.6029-2-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101040438.6029-2-standby24x7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-11-19 13:04:38, Masanari Iida wrote:
> Since following path was merged in 5.4-rc3,
> auto-tuning feature in threads-max was not exist any more.
> Fix the admin-guide document as is.
> 
> kernel/sysctl.c: do not override max_threads provided by userspace
> b0f53dbc4bc4c371f38b14c391095a3bb8a0bb40
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 38e0f10d7d9f..9035adbdff58 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1109,10 +1109,6 @@ constant FUTEX_TID_MASK (0x3fffffff).
>  If a value outside of this range is written to threads-max an error
>  EINVAL occurs.
>  
> -The value written is checked against the available RAM pages. If the
> -thread structures would occupy too much (more than 1/8th) of the
> -available RAM pages threads-max is reduced accordingly.
> -
>  
>  unknown_nmi_panic:
>  ==================
> -- 
> 2.24.0.rc1

-- 
Michal Hocko
SUSE Labs
