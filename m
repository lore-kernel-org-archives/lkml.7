Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ECC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D782175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558722998;
	bh=uTVitLoRyg/beX8MLrRuWZqh3EnOyA+AB26GBM6Osjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eSqxDmBk8kmLojHzlzSzxn/sM6vAmjWkoSPeKUzWujod39SW9tyv9omQFvluYroZG
	 StKiFkyg/NP6KUlMWmTOFKQAG9AJnCDjTBSQGSB4c+2qqB2FCSVgpkHkxiwigrY6iM
	 76pfxUT5GUhI5Frn5j8f7T3Cm/HrlaNEghgVsKAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfEXSgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbfEXSgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:36:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6582175B;
        Fri, 24 May 2019 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722996;
        bh=uTVitLoRyg/beX8MLrRuWZqh3EnOyA+AB26GBM6Osjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aG9ucNoDot3rKjF3edEvwT/0cAWJrgIZvebS8mn5PBW7OsBI7qONfz9SLcbGZ1PlQ
         sAEcmMGY5VrgyR2soLHzCNihVgqfeMg5PG9epAJ0hgpS6CxFvXK07U8iwlk4isn0HZ
         8VLPixsSUYEbq790bCAxDMYSfoeu8oEATHYk/Ah0=
Date:   Fri, 24 May 2019 20:36:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.2-rc1/2
Message-ID: <20190524183633.GA7304@kroah.com>
References: <20190512194136.GA12189@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512194136.GA12189@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:41:36PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is the pull request containing fixes for 5.2-rc1/2.
> 
> It contains 2 fixes (1 of them for stable) and 1 change to a new IOCTL
> that was introduced to kernel 5.2 in the previous pull requests.
> 
> See the tag comment for more details.
> 
> Thanks,
> Oded
> 
> The following changes since commit 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13:
> 
>   Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-05-09 19:35:41 -0700)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-05-12

Is this pull request still needed, or was it also part of the other one?

How about fixing all of this by just sending patches?  :)

thanks,

greg k-h
