Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41D520693
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mP7niZt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCPP3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:29:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t5cw39HPfSFf2LVneY7EdHvHZGIOu34sZqxkt+YvlAc=; b=mP7niZt6gtT7/h2wWm8B+KjFAO
        TBFzG/0tz+pcT8r9IMIZxm7ULRAURELMyKcC3BRkx+llfQ1AEMnInrlD0TKGH/9FMJfulEmEkktwj
        0UXcjv4R88mxy7guY4aqtUZOEtfoBH7A/WQGGqdczDT/7TnfkazGHkMhK5Cqw7BqZd3FGuvZehc7w
        MtIlL9nHvXndwb38uoCkvlhovhgmdaX6J0lEf0tfTYzLp7SpxOl0kqwM29zDDVdtiDFDjPUubZ97a
        ym9DIp8vwrSk05dZgioopXX/vB6iEbDuPY3S8kItDkik9tKZisiNKK+aZRyihZnUF4ovn4TLtx7Tl
        l0+985kQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5BF7-00048Z-Nj; Sat, 16 Mar 2019 15:29:01 +0000
Subject: Re: [PATCH] staging: erofs: Add function comment for erofs/inode.c
To:     Arshad Hussain <arshad.super@gmail.com>,
        linux-erofs@lists.ozlabs.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        yuchao0@huawei.com, linux-kernel@vger.kernel.org
References: <20190316061628.1734-1-arshad.super@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92f3bcfb-5f04-2d46-45de-0e1114d848f5@infradead.org>
Date:   Sat, 16 Mar 2019 08:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190316061628.1734-1-arshad.super@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 11:16 PM, Arshad Hussain wrote:
> This patch adds functions comment for file erofs/inode.c in
> sphinx format.
> 
> Signed-off-by: Arshad Hussain <arshad.super@gmail.com>
> ---
>  drivers/staging/erofs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 924b8dfc7a8f..c68f280ba849 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -14,7 +14,15 @@
>  
>  #include <trace/events/erofs.h>
>  
> -/* no locking */
> +/**
> + * read_inode(): Get physical Inode from disk.This is with
> + * 		 No locking.

Hi,

For all of these functions, the format should be:

 * func_name() - description

i.e., use a hyphen/dash, not a colon.

Thanks.

> + *
> + * @inode: VFS inode structure
> + * @data: Page address where inode will be read
> + *
> + * Return: 0 on Success, Error number on failure
> + */
>  static int read_inode(struct inode *inode, void *data)
>  {
>  	struct erofs_vnode *vi = EROFS_V(inode);
> @@ -102,7 +110,13 @@ static int read_inode(struct inode *inode, void *data)
>  	return 0;
>  }
>  
> -/*
> +/**
> + * fill_inline_data(): Fill last page if inline data is available
> + *
> + * @inode: VFS inode structure
> + * @data: TRUE if directory
> + * @m_pofs: Position to correct inode
> + *
>   * try_lock can be required since locking order is:
>   *   file data(fs_inode)
>   *        meta(bd_inode)
> @@ -111,6 +125,8 @@ static int read_inode(struct inode *inode, void *data)
>   * no data operations exist. However I tend to
>   * try_lock since it takes no much overhead and
>   * will success immediately.
> + *
> + * Return: 0 on Success, Error number on failure
>   */
>  static int fill_inline_data(struct inode *inode, void *data,
>  			    unsigned int m_pofs)
> @@ -151,6 +167,15 @@ static int fill_inline_data(struct inode *inode, void *data,
>  	return -EAGAIN;
>  }
>  
> +/**
> + * fill_inode(): Fill in the inode
> + *
> + * @inode: VFS inode structure
> + * @isdir: TRUE if directory
> + *
> + * return: 0 on success, else error code on error
> + */
> +
>  static int fill_inode(struct inode *inode, int isdir)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> @@ -224,9 +249,16 @@ static int fill_inode(struct inode *inode, int isdir)
>  	return err;
>  }
>  
> -/*
> +/**
> + * erofs_ilookup_test_actor(): Obtain inode from mounted FS
> + *
> + * @inode: VFS inode structure
> + * @opaque: Data pointer passed to test/set
> + *
>   * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
>   * we should do more for 32-bit platform to find the right inode.
> + *
> + * Return: NID on Success
>   */
>  #if BITS_PER_LONG == 32
>  static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
> @@ -236,6 +268,14 @@ static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
>  	return EROFS_V(inode)->nid == nid;
>  }
>  
> +/*
> + * erofs_iget_set_actor(): Obtain inode from mounted FS
> + *
> + * @inode: VFS inode structure
> + * @opaque: Data pointer passed to test/set
> + *
> + * Return: 0 on success
> + */
>  static int erofs_iget_set_actor(struct inode *inode, void *opaque)
>  {
>  	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
> @@ -245,6 +285,14 @@ static int erofs_iget_set_actor(struct inode *inode, void *opaque)
>  }
>  #endif
>  
> +/**
> + * erofs_iget_locked(): Get the VFS inode from mounted FS
> + *
> + * @sb: VFS superblock structure of mounted FS
> + * @nid: Node ID to get
> + *
> + * Return: Pointer to inode
> + */
>  static inline struct inode *erofs_iget_locked(struct super_block *sb,
>  					      erofs_nid_t nid)
>  {
> @@ -259,6 +307,19 @@ static inline struct inode *erofs_iget_locked(struct super_block *sb,
>  #endif
>  }
>  
> +/**
> + * erofs_iget(): Get the VFS inode from the inode cache.
> + *
> + * @sb: VFS superblock structure
> + * @nid: Node ID
> + * @isdir: TRUE if directory.
> + *
> + * Get inode from inode cache. If not in cache, get it from disk
> + * and fill the cache.
> + *
> + * return: Pointer to the inode on success, else error code on error
> + */
> +
>  struct inode *erofs_iget(struct super_block *sb,
>  	erofs_nid_t nid, bool isdir)
>  {
> 


-- 
~Randy
