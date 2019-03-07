Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A75C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41B020835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCGIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:09:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:47058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfCGIJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:09:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D956B137;
        Thu,  7 Mar 2019 08:09:42 +0000 (UTC)
Date:   Thu, 7 Mar 2019 09:09:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pankaj Suryawanshi <suryawanshipankaj@yahoo.com>
Cc:     s.szyprowski@samsung.com, mina86@mina86.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: CMA allocation failure and Latency issue
Message-ID: <20190307080940.GL4603@dhcp22.suse.cz>
References: <22ed9e4c-962b-4e8c-8549-d8cca578957f@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ed9e4c-962b-4e8c-8549-d8cca578957f@email.android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Cc linux-mm and lkml]

Please do not use html emails, thanks!

On Thu 07-03-19 13:28:59, Pankaj Suryawanshi wrote:
> Hello,
> 
> I am facing issue related to CMA allocation failure of large size buffer.
> 
> I am beginner in Linux memory management. So I need your help to debug the
> issue, 
> 
> I have below questions 
> 
> 1. Why migration failed
> 2. Who pinned the pages, Which process pinned ,how to know ?
> 3. How to migrate pages forcefully so failure will avoid.(not preferable
> approach)
> etc.
> 
> Any help would be appreciated.
> 
> Please let me know if you require further information.
> 
> Regards,
> Pankaj

-- 
Michal Hocko
SUSE Labs
