Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B631C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98E4204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfCRJpG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:45:06 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46502 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfCRJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72D2660F6D8B;
        Mon, 18 Mar 2019 10:30:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gC1JsEAVKMFk; Mon, 18 Mar 2019 10:30:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27AA861054C0;
        Mon, 18 Mar 2019 10:30:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5blHwQ4xf-wr; Mon, 18 Mar 2019 10:30:13 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C37EB60F6D8B;
        Mon, 18 Mar 2019 10:30:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hostfs: fix mismatch between link_file definition and declaration
Date:   Mon, 18 Mar 2019 10:30:12 +0100
Message-ID: <2148931.zAvBH5bg2x@blindfold>
In-Reply-To: <fa1378b0-3048-8309-a152-8fdf5696731d@canonical.com>
References: <20190317230909.7373-1-colin.king@canonical.com> <1760676.zAVrM27zAz@blindfold> <fa1378b0-3048-8309-a152-8fdf5696731d@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. März 2019, 09:41:28 CET schrieb Colin Ian King:
> On 17/03/2019 23:49, Richard Weinberger wrote:
> > Am Montag, 18. März 2019, 00:09:09 CET schrieb Colin King:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The function link_file declaration in the header file has the order
> >> of the two arguments (from, to) swapped when compared to the definition
> >> arguments of (to, from).  Fix this by swapping them around to match
> >> the definition.
> >>
> >> This error predates the git history, so no idea when this error
> >> was introduced.
> > 
> > commit bf4f804738544a95b8bc8d6a7e2629c3fc0240dd
> > Author: jdike <jdike>
> > Date:   Sat Dec 9 22:52:44 2000 +0000
> > 
> >     hostfs now mostly works.  Almost all of the common operations are now
> >     implemented, the main exceptions being mknod and executing files from
> >     a hostfs filesystem.
> > 
> > Enough archaeology for today. :-)
> 
> Nice. How do you find these ancient git commits?

This commit is from the old UML cvs tree.
I did a import to git some time ago and pushed it to:
https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml-history.git/

For classic pre-git stuff, check:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

Thanks,
//richard


