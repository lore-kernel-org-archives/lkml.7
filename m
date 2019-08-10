Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668BC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D599217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565438137;
	bh=RZI/Tb9YvCMrcP9KfiEOl4Eo4vpguBqD0XIW4QHFUH8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oqW3BlEtXTzgj66LPhQHKxfEIFk+Fc5wX1DwpWU2cKsf2moqKB0zPGeZliTa0tL9t
	 Uv2HKnbSrYseVRxKnkcHHAWY73hN9Tw0EMUX/vnJ1yHgo35wjowwfHl8LVtxOfGIeh
	 7pk8i3v40snajsttfFCIgpPjAPa7cSkEWKYemHRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfHJLzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfHJLzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:55:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF76120880;
        Sat, 10 Aug 2019 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565438135;
        bh=RZI/Tb9YvCMrcP9KfiEOl4Eo4vpguBqD0XIW4QHFUH8=;
        h=Date:From:To:Cc:Subject:From;
        b=h8xzisPV0nm5yRzzttW9CjpxrXHfVvGt+XzoN4R6ofpCdPZ7Y/DCysNqD6XGuFH2u
         Fpv9K5RQxeKuBQo4YJrgF4RcE8vcdVk4lBW/tgxGF+L1WU80Y5tx1IdZXWZbCwuJ/2
         Fhf26inJVTcFozedAArsQJWyvQchqhWXUO3wDp2o=
Date:   Sat, 10 Aug 2019 13:55:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Add SPDX kernel tree to linux-next
Message-ID: <20190810115533.GA6302@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I realized that I've been sending patches to Linus from my "SPDX" kernel
tree for a few releases now, and it's not included in linux-next, which
is not good.

So, could you please add the kernel tree / branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git spdx-linus

to linux-next?

thanks,

greg k-h
