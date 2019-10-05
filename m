Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7601C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7463B20862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570303112;
	bh=ml5YY8sFeT+x/78kF+5x4moou34bSVER9pmDCNCHVBY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=L3ryXx5TUrSbVHKCrWXsA0Qb7BlpvUhR7VOy02bhCA2aBHnMAYbAWdfEAuiEnuh4p
	 /gM+C+BNOWS/+YdHYJF6m3undyJr19PsQLoqzx6B6xgsMtqMJVvn2OWD8EUQUQO4Oi
	 YjUny+mtbrBIu6S+j32uy1mteiSVH+FP5Z/yFXJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfJETSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbfJETSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:18:31 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04E92084D;
        Sat,  5 Oct 2019 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570303110;
        bh=ml5YY8sFeT+x/78kF+5x4moou34bSVER9pmDCNCHVBY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r/Fi0GcA5v2+kY18q4i9qGUDaslaCFgmFfvug/40FCPpMag1wEOSHyXciCKBvUF82
         ZnlvZ2Uq4kosP/HkP929U0TMZRJnAQ5m3+8jSmcE1WxQxkrDUtXy+TfkK7cLWu9fxm
         3No9zMCfvODGn+W8QsGDwhzjF3X0Zwe/J6a4mEvc=
Date:   Sat, 5 Oct 2019 12:18:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools/memory-model/Documentation: Add plain accesses
 and data races to explanation.txt
Message-ID: <20191005191829.GA25888@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <Pine.LNX.4.44L0.1910011338240.1991-100000@iolanthe.rowland.org>
 <20191003101330.GA11363@andrea.guest.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003101330.GA11363@andrea.guest.corp.microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:13:30PM +0200, Andrea Parri wrote:
> On Tue, Oct 01, 2019 at 01:40:19PM -0400, Alan Stern wrote:
> > This patch updates the Linux Kernel Memory Model's explanation.txt
> > file by adding a section devoted to the model's handling of plain
> > accesses and data-race detection.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> For the entire series,
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Applied and promoted to from lkmm-dev to lkmm, thank you both!

							Thanx, Paul
