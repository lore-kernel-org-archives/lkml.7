Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D81B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415232;
	bh=s/w2cDybZN153RBjEFdpWUOxiWKPqMPnDMZlcIKXmyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lEPbtz11xPSUaqFGg6JfHlxsivzM+2tbhnwXXr2Kvxko5Tt7ZVFAIKarZ5AoKNKmB
	 4GVBRtT0aHKlZ8lD+1VBKRZ9u02GMU6v86Oqcx1RpMhQ4f+tQhe5Pun7gjAvvGH8Vr
	 eCWSJJX/u6p5qRtcnIaO+EFKZ05bp+qIs17+F2pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfDPLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfDPLrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4BE20868;
        Tue, 16 Apr 2019 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415230;
        bh=s/w2cDybZN153RBjEFdpWUOxiWKPqMPnDMZlcIKXmyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo+wMKzeHTKdJMTaO0a+JZ1lgHk+6xEbac0+JxthKofcdmHCuKl8PPBoUJ+qx35YQ
         kMZlWNpY8YnmHF7y0OT4MNM1IMceaA9hBXhSmbwGy/Qr2+wRy3vVTlhkDxUFjXRSfc
         9NZ9BO5CxaEJpeYDEwWmUb+wn/0MPtSX9RK+Qn6c=
Date:   Tue, 16 Apr 2019 12:46:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon fixes for v5.1-rc4
Message-ID: <20190416104656.GA2870@kroah.com>
References: <CGME20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096@epcas1p1.samsung.com>
 <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:21:25AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-fixes pull request for v5.1-rc4. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
> 
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.1-rc4
> 
> for you to fetch changes up to 86baf800de84eb89615c138d368b14bff5ee7d8a:
> 
>   extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       extcon: ptn5150: fix COMPILE_TEST dependencies
> 
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now pulled, sorry for the delay, was on vacation.

greg k-h
