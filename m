Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DAEFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CE62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230758;
	bh=h8jWKRLHcYQHPvx6iEFsiy1s79ISKCPYqeIJX+eOlpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D3nLNFmRLn1637VSkyAYaAKS4oVokZF3xlB7NZP5QerUIHDNIAK7dGFvw5kHOgvkS
	 U4yU7UtPAlk27A5wI4mlem2Wg1HNh5iniVF/PGEPrdHiwixu0BZhx9ZSTiwzUcSEYi
	 rze8CF0PbdZ82L7JIRI5T7dyU6eE5fX9WwDkVbIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfJPM7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731686AbfJPM7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:59:16 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6812168B;
        Wed, 16 Oct 2019 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571230756;
        bh=h8jWKRLHcYQHPvx6iEFsiy1s79ISKCPYqeIJX+eOlpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+YK/3/0W80KVPE8m98VFL7OHmqvox3LIolxS5kO9JXIp+DLCvXkYlbvXdgDGcrss
         lvTRh1GTQMtxUO1BTRvBFBtP8eR3kp0dmwY+hvY7jSWHApU0ybyM2JJwSgWfLMVjv8
         1cf2bdwoo3UfHA+iBQLR2fVQqCrA2bkeB1mf1xfs=
Date:   Wed, 16 Oct 2019 05:59:14 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zzoru <zzoru007@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        LKML <linux-kernel@vger.kernel.org>, dokyungs@uci.edu,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: WARNING in __alloc_pages_nodemask
Message-ID: <20191016125914.GD26615@kroah.com>
References: <CALRZ7UuEBvMtL6Q3TOKjXdh9B4X5bcHUdbO7i20TmPShZHmKZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALRZ7UuEBvMtL6Q3TOKjXdh9B4X5bcHUdbO7i20TmPShZHmKZg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:21:59AM -0700, zzoru wrote:
> We found the following crash on Linux 5.4-rc1 (Not patched in current
> HEAD commit 3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442)
> with our customized syzkaller.

<snip>

For this, and the other report, can you make up a patch to fix the issue
and submit it?

Also, 5.4-rc3 is out, you might want to update to a newer kernel as lots
and lots of USB-specific syzkaller-found issues have been fixed since
-rc1.

thanks,

greg k-h
