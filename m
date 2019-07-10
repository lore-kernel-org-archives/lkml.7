Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D71EC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562774265;
	bh=EEnnb2NoOcHXGz6PhQtRPu0FUfnN5+hXFF/XcIe6B64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G5IeK/xrcsqpbAQCXd25yLzNJf9KANY4dHduZflAjFgZFDFLE1lHp5iOwrT6YfwzZ
	 TGLgNcyt4ctGs+zXUy+enczj+LNKU3y0dtmgGYgslhnA0KbnA059BnpSEBTOnQ0viO
	 w21nhMnKO8JxOLnmdM3Kpr8kAl9BPHtXEXMddEVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfGJP5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:57:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hSaOXHptf/6kKej0VV02Bg9HRz9WMNoWaX2qBfjn7nA=; b=UNutNSOpJ90u9aN3M+sCGcLhb
        KT0uwy0W/gaRMA9h2xyZmJXFcaayg+Q3dOnMK1gPqgVlWwrhj1F9Q+fKFn8GB7Ort7qAQH6OOFxr9
        1TvM0yo0mG8nPymiJEMZNZgeTEwdAiE7vQOolmaOjYcx0uDeFExy4A1gtqMlOhvZmkgmpLdYAckLH
        bAi/q9KldP5Mq1kmVtGQF4gkTcD6EsabD7fWMNdZBNt61AUxAc1sfNrwqMHVJiL7DDX/9oCxdMUBs
        b1mehmLpHVtB+Lx8BtqyUBIfSjIbG7ZDGgIbUBJ51BDz9CuZSbORuXOXC9xTevgsezXQE601+yh25
        i7FGn5YMg==;
Received: from 177.41.133.216.dynamic.adsl.gvt.net.br ([177.41.133.216] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlEyM-0000Ff-OK; Wed, 10 Jul 2019 15:57:35 +0000
Date:   Wed, 10 Jul 2019 12:57:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH v3] Documentation: filesystems: Convert jfs.txt to
Message-ID: <20190710125730.0d0cb685@coco.lan>
In-Reply-To: <1562772541-32144-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190710093323.7e5d6790@coco.lan>
        <1562772541-32144-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Jul 2019 08:29:01 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> escreveu:

> This converts the plain text documentation of jfs.txt to reStructuredText
> format. Added to documentation build process and verified with 
> make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
> Changes in v3:
>         1. Reverted to minimally changed jfs.rst
>         2. Used -M1 in git format-patch to show files as renamed
> 
> Changes in v2:
>         1. Removed flat-table.
>         2. Moved jfs.rst from filesystem to admin-guide
> 
>  Documentation/admin-guide/index.rst                |  1 +
>  .../{filesystems/jfs.txt => admin-guide/jfs.rst}   | 44 ++++++++++++++--------
>  2 files changed, 30 insertions(+), 15 deletions(-)
>  rename Documentation/{filesystems/jfs.txt => admin-guide/jfs.rst} (51%)
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 8001917..2871b79 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -70,6 +70,7 @@ configure specific aspects of kernel behavior to your liking.
>     ras
>     bcache
>     ext4
> +   jfs
>     pm/index
>     thunderbolt
>     LSM/index
> diff --git a/Documentation/filesystems/jfs.txt b/Documentation/admin-guide/jfs.rst
> similarity index 51%
> rename from Documentation/filesystems/jfs.txt
> rename to Documentation/admin-guide/jfs.rst
> index 41fd757..9e12d93 100644
> --- a/Documentation/filesystems/jfs.txt
> +++ b/Documentation/admin-guide/jfs.rst
> @@ -1,45 +1,59 @@
> +===========================================
>  IBM's Journaled File System (JFS) for Linux
> +===========================================
>  
>  JFS Homepage:  http://jfs.sourceforge.net/
>  
>  The following mount options are supported:
> +
>  (*) == default
>  
> -iocharset=name	Character set to use for converting from Unicode to
> +iocharset=name
> +                Character set to use for converting from Unicode to
>  		ASCII.  The default is to do no conversion.  Use
>  		iocharset=utf8 for UTF-8 translations.  This requires
>  		CONFIG_NLS_UTF8 to be set in the kernel .config file.
>  		iocharset=none specifies the default behavior explicitly.
>  
> -resize=value	Resize the volume to <value> blocks.  JFS only supports
> +resize=value
> +                Resize the volume to <value> blocks.  JFS only supports
>  		growing a volume, not shrinking it.  This option is only
>  		valid during a remount, when the volume is mounted
>  		read-write.  The resize keyword with no value will grow
>  		the volume to the full size of the partition.
>  
> -nointegrity	Do not write to the journal.  The primary use of this option
> +nointegrity
> +                Do not write to the journal.  The primary use of this option
>  		is to allow for higher performance when restoring a volume
>  		from backup media.  The integrity of the volume is not
>  		guaranteed if the system abnormally abends.
>  
> -integrity(*)	Commit metadata changes to the journal.  Use this option to
> +integrity(*)
> +                Commit metadata changes to the journal.  Use this option to
>  		remount a volume where the nointegrity option was
>  		previously specified in order to restore normal behavior.
>  
> -errors=continue		Keep going on a filesystem error.
> -errors=remount-ro(*)	Remount the filesystem read-only on an error.
> -errors=panic		Panic and halt the machine if an error occurs.
> +errors=continue
> +                        Keep going on a filesystem error.
> +errors=remount-ro(*)
> +                        Remount the filesystem read-only on an error.
> +errors=panic
> +                        Panic and halt the machine if an error occurs.
>  
> -uid=value	Override on-disk uid with specified value
> -gid=value	Override on-disk gid with specified value
> -umask=value	Override on-disk umask with specified octal value.  For
> -		directories, the execute bit will be set if the corresponding
> +uid=value
> +                Override on-disk uid with specified value
> +gid=value
> +                Override on-disk gid with specified value
> +umask=value
> +                Override on-disk umask with specified octal value. For
> +                directories, the execute bit will be set if the corresponding
>  		read bit is set.
>  
> -discard=minlen	This enables/disables the use of discard/TRIM commands.
> -discard		The discard/TRIM commands are sent to the underlying
> -nodiscard(*)	block device when blocks are freed. This is useful for SSD
> -		devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
> +discard=minlen, discard/nodiscard(*)
> +                This enables/disables the use of discard/TRIM commands.
> +		The discard/TRIM commands are sent to the underlying
> +                block device when blocks are freed. This is useful for SSD
> +                devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
>  		command is also available together with the nodiscard option.
>  		The value of minlen specifies the minimum blockcount, when
>  		a TRIM command to the block device is considered useful.



Thanks,
Mauro
