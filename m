Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75655C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF922064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562761631;
	bh=Xm73U+ki2hKyWE8Ld+H5I9QGYsAnhrFCW4lA+Um5Oxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VSzuml631K8YVxVkDRfqLttBOXNdAG4U0lEgMFB84TaPab4QzBgQ+CUcPbWHwA2QN
	 SLpH8tD6mzLIg69BuThkeOFUvaI4zZWVmc4WNHD6uyXOYHwFC+CesazA335OLNZ84t
	 tburgjMHAmvVwYDHicHjGyOIULpsdGNV0jGZLpyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGJM0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:26:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kVhwy4jroDHBfIWxRCYth20jK+v7xvt7xAfvb71taGU=; b=JMNfPLh3IjOBu2a75+VyiZo94
        i+3nzwdPj2IIJhb6HSb+8P0J8ynuoPCQ6oNWsPAPB2ATkJXGj57PsQyqv3uqsj66JYWQPIbp3aZvm
        qNVam7hg/Vu8FOvuM16eKAha8zFuQB569ZNUwK7UG4tePTyBWmf4GovF/ruxRb1Sx9W5sSa36sG75
        sDuRUDKxclEV98H/DiKZIGoQPPr/uRkHlFTliNjqURzKxbUdk4JNBUIitbBieKxdMXOdtZ6aYvlmK
        0opgaLUCGzcOjQRtVa98HDog3ZQimvv0WnLxJdqE1LIKX3Ykva1gWj6oByipy6OK93RknVTm7EtSm
        gkqqenekQ==;
Received: from 177.43.30.58.dynamic.adsl.gvt.net.br ([177.43.30.58] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlBfm-000688-GT; Wed, 10 Jul 2019 12:26:10 +0000
Date:   Wed, 10 Jul 2019 09:26:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: filesystems: Convert ufs.txt to
 reStructuredText format
Message-ID: <20190710092605.73ddee8b@coco.lan>
In-Reply-To: <1562730162-2116-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190707013947.GA10663@t-1000>
        <1562730162-2116-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  9 Jul 2019 20:42:42 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> escreveu:

> This converts the plain text documentation of ufs.txt to reStructuredText format.
> Added to documentation build process and verified with make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
> Changes in v2:
> 	1. Removed flat-table
> 	2. Moved ufs.rst to admin-guide
> 	
>  Documentation/admin-guide/index.rst |  1 +
>  Documentation/admin-guide/ufs.rst   | 48 +++++++++++++++++++++++++++++
>  Documentation/filesystems/ufs.txt   | 60 -------------------------------------
>  3 files changed, 49 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/admin-guide/ufs.rst
>  delete mode 100644 Documentation/filesystems/ufs.txt

please use -M1 when producing the diff, in order to show it as as a change
and not as a delete/create.


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
> diff --git a/Documentation/admin-guide/ufs.rst b/Documentation/admin-guide/ufs.rst
> new file mode 100644
> index 0000000..20b9c56
> --- /dev/null
> +++ b/Documentation/admin-guide/ufs.rst
> @@ -0,0 +1,48 @@
> +=========
> +USING UFS
> +=========

In order to make it more coherent with the other documents, please
capitalize the titles, e. g.:

	=========
	Using UFS
	=========

> +
> +mount -t ufs -o ufstype=type_of_ufs device dir
> +
> +UFS OPTIONS
> +===========

Same here:

	UFS Options
	===========

and so on.

> +
> +ufstype=type_of_ufs
> +	UFS is a file system widely used in different operating systems.
> +	The problem are differences among implementations. Features of
> +	some implementations are undocumented, so its hard to recognize
> +	type of ufs automatically. That's why user must specify type of 
> +	ufs manually by mount option ufstype. Possible values are:
> +
> +	**old**	        old format of ufs default value, supported as read-only

Please avoid adding markups where not needed. In this specific case,
the best would be, instead, to use:

	old
		old format of ufs
		default value, supported as read-only

...
	openstep
		used in OpenStep
		supported as read-only


> +
> +	**44bsd**       used in FreeBSD, NetBSD, OpenBSD supported as read-write
> +
> +	**ufs2**        used in FreeBSD 5.x supported as read-write
> +
> +	**5xbsd**       synonym for ufs2
> +
> +	**sun**         used in SunOS (Solaris)	supported as read-write
> +
> +	**sunx86**      used in SunOS for Intel (Solarisx86) supported as read-write
> +
> +	**hp**  used in HP-UX supported as read-only
> +
> +	**nextstep**    used in NextStep supported as read-only
> +
> +	**nextstep-cd** 	used for NextStep CDROMs (block_size == 2048) supported as read-only
> +
> +	**openstep**    used in OpenStep supported as read-only
> +
> +
> +POSSIBLE PROBLEMS
> +-----------------
> +
> +See next section, if you have any.
> +
> +
> +BUG REPORTS
> +-----------
> +
> +Any ufs bug report you can send to daniel.pirkl@email.cz or
> +to dushistov@mail.ru (do not send partition tables bug reports).
> diff --git a/Documentation/filesystems/ufs.txt b/Documentation/filesystems/ufs.txt
> deleted file mode 100644
> index 7a602ad..0000000
> --- a/Documentation/filesystems/ufs.txt
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -USING UFS
> -=========
> -
> -mount -t ufs -o ufstype=type_of_ufs device dir
> -
> -
> -UFS OPTIONS
> -===========
> -
> -ufstype=type_of_ufs
> -	UFS is a file system widely used in different operating systems.
> -	The problem are differences among implementations. Features of
> -	some implementations are undocumented, so its hard to recognize
> -	type of ufs automatically. That's why user must specify type of 
> -	ufs manually by mount option ufstype. Possible values are:
> -
> -	old	old format of ufs
> -		default value, supported as read-only
> -
> -	44bsd	used in FreeBSD, NetBSD, OpenBSD
> -		supported as read-write
> -
> -	ufs2    used in FreeBSD 5.x
> -		supported as read-write
> -
> -	5xbsd	synonym for ufs2
> -
> -	sun	used in SunOS (Solaris)
> -		supported as read-write
> -
> -	sunx86	used in SunOS for Intel (Solarisx86)
> -		supported as read-write
> -
> -	hp	used in HP-UX
> -		supported as read-only
> -
> -	nextstep
> -		used in NextStep
> -		supported as read-only
> -
> -	nextstep-cd
> -		used for NextStep CDROMs (block_size == 2048)
> -		supported as read-only
> -
> -	openstep
> -		used in OpenStep
> -		supported as read-only
> -
> -
> -POSSIBLE PROBLEMS
> -=================
> -
> -See next section, if you have any.
> -
> -
> -BUG REPORTS
> -===========
> -
> -Any ufs bug report you can send to daniel.pirkl@email.cz or
> -to dushistov@mail.ru (do not send partition tables bug reports).



Thanks,
Mauro
