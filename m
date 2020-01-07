Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A285FC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7040A2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578420292;
	bh=hZfs1VmlNn9lkKXWmR1EyNETRDH4pSYS5DmkTwkDhxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/Fwe9QWLxdl8jnUAQWu4ajIpJUt9nj+E8J2Oc24oAV5d/aPkDJbaHOtEzpyun0ak
	 3vQBbeKtIyv1pDHPK1zEPb/1TSean7PSjRdfCHJGFgfiWidS1/XWZ5tqS1+pnSTjj1
	 W627+mymHZwd7g73gm9Vj8Xv3jjZEH5RLnhkRJ9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAGSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgAGSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:04:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE092087F;
        Tue,  7 Jan 2020 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578420290;
        bh=hZfs1VmlNn9lkKXWmR1EyNETRDH4pSYS5DmkTwkDhxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlCffCUsYQ2ZVM7wp+SaTFw95WWU54wH+IR7BKxznERqzPZ26cJkBFzNycOBVuiMV
         VKwGyNTfHOQfgCJmGh43Zr2qa0FNrzoEE2U57+scNV34aNbCtoN3lrdG5VT95FdMBa
         XeYQmAhvA3Vufr2GO1Nf8XX0Kku3IebJ9bmPDiLg=
Date:   Tue, 7 Jan 2020 18:04:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v3] locking/qspinlock: Fix inaccessible URL of MCS lock
 paper
Message-ID: <20200107180445.GD32009@willie-the-truck>
References: <20200107174914.4187-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107174914.4187-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:49:14PM -0500, Waiman Long wrote:
> It turns out that the URL of the MCS lock paper listed in the source
> code is no longer accessible. I did got question about where the paper
> was. This patch updates the URL to BZ 206115 which contains a copy of
> the paper from
> 
>   https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Thanks!

Acked-by: Will Deacon <will@kernel.org>

Will
