Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0194C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFB220848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551459885;
	bh=5dxi8N7iahs6eiZjt8R/TTZ2aVoUlJBvbpSxDWlgMz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oyc4eT/450v634YAx3zqA9MyvwLCeDHnJqWp3iapbBJD95540T5pws1hjWTm1W0we
	 MZvz+vq8x3DQcRVPolUCB3QwUzg7MhX2Ts1Tz8CEbAxg7Ras7ZoR4ZOGZYTDrKC37q
	 KvKKllh5OqA1UJTiKCRoLD/34YSutT4B9D/Ki/Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbfCAREo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfCAREn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:04:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDDE20848;
        Fri,  1 Mar 2019 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551459883;
        bh=5dxi8N7iahs6eiZjt8R/TTZ2aVoUlJBvbpSxDWlgMz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjI1yrUolJ/+uh4Mh7NrLS5T7YULmIB/99PwaWBXZ9ULAtOM0IeZU6GVnmCtgYI6w
         wcCS8jq119DfFDtkoxITFz8w4tlRsHuDm3XfZWesUHbnw4Gw2wuuqMsaVOc/0nfmAD
         96CrHw3B89NOHGLZN/tdNpScjiWk4y1D43wDDUHo=
Date:   Fri, 1 Mar 2019 18:04:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: make default autosuspend delay configurable
Message-ID: <20190301170440.GA19038@kroah.com>
References: <20190301162341.GC19937@kroah.com>
 <20190301164320.13948-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301164320.13948-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:43:20PM +0000, Mans Rullgard wrote:
> Make the default autosuspend delay configurable at build time.
> This is useful for systems that require a non-standard value as
> it avoids relying on the command line being properly set.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes in v2:
> - add explanatory text to Kconfig help

Much nicer, thanks!

greg k-h
