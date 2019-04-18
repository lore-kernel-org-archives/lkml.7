Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132BC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DACB2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555564658;
	bh=9I4swAVKjdH10ubnJcsOBFGDVxI67C4v5gGkyOoNAdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHSIoXsiqDelGWjCJE+q/Ruw1cu1EXSuzoPJHx1Nh4gv+IsxNd+CxOqcYKiN5kxFS
	 cmri7IKqE3DdAtc8DEtib+Q2NmM1zK92hE9Y28SH9CbCcj8vU8fqpbmQ670/95QqWS
	 +fRGl9yG124+Oz9keyQrRdgZHrC91WfEgvva2N6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfDRFRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfDRFRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:17:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3419F21850;
        Thu, 18 Apr 2019 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555564655;
        bh=9I4swAVKjdH10ubnJcsOBFGDVxI67C4v5gGkyOoNAdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8QPprCMEfSXrmMHsm9yJPU074UVXeQwGGOgfzTbbY8JvoJji46iCg1PbvAzT23Qf
         2vfioBW4HrBWNshpTkbZ7CUc60O4fzg/10ErLhTMBzb8SUyfNGxlunl4axRLsCjT3G
         rJfuOh+QLvdS2QLtOzOA4/UdK1GbzyP84zJlBdig=
Date:   Thu, 18 Apr 2019 07:17:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
Message-ID: <20190418051732.GA17053@kroah.com>
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:51:56AM +0900, Sugaya Taichi wrote:
> Add Milbeaut serial control including earlycon and console.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
> Changes from v2:
>  - Fix build warning.

No, I only need an incremental patch fixing the one sparse warning
found, not a whole new patch as I have already merged your original
patch, right?

thanks,

greg k-h
