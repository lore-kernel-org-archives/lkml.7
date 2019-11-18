Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E94C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B96B2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRR6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:58:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:60182 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRR6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:58:32 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D6149A7;
        Mon, 18 Nov 2019 17:58:32 +0000 (UTC)
Date:   Mon, 18 Nov 2019 10:58:31 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        prarit@redhat.com, rafael.j.wysocki@intel.co,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] admin guide/pm: Admin guide for intel-speed-select
Message-ID: <20191118105831.5fd78335@lwn.net>
In-Reply-To: <20191118174828.GY32742@smile.fi.intel.com>
References: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
        <20191118104105.11776f58@lwn.net>
        <20191118174828.GY32742@smile.fi.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 19:48:28 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 18, 2019 at 10:41:05AM -0700, Jonathan Corbet wrote:
> > On Fri, 15 Nov 2019 12:49:25 -0800
> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:  
> 
> > > Added documentation to configure servers to use Intel(R) Speed
> > > Select Technology using intel-speed-select tool.  
> 
> > > +=========================================================
> > > +Intel® Speed Select Technology (Intel® SST) : User Guide
> > > +=========================================================  
> > 
> > People give me grief when I take docs patches adding non-ascii characters.
> > Adding nearly 100 useless ® symbols seems likely to trigger that sort of
> > unicode aversion.  Can I ask you, please, to take those out?  There are
> > many occurrences of unadorned "Intel" in the kernel, and the world hasn't
> > ended yet.  
> 
> Side comment. It's really strange to hear above in 21st centure. We are living
> in Unicode times. How harm unicode characters nowadays?

In general I agree, and I have little patience for complaints about
non-ascii characters in places where they actually have value. This,
however, is not one of those places.

Thanks,

jon
