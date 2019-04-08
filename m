Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73009C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BDC20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDHKel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:34:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:25882 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDHKel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:34:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 03:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="140963273"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 03:34:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDRbp-0006pb-5I; Mon, 08 Apr 2019 13:34:37 +0300
Date:   Mon, 8 Apr 2019 13:34:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20190408103437.GK9224@smile.fi.intel.com>
References: <20190408130212.0a41f2a8@canb.auug.org.au>
 <20190408091458.00004e48@huawei.com>
 <20190408100121.GH9224@smile.fi.intel.com>
 <20190408111439.000049bc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408111439.000049bc@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:14:39AM +0100, Jonathan Cameron wrote:
> On Mon, 8 Apr 2019 13:01:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 08, 2019 at 09:14:58AM +0100, Jonathan Cameron wrote:
> > > On Mon, 8 Apr 2019 13:02:12 +1000
> > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > > > Today's linux-next merge of the staging tree got a conflict in:
> > > > 
> > > >   drivers/iio/industrialio-buffer.c
> > > > 
> > > > between commit:
> > > > 
> > > >   20ea39ef9f2f ("iio: Fix scan mask selection")
> > > > 
> > > > from the staging.current tree and commit:
> > > > 
> > > >   3862828a903d ("iio: buffer: Switch to bitmap_zalloc()")
> > > > 
> > > > from the staging tree.
> > > > 
> > > > I fixed it up (I just used the staging tree version) and can carry the
> > > > fix as necessary. This is now fixed as far as linux-next is concerned,
> > > > but any non trivial conflicts should be mentioned to your upstream
> > > > maintainer when your tree is submitted for merging.  You may also want
> > > > to consider cooperating with the maintainer of the conflicting tree to
> > > > minimise any particularly complex conflicts.
> > > >   
> > > Thanks Stephen,
> > > 
> > > That is the correct resolution.  
> > 
> > I think it still misses the following fix:

> Is that actually a problem given it's copied over from buffer->scan_mask just after allocation?
> The two masks are the same length so I don't think we have a problem with this one.
> Am I missing something?

Hmm... I didn't get why the commit 20ea39ef9f2f fixes anything.

-- 
With Best Regards,
Andy Shevchenko


