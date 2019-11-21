Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B76C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5092070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574349401;
	bh=1mwCmyP+2+wZJqa8YEmau3a8t7+7q47dmFQ/arnqZSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nmGnHIbeYoA4L6Iw+fNDJKbxHhqiLsLlUMCaK5/NaFd7dPffRy2fKa97NCPN1X7iS
	 Py2w7Lu0A2EFj8bHj/VbbcYy9UeZMFNrUo5heukMMsC0JXIpBumpsAnpJcqXmwfWev
	 mHirdmjr6vzMJ4d4l1mH+f2wLkZOeYVpFQyFbbko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKUPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:16:39 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D4A2070A;
        Thu, 21 Nov 2019 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574349399;
        bh=1mwCmyP+2+wZJqa8YEmau3a8t7+7q47dmFQ/arnqZSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/0Rkz1aWHKHvPGaeJOOASGfR7YaOeMGAV7yabyzdztGPSi4qL+Sm/42+g4zht1Ge
         Uef7/eR2LC2iqj9KPKiwXNq48rndqysu42DWg6z+pWw5riJHVw0S3369rw3IJ5lKRM
         7TtNsyJ32jSNUFkTwmfFKA3Jb/b5yxYcHekg/DWg=
Date:   Thu, 21 Nov 2019 16:16:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, pzb@amzn.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/process: Add Amazon contact for embargoed hardware
 issues
Message-ID: <20191121151634.GA651285@kroah.com>
References: <da6467d2649339b42339124fd19a8a2f91cc00dd.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6467d2649339b42339124fd19a8a2f91cc00dd.camel@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:53:11PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index a3c3349046c4..e768aa8c7c12 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -255,7 +255,7 @@ an involved disclosed party. The current ambassadors list:
>    Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
>    SUSE		Jiri Kosina <jkosina@suse.cz>
>  
> -  Amazon
> +  Amazon	Peter Bowen <pzb@amzn.com>

I too like to sign up random people to do things :)

Can we get a ack/sob from Peter as well?

thanks,

greg k-h
