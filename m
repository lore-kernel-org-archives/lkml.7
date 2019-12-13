Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLMKXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:23:43 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:29421 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfLMKXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:23:43 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xBDANWAD002207;
        Fri, 13 Dec 2019 11:23:32 +0100
Date:   Fri, 13 Dec 2019 11:23:32 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191213102332.GA2196@1wt.eu>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
 <20191211182401.GF31670@1wt.eu>
 <20191212212520.GA9682@avx2>
 <20191213095634.GB2407@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213095634.GB2407@kadam>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:56:34PM +0300, Dan Carpenter wrote:
> On Fri, Dec 13, 2019 at 12:25:20AM +0300, Alexey Dobriyan wrote:
> > "Complain to linux-kernel" is meaningless, kernel is not responsible.
> > 
> > What the message is even supposed to say?
> > 
> 
> You could direct people to a website and then update the instructions
> as needed.

Another possibility is to just log this as a debug message, and in this
case the user can feel free to ignore it. But a warning is something that
needs to be addressed and without instructions it's hard.

Regards,
Willy
