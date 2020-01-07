Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A8C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958B62072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431510;
	bh=FhiT8EaHccPqvOpQJLyOpYXWGn+VUnFPf/RKRsJpRuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MY1OvwhUtOceBWug3NyIFKSxYkqInRWApcqkn9yeS17QGrw7/CPufgvfiGICW4K2l
	 sGS7wQVENm0C3+nqtZsTpAP3YqIxtZ35CYOx0rhr/UMm/fYmQ87ERPyhh7Mu5Ql2sd
	 uqg1xKk7HRG8m1GCrX3my/oRpcAVVN6V1VS7uDIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgAGVLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgAGVLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765872072A;
        Tue,  7 Jan 2020 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431502;
        bh=FhiT8EaHccPqvOpQJLyOpYXWGn+VUnFPf/RKRsJpRuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtbXSp1WuBMrfdg1Xuo17aOudNG6KWpxH3PnFFg/Gwgl0KIW/FSgm1gTSlqqpA4LJ
         LvQ7PjPvfFd48o3O4Qy+UI8WpgdT7FCK+eRTlSI7cCp5Jf36yDkiEFjKQ/CBkCf7+5
         eEeugD+LG/J4/KFGDCzdIe6PNK2zaZpMfSokJ294=
Date:   Tue, 7 Jan 2020 22:03:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     mateusznosek0@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/kernfs/dir.c: Clean code by removing always true
 condition
Message-ID: <20200107210325.GA2255571@kroah.com>
References: <20191230191628.21099-1-mateusznosek0@gmail.com>
 <20200107155110.GA2677547@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107155110.GA2677547@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 07:51:10AM -0800, Tejun Heo wrote:
> On Mon, Dec 30, 2019 at 08:16:28PM +0100, mateusznosek0@gmail.com wrote:
> > From: Mateusz Nosek <mateusznosek0@gmail.com>
> > 
> > Previously there was an additional check if variable pos is not null.
> > However, this check happens after entering while loop and only then,
> > which can happen only if pos is not null.
> > Therefore the additional check is redundant and can be removed.
> > 
> > Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Greg, can you please route this one?

Sure, will do, thanks.

greg k-h
