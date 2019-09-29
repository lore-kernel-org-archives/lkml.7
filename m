Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F6FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DCE21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569751803;
	bh=pwJo+EJtrS9oVfQHiXOw4zn6GSy+QbPofSc0wlHv20s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZcZxrvEPRLvLYqC7DqTUNeZ0Aq3VVWrLQZmSQvnl6bJLmhqULXjfrkuU2R7ZVoIB
	 KBGQQKb0DcMbT5DKRMH5vuIkLqSB5n28vUMFZtC2pGsZS+Lu6Co5ENIfesa0xLBmDa
	 185twWqfMLLM7W6C9cp23+fe0t/FSDHhLYqlgx/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfI2KKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 06:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfI2KKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:10:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3631207FA;
        Sun, 29 Sep 2019 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569751801;
        bh=pwJo+EJtrS9oVfQHiXOw4zn6GSy+QbPofSc0wlHv20s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFd7ZaiHJmGnMYOpWsB+hf6lWfl1aKy5rGbTBM9Oyxp8fibSU2Fr4tkzgxJ/mLkvQ
         0pA/9PkQFJkwTHJk2L8PBd0ltvjwtawZLuGMJsrGoD5ttraMw0TNirVDDCnSXtM0ly
         M9yJz1N92jr9Mdn9I+6wWSoS+vRj7fKNm3zAAWsA=
Date:   Sun, 29 Sep 2019 12:09:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: exfat: exfat_super.c: fixed camelcase coding
 style issue
Message-ID: <20190929100958.GA1906533@kroah.com>
References: <20190928231910.16898-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928231910.16898-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 06:19:10PM -0500, Jesse Barton wrote:
> Fixed a coding style issue.

What coding style issue?  Always be specific here.

> Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
> ---
>  drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Also remember to follow the output of scripts/get_maintainer.pl to
properly find the maintainer to cc:, otherwise patches might get
overlooked.

thanks,

greg k-h
