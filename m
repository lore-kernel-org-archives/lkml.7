Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B8C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7186520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDHMCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:02:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfDHMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:02:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E05DEE44A01EEE3C951F;
        Mon,  8 Apr 2019 20:02:04 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 20:02:01 +0800
Date:   Mon, 8 Apr 2019 13:01:51 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20190408130151.0000278a@huawei.com>
In-Reply-To: <20190408103437.GK9224@smile.fi.intel.com>
References: <20190408130212.0a41f2a8@canb.auug.org.au>
        <20190408091458.00004e48@huawei.com>
        <20190408100121.GH9224@smile.fi.intel.com>
        <20190408111439.000049bc@huawei.com>
        <20190408103437.GK9224@smile.fi.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 13:34:37 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 11:14:39AM +0100, Jonathan Cameron wrote:
> > On Mon, 8 Apr 2019 13:01:21 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Mon, Apr 08, 2019 at 09:14:58AM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 8 Apr 2019 13:02:12 +1000
> > > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> 
> > > > > Today's linux-next merge of the staging tree got a conflict in:
> > > > > 
> > > > >   drivers/iio/industrialio-buffer.c
> > > > > 
> > > > > between commit:
> > > > > 
> > > > >   20ea39ef9f2f ("iio: Fix scan mask selection")
> > > > > 
> > > > > from the staging.current tree and commit:
> > > > > 
> > > > >   3862828a903d ("iio: buffer: Switch to bitmap_zalloc()")
> > > > > 
> > > > > from the staging tree.
> > > > > 
> > > > > I fixed it up (I just used the staging tree version) and can carry the
> > > > > fix as necessary. This is now fixed as far as linux-next is concerned,
> > > > > but any non trivial conflicts should be mentioned to your upstream
> > > > > maintainer when your tree is submitted for merging.  You may also want
> > > > > to consider cooperating with the maintainer of the conflicting tree to
> > > > > minimise any particularly complex conflicts.
> > > > >     
> > > > Thanks Stephen,
> > > > 
> > > > That is the correct resolution.    
> > > 
> > > I think it still misses the following fix:  
> 
> > Is that actually a problem given it's copied over from buffer->scan_mask just after allocation?
> > The two masks are the same length so I don't think we have a problem with this one.
> > Am I missing something?  
> 
> Hmm... I didn't get why the commit 20ea39ef9f2f fixes anything.
> 
Good point.  I'm don't think it ever did.  

Alex, any thoughts?

Jonathan

