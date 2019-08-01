Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4863C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509920838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564668615;
	bh=aTQgjcwnlFP9R0XuBVgdEzfyH25m29QufiYDNE5ngdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=igB2/+Ml8NTMlLFvuB6QGIozN6jIpHOGQ2QiE4TnFEv/FWSEOcaqfmZKuaoDwzXA5
	 CzYudqmrrkkwDfsZpQjZmyrPZ4OQbw5Z7NHLro4EaSeNJDtUvN2tvnCTql5qOvNYwe
	 bB90oZaC6YGjM27iSxd+Sjw8HlxuEKTWPAl7bYUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfHAOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbfHAOKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:10:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D0020679;
        Thu,  1 Aug 2019 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564668613;
        bh=aTQgjcwnlFP9R0XuBVgdEzfyH25m29QufiYDNE5ngdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDX4xAksYbtR2hl+kD3gWwwg9YL0fEHnijkOWgjt8paEPQ4/srbpTdfQtjKvuChs6
         FbFeAjYi4RTMZOZMSONSFZQ+IfLq1um6mVcaAbCUi0JtR+o0hvdJhMLJ/+2UMeFRAP
         5jrS7r6HXoYJRAbw9YGfs2JilMmDU7QScT+kn/Ko=
Date:   Thu, 1 Aug 2019 15:10:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190801141009.iksa5pc25vxlydak@willie-the-truck>
References: <20190801235614.4318ce1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801235614.4318ce1a@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:56:14PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   23fb9748a46d ("arm64: Lower priority mask for GIC_PRIO_IRQON")
> 
> is missing a Signed-off-by from its committer.

Urgh, I just can't get this one right, can I? Let's see if I managed it
this time. Otherwise I'm reverting the thing and we'll just have to live
with broken priority masking forever!

Will
