Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D3C10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91302084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCKFBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:01:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCKFBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:01:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 67FF7148EA41A;
        Sun, 10 Mar 2019 22:01:00 -0700 (PDT)
Date:   Sun, 10 Mar 2019 22:00:58 -0700 (PDT)
Message-Id: <20190310.220058.191106608509733546.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 22:01:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get the following IDE changes, nothing super exciting as
usual:

1) Switch fallthrus from Gustavo A. R. Silva

2) Kconfig formatting cleanup from Enrico Weigelt

3) OF interface adjustment from Rob Herring

Thanks!

The following changes since commit cf76c364a1e1e5224af80edf70a1e3023e1fcf8c:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-12-05 17:06:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to dc5c37736d16ec90559888fb4c974977fc8ed1ca:

  drivers: ide: Kconfig: pedantic formatting (2019-03-10 11:12:38 -0700)

----------------------------------------------------------------
Enrico Weigelt, metux IT consult (1):
      drivers: ide: Kconfig: pedantic formatting

Gustavo A. R. Silva (2):
      ide: hpt366: mark expected switch fall-throughs
      ide: mark expected switch fall-through

Rob Herring (1):
      ide: Use of_node_name_eq for node name comparisons

 drivers/ide/Kconfig      | 26 +++++++++++++-------------
 drivers/ide/hpt366.c     |  4 ++--
 drivers/ide/ide-floppy.c |  2 +-
 drivers/ide/pmac.c       |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)
