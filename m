Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B248CC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3AA2408C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559636549;
	bh=bWEJMOj0o2IDDGnopxojGRTCuxKBVcBfseHXoPLxNrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMkCFfEu/V4Blv1+C3SzY9NbKvlmelItVV7v8x43/bF5ZxNtvLbtxgrDDYRjoVMYu
	 It/OL3FmW4e51Hl7HM31cozaK5gvNo4NlsHlA1G12kChtjYJTN2mb7sUP6ovlC4TmL
	 DwgZZfTzRLQJoIXYPsD2x4+esfxQQtwqoIh35CdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfFDIW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfFDIW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:22:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3C523CCA;
        Tue,  4 Jun 2019 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559636548;
        bh=bWEJMOj0o2IDDGnopxojGRTCuxKBVcBfseHXoPLxNrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgE8rGRpa2gcU/gaTojoM8Yz5p3LsybZTaXyJKkqYZG41iT6fz+dVZivSw7gsJbTd
         VqETMJ4IbXD07NK/pg+W4uvEgr86MRSFFlwjiLQ6Nl7DFpoX8qH5THrmKF7yKaLjnN
         EO8oLFrBobHMzwBufnrXL4O0fouNq9phnudteMps=
Date:   Tue, 4 Jun 2019 10:21:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.0.21
Message-ID: <20190604082159.GA25963@kroah.com>
References: <20190604073843.GA4985@kroah.com>
 <20190604081553.GB10154@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604081553.GB10154@Gentoo>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:45:53PM +0530, Bhaskar Chowdhury wrote:
> Heads up! this has reached an EOL ...so please move to 5.1 series.

That's exactly what I said.  Why repeat it in a top-post?

confused,

greg k-h
