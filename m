Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD206C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C152206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220561;
	bh=6Uw6D3Ez1Kw8ObQskdTe0VNQsp/YUYFcuv8Feqob4u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HyK7TTzCFSAE0+XKTbfA4HndMtZLqsDCwMqKbYHt6QQXiI4PNdy9yXbg2JC/jj0Ue
	 5g4ktzKS8lfdBwE/e5FSgpSiMgD8mHreDGUbA84Zgbx6zo8eUEQK7/9luVW7Sk452D
	 FUnXcjcs9+7UNZ2FvSAezm680q5xovXkjleP5hS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfDBP4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfDBPz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:55:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7F620645;
        Tue,  2 Apr 2019 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220558;
        bh=6Uw6D3Ez1Kw8ObQskdTe0VNQsp/YUYFcuv8Feqob4u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8iKZafTRgTeLi0zlvhsO+CeEqAJXVGR2/h6S9B6YrJ/R41ygkALj3/RromgM7bF3
         5X/yKxhhDTCjBUDs0s+4CeX2d0WlzxbIUTwivHioYZYYfeupnHDag0L52nHVK5tCuQ
         NMt4wkXjni8ClRDUh7HT2skbdjejMeV6vrygLpWc=
Date:   Tue, 2 Apr 2019 17:55:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.1-rc4
Message-ID: <20190402155555.GA11881@kroah.com>
References: <20190401172618.GA6090@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401172618.GA6090@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:26:18PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> One small but important fix for the next -rc:
> 
> - Fix the low credit limit for DMA channel #0. Without this fix, the
>   channel is unusable by the user.

Pulled and pushed out, thanks.

greg k-h
