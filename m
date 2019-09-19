Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD78C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9D208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404923AbfISV4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:56:31 -0400
Received: from verein.lst.de ([213.95.11.211]:44443 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389212AbfISV4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:56:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C0CB68B20; Thu, 19 Sep 2019 23:56:26 +0200 (CEST)
Date:   Thu, 19 Sep 2019 23:56:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [xfs] 27d1053021: xfstests.xfs.173.fail
Message-ID: <20190919215625.GA13358@lst.de>
References: <20190919014602.GN15734@shao2-debian> <20190919174705.GA9622@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919174705.GA9622@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 07:47:05PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 19, 2019 at 09:46:02AM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 27d10530217ee6d6a0388014fd773820ee354ce5 ("xfs: remove the unused XFS_ALLOC_USERDATA flag")
> 
> Well, this does not make a whole lot of sense, given that the patch
> literally just removes an unused flag.  that being said that test has
> been father flakey for me for a long time.

But the weird part is that it actually reproduces here with 1k block
size file system despite make no sense at all..
