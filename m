Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DAA20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711218;
	bh=KXj8oBX2qzB/GbIGrLUv7Ge6UxUdH2Os7y8LoW0vjOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z63US7BlKEQR3nWd7LK3Uksio1ybfcd6OM4kHfISzq7O9pTY5lGU+JjrhM0RBXI4f
	 +f1YkkpTUSHrmt0XPw18B9+DPeDdc41eorrK8cBTxyYF4muLvKjoJzQUgLxwcz5x/+
	 yXSxWLVMd9rhtnMt6xiVFO2IYqL+WxislT7BxAfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbfC0S05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404329AbfC0SZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:56 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEE2206BA;
        Wed, 27 Mar 2019 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711156;
        bh=KXj8oBX2qzB/GbIGrLUv7Ge6UxUdH2Os7y8LoW0vjOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8iRfD2XozhjfL4zDVXcPxylfdAMpvvjccn9xge7vwPfNIuLClOB3NcVxyTQR6b8C
         5fpTnaVvsZ44XzAo0IBEMIFn0hW616kbTrsFnUWusbzcKlkTSH04ZdB1c7zDywgUUp
         4GoX2pw9r4q7jUOPI+H/Fu1JLaWzjhNZJKIUPoas=
Date:   Wed, 27 Mar 2019 23:38:59 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Cunningham <wjcunningham7@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] Staging: emxx_udc: emxx_udc: Fixed a coding style error
Message-ID: <20190327143859.GA29204@kroah.com>
References: <20190326134723.GA32229@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326134723.GA32229@titus.pi.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:47:23AM -0400, Will Cunningham wrote:
> Removed unnecessary parentheses.
> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Someone else sent this patch right before you did, sorry.

greg k-h
