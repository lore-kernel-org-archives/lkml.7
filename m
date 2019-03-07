Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7552B20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551990159;
	bh=qaq6pFjAsqd/+e+W4bwmmD16NAJ+G59QUzX963PWJeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxjKxeRnCDOLHRJ8AwMYe5ylq8jlytfUz2M6sjlBg8lxJnO4a0YIh4ykyqyKau0Bz
	 6ug3eD0aPFXtIZ/0thzCSWbXzlhnJJ3Sw9PaW7EdlAy1JDyv4A2AleY/GyAlnnIGad
	 Y/Icp7xyzLNiBPicyCE0iizD9L/o2IzYKEDq5Zp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCGUWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfCGUWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:22:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9A320840;
        Thu,  7 Mar 2019 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551990155;
        bh=qaq6pFjAsqd/+e+W4bwmmD16NAJ+G59QUzX963PWJeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vr+jDouilMvU7vyOhhWUgMGkk6LGVQWHXAS4nWN4la28EQlUwBbk4ZA6z3RCIe7vY
         1+u/zuhzIesLptn4j6L1BEliybJcZ42AIJS6BAkdzG0+tpyAbzYQZnhcx5cuvnd4/z
         dUtvcyuTSvfa3Yr+yO7nqFV32NhWroA6I6BwsbHg=
Date:   Thu, 7 Mar 2019 21:22:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jin Chen <nobijinc@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [RESEND][PATCH 2/2] staging: sm750fb: trivial Camel Case removal
 for setDisplayControl().
Message-ID: <20190307202232.GA16300@kroah.com>
References: <20190303165532.23727-1-tomli@tomli.me>
 <20190303165532.23727-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303165532.23727-3-tomli@tomli.me>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:55:32AM +0800, Yifeng Li wrote:
> Rename the function setDisplayControl() to set_display_control().
> This fixes the following checkpatch.pl warning:
> 
>     CHECK: Avoid CamelCase: <setDisplayControl>
> 
> Suggested-by: Jin Chen <nobijinc@gmail.com>
> Signed-off-by: Jin Chen <nobijinc@gmail.com>
> [tomli@tomli.me: resent as trivial patch, reworded the commit message]
> Signed-off-by: Yifeng Li <tomli@tomli.me>

I've already applied Jin's patch to the tree, so no need to resend this.

thanks,

greg k-h
