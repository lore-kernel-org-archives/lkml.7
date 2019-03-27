Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36169C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31B62087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711318;
	bh=pTG9qk2V5Nd8Yv/SabhEbP+M9n0q9g8nr46QjXLJrvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hY/oNw3fbMAXfzmo5uZ2fdNOvfdKXM7IOkqmmNV37M+CMWsjzkz53SGoqF1C0IFiq
	 644WR8b2NVtmhvyhrhLzf/SyfMl9LtmWIt+FAM2Ibsu3jhZoxlMMbIP8UKp5NGQqVA
	 FnkkXbxk7dm6WxlJz17HoDkS0fTVRQRN8yxJaKXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbfC0S2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391236AbfC0S2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:33 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6A420651;
        Wed, 27 Mar 2019 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711312;
        bh=pTG9qk2V5Nd8Yv/SabhEbP+M9n0q9g8nr46QjXLJrvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+nuM/P9KnPJaAMrrUFhcgVzxMIGn3beynPQlB1SCJScypmlJU3yZE8/6qKVLcInD
         /UDG0MkKWbMxjjH4yqSB4wp4pHDyQeMurOvFfEXnedHOOF5677FQBe3I6wUuLcIZCK
         gqoDgNfKnFFwkDx/8TvjkgEqQCYzc7eOi9+aOQCs=
Date:   Thu, 28 Mar 2019 01:38:31 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     lkml@metux.net, morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] Respond:add support for SUNIX Multi-I/O board
Message-ID: <20190327163831.GB11712@kroah.com>
References: <20190315101059.25096-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315101059.25096-1-saumah@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 06:10:59PM +0800, Morris Ku wrote:
> +driver support maximum 4 boards can be installed incombination
> +(up to 32 serial port and 2 parallel port)
> +
> +And do we really need a global list of them ? (instead of just having
> +all per-board / per-port data in a per-board / per-port driver instance)
> +
> +
> i prefer to keep current format.

No, this needs to be fixed, you can not use static arrays anymore for
stuff like this.

greg k-h
