Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA51C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F421473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfFNNEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:04:24 -0400
Received: from verein.lst.de ([213.95.11.211]:46800 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNNEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:04:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 28B3568B02; Fri, 14 Jun 2019 15:03:54 +0200 (CEST)
Date:   Fri, 14 Jun 2019 15:03:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Christoph Hellwig <hch@lst.de>, Muli Ben-Yehuda <mulix@mulix.org>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of the calgary iommu driver
Message-ID: <20190614130353.GA1036@lst.de>
References: <20190409140347.GA11524@lst.de> <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com> <20190508175219.GA32030@lst.de> <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:56:46PM +0100, Jon Mason wrote:
> I do have a system.  So, it could be tested.  However given the age of
> the HW, I would say it is not worth the effort to update and it would
> be best to remove it from the kernel.
> 
> I can send a patch to do this, unless you would prefer to do it (or
> already have something handy).

Do you still plan to send that patch?
