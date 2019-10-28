Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FBE21835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572277467;
	bh=Vw6GOlLIyJWbHl6tEVCiGyfOHiOuVzP1YEeoEouPlrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AwO46Rw/HjiP2aoWXpQPykNzod3gCPVC8Qx9E9hl1VhiDHO86PDoBnYBtj82JDPxm
	 dzlBtoBhrMr7U2979HcZoRBuIIIXNhGIJXtMMK7pSWBVZ0eHHrk217AAiJTGvA8tjJ
	 nFrBOxk/BBIrXHe/8oghoigApPoKgbrtuIYjOVFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbfJ1Po0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ1PoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:44:25 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C0421721;
        Mon, 28 Oct 2019 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572277465;
        bh=Vw6GOlLIyJWbHl6tEVCiGyfOHiOuVzP1YEeoEouPlrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxr5gjwtJws1NFeA95O9WSVj2uSK/rojrJTVK2xhh+mVH/CLQJDiZ5+PA94LPgbgb
         huhy7AyJbIM9Yl7YUmv4dOq+lbNbZpIE/6PI6qQkmM7uxe+/lEkSzxyJIG545ytvh6
         cDoQJiZs3NnreiGaTfBO2YX406o9LXXpAKGicejQ=
Date:   Mon, 28 Oct 2019 16:44:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v4 2/2] staging: rtl8712: Remove lines before a close
 brace
Message-ID: <20191028154422.GA170402@kroah.com>
References: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
 <359179720fcf90dd7aa35faab5d074bc829fa192.1572276208.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359179720fcf90dd7aa35faab5d074bc829fa192.1572276208.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:39:08PM -0300, Cristiane Naves wrote:
> Fix Blank lines aren't necessary before a close brace '}'. Issue found
> by checkpatch.
> 
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 2 --
>  1 file changed, 2 deletions(-)

This patch did not apply to my tree, it was already present.

thanks,

greg k-h
