Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD171C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE35D2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFNFor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:44:47 -0400
Received: from verein.lst.de ([213.95.11.211]:44056 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfFNFor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:44:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7215268B02; Fri, 14 Jun 2019 07:44:18 +0200 (CEST)
Date:   Fri, 14 Jun 2019 07:44:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: switch nios2 and microblaze to use the generic uncached
 segement support
Message-ID: <20190614054418.GA6722@lst.de>
References: <20190603065324.9724-1-hch@lst.de> <1560476434.21652.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560476434.21652.1.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:40:34AM +0800, Ley Foon Tan wrote:
> Hi Christoph
> 
> Can this patch in http://git.infradead.org/users/hch/dma-mapping.git/sh
> ortlog/refs/heads/for-next
> 
> [PATCH 1/2] nios2: use the generic uncached segment support in dma-
> direct

Hi Ley Foon,

I don't understand the above sentence.  Does it imply a Reviewed-by?
