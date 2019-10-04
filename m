Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1058C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95997215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570191476;
	bh=x1L2ZokeQOne/DqP/usAhgrzcCQTLBVzVANkVMBLdBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IoiDNYMyPBc/AKAcOFdm6Qg9JIKjXVFPYlHcp1psKIg6TMI/njqxYUgAV0TFGtPdJ
	 Sa6hkQma25h1i3SprNFgGnqCs5+t2mokyOxS0XCfXlxCsoAtG8pgssDDh881X3xqaj
	 kT42wi01fiW0sFLNGHP5Iib1LsPh3ecVyR974DwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfJDMR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJDMRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:17:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6962070B;
        Fri,  4 Oct 2019 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570191475;
        bh=x1L2ZokeQOne/DqP/usAhgrzcCQTLBVzVANkVMBLdBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+8xF3iw9f6DsSsXYXsvqtfnO6A3JLaGPbHeq+6iVIV9vjxzrS2gP3UoMELtgutJg
         G7xp/hXnHFS/2nDO472YaSJIjK703er6JAW3LtWnK1G2BINzQ8fYEBG/3nRIPWIva5
         NGZ8Gc8IEyO8vnONSvoTEVHzwXdzTRJZxi2Mqqk8=
Date:   Fri, 4 Oct 2019 14:17:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, youling 257 <youling257@gmail.com>
Subject: Re: Problem with "driver core: platform: Add an error message to
 platform_get_irq*()" commit
Message-ID: <20191004121752.GA409122@kroah.com>
References: <01e3d855-c849-ad7f-a6f8-87c806bb488b@redhat.com>
 <5d965926.1c69fb81.6d844.cdc4@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d965926.1c69fb81.6d844.cdc4@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:25:09PM -0700, Stephen Boyd wrote:
> Quoting Hans de Goede (2019-10-03 13:20:24)
> > 
> > The best solution I can come up with is adding a new
> > platform_get_irq_byname_optional mirroring platform_get_irq_optional
> > and using that in drivers such as the dwc3 driver.
> > 
> > Does anyone have a better suggestion?
> > 
> 
> A byname_optional API sounds good to me.
> 

Sounds fine to me as well.

greg k-h
