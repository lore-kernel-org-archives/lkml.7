Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945DEC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7E2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGLIFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:05:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:40744 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfGLIFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:05:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E4A83C009; Fri, 12 Jul 2019 10:05:01 +0200 (CEST)
Date:   Fri, 12 Jul 2019 10:04:46 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 5.3
Message-ID: <20190712080446.GA19400@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a 9p update for 5.3, just a couple of fixes that have been
sitting here for too long as I missed the 5.2 merge window.

I have two more patches that I didn't have time to test early enough for
this but also are plain details fix, please let me know if you would
prefer having me send a pull request for -rc2 after a week in -next or
if I should just wait until the next window.
There's little risk but I'm usually rather conservative on this.


The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the git repository at:

  git://github.com/martinetd/linux tags/9p-for-5.3

for you to fetch changes up to 80a316ff16276b36d0392a8f8b2f63259857ae98:

  9p/xen: Add cleanup path in p9_trans_xen_init (2019-05-15 13:00:07
  +0000)

----------------------------------------------------------------
9p pull request for inclusion in 5.13

Two small fixes to properly cleanup the 9p transports list if virtio/xen
module initialization fail.
9p might otherwise try to access memory from a module that failed to
register got freed.

----------------------------------------------------------------
YueHaibing (2):
      9p/virtio: Add cleanup path in p9_virtio_init
      9p/xen: Add cleanup path in p9_trans_xen_init

 net/9p/trans_virtio.c |    8 +++++++-
 net/9p/trans_xen.c    |    8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)
