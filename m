Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D266C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488342064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562762011;
	bh=uzCaeu3qJi1y+qctqOPXxxISm043JzDOeETQiMlzigY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cGlwpmljnvNbt0acHAEQOYxXQmlSlEdjYdjTa+FBZ2HOnmb+bMbQnjjhxGqh65vzR
	 KxnStax/noS4GtJEtrvSkwcp0dHNftlqosqG/o8W/nTX+DUp6WRSFBZC7pMFz0a1Gk
	 DIr28EJwqWvU6RKdJeiu8I/RxBkQw31rth3osUY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGJMda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfGJMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GKkOnAHYDmsJE3tUOrE8JALnqY0x8ZYyqWzgAXaSu+Q=; b=cJAAXxcAbGgqJIxPdKdWKNKVI
        suu8u6qA3YQBP6DTI2mH70OELSPRlB771aHZt9B/K9lfSy875eHxYgEI0iykPIc9aTTbLg2TW4w9f
        zRE7d3GP4a0HdJuW0YrerBj337Vc8heCGQoVfNCj+CMwOl/AdWJUbWOUMMM6NyMkz04n8gmzCAFQf
        KmdrNcismlICU2qob9i8Z1bY3KciGflpop/Fu6qhCpVoAfhib79ZFi1BE/LmpzFczGAh8sS5InONd
        xCoXysK84c8XMrb8rEVCeyVb2qxc4Xf0u/gnF3OLIWhl4pLuG2fm8634LbVPW4dGAYFqDVeCCTtKE
        znIo8dpsA==;
