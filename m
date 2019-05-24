Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A451520815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558711158;
	bh=kmYgj5gKowihH9Hz+CQdYeZjDyUaNPJOm5n23hQQWrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ra15Rzlz3r/gFvlgw3ZTga1KnE/EqKaDnZQQY+mDx1m2uP7kEeYDSi1T394Uk503w
	 thJKkRaYfAalqpMLp1QVUNo4vY+LSCXDZ7jqrmG+HlEocbiBr7fYXTcEPNxgDDc8Ga
	 FBAUz6ThMw7iwUnMaiP4baDiwzwiBvb2zm1YXPME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfEXPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389079AbfEXPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:19:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF4A2075E;
        Fri, 24 May 2019 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558711155;
        bh=kmYgj5gKowihH9Hz+CQdYeZjDyUaNPJOm5n23hQQWrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEYe5FdW353C/LCqKEFnf4py+eROkFAaU3tXUILEyVSuYvIwXIP9467DGRXdjoPFn
         pitiSmt0cQ/PDMxfXR8viCx+3N83oXI1UjFLfOgxRPtNMDApzrlcKbE2mZ30b8jtt3
         qxpe443AFhusMA/dy/1IR4IAkicU23McJ6qCd0w8=
Date:   Fri, 24 May 2019 17:19:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Tony Luck <tony.luck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Subject: Re: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade
 Lake) affected by MDS
Message-ID: <20190524151912.GA29389@kroah.com>
References: <CAMGffEkQmdrrH3+UChZx_Af6WcFFQFw6fz3Ti4CRUau-wq7jow@mail.gmail.com>
 <20190524141732.GA4412@kroah.com>
 <7B9F565D-EE66-432B-9D29-E494BFD24683@gmail.com>
 <CAMGffEmmtJhQE04xt84QHrDxUFa0OqbKfZZT_mhXN6P6D99-WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmmtJhQE04xt84QHrDxUFa0OqbKfZZT_mhXN6P6D99-WA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:14:38PM +0200, Jinpu Wang wrote:
> I would expect the production Cascade Lake supports md-clear feature,
> so VM migration works from old generation.
> Could some one give me an answer?

No idea, try it and see!

good luck!

greg k-h
