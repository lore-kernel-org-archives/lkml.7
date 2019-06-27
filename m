Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A2C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5112082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596799;
	bh=Li+vIJnqrc/kPaTgtlczdnW8Xa77lC4PVo4VW35qzlc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OYQw08Xecxj9mNgGlaVCcph3nqV5TsPuv8r2Jzn8EcmOpcnCnyu85mXFUbP5oBMfU
	 sg+5ja1p2jW+HvypqwMwhArYN1WgqjGy1OCC9Koo2CIzeLSw0NLPZPpKk78Gc+k+kg
	 cvIuUS4S5xyPfFwAGo+LAIkLs8HwvVWdA1QlNSsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfF0AxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfF0Act (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:32:49 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3024421726;
        Thu, 27 Jun 2019 00:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595568;
        bh=Li+vIJnqrc/kPaTgtlczdnW8Xa77lC4PVo4VW35qzlc=;
        h=Date:From:To:Cc:Subject:From;
        b=LpVxVek8b/yKtYPAJ794bZnHpCIlLO5t8i10J5GMym1KkWokLxshNPbRhRRhIFXBg
         ZXaFDu53LvNzFz15gepYQ7IcXtgfhx829aAMBgfxLsaiPk6PYaqLZi1h7kA0bwkdmz
         mAt4UAlJWo4eHN8sA25L6AmNm3srtTvQredj0laQ=
Date:   Thu, 27 Jun 2019 08:32:24 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.184
Message-ID: <20190627003224.GA10733@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.184 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile              |    2 +-
 net/ipv4/tcp_output.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Eric Dumazet (1):
      tcp: refine memory limit test in tcp_fragment()

Greg Kroah-Hartman (1):
      Linux 4.4.184

