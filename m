Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB70C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31220673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfFNGwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:52:32 -0400
Received: from verein.lst.de ([213.95.11.211]:44566 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfFNGwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:52:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 14D0B68B05; Fri, 14 Jun 2019 08:52:03 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:52:02 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Subject: Re: switch nios2 and microblaze to use the generic uncached
 segement support
Message-ID: <20190614065202.GA8084@lst.de>
References: <20190603065324.9724-1-hch@lst.de> <1560476434.21652.1.camel@intel.com> <20190614054418.GA6722@lst.de> <1560492659.21652.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560492659.21652.3.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:11:00AM +0000, Tan, Ley Foon wrote:
> On Fri, 2019-06-14 at 07:44 +0200, Christoph Hellwig wrote:
> > On Fri, Jun 14, 2019 at 09:40:34AM +0800, Ley Foon Tan wrote:
> > > 
> > > Hi Christoph
> > > 
> > > Can this patch in http://git.infradead.org/users/hch/dma-mapping.gi
> > > t/sh
> > > ortlog/refs/heads/for-next
> > > 
> > > [PATCH 1/2] nios2: use the generic uncached segment support in dma-
> > > direct
> > Hi Ley Foon,
> > 
> > I don't understand the above sentence.  Does it imply a Reviewed-by?
> Sorry, typo in my previous email. 
> Can't find this patch in the git link you provided (for-next branch).
> Did you push the patch?

No, I did not push the microblaze and nios2 patches there.  The for-next
patch just has the baseline, you'll need to apply the nios2 on top of
that branch to test it.  If it tests good and you are fine with it I'd
like to apply it to that branch.
