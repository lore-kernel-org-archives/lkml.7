Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5258520873
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555404995;
	bh=lNmBJmIgW9yvsRYMGF8ywvfQiq3C+bioom8LQy8Dz80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtDvRFSZD+Iuqk6cWvr/a6luUK26yq8L+u88bF7f3AZf9OItUPLti0aKwhwO1AIjZ
	 rVgNOSjbq4FR126igfehIfOUsZA8+KXOQey0UjkFiO7gmR3rpw5rpHKedsGq63mBf0
	 xMegadYWH5lmUfZ+crIA1cISSd2yKKbekNJCiXrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfDPI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfDPI4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:56:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E1A20868;
        Tue, 16 Apr 2019 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555404992;
        bh=lNmBJmIgW9yvsRYMGF8ywvfQiq3C+bioom8LQy8Dz80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgVVwvZPXllpakyjZbmg9JSJCFFxPQVpzlNLzTPa6KqXh431W/rPQL8CQ3n0Ua8GQ
         nzxHOgtqF5TXzm0fqrplZfLKctqj22WjJShnVU/SrE07FSpk8CvC+H4bKTk71lrd4r
         r59nvsZ4iG2YgOgKrvHjQHS6872c976EzFX0GN30=
Date:   Tue, 16 Apr 2019 10:56:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     stable@vegr.kernel.org, Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.14] atm:idt77252: Fix a kernel address leakage in
 idt77252
Message-ID: <20190416085630.GA4209@kroah.com>
References: <20190416065727.13303-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416065727.13303-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:57:27PM +0800, Fuqian Huang wrote:
> Outputting kernel addresses will reveal the locations of kernel code
> and data. And there is no need to print the address of 
> function idt77252_init in idt77252_init. 
> This case is similar to CVE-2018-7273[1].
> Just remove the print statement.
> 
> [1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7273
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/atm/idt77252.c | 2 --
>  1 file changed, 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
