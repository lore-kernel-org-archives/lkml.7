Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D204C32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8120872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569566364;
	bh=Mhvb/y6R698xgZGIjNVfK3IRa23BD0DXn2mb6szDw+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HiiASmWiGRn35r9AW2UtQhBzMRY2kiVPyWfi99ytDeRyHtJgMpS+nEsBCWO5+xlqk
	 dCYuGx+cQQ/Pbs/yUv2DXO7h7E2qGknbTP75ll5SDVP54Vve5Ngiss/ThFiPI0lDLV
	 Tp0w6S+Z9fiA/UKZVfy3lXNkspClHETdCpfbiuSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfI0GjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0GjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:39:22 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1065206B7;
        Fri, 27 Sep 2019 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569566362;
        bh=Mhvb/y6R698xgZGIjNVfK3IRa23BD0DXn2mb6szDw+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKJdL5KWsnRBktC7HuWrlX8BYz0WTA9rbocMXzDL/hnNZ4T7YLwPkIwb5lfGzmcGk
         +dDuSzLcHBxCxAh5/HCJP6xOFMA2ZhVWgT1pT4cCn3cfEQojJavDm7hBszIrQvgw/c
         HkXqUPv60/boJjIGL16WR67xYFp64TamMTHtXLOs=
Date:   Fri, 27 Sep 2019 08:27:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 1/1] leds: remove PAGE_SIZE limit of
 /sys/class/leds/<led>/trigger
Message-ID: <20190927062736.GD1786098@kroah.com>
References: <1568387004-3802-1-git-send-email-akinobu.mita@gmail.com>
 <1568387004-3802-2-git-send-email-akinobu.mita@gmail.com>
 <54d4debc-470a-86f6-e43c-f51f1c7913e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d4debc-470a-86f6-e43c-f51f1c7913e0@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:30:08PM +0200, Jacek Anaszewski wrote:
> Hi Greg,
> 
> Akinobu seems to have addressed all issues that have been
> raised regarding this patch. I'd be happy to have your ack before
> applying it.

You have to wait until after -rc1 is out before doing anything, so
there's no rush :)

I'll go review it now...

greg k-h
