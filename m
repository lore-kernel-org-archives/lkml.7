Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D22CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7742E214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572113947;
	bh=jdl0SJqKBenXqOsIi5R+H/0Mw0637lfkMVvmePr1Z0Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oMOYi+IyOV6DOS84p/+J48Qf2SEUmaN+RFk6eLT2fCUVYbk005Y0eT/jAFPKvh8wr
	 q1m13zjyxaNcSYqn2GSZASLINp7m2sIos3yOZQC1qTtokKB1ceYaFpk4OmzU+SFChe
	 sEWhKg0zgzD4cvDQQ63A40fbgfYBgF1YmoXEq8h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfJZSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJZSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:19:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C9E20867;
        Sat, 26 Oct 2019 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113946;
        bh=jdl0SJqKBenXqOsIi5R+H/0Mw0637lfkMVvmePr1Z0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=ES17A3lHCSGWD2siHt86OuDmikWQ4vk/MKBY2brTQQfGr9G+qr/pBKqr5SKPJZf8y
         vNgIsH2V0EhyXIiV1aJwiln7aBycp3CeIOvajQ/tpJX4wDLgP5LVKaBL64W+mI9TXF
         T0QQdUzKKijZxeYg6TjmJjoBVxsBSWir0LUMI7Dk=
Date:   Sat, 26 Oct 2019 20:19:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fix for 5.4-rc5
Message-ID: <20191026181903.GA649190@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc5

for you to fetch changes up to f50b6805dbb993152025ec04dea094c40cc93a0c:

  8250-men-mcb: fix error checking when get_num_ports returns -ENODEV (2019-10-15 21:38:41 +0200)

----------------------------------------------------------------
TTY/Serial driver fix for 5.4-rc5

Here is a single tty/serial driver fix for 5.4-rc5 that resolves a
reported issue.

It has been in linux-next for a while with no problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      8250-men-mcb: fix error checking when get_num_ports returns -ENODEV

 drivers/tty/serial/8250/8250_men_mcb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
