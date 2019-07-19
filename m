Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C83C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B00621850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508033;
	bh=+N7bbfXmnlKMhN5RHiS3PpWZx4Anz1FOdyXFz3ihzuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWiQ37PBrwPB2v/DcWgFFtZsw29/HL4fk3MWvNql76TyE1mojFvw5c3GYVc0VlNNW
	 dK4p/mgD4fcQmQJ5fVzN5k6KBtNdeNyJQg2//+d0Mo4cwTRoT7MxeQXO6HzQoHEsgo
	 6QdaePEc3ggdijrE+TywwhP5T4p3ujv1f+oNZ3U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfGSDrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGSDrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:47:11 -0400
Received: from localhost (p91006-ipngnfx01marunouchi.tokyo.ocn.ne.jp [153.156.43.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70A82173B;
        Fri, 19 Jul 2019 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508031;
        bh=+N7bbfXmnlKMhN5RHiS3PpWZx4Anz1FOdyXFz3ihzuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BicAfbVzzWqn9/gwFJGmCMyfw2emad4Ep4Yh/45H9Y51/j1yNCRR6ycndgW/dkOY1
         ksFfSjkP4MWlviptn3Tmj6E6T9Xz26whLtlFTFXLBrWegKG7YCsq29+7aFPSFa73x8
         O9dt3LwMWXmGtJda+Eo+QyEKUmQTovQWgLkgynvc=
Date:   Fri, 19 Jul 2019 12:47:08 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 00/21] 5.2.2-stable review
Message-ID: <20190719034708.GD8184@kroah.com>
References: <20190718030030.456918453@linuxfoundation.org>
 <20190718205818.GF6020@JATN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718205818.GF6020@JATN>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:58:18PM -0600, Kelsey Skunberg wrote:
> On Thu, Jul 18, 2019 at 12:01:18PM +0900, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.2.2 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.2-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted with no regressions on my system.

Thanks for testing all of these and letting me know.

greg k-h
