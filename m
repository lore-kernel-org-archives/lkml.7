Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68236C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F2C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGJHjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:39:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:32077 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfGJHjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:39:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 00:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="176757754"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 00:39:21 -0700
Date:   Wed, 10 Jul 2019 15:22:34 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v2 00/11] FPGA DFL updates
Message-ID: <20190710072234.GA26817@hao-dev>
References: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
 <20190710050746.GA28620@hao-dev>
 <20190710055417.GA5778@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710055417.GA5778@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 07:54:17AM +0200, Greg KH wrote:
> On Wed, Jul 10, 2019 at 01:07:46PM +0800, Wu Hao wrote:
> > On Fri, Jul 05, 2019 at 08:23:47AM +0800, Wu Hao wrote:
> > > Hi Greg / Moritz
> > > 
> > > This is v2 patchset which adds more features to FPGA DFL. This patchset
> > > is made on top of patch[1] and char-misc-next tree. Documentation patch
> > > for DFL is dropped from this patchset, and will resubmit it later to
> > > avoid conflict.
> > 
> > Hi Greg,
> > 
> > Did you get a chance to take a look at this new version to see if these
> > patches are good to take?
> > 
> > Hope we can catch up with the merge window.
> 
> You sent them last Friday.  I actually tried to not do kernel work last
> weekend.  The merge window opened up on Sunday.  My trees should have
> been closed last week, so no, this missed this merge window, I'll
> review these patches once 5.3-rc1 is out.

Oh..... I see...

Ok. Then let me resend it with documentation patch added back once 5.3-rc1
is out.

Thanks
Hao

> 
> thanks
> 
> greg k-h
