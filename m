Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FA9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDC620854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553014334;
	bh=3jyZCLLZarvHhKm7Z2ZaPzXtjygp39jLhwDWhzancBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bAaYyOeadZhrDNkk1StAfLGXnkoz9M1ly6O5Zyw3z3QPwGeNcQeKSqDZVRYv+/OdK
	 Qr6V2WyX9Va4ZwH8YU9MRl5nml48SBgcsZEffZmwgnyuFMgtJ5Vyr0iOOMMTZgrgBT
	 WxmSNBNw8fztwvgEy6ojqkMuBaFS77+vDvfcgeo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCSQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfCSQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:52:12 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE5E20835;
        Tue, 19 Mar 2019 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553014331;
        bh=3jyZCLLZarvHhKm7Z2ZaPzXtjygp39jLhwDWhzancBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZEt0iGMqbLbfoOeryClTvKAM/ihXCUkDGGblwPKOZnUWekiws96/N2ylamaWcshc
         oDn8kIsgrhRBXXBXXfvO9RpperVu4Mt4BuHRTar+BbKpeESibP0IHTmyWPks/JE9LE
         t9lTuD9wpaFqnkpzPxqwdz8bqvbGx9akOw+NChAQ=
Date:   Tue, 19 Mar 2019 17:52:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] drivers: power: supply: goldfish_battery: Fix bogus SPDX
 identifier
Message-ID: <20190319165208.GA21123@kroah.com>
References: <alpine.DEB.2.21.1903191529010.2537@nanos.tec.linutronix.de>
 <CAOGAQepj=yW4uQSRHpvnQz71+D8a7+H71XtrApp8YGU65XgoqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQepj=yW4uQSRHpvnQz71+D8a7+H71XtrApp8YGU65XgoqA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:14:32AM -0700, Roman Kiryanov wrote:
> Hi, I am sorry for this warning. I remember I checked all changes I
> sent, maybe missed this one.
> 
> At the bottom the file says
> 
> MODULE_LICENSE("GPL");
> 
> and
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> makes it inconsistent.

No, please read include/linux/module.h in 5.1-rc1, that nightmare is now fixed up.

Also, you were inconsistent from the beginning with the text at the top
of the file, so that was your issue to start with :)

Also, please do not top post.

thanks,

greg k-h
