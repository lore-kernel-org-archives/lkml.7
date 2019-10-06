Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE5C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560F20867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570388805;
	bh=uSjjwqJ+WQNYE7UjlHLyYnUqr6Pwy8Mnlttuvz673UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LjqYAVw5C3gt+FXaudQMj2Y30z6ZF/Wtku6kiZO8m/4zJWc8ibwMAUfwMTyseB3v6
	 +B76scqhPYH9lofG/SqJCpuYoHCq4U9DcDx03iFw5cpUdqoW18MwZzrO7hY3IeFQtd
	 SyqA0D+NO2ugUnI3LSKVm0zClcEDF7NLp8kb+O3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfJFTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfJFTGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:06:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2D22080F;
        Sun,  6 Oct 2019 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570388803;
        bh=uSjjwqJ+WQNYE7UjlHLyYnUqr6Pwy8Mnlttuvz673UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/bvtaOnBCthDPK4ZmxMAF3ECimk4Jylp+MLMmkYRmmhLHwHarvohCbWxnfXx9EkK
         Nlb7QMKYYqyUec4D65xXiN/1qka39yXJkSdpNRm9drA75paFPqY3Znz8xQsFsMiNzS
         yj583ZSZvB4JGPKZxf912Irb3hNiglciIFChME1k=
Date:   Sun, 6 Oct 2019 21:06:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jules Irenge <jbi.octave@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        abbotti@mev.co.uk, olsonse@umich.edu
Subject: Re: [Outreachy kernel] [PATCH] staging: comedi: Capitalize macro
 name to fix camelcase checkpatch warning
Message-ID: <20191006190640.GA237538@kroah.com>
References: <20191006184827.12021-1-jbi.octave@gmail.com>
 <alpine.DEB.2.21.1910062100530.2515@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910062100530.2515@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 09:01:09PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 6 Oct 2019, Jules Irenge wrote:
> 
> > Capitalize RANGE_mA to fix camelcase check warning.
> > Issue reported by checkpatch.pl
> 
> I guess mA means something, so it would be better to keep it?

Yes it does, we need to keep it, sorry.

thanks,

greg k-h
