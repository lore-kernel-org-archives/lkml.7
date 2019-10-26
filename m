Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E8214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572113899;
	bh=Jqv9TKri+ARTR9XEPwnhYdw3SNS4K0x25ZrWaOi5M7A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SE+rCu9xxiebNDdnbi/R4tXg16/hJT0N9ucUR14W2HURXQULq4FPkKbucmbh9W+z+
	 cuOqb++EyyloODKnFYEYHMLzbhnVBz+lB4DRlhBaXgQk2hyXS0Gb3JnrRsvWpeII4h
	 EZts44Ov6P0mInY5aA1N/LTDZFa0bmAGsyj0KHj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfJZSSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJZSSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:18:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5587820867;
        Sat, 26 Oct 2019 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113897;
        bh=Jqv9TKri+ARTR9XEPwnhYdw3SNS4K0x25ZrWaOi5M7A=;
        h=Date:From:To:Cc:Subject:From;
        b=VkLChL1PdqWQGexpMZnLljRlEId5/7HvSdkTXMcDL3VrIoiEpiZ+IlLmsLA5W/RsT
         mkIERKpJMJaqcWpQrFGqa3o8/kfD7B7FsDFB108JikK8PJOfCYyUtTZqKmud1l8F7b
         w++ckEZJjBxJRPi/J27Ihz5NmvuZplIeGHsYcYUA=
Date:   Sat, 26 Oct 2019 20:18:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fix for 5.4-rc5
Message-ID: <20191026181815.GA649015@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.4-rc5

for you to fetch changes up to 82af5b6609673f1cc7d3453d0be3d292dfffc813:

  sysfs: Fixes __BIN_ATTR_WO() macro (2019-10-02 10:06:45 +0200)

----------------------------------------------------------------
Driver core fix for 5.4-rc5

Here is a single sysfs fix for 5.4-rc5.

It resolves an error if you actually try to use the __BIN_ATTR_WO()
macro, seems I never tested it properly before :(

This has been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Nayna Jain (1):
      sysfs: Fixes __BIN_ATTR_WO() macro

 include/linux/sysfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
