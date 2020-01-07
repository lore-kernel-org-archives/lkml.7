Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB0C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820682075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aj0Yzfm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAGM6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:58:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgAGM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tkecHAhepVTKoRjZgThjlsxs8naRIFB+LvWuTmW8e0A=; b=Aj0Yzfm+MIDwlRGDQG+ox/Ztg
        Hp5maIvbT9R78GrBfY3ZnyvgaT/sTvqNhtDHieZhgzKLzwhcW9Zp6PZF/RRU8lYmPVyiDnDeY6gFV
        Y9NQiZgO4NLDFEkhE38l7a9TBap+VQ73Uk7V0CVr3ZP+oPqZusJzObVrNa9sW/7ZM/0yS8Ht8w2k9
        uOCdBizdlqD50Guphl2rTBslYBHo3j3Trb/qhjbhfx0x9tqur9UHo+kGaNeZELE2YwJ71+GbAyAx9
        XMFAmWuPevFo8pH7RgjlpTrsM1ULf6PhQhPHrwDnXU+mmsN3FZ5gY51FcHTpL9qZiP9ZwhFagpuvg
        sQB2Phbrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iooRG-0006dh-II; Tue, 07 Jan 2020 12:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 953F63012C3;
        Tue,  7 Jan 2020 13:56:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032ED20D3D423; Tue,  7 Jan 2020 13:58:24 +0100 (CET)
Date:   Tue, 7 Jan 2020 13:58:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Message-ID: <20200107125824.GA2844@hirez.programming.kicks-ass.net>
References: <20191223022532.14864-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223022532.14864-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 09:25:32PM -0500, Waiman Long wrote:
> It turns out that the URL of the MCS lock paper listed in the source
> code is no longer accessible. I did got question about where the paper
> was. This patch updates the URL to one that is still accessible.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10c6956..1d008d2333c0 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -34,7 +34,7 @@
>   * MCS lock. The paper below provides a good description for this kind
>   * of lock.
>   *
> - * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
> + * https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf

Do we want to stick a copy of the paper in our bugzilla and link that
instead? ISTR we do something similar elsewhere, but I'm having trouble
finding it.

Thomas, Konstantin?