Received: from 177.43.30.58.dynamic.adsl.gvt.net.br ([177.43.30.58] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlBmp-0008Nv-KX; Wed, 10 Jul 2019 12:33:28 +0000
Date:   Wed, 10 Jul 2019 09:33:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     willy@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: filesystems: Convert jfs.txt to
Message-ID: <20190710093323.7e5d6790@coco.lan>
In-Reply-To: <1562729125-31475-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190708195717.GG32320@bombadil.infradead.org>
        <1562729125-31475-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  9 Jul 2019 20:25:25 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> escreveu:

> This converts the plain text documentation of jfs.txt to reStructuredText format.
> Added to documentation build process and verified with make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
> Changes in v2:
>         1. Removed flat-table.
>         2. Moved jfs.rst from filesystem to admin-guide
> 
>  Documentation/admin-guide/index.rst |  1 +
>  Documentation/admin-guide/jfs.rst   | 50 +++++++++++++++++++++++++++++++++++
>  Documentation/filesystems/jfs.txt   | 52 -------------------------------------
>  3 files changed, 51 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/admin-guide/jfs.rst
>  delete mode 100644 Documentation/filesystems/jfs.txt

As commented on ufs patch, please use -M1 to show it as a diff, and not as
two separate changes.

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
> diff --git a/Documentation/admin-guide/jfs.rst b/Documentation/admin-guide/jfs.rst
> new file mode 100644
> index 0000000..a0a95e5
> --- /dev/null
> +++ b/Documentation/admin-guide/jfs.rst
> @@ -0,0 +1,50 @@
> +===========================================
> +IBM's Journaled File System (JFS) for Linux
> +===========================================
> +
> +JFS Homepage:  `<http://jfs.sourceforge.net/>`_
> +

No need. Just keep it as:

	JFS Homepage:  http://jfs.sourceforge.net/

Sphinx will do the right thing when it finds a URL that starts with
http/https.

> +The following mount options are supported:
> +(*) == default

You need a blank line between those two above.

> +
> +**iocharset=name**      Character set to use for converting from Unicode to ASCII. The default is to do no conversion.
> +
> +**iocharset=utf8**      Use for UTF-8 translations. This requires CONFIG_NLS_UTF8 to be set in the kernel .config file.
> +
> +**iocharset=none**      specifies the default behavior explicitly.
> +
> +**resize=value**        Resize the volume to <value> blocks. JFS only supports growing a volume, not shrinking it.
> +This option is only valid during a remount, when the volume is mounted read-write. The resize keyword with no value 
> +will grow the volume to the full size of the partition.
> +
> +
> +**nointegrity**	        Do not write to the journal. The primary use of this option is to allow for higher performance 
> +when restoring a volume from backup media. The integrity of the volume is not guaranteed if the system abnormally abends.
> +
> +**integrity(*)**	Commit metadata changes to the journal. Use this option to remount a volume where the nointegrity 
> +option was previously specified in order to restore normal behavior.
> +
> +**errors=continue**	Keep going on a filesystem error.
> +
> +**errors=remount-ro(*)**	Remount the filesystem read-only on an error.
> +
> +**errors=panic**	Panic and halt the machine if an error occurs.
> +
> +**uid=value**	Override on-disk uid with specified value
> +
> +**gid=value**	Override on-disk gid with specified value
> +
> +**umask=value**	Override on-disk umask with specified octal value. For directories, the execute bit will be set if the 
> +corresponding  read bit is set.
> +
> +**discard=minlen, discard, nodiscard(*)**

Please preserve as much as possible the original format.

If you just place the mount option on one line and the description at the
next one, e. g.:

	iocharset=name
	              	Character set to use for converting from Unicode to
	                ASCII.  The default is to do no conversion.  Use
	                iocharset=utf8 for UTF-8 translations.  This requires
	                CONFIG_NLS_UTF8 to be set in the kernel .config file.
	                iocharset=none specifies the default behavior explicitly.

	resize=value
	            	Resize the volume to <value> blocks.  JFS only supports
	                growing a volume, not shrinking it.  This option is only
	                valid during a remount, when the volume is mounted
	                read-write.  The resize keyword with no value will grow
	                the volume to the full size of the partition.
...

It will produce a very nice output, and the changes will be minimum,
without any special markup.


> +
> +This enables/disables the use of discard/TRIM commands. The discard/TRIM 
> +commands are sent to the underlying block device when blocks are freed. This is useful for SSD devices and 
> +sparse/thinly-provisioned LUNs. The FITRIM ioctl command is also available together with the nodiscard option.
> +The value of minlen specifies the minimum blockcount, when a TRIM command to the block device is considered useful.
> +When no value is given to the discard option, it defaults to 64 blocks, which means 256KiB in JFS. The minlen value 
> +of discard overrides the minlen value given on an FITRIM ioctl().
> +
> +The JFS mailing list can be subscribed to by using the link labeled
> +"Mail list Subscribe" at our web page `<http://jfs.sourceforge.net/>`_

Same here: just keep the URL as-is:

	The JFS mailing list can be subscribed to by using the link labeled
	"Mail list Subscribe" at our web page http://jfs.sourceforge.net/


> diff --git a/Documentation/filesystems/jfs.txt b/Documentation/filesystems/jfs.txt
> deleted file mode 100644
> index 41fd757..0000000
> --- a/Documentation/filesystems/jfs.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -IBM's Journaled File System (JFS) for Linux
> -
> -JFS Homepage:  http://jfs.sourceforge.net/
> -
> -The following mount options are supported:
> -(*) == default
> -
> -iocharset=name	Character set to use for converting from Unicode to
> -		ASCII.  The default is to do no conversion.  Use
> -		iocharset=utf8 for UTF-8 translations.  This requires
> -		CONFIG_NLS_UTF8 to be set in the kernel .config file.
> -		iocharset=none specifies the default behavior explicitly.
> -
> -resize=value	Resize the volume to <value> blocks.  JFS only supports
> -		growing a volume, not shrinking it.  This option is only
> -		valid during a remount, when the volume is mounted
> -		read-write.  The resize keyword with no value will grow
> -		the volume to the full size of the partition.
> -
> -nointegrity	Do not write to the journal.  The primary use of this option
> -		is to allow for higher performance when restoring a volume
> -		from backup media.  The integrity of the volume is not
> -		guaranteed if the system abnormally abends.
> -
> -integrity(*)	Commit metadata changes to the journal.  Use this option to
> -		remount a volume where the nointegrity option was
> -		previously specified in order to restore normal behavior.
> -
> -errors=continue		Keep going on a filesystem error.
> -errors=remount-ro(*)	Remount the filesystem read-only on an error.
> -errors=panic		Panic and halt the machine if an error occurs.
> -
> -uid=value	Override on-disk uid with specified value
> -gid=value	Override on-disk gid with specified value
> -umask=value	Override on-disk umask with specified octal value.  For
> -		directories, the execute bit will be set if the corresponding
> -		read bit is set.
> -
> -discard=minlen	This enables/disables the use of discard/TRIM commands.
> -discard		The discard/TRIM commands are sent to the underlying
> -nodiscard(*)	block device when blocks are freed. This is useful for SSD
> -		devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
> -		command is also available together with the nodiscard option.
> -		The value of minlen specifies the minimum blockcount, when
> -		a TRIM command to the block device is considered useful.
> -		When no value is given to the discard option, it defaults to
> -		64 blocks, which means 256KiB in JFS.
> -		The minlen value of discard overrides the minlen value given
> -		on an FITRIM ioctl().
> -
> -The JFS mailing list can be subscribed to by using the link labeled
> -"Mail list Subscribe" at our web page http://jfs.sourceforge.net/



Thanks,
Mauro
