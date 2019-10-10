Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD25C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55A2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697961;
	bh=CBsMU142wfX9FybWwG+uuFeTqNtLpXx3v2EZPchDETs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q6YhU9GaYLEKD5hV7Yz4VLC3dYR8bvlCXJxVYVXfJML2XQuMuo8hnpQelz8VqJnjs
	 68LeGgSZ9LrmAzdaBCOQMkgRs9Rn2hkLJocnC/ZrUCWZFjQwnenLFF0sCHdzfBkKsY
	 2cEcjdAMWGamBwSVvQHG6+PnndgAYdisDBZQUkDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfJJI7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388520AbfJJI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:59:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F0D2190F;
        Thu, 10 Oct 2019 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697958;
        bh=CBsMU142wfX9FybWwG+uuFeTqNtLpXx3v2EZPchDETs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRZVyrNBrGhWLYx+dXPGzcSkHO5EWb2PWUxkCozfLTkecgnW2NQSIOMqAEsV6hrsK
         qsqityIn/xOoTRUyi8dLC9nLvBOLTp+fNbtv1SR/SM2HeidX+etktZ386rhw3Kw2yQ
         04ss6LkG6iXRyVRUJswRulPJUXjMx9xZyBl1frXA=
Date:   Thu, 10 Oct 2019 10:59:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: rtl8723bs: Remove comparisons to NULL in
 conditionals
Message-ID: <20191010085916.GA452879@kroah.com>
References: <cover.1570682635.git.wambui.karugax@gmail.com>
 <da71920fa80298badcced3519f2b84afbdd28a7e.1570682635.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da71920fa80298badcced3519f2b84afbdd28a7e.1570682635.git.wambui.karugax@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:49:05AM +0300, Wambui Karuga wrote:
> Remove most comparisons to NULL in conditionals in
> drivers/staging/rtl8723bs/core/rtw_mlme.c
> Issues reported by checkpatch.pl as:
> CHECK: Comparison to NULL could be written
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 46 +++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Due to lots of other changes in this file recently, this patch does not
apply, and so the rest of this series does not apply either.

Can you please rebase this against my staging-testing branch and resend?

thanks,

greg k-h
