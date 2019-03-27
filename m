Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FE2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553648948;
	bh=w4Tk+v310QSVNovConGzf2cdojMX+xJmbNqkvihIYnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=whbJLf61AyATWtocxN9SbVp93qiOEyubVDkyQOs/a/3wddtU45wldFD5u4AwPZB96
	 8mfo55Pyg9MogI4+Axf0I6FzJkTPLPiYEUoZec7WGxBqtgXd0vewcSMe2j1G7n5ra/
	 KH94MvThy3O0TJNGVZDixYS3Txu58p2718KC0BS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfC0BJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbfC0BJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:09:06 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C25602075D;
        Wed, 27 Mar 2019 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553648946;
        bh=w4Tk+v310QSVNovConGzf2cdojMX+xJmbNqkvihIYnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJ37qDOuMWZMJ0atgXsrBjGzJR7RUuOMNXT+rMcu4wIpwxwmtRuijf5vJ4N4ioElk
         vp7M2z9q5oR4FwippR4i1BxyLxYzAlPHH96Go0kizb0EmRRVZVru12nxXuXcteedXA
         79utdJXFuPOFYG9HR0YMpZrYkBF31u20YzPZXqiY=
Date:   Wed, 27 Mar 2019 10:09:01 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull v2] habanalabs fixes for 5.1-rc3
Message-ID: <20190327010901.GA30198@kroah.com>
References: <20190326081335.GA4175@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326081335.GA4175@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:13:35AM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> A couple of important fixes for habanalabs driver:
> 
> - Fix host crash upon resume after suspend
> - Fix MMU related bugs which result in user's jobs getting stuck
> - Fix race between user context cleanup and hard-reset which results in
>   host crash
> - Fix sparse warning

Much better, thanks, now pulled and pushed out.

greg k-h
