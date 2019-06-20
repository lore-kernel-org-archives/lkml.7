Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC1AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7087A206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561020388;
	bh=C3FIaHH6GeL///CqL9l/V87nt0hRJPiygrAM7yPhaVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oz4hg/mY7CXi0lM+ogTJ6e4usg0ujJk36zJ9MlnQeQ8cRu/MUMPMtbtWG5PytrIsX
	 PQN4Tzvw33sSkwCFDqY13m37s8RSCf1Qw38Zi2BZonccJROpBrUU52jpgSfWDclW1/
	 16QZnKt3VsMtmkgE8nNU6AhDuxYZ4HA9bUKIJ69o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfFTIq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTIq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:46:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE6A206E0;
        Thu, 20 Jun 2019 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561020385;
        bh=C3FIaHH6GeL///CqL9l/V87nt0hRJPiygrAM7yPhaVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yO+0WyYu0Be5qeb9e4yGWQRLg24mxi4t19gw6ztPaF4/kEKZ8cTjwxUNsILRguieP
         jcHom8TAGITzgQXUxt+L0RrwWqwbiamTzCvlEcUWwqCHDnr7zexlsq3EXBbXZDu8xH
         I7OAJYkhNg5lkh9sq3URhswMVzsvvBX0Hbu8AihQ=
Date:   Thu, 20 Jun 2019 10:46:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] slimbus: fix kerneldoc comments
Message-ID: <20190620084623.GA20943@kroah.com>
References: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
 <20190620081129.4721-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620081129.4721-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:11:27AM +0100, Srinivas Kandagatla wrote:
> From: Jonathan Corbet <corbet@lwn.net>
> 
> The kerneldoc comments in drivers/slimbus/stream.c were not properly
> formatted, leading to a distinctly unsatisfying "no structured comments
> found" warning in the docs build.  Sprinkle some asterisks around so that
> the comments will be properly recognized.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/stream.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Turns out this was already in my tree :)

Also, when sending out patches, be sure to cc: the authors, no need to
suppress that in git send-email.

thanks,

greg k-h
