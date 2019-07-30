Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A054C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfG3QiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:38:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36328 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG3QiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:38:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsV8T-0001yS-2B; Tue, 30 Jul 2019 18:38:01 +0200
Message-ID: <27feb840cba115e4ff8c96d47dfbab08fda30bef.camel@sipsolutions.net>
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
Date:   Tue, 30 Jul 2019 18:37:56 +0200
In-Reply-To: <20190730162320.GA28134@kroah.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
         <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
         <41a47bd3f48ea0ecd25e6ffefff9f100edf53a0c.camel@sipsolutions.net>
         <20190730162320.GA28134@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 18:23 +0200, Greg KH wrote:
> On Sat, Jul 27, 2019 at 08:43:21PM +0200, Johannes Berg wrote:
> > On Sun, 2019-07-28 at 00:59 +0900, Akinobu Mita wrote:
> > > s/dev_coredumpmsg/dev_coredumpsg/
> > 
> > Oops, thanks
> > 
> > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> > 
> > Greg, I think before you took these patches?
> 
> Took what patches?  I don't see anything here :(

I mean, you take patches to devcoredump in general?

So need to resend with you included, I guess.

johannes

