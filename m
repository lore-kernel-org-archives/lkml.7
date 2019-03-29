Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553888389;
	bh=YMhvVLl8ttt1NiAI8R5fKbDqQIWhJVin4SFzvxlz2FU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mJKz8KpG5pCv6YNARvnmRzbhIUHTDCQ+I7wf/vCvAX7mZbXZhJDr324KMG4Nw+9N/
	 nkzAZ+oNZgKY798NxL4vX6eiTftlvSarISnY5PZxFqNzBTdgbaxFP2zOg2RUWvxh9k
	 Ku4mNseyyV16ZmjR6SUy48vFmarVeSVCIf1WUdD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfC2Tjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfC2Tjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:39:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA65C2064A;
        Fri, 29 Mar 2019 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553888387;
        bh=YMhvVLl8ttt1NiAI8R5fKbDqQIWhJVin4SFzvxlz2FU=;
        h=Date:From:To:Cc:Subject:From;
        b=e/2aELsRz0ZzIBVaxWP7iOJPLTGkDh1yxCTk/Osyzk37JMsFMf08xj40PowOn0cMu
         zTVditmtOmYavGgt+66pZVbOgWCLnPA7hm9zTha+6/gxw47PkgOKpMTMkXdvMAp1br
         DmtRZ70v8Yd1A7fL9KZDK5difqixe3g3084RppWc=
Date:   Fri, 29 Mar 2019 20:39:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fixes for 5.1-rc3
Message-ID: <20190329193944.GA11609@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.1-rc3

for you to fetch changes up to cd1b772d4881d1cd15b90ec17aab9ac7950e8850:

  driver core: remove BUS_ATTR() (2019-03-18 07:07:30 +0100)

----------------------------------------------------------------
Driver core patch for 5.1-rc3

Here is a single driver core patch for 5.1-rc3.

After 5.1-rc1, all of the users of BUS_ATTR() are finally removed, so we
can now drop this macro from include/linux/device.h so that no more new
users will be created.

This patch has been in linux-next for a while, with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      driver core: remove BUS_ATTR()

 include/linux/device.h | 2 --
 1 file changed, 2 deletions(-)
