Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06786C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D029020863
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEHXxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:53:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54052 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfEHXxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:53:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0C6F147866BF;
        Wed,  8 May 2019 16:53:20 -0700 (PDT)
Date:   Wed, 08 May 2019 16:53:20 -0700 (PDT)
Message-Id: <20190508.165320.2267661705586017777.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 16:53:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finally deprecate the legacy IDE layer.

Frankly this is long overdue.

Please pull, thanks a lot!

The following changes since commit ef75bd71c5d31dc17ae41ff8bec92630a3037d69:

  Merge tag 'gfs2-for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2019-05-08 13:16:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide 

for you to fetch changes up to 7ad19a99ad431b5cae005c30b09096517058e84e:

  ide: officially deprecated the legacy IDE driver (2019-05-08 16:47:23 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      ide: officially deprecated the legacy IDE driver

 drivers/ide/ide-probe.c | 3 +++
 1 file changed, 3 insertions(+)
