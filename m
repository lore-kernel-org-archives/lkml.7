Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783EC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F4C20665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfGISUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:20:15 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.194]:30918 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbfGISUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:15 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 3E14D4FC4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2019 13:20:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kuishIMGb2qH7kuishOVwN; Tue, 09 Jul 2019 13:20:14 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:54240 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hkuiq-000EUM-Of; Tue, 09 Jul 2019 13:20:13 -0500
Date:   Tue, 9 Jul 2019 13:20:10 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc1
Message-ID: <20190709182010.GA32200@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.149.185
X-Source-L: No
X-Exim-ID: 1hkuiq-000EUM-Of
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net (embeddedor) [201.172.149.185]:54240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc1

for you to fetch changes up to d93512ef0f0efa17eded6b9edf8e88e8418f44bd:

  Makefile: Globally enable fall-through warning (2019-07-08 15:23:22 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc1

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through. These patches are part of the ongoing efforts
to enable -Wimplicit-fallthrough. All of them have been baking in linux-next
for a whole development cycle.

Also, pull the Makefile patch that universally enables the
-Wimplicit-fallthrough option.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (6):
      afs: fsclient: Mark expected switch fall-throughs
      afs: yfsclient: Mark expected switch fall-throughs
      can: mark expected switch fall-throughs
      firewire: mark expected switch fall-throughs
      platform/x86: acer-wmi: Mark expected switch fall-throughs
      Makefile: Globally enable fall-through warning

 Documentation/process/deprecated.rst          | 14 +++++++
 Makefile                                      |  3 ++
 drivers/firewire/core-device.c                |  2 +-
 drivers/firewire/core-iso.c                   |  2 +-
 drivers/firewire/core-topology.c              |  1 +
 drivers/net/can/at91_can.c                    |  6 ++-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  2 +-
 drivers/net/can/spi/mcp251x.c                 |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  2 +-
 drivers/platform/x86/acer-wmi.c               |  4 ++
 fs/afs/fsclient.c                             | 51 ++++++++++++++++---------
 fs/afs/yfsclient.c                            | 54 +++++++++++++++++----------
 12 files changed, 100 insertions(+), 44 deletions(-)
