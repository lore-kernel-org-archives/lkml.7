Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60652C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE982084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554298295;
	bh=APsVE2HNM1yvN30VdtPTZSwbP5F1EvMqlD6Jj3TMZvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1f4Ih07SbMcVD51PHvRRvF+8xUc/P+RRkHaZMndEW3cuuczxl/mEMactLAnoOm9m
	 hNd1QnJSeos4WW2H65ofUigujmV7GXk1l3JifXkXkRW+R/SFQA5tCT5aOFF+GT2D/D
	 IFJXqRAF59/85cpWUKZz/P7/IuzazhpVunCFCr8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCNbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:31:33 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BFA2075E;
        Wed,  3 Apr 2019 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554298293;
        bh=APsVE2HNM1yvN30VdtPTZSwbP5F1EvMqlD6Jj3TMZvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Is7u/VGEar2BwA1zV8Ct359ueRijOFpXhP3O9hkazTLkkuvkVSRLuTYS7Hg5oY90U
         tTUvZKgOJ+dw4+MhvGccfyZ7Xlj5omEDLjIwaPc7oJudBnTgTP5oHCs1MGkEULujtl
         9FkE6JuhCLKEliSrwxFfLReYHGSS80twmvdXL6LY=
Date:   Wed, 3 Apr 2019 15:00:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] staging:iio:accel:adis16203: add SPDX license
 identifier tag
Message-ID: <20190403130010.GA3660@kroah.com>
References: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:41:28AM +0200, Nicholas Mc Guire wrote:
> Pop in the SPDX tag as the license is clearly indicated
> as GPL V2 or later this should also be indicated with a SPDX license
> identifier tag.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

I sent patches yesterday to fix up all of drivers/staging/ for all spdx
issues so as to keep people from accidentally getting this wrong.  That
patch is now in my tree and will show up in linux-next tomorrow.

Sorry,

greg k-h
