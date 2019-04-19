Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D05EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613B320449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698958;
	bh=UXSAuXtBKtiyp6wd0QD5G7QbrsNlC+cikHNtloM+vQE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SK0pfLQlVdcPe8uvE7ZaQZ0hkd59vCsvks+gyl90TSVOL7k860RyPv8XFNWRNuMKz
	 8Q1+hWWqryBTXe6Uayt2S0oyqlN5Em6Y6d1NaFJgXvycIib5owc2plQtL6iuCvavxd
	 L+norL48HXIITOgreFCv4TbnksZKqjKW2ug4Vxrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfDSSf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE572195D;
        Fri, 19 Apr 2019 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677044;
        bh=UXSAuXtBKtiyp6wd0QD5G7QbrsNlC+cikHNtloM+vQE=;
        h=Date:From:To:Cc:Subject:From;
        b=CxeayGzL/hjJoc17FnlK7+php3magpR8igmHKtZV3XqQ8IjWSosCS81lzovRthDaT
         agjmHE1V4j9exUlveX7iYflddfFSSg3PfjVFvXeZzb4EddUt/iVkmrQanZKIFnnjO0
         LyZmDKBSnpRzu+hxnHBcAMY5Pur5l29svNk+HtcM=
Date:   Fri, 19 Apr 2019 14:30:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.1-rc6
Message-ID: <20190419123042.GA4761@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc6

for you to fetch changes up to bb0925b283fe558fa9530c9d0b6158e9b6c9dfa6:

  Merge tag 'extcon-fixes-for-5.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-linus (2019-04-16 12:46:09 +0200)

----------------------------------------------------------------
char/misc fixes for 5.1-rc6

Here are 4 small misc driver fixes for 5.1-rc6.

Nothing major at all, they fix up a Kconfig issues, a SPDX invalid
license tag, and 2 tiny bugfixes.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      extcon: ptn5150: fix COMPILE_TEST dependencies

Bo YU (1):
      misc: fastrpc: add checked value for dma_set_mask

Greg Kroah-Hartman (2):
      Merge tag 'misc-habanalabs-fixes-2019-04-01' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus
      Merge tag 'extcon-fixes-for-5.1-rc4' of git://git.kernel.org/.../chanwoo/extcon into char-misc-linus

Oded Gabbay (1):
      habanalabs: remove low credit limit of DMA #0

Thomas Gleixner (1):
      drivers: power: supply: goldfish_battery: Fix bogus SPDX identifier

 drivers/extcon/Kconfig                  | 2 +-
 drivers/misc/fastrpc.c                  | 7 ++++++-
 drivers/misc/habanalabs/goya/goya.c     | 9 ++++-----
 drivers/power/supply/goldfish_battery.c | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)
