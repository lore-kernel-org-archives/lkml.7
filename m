Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFDC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AD6227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576148822;
	bh=Y0loDw+uKFeN7cf78aOvQigklGH6Ys0zQRFUm0ZVYuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KBdiUiQ/q60lw9Lqs3xq1V5GcN6u5Hmb9GwSW7ZaNBEiI8HPjxXZMm8dCe5yY3eFm
	 XkIHJbg1KHUS24oqjTZXkQ2pCDMw8Zt3sMiXrLQmpsVegi+Jma0nCcv2yGZetGRS1t
	 hQRaWlhgHrT4R8IB5cw7eXDHMfXsIToCUyg97fFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfLLLHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfLLLHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:07:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F3D2067C;
        Thu, 12 Dec 2019 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576148820;
        bh=Y0loDw+uKFeN7cf78aOvQigklGH6Ys0zQRFUm0ZVYuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tuv5lWkKG9kriUxqdbH5FxuUH9XO3guojzxKaKZd+KUI1T8MVOL6B7LBUfWoPhe8H
         q84SwjIt4mJwXWZkE0CpFYt/x6lDVIea1uiurG7NAuwJ8Pu+KH2rKSMhpch/OAKHXg
         wyJnS0ybv0P5RM2PSrgZnTk48ns+Ht87FPCFyNbU=
Date:   Thu, 12 Dec 2019 12:06:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] tty: serial: samsung.h: fix up minor comment issues
Message-ID: <20191212110658.GA1490894@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-3-gregkh@linuxfoundation.org>
 <20191210151204.GH11222@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210151204.GH11222@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:12:04PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 10, 2019 at 03:36:59PM +0100, Greg Kroah-Hartman wrote:
> > checkpatch found some minor issues with comments in samsung.h, so fix
> > that up.
> >
> 
> No, you remove this header two patches later. No point to fix checkpatch
> issues here.

It's nice to delete "clean" files :)

