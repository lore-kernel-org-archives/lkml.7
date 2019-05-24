Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8621848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558722651;
	bh=90gbbJoSH5e/DbujPH4jsD6Dp2o4oN2DKsos/CYbGqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elXnycjOHcSx0YrD8W+SSbPVq/X8PNh1Wr2uoBfvanZT/Q10hfWORf3YR3blzwWkM
	 DAF7xbSr+WXev7XBh9VKi++ReRyNLRLoB60C04dHQ4905qdP8JyivBoi7ZiTgPno01
	 fxqGNEJAPr9O9gwcDunTWw8Ver6aEH5AdgI8EaG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfEXSau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfEXSau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:30:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6721E2175B;
        Fri, 24 May 2019 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722649;
        bh=90gbbJoSH5e/DbujPH4jsD6Dp2o4oN2DKsos/CYbGqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYhBz0j63dwk0VEiRZPvJJY424FLGoUH2PO3tNa/iHXjw1FDr4j4HIRh9UPr1L08I
         VfJGOjrZ8Iq/KUcxedzGX4ChL/c2tj2NMInzsL/GrmTfJCt/ldBRnjPRNe1mEyWW4H
         BKwk9sm2NpJZkj1P1Hjn3+LhpFKmT3lM5fRJzmvc=
Date:   Fri, 24 May 2019 20:30:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] lkdtm fixes for next
Message-ID: <20190524183045.GA16661@kroah.com>
References: <201905091017.DA22A3E0C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905091017.DA22A3E0C@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:19:39AM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these lkdtm fixes for next. If possible, it'd be nice to get
> these into v5.2 (they're small fixes), but I'm fine if they have to wait.
> I meant to send these earlier, but got distracted by other things.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:
> 
>   Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

Now pulled, thanks.

greg k-h
