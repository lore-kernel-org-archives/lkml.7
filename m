Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A82C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A230206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554401006;
	bh=GvoUNVlyd6B8uHlyB8NYgh1Eli3EOBgcsGO++h+0uKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lt6HSgS2OGx4knJg8vU+XC8rs7nnIj0aYzMNsGiUkJewvgteeqV6h3TorLAT4aPHD
	 IqX9eHMN3D9bSUuulTSbHmuY8u61cEOVsn3L/k6JR9p3mVNbtq+xOppdRdeQvgnd9G
	 vUoi55dG7XfXI/eth2NUS8rn9iCYDTRt8aczO4So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfDDSDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfDDSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:03:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F64F206C0;
        Thu,  4 Apr 2019 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554401003;
        bh=GvoUNVlyd6B8uHlyB8NYgh1Eli3EOBgcsGO++h+0uKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0ixKCw0s7dPc+0BuWcL14SHSBRAz+StaY4QzOld/7A1YJJwwpAr11gmcRveDHpN9
         /drDCfrW/RjpfFdUfYavxnWC65oT7S6JEFkVNoygd3FISNUd2I+V1PPA+uj6g44rVL
         5eOWZ9+P2sUGQ/zmdL0KfTG0J9XL4FtopU9cHy18=
Date:   Thu, 4 Apr 2019 20:03:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] drivers: base: regmap: add proper SPDX identifiers
 on files that did not have them.
Message-ID: <20190404180320.GA20855@kroah.com>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
 <20190403033227.GG2059@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403033227.GG2059@sirena.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:32:27AM +0700, Mark Brown wrote:
> On Tue, Apr 02, 2019 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> 
> > --- a/drivers/base/regmap/regcache-flat.c
> > +++ b/drivers/base/regmap/regcache-flat.c
> > @@ -1,13 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> 
> Please make the whole header a C++ header so that things look more
> consistent and intentional.

SPDX lines are "intentional" :)

But sure, if you like your comments that way, I'll go redo this...

thanks,

greg k-h
