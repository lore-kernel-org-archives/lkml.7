Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEBC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7904D21871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567881637;
	bh=YcWHSR1UR2DuvNd+xPZI6Zz9k2rts8pZwRrCe/VRV/o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qDi5kJhdNDpk5EaKBAlTgZ+8afjFPnqIYJcPd7MYe+Sk/W4M+y1quvCI3Di4YABG9
	 IrowMF7LA2P6oYBBo3rF3CW1xLUq+aSvbhPielcI3qjRqW8Lh+eW1esFZv9i2ap/lB
	 39Q8LKgzgV1bJrAx074qu2SHyakFQQUlqe1yPo1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391629AbfIGSkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733279AbfIGSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:40:36 -0400
Received: from localhost (unknown [80.251.162.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328A120854;
        Sat,  7 Sep 2019 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567881635;
        bh=YcWHSR1UR2DuvNd+xPZI6Zz9k2rts8pZwRrCe/VRV/o=;
        h=Date:From:To:Cc:Subject:From;
        b=1ShmnG7IP7CO6IF2AXX0ulMlxHhc+WmfeNd82IdS+5pTRnAu2u62u9aadbJ6gb18m
         X0jBzrKzdIAYnom/JrjEV3PNO0BbNqHKJfMzUh42aQWsPxLlyWIbV7Nj3rpum8YtYK
         7nffVV43JDaYWpjcPJ2KghWY5Jw5PkOaJIl6pCgw=
Date:   Sat, 7 Sep 2019 19:40:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.3-rc8
Message-ID: <20190907184033.GA29833@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc8

for you to fetch changes up to a8e0abae2fe0e788fa3d92c043605d1211c13735:

  Documentation/process: Add Qualcomm process ambassador for hardware security issues (2019-09-07 18:30:54 +0100)

----------------------------------------------------------------
Documentation update for 5.3-rc8

Here is a few small patches for the documenation file that came in
through the char-misc tree in -rc7 for your tree.  They fix the mistake
in the .rst format that kept the table of companies from showing up in
the html output, and most importantly, add people's names to the list
showing support for our process.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Cooper (1):
      Documentation/process: Volunteer as the ambassador for Xen

Kees Cook (1):
      Documentation/process: Add Google contact for embargoed hardware issues

Sasha Levin (1):
      Documentation/process/embargoed-hardware-issues: Microsoft ambassador

Trilok Soni (1):
      Documentation/process: Add Qualcomm process ambassador for hardware security issues

 Documentation/process/embargoed-hardware-issues.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
