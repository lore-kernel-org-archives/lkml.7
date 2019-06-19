Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E0C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F29D20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfFSHyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:54:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfFSHyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:54:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0971D3AD6E33AC54E9A;
        Wed, 19 Jun 2019 15:54:32 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 15:54:27 +0800
Date:   Wed, 19 Jun 2019 08:54:16 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the staging.current
 tree
Message-ID: <20190619085416.00001d8f@huawei.com>
In-Reply-To: <20190618115131.GB21419@kroah.com>
References: <20190618073618.0682627e@canb.auug.org.au>
        <20190618115131.GB21419@kroah.com>
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

On Tue, 18 Jun 2019 13:51:31 +0200
Greg KH <greg@kroah.com> wrote:

> On Tue, Jun 18, 2019 at 07:36:18AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   0c75376fa395 ("counter/ftm-quaddec: Add missing dependencies in Kconfig")
> > 
> > Fixes tag
> > 
> >   Fixes: a3b9a99 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > 
> > has these problem(s):
> > 
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
> > 
> > In commit
> > 
> >   bce0d57db388 ("iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller")
> > 
> > Fixes tag
> > 
> >   Fixes: c91c1c844ebd ("imu: st_lsm6dsx: add i2c embedded controller support")
> > 
> > has these problem(s):
> > 
> >   - Subject does not match target commit subject
> >     Just use
> > 	git log -1 --format='Fixes: %h ("%s")'  
> 
> Ugh.
> 
> I blame Jonathan for all of these as they came in through his tree :)
> 
> thanks,
> 
> greg k-h

I'll keep a closer eye on this going forwards.

Thanks,

Jonathan

