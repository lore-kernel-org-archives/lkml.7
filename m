Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B39C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F67206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfG3RO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:14:27 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36962 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3RO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:14:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsVhg-0002yM-0d; Tue, 30 Jul 2019 19:14:24 +0200
Message-ID: <eb5285a0f1ee2f7211a0e0687e0ed73ba8920fea.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] devcoredump: fix typo in comment
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date:   Tue, 30 Jul 2019 19:14:21 +0200
In-Reply-To: <20190730171159.GB32124@kroah.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
         <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
         <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
         <20190730162320.GA28134@kroah.com>
         <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
         <20190730164553.GA14088@kroah.com>
         <a8e2b0673b982696e3e3a71abfd1f647f2bcb2b7.camel@sipsolutions.net>
         <20190730171159.GB32124@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 19:11 +0200, Greg KH wrote:
> On Tue, Jul 30, 2019 at 06:49:12PM +0200, Johannes Berg wrote:
> > On Tue, 2019-07-30 at 18:45 +0200, Greg KH wrote:
> > 
> > > > I mean, you take patches to devcoredump in general?
> > > 
> > > I have no idea, run 'scripts/get_maintainer.pl' to be sure :)
> > 
> > That actually points to me :-)
> > 
> > So really I guess the question is how I should send these upstream? It's
> > to drivers/base/devcoredump.c and include/linux/devcoredump.h and I
> > kinda figured you wanted to see these things.
> 
> Ah, sure, I can take them, I had no idea what devcoredump was.  Remember
> my patch workload :)

:-)

> So send them on please.

Will do. Thanks Greg.

johannes

