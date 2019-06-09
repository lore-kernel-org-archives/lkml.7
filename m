Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE81C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7AD20868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560078081;
	bh=4yCqDJ6gnHMOGHmX6Tj7HsB2ULZ8HyC9XSpyPlZH4I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vjy7sHW4GwVFBVk07+JwTaS3wl6ouHxJH72tBpbMgXzhkdgKAgBeFCazDyBKrLkG9
	 /EwGmbJggAwYDtI9ieCL7G2UwJbKepxp7ZNaj2fw/Hqj3TOnkun6ZaIZERIDbyiuX8
	 5yVTpgDo1k7Y/8s+n+TnMDnY8Y9JneySMt1AlAJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfFILBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFILBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:01:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420272083D;
        Sun,  9 Jun 2019 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560078078;
        bh=4yCqDJ6gnHMOGHmX6Tj7HsB2ULZ8HyC9XSpyPlZH4I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiF2h4EF+q1VatqeNNr06wWGkVwjUzpfSQpb1dwlJhdSr5IoS5j0usJ76lShqaL70
         7T/PF99a+BRVtuv52+XIJxsGjywPhetr3EmRbnUwBOFXw+cQ9jZutFcQsQJyjdxKAA
         zlZX0cAgEm2RLyZ73FcQdaBajpx1BEa9V1wPfYmo=
Date:   Sun, 9 Jun 2019 13:01:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix indentation issues
Message-ID: <20190609110116.GC30671@kroah.com>
References: <20190609053741.GA12637@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609053741.GA12637@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 11:07:41AM +0530, Hariprasad Kelam wrote:
> fix below issues reported by checkpatch
> 
> CHECK: Please don't use multiple blank lines
> WARNING: space prohibited between function name and open parenthesis '('
> +void _rtw_open_pktfile (_pkt *pktptr, struct pkt_file *pfile)
> WARNING: space prohibited before semicolon
> WARNING: space prohibited between function name and open parenthesis '('
> CHECK: spaces preferred around that '-' (ctx:VxV)
> CHECK: Comparison to NULL could be written "!pxmitbuf->pallocated_buf"
> CHECK: spaces preferred around that '*' (ctx:VxV)
> CHECK: spaces preferred around that '/' (ctx:VxV)
> WARNING: Missing a blank line after declarations
> WARNING: braces {} are not necessary for single statement blocks
> CHECK: spaces preferred around that '/' (ctx:VxV)
> CHECK: Using comparison to true is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

That is a lot of different issues trying to be fixed in one patch.
Please break this up into "one logical type of fix per patch" and make a
patch series.

thanks,

greg k-h
