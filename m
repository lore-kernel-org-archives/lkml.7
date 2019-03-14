Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497AAC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1330A2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552600373;
	bh=+QR694uhaZQglKgo60qI7fRbgH1gaNS8m24iXNszGpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FoRXFUTwkzOePo2YsDOOPYlPeN4uTpm4jK5Gc1VTiNSNhbeouS5VY7RZTv9PGCnRY
	 FyTFi8IXK93O8KFPDkyCdkwhaBbPUTXY91Pc7ofI4MeQArMhH/d/i/LqY9nzQUQrrA
	 IxOjcWk6UX2v/54B8RriUc2uos2UJ9Xmrqst5VJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCNVwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfCNVwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:52:51 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996ED2087C;
        Thu, 14 Mar 2019 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552600370;
        bh=+QR694uhaZQglKgo60qI7fRbgH1gaNS8m24iXNszGpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMh8Rdj8MjTu5NpjrJLELM0LOpNrjEmGZrpnbrqY2kZdAtzDXBb5ntjf0Y7eVBJTt
         fkkumcvuERNVdYUqQ/TMMeoIeUNZv4EACeStMsSrncyBGml81ZEzG0G4xAct1q6UTm
         h87FaD9/MPPsGRn2TUwSaxJA2dOaHWcylWEVXqbI=
Date:   Thu, 14 Mar 2019 14:52:50 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alan J. Wylie" <alan@wylie.me.uk>
Cc:     Alec Ari <neotheuser@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Re: Linux 5.0.2
Message-ID: <20190314215250.GB17893@kroah.com>
References: <20190314162756.GA20704@kroah.com>
 <87pnqtkz23.fsf@wylie.me.uk>
 <20190314200709.GA16125@kroah.com>
 <87ftrpkx0d.fsf@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftrpkx0d.fsf@wylie.me.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 08:43:14PM +0000, Alan J. Wylie wrote:
> 
> (Adding Linus, since his tree is also broken)

Again, can you try running 'git bisect' to find the offending commit?

thanks,

greg k-h
