Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5873AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDA420700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573911606;
	bh=9L9vkPU+Bqc1VFCQSBprUu/ar30oFxbG2b3To5bR7ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TmJGWsPjy1zLjHtk619IN6q9vNK9HWnv8NElOUKrctwE8giepeoZCTNTCwOcfFXiH
	 iKBCd4mZcuj5VVer9rLdUDSCBKACBV5/ec3M5QAHkd3g/yh8YjAmref1642uMJpLNm
	 wMIbdQ6KyybZ+/E2XJBgMw9p56QB1210cOmNn2Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKPNjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 08:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKPNjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:39:32 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D66206D4;
        Sat, 16 Nov 2019 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573911571;
        bh=9L9vkPU+Bqc1VFCQSBprUu/ar30oFxbG2b3To5bR7ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3wiuOdxMeGs98kv4cd5rsY2FBjgMbuKA6SgSMbwsQMkVqaI39NjpbBX5lEsd6x1c
         T8WhewMwxyJp9WI4/skS6cMju9lBi//j8VNLRbHyeVncD9zE0bsZEVI8jG/r/yexyL
         8p1w9q93fcrXUs0Cyix6AunRtxPLXTpcsmpjTLuc=
Date:   Sat, 16 Nov 2019 14:39:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Arthur Heymans <arthur@aheymans.xyz>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: Re: [PATCH 2/3] firmware: google: Unregister driver_info on failure
 and exit in gsmi
Message-ID: <20191116133928.GD454551@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
 <20191115134842.17013-3-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115134842.17013-3-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:48:38PM +0100, patrick.rudolph@9elements.com wrote:
> From: Arthur Heymans <arthur@aheymans.xyz>
> 
> Fix a bug where the kernel module couldn't be loaded after unloading,
> as the platform driver wasn't released on exit.
> 
> Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> ---

When sending a patch from someone else, you too have to add your s-o-b
so that we can accept it as that shows the progression of the patch (and
you are accepting responsibility for it being correct.)

Please fix up when you resend.

thanks,

greg k-h
