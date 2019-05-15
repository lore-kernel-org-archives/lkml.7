Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AADC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CB62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557933272;
	bh=FCiLzEOMAEmbfLIpa+6WETjOycWWnznhDhVY0gw0E2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MDigLKT/rTnwdKklLxQOJN4eB++zkittiLH8X3jZXLnRR4qHr10+deT+qWzEacrNi
	 bgIBk2CHg7fqT61LYsAaF/h/ophSunk6PqnyBv/UUO6WY+aIoS9K3MmittUhyzpmXS
	 OrXl8X+BgHQm8iJFAXqxIcDjTskLcYGt1eVquYOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfEOPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfEOPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA282084E;
        Wed, 15 May 2019 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557933269;
        bh=FCiLzEOMAEmbfLIpa+6WETjOycWWnznhDhVY0gw0E2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSGLRx2DJtlBEhkfRbpR2qg5cjAcOmNCbTOnGGH3KhnW9/AVImEA6KPsHyObcCEUc
         yaukZkVRyaSn1bVczSw7OwhmNL5FIaVZ3u9WOjNkwL/oPBIfWEBF7nHMRV4eqxLozy
         9xKSGygcvQR341TOw8ILJ1wm1XvUcAndM+NijNZU=
Date:   Wed, 15 May 2019 17:13:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     parna.naveenkumar@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bsr: "foo * bar" should be "foo *bar"
Message-ID: <20190515151358.GD23599@kroah.com>
References: <20190515134310.27269-1-parna.naveenkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515134310.27269-1-parna.naveenkumar@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:13:10PM +0530, parna.naveenkumar@gmail.com wrote:
> From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> 
> Fixed the checkpatch error. Used "foo *bar" instead of "foo * bar"
> 
> Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> ---
>  drivers/char/bsr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Where is patch 1/2 of this series?
