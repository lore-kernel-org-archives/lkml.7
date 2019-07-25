Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92D6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B3C2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564037972;
	bh=miIwFhrxJf4kZI85IfYksV/RrRk2DPZY6j8Ex6+Uzn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wR8fIiasSfyJNfdyPzV4jU8bYOrfxYtHuWy3bKjZGGZMamczVTjfOWX5EII/kfPgC
	 vBcQ0CIByZ3ODaTwF5ugnX2pazj7iVFolyi5VTJCNuqUZkltkzIv4VyRMzwfouehPj
	 ggBSbql7UJBd/9o522osU2lkWXmV5kM/sJ2Ma4i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfGYG7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfGYG72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:59:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF2D2081B;
        Thu, 25 Jul 2019 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564037968;
        bh=miIwFhrxJf4kZI85IfYksV/RrRk2DPZY6j8Ex6+Uzn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uW5Nu8Ujalj/79GTY/S3WuLs2rVZRW4mYAaQ6Axl2pPqkDMMI5a8lhq4m1l3FRHPO
         n14nrtLICUWIUC3pcLtsV5iGGXHYpxMLLj9iWqjU+m9MeNwhpJ70N682RYKbsLhvgb
         rRkRfDCFSOFgHi/RDgA4WjIYGTpsuIG6nBZMeDTA=
Date:   Thu, 25 Jul 2019 08:33:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willem van der Walt <wvdwalt@csir.co.za>
Cc:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190725063330.GA6723@kroah.com>
References: <20190315130035.6a8f16e9@narunkot>
 <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot>
 <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com>
 <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net>
 <alpine.DEB.2.21.1.1907250724490.6623@willempc.meraka.csir.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1907250724490.6623@willempc.meraka.csir.co.za>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 08:11:04AM +0200, Willem van der Walt wrote:
> Hi,
> I have added a few things inline in Greg's message, mainly regarding the
> bleeps and cursor_time.

This is a great start, can someone turn this into the correct format
that we need for Documentation/ABI/ ?

thanks,

greg k-h
