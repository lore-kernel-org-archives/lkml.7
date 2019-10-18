Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97DCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A252245A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571393716;
	bh=0w1nWKVTncaR1KMNvi/d1vuu7AgxloRlEXtR81GmvEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKsteYuV4XuE/U8eji39/z68aHEZB+eJ3turUVCYGrp6nx/8jRGGzMGEooKGVI8tw
	 zSor7WzcKly+k6jEZ6+mx+rRMx5Gy4Gm/CyoMv/BFcLgh4V8RJxIL5qKXXkCIY6REs
	 LDxXyoN3zSAgJgkQzEC63v3wXUzgIBnjXjYHS9mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442459AbfJRKPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405197AbfJRKPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:15:13 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DD2222C3;
        Fri, 18 Oct 2019 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571393713;
        bh=0w1nWKVTncaR1KMNvi/d1vuu7AgxloRlEXtR81GmvEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUigrHvWxaPf7GV+6RONd0dnt+cseGtoO4i/RW659+2HuH0w2NmRo2BJGN9JJnfAy
         myGJaooD7KyACrXSujzvTnSpDKoWV+oqhqtpcwNdthp6HxmLvSoITs9KE229pNMHvy
         Cw8Ep3QOhaja2RoVGykeI8tAMJPwrVVCdCJm/xHk=
Date:   Fri, 18 Oct 2019 03:15:10 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH] export,module: add SPDX GPL-2.0 license identifier to
 headers with no license
Message-ID: <20191018101510.GA1172290@kroah.com>
References: <20191018045053.8424-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018045053.8424-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:50:53PM +0900, Masahiro Yamada wrote:
> Commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
> identifier to files with no license") took care of a lot of files
> without any license information.
> 
> These headers were not processed by the tool perhaps because they
> contain "GPL" in the code.
> 
> I do not see any license boilerplate in them, so they fall back to
> GPL version 2 only, which is the project default.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Ah, nice catch!

I'll queue this up to my spdx tree if no one objects.

thanks,

greg k-h
