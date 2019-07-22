Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09775C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB203218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfGVT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:58:15 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:41794 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbfGVT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:58:15 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A93D420C9E4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:58:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id peRqhmRzYiQerpeRqhCrsi; Mon, 22 Jul 2019 14:58:14 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:47902 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hpeRp-0032XC-D0; Mon, 22 Jul 2019 14:58:13 -0500
Date:   Mon, 22 Jul 2019 14:58:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
Message-ID: <20190722195813.GA18127@embeddedor>
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
X-Exim-ID: 1hpeRp-0032XC-D0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net (embeddedor) [201.172.149.185]:47902
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 42
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc2

for you to fetch changes up to bc512fd704a92e1be700c941c137d73c0f222eed:

  Makefile: Globally enable fall-through warning (2019-07-22 14:50:20 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc2

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through. These patches are part of the ongoing efforts
to enable -Wimplicit-fallthrough. Most of them have been baking in linux-next
for a whole development cycle.

Also, pull the Makefile patch that globally enables the
-Wimplicit-fallthrough option.

Finally, some missing-break fixes that have been tagged for -stable:

 - drm/amdkfd: Fix missing break in switch statement
 - drm/amdgpu/gfx10: Fix missing break in switch statement

Notice that with these changes, we completely get rid of all the
fall-through warnings in the kernel.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (11):
      firewire: mark expected switch fall-throughs
      can: mark expected switch fall-throughs
      afs: yfsclient: Mark expected switch fall-throughs
      afs: fsclient: Mark expected switch fall-throughs
      mtd: onenand_base: Mark expected switch fall-through
      perf/x86/intel: Mark expected switch fall-throughs
      drm/amdkfd: Fix missing break in switch statement
      drm/amdgpu/gfx10: Fix missing break in switch statement
      drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
      drm/i915: Mark expected switch fall-throughs
      Makefile: Globally enable fall-through warning

 Documentation/process/deprecated.rst             | 14 ++++++
 Makefile                                         |  3 ++
 arch/x86/events/intel/core.c                     |  2 +
 drivers/firewire/core-device.c                   |  2 +-
 drivers/firewire/core-iso.c                      |  2 +-
 drivers/firewire/core-topology.c                 |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c            |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c |  1 -
 drivers/gpu/drm/i915/Makefile                    |  1 -
 drivers/gpu/drm/i915/display/intel_display.c     |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c          |  1 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c        |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c            |  1 +
 drivers/mtd/nand/onenand/onenand_base.c          |  1 +
 drivers/net/can/at91_can.c                       |  6 ++-
 drivers/net/can/peak_canfd/peak_pciefd_main.c    |  2 +-
 drivers/net/can/spi/mcp251x.c                    |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c          |  2 +-
 fs/afs/fsclient.c                                | 51 ++++++++++++++--------
 fs/afs/yfsclient.c                               | 54 +++++++++++++++---------
 22 files changed, 106 insertions(+), 49 deletions(-)
