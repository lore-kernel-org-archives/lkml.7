Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA7DC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9FD2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKCPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:15:07 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:40636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726588AbfDKCPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:15:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A0189180A8130;
        Thu, 11 Apr 2019 02:15:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing90_839632b96fb5b
X-Filterd-Recvd-Size: 1754
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Apr 2019 02:15:04 +0000 (UTC)
Message-ID: <6a125c70e81fd0daa1532410774b57b2dfdf409d.camel@perches.com>
Subject: Re: [RFC PATCH hubcap] orangefs: orangefs_file_open() can be static
From:   Joe Perches <joe@perches.com>
To:     kbuild test robot <lkp@intel.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     kbuild-all@01.org, Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Apr 2019 19:15:02 -0700
In-Reply-To: <20190411015850.GA10504@lkp-wsm-ep1>
References: <201904110915.9jPFP0Co%lkp@intel.com>
         <20190411015850.GA10504@lkp-wsm-ep1>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 09:58 +0800, kbuild test robot wrote:
> Fixes: 9a959aaffd70 ("orangefs: remember count when reading.")

Making something static likely does not warrant a "Fixes:" tag

> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  file.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index d198af9..01d0db6 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -571,7 +571,7 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	return rc;
>  }
>  
> -int orangefs_file_open(struct inode * inode, struct file *file)
> +static int orangefs_file_open(struct inode * inode, struct file *file)
>  {
>  	file->private_data = NULL;
>  	return generic_file_open(inode, file);

