Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCF52184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552821115;
	bh=az5/S+AZ1OBw51Q6XA0wgKKVsCWsxxx+ZLLxmFXncag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3MHU6juggxp6jZs+BYE/apVFnSqmsW45t0DrpDKEisPezWJKQ9CkM++h4Lu/E1As
	 borP32UvmNAwq9WZM9K5gg8QpA1/tBMY6uJqWPVk8lv2sDItkujmb0h7eObShQ402P
	 NfdXGad3pPy1qpTQEyDcS7jGsUJURbxj/LUqx4F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCQLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfCQLLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:11:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B0C21019;
        Sun, 17 Mar 2019 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552821113;
        bh=az5/S+AZ1OBw51Q6XA0wgKKVsCWsxxx+ZLLxmFXncag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQYpVncXCwbBJdlxuSsAhmut7oGz9me0rGa8HfFFLMr8BsGoOB1EviPIklJOUBXJM
         RqdJwF+jfW3yopQEA3EOIeAqnMI61sN16EiVxyy2IybvtWOZbIodcR+fbmyLjE/Ij3
         VSE9yRr4P21AJ/RqbhA9vEXNeA9NQ3fdaM+caATM=
Date:   Sun, 17 Mar 2019 12:11:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: erofs: Add whitespace after declaration
Message-ID: <20190317111150.GB4614@kroah.com>
References: <20190316112958.GA29023@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316112958.GA29023@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 04:59:58PM +0530, Bharath Vedartham wrote:
> Fix the checkpatch.pl warning to add a whitespace after declaration
> statements.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v2
> 	- Mutt was giving me a few problems. I apologise for the
> 	  previous poor patches.
> ---
>  drivers/staging/erofs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 924b8df..9a36a1f 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -270,8 +270,8 @@ struct inode *erofs_iget(struct super_block *sb,
>  	if (inode->i_state & I_NEW) {
>  		int err;
>  		struct erofs_vnode *vi = EROFS_V(inode);
> -		vi->nid = nid;
>  
> +		vi->nid = nid;
>  		err = fill_inode(inode, isdir);
>  		if (likely(!err))
>  			unlock_new_inode(inode);
> @@ -305,4 +305,3 @@ const struct inode_operations erofs_fast_symlink_iops = {
>  #endif
>  	.get_acl = erofs_get_acl,
>  };
> -

You also removed the last line of the file, which you did not mention :(

