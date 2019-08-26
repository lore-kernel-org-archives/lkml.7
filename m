Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC513C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A6C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566810390;
	bh=Dy/rDoyWjrefKyqTAImT3t0UysmvX/STFijFHWt2h2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jHrIzMI2FkrvnAgTT5FqMRip9HHPke99t4N1u0o8V+z1WG3zioB9JrHEeFXXossGE
	 kondQM3qVyp9URFk2/RwVrSxElM764I3GuOgdfMBmvHRf4hYkHDpMLAcRpKZAfoBVh
	 bJlMv1591nb8rdgdsR9jcgzSZIJjOOvOB9vRZJWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHZJG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfHZJG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:06:29 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCB4206BA;
        Mon, 26 Aug 2019 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566810388;
        bh=Dy/rDoyWjrefKyqTAImT3t0UysmvX/STFijFHWt2h2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJz3ha2LXsw5lb5i2BjvntVte6Kt4tnu5bLb0cV4xt+aIlbrzHRDgcZHNhF4xNo1q
         bOQy9asqYEEA+huS30+d7salxMfmKKWlW2TZqLYsUp0kE3509pDUehoUy0VJATrovW
         IUiZKu/c5DB4c0eh/yVqMC26INvimjVyRs2ZsusE=
Date:   Mon, 26 Aug 2019 11:06:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 38/53] IB/hfi1: Fix Spectre v1 vulnerability
Message-ID: <20190826090618.GA15666@kroah.com>
References: <20190805124927.973499541@linuxfoundation.org>
 <20190805124932.331142598@linuxfoundation.org>
 <3d25fa83-91e6-dd99-2170-44a51066c82d@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d25fa83-91e6-dd99-2170-44a51066c82d@embeddedor.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:16:36AM -0500, Gustavo A. R. Silva wrote:
> Hi Greg,
> 
> Can you please add these other two patches to stable:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d64062b57eeb58d4928aed945515bf53f7944913

Does not apply :(

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=737298d18836fd14b8820de6504536c998986bcd

Also does not apply :(

Can you provide backports that work if they really are needed?

thanks,

greg k-h
