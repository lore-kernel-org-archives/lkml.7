Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C4C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369C72184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555569652;
	bh=tNuRN8ZkjOQ1nm9L6vPj9+HgmrArntga33ZuRL1GD44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vprg9I7xq1jcfr6vhJIiegU0SRoMeB1V4o3So3xDi1Ynl6d0zjXntRZLxillNSF/J
	 xpO9Gh3GMD7og1joaYwKAsfoapwE1+19MU+U1M+d5rZfRTuqwcz048NpjHKOMctosI
	 xTutLuYcmjFeZ953QqaxsAQy/z8F34/GAZ1vi84A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbfDRGkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbfDRGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:40:51 -0400
Received: from localhost (ip-213-127-62-114.ip.prioritytelecom.net [213.127.62.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1D0214DA;
        Thu, 18 Apr 2019 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555569650;
        bh=tNuRN8ZkjOQ1nm9L6vPj9+HgmrArntga33ZuRL1GD44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydD28DkMROok8YTiuHevZeFGX3eiqfaDeqdOs0yyseGTpKtln30GLJIZBP5+lpsiw
         QvDaWusKTTTUFCPiApcduWfYtwomkDn80q9p4P6zLq0eMzO9vlAYvPTaMoRk3WSEd6
         aWOlYh12jQFHat1Qum9laSbVvBtmbT/M2HCJYVp4=
Date:   Thu, 18 Apr 2019 08:40:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: Fix using plain integer instead of Null pointer
Message-ID: <20190418064045.GA12503@kroah.com>
References: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:21:25PM +0900, Sugaya Taichi wrote:
> Fix build warning that using plain integer as Null pointer.
> This is reported by kbuild test robot.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  drivers/tty/serial/milbeaut_usio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Using a "Reported-by:" tag is usually a good idea.  I'll add it when I
apply the patch, but for next time can you please add it?

thanks,

greg k-h
