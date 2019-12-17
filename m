Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3401C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83979218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfLQPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:15:53 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:51674 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLQPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:15:52 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ihEZh-0006DW-00; Tue, 17 Dec 2019 15:15:49 +0000
Date:   Tue, 17 Dec 2019 10:15:49 -0500
From:   Rich Felker <dalias@libc.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/2] sh: get rid of __ARCH_USE_5LEVEL_HACK
Message-ID: <20191217151549.GH1666@brightrain.aerifal.cx>
References: <20191217142150.10392-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217142150.10392-1-rppt@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:21:48PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches update the SuperH page table folding/unfolding to take into
> account the 5th level.

Is this only for 64-bit/sh5? If so, I'd really like to avoid having
patch churn that nominally keeps it working, since it doesn't; GCC
dropped support a long time ago and it was experimental to begin with,
never appeared in production. Has anyone looked lately at what it
would take to remove it?

Rich
