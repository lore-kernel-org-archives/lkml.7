Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEAAC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C497120872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409123AbfIXFwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 01:52:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50952 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405843AbfIXFwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 01:52:09 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8O5q2HR026307;
        Tue, 24 Sep 2019 07:52:02 +0200
Date:   Tue, 24 Sep 2019 07:52:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Ben sent 132 patches and Sasa sent 203 patches..woohooo!
Message-ID: <20190924055202.GB26202@1wt.eu>
References: <20190924053003.GA29856@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924053003.GA29856@Gentoo>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:00:06AM +0530, Bhaskar Chowdhury wrote:
> Is this kind of heaving patching done before?? I can't recollect.

Yes it's being done, and quite frankly Bhaskar, this e-mail as well as
all your other automated ones ("thanks a bunch") after each and every
release do not bring any value and only add noise, particularly when
developers are directly CCed. You should avoid this because you're
training developers to systematically ignore your messages and the day
you have a real question or issue to report, nobody will notice nor
respond.

Just my two cents,
Willy
