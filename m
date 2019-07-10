Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6AC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562774339;
	bh=GcCJY0Zi8vs1h6v9n47aiDjcuE+m4BmvnX+bbijkSAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SeKAAYUVS7jBeboZijPxdqgKKpkuC9HqJRtqZI/rUa7eq2IJrsa1xhwWC1xh+28nl
	 2fjqp6+8bsUB/8s1qfKMavOQcZQlF1hXz86+jSYSqosryhRr/AGcWOmGm3o4gI3Mj4
	 5bOxqRGHDxYwXpsyF5OIHBSsCgjb/+RjDZi1w4oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGJP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:58:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGJP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ye5D+69oXsL3ZSs+9dVCnYnrCkxo5vD05Afm448wymE=; b=oL1AsU5FoQd4Mf9VU+4awTZLX
        3JAYkeJFzj6XEY4LsS0y9W6HJtW0QvVizzzKM3k9SQwP74YdTjPJeF8d9bdV5U+1w1Y7SE+X+cocj
        xHwjx7Sl5UG5RQIhLiUKKAYqLypx+laOf1e3H70xkKpMZ6Lw3X3n8cZs0gjF0DEwV93RBjFpFnBPU
        OQPUBFUVwQ5QOC3uYpPxSm+s8L2s+saPyAjmSWuV6KTe4sX0xFB7Z5o5Vzp97EZZmQthuhG0Imjt/
        s+pdrvG86YTJBIZzwMIcYT9yIQ9goOpBwNhP2stSAgQuIb2dYRr46+vF4rNbgGZBxoTZbYNDC/EXG
        4UFy68UZg==;
Received: from 177.41.133.216.dynamic.adsl.gvt.net.br ([177.41.133.216] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlEzc-0000em-QW; Wed, 10 Jul 2019 15:58:53 +0000
Date:   Wed, 10 Jul 2019 12:58:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: filesystems: Convert ufs.txt to
 reStructuredText format
Message-ID: <20190710125849.38f30c43@coco.lan>
In-Reply-To: <1562772683-32422-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190710092605.73ddee8b@coco.lan>
        <1562772683-32422-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Jul 2019 08:31:23 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> escreveu:

> This converts the plain text documentation of ufs.txt to
> reStructuredText format. Added to documentation build process
> and verified with make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
> Changes in v3:
>         1. Reverted to minimally changed ufs.rst
> 	2. Fix Minor Space Issues
>         3. Used -M1 in git format-patch to show files as renamed
> Changes in v2:
>         1. Removed flat-table
>         2. Moved ufs.rst to admin-guide
> 
>  Documentation/admin-guide/index.rst                |  1 +
>  .../{filesystems/ufs.txt => admin-guide/ufs.rst}   | 36 +++++++++++++---------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>  rename Documentation/{filesystems/ufs.txt => admin-guide/ufs.rst} (69%)
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 2871b79..9bfb076 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -71,6 +71,7 @@ configure specific aspects of kernel behavior to your liking.
>     bcache
>     ext4
>     jfs
> +   ufs
>     pm/index
>     thunderbolt
>     LSM/index
> diff --git a/Documentation/filesystems/ufs.txt b/Documentation/admin-guide/ufs.rst
> similarity index 69%
> rename from Documentation/filesystems/ufs.txt
> rename to Documentation/admin-guide/ufs.rst
> index 7a602ad..55d1529 100644
> --- a/Documentation/filesystems/ufs.txt
> +++ b/Documentation/admin-guide/ufs.rst
> @@ -1,37 +1,45 @@
> -USING UFS
> +=========
> +Using UFS
>  =========
>  
>  mount -t ufs -o ufstype=type_of_ufs device dir
>  
>  
> -UFS OPTIONS
> +UFS Options
>  ===========
>  
>  ufstype=type_of_ufs
>  	UFS is a file system widely used in different operating systems.
>  	The problem are differences among implementations. Features of
>  	some implementations are undocumented, so its hard to recognize
> -	type of ufs automatically. That's why user must specify type of 
> +	type of ufs automatically. That's why user must specify type of
>  	ufs manually by mount option ufstype. Possible values are:
>  
> -	old	old format of ufs
> +	old
> +                old format of ufs
>  		default value, supported as read-only
>  
> -	44bsd	used in FreeBSD, NetBSD, OpenBSD
> +	44bsd
> +                used in FreeBSD, NetBSD, OpenBSD
>  		supported as read-write
>  
> -	ufs2    used in FreeBSD 5.x
> +	ufs2
> +                used in FreeBSD 5.x
>  		supported as read-write
>  
> -	5xbsd	synonym for ufs2
> +	5xbsd
> +                synonym for ufs2
>  
> -	sun	used in SunOS (Solaris)
> +	sun
> +                used in SunOS (Solaris)
>  		supported as read-write
>  
> -	sunx86	used in SunOS for Intel (Solarisx86)
> +	sunx86
> +                used in SunOS for Intel (Solarisx86)
>  		supported as read-write
>  
> -	hp	used in HP-UX
> +	hp
> +                used in HP-UX
>  		supported as read-only
>  
>  	nextstep
> @@ -47,14 +55,14 @@ ufstype=type_of_ufs
>  		supported as read-only
>  
>  
> -POSSIBLE PROBLEMS
> -=================
> +Possible Problems
> +-----------------
>  
>  See next section, if you have any.
>  
>  
> -BUG REPORTS
> -===========
> +Bug Reports
> +-----------
>  
>  Any ufs bug report you can send to daniel.pirkl@email.cz or
>  to dushistov@mail.ru (do not send partition tables bug reports).



Thanks,
Mauro
