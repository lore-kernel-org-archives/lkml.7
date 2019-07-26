Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A4C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58E622C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DNuBBSry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZCz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:55:27 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.114]:24451 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbfGZCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:55:27 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id A5212A8C05
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 21:55:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id qqODhOlp2YTGMqqODhDU9U; Thu, 25 Jul 2019 21:55:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rzOPNT9cxhr8EuEtqUBeG7FiHBw/MSCY4bnSC0/L+eI=; b=DNuBBSryUHZ6FslhSNzGIgzQ1I
        l5JcPh8jUOCmOfHvIldJnwzkKpxlisYLk42B7mOY+gf0RjEgPPlaAu8rgpqX44B9pLiuY8crSd6zs
        KAD6OherUXY0Ws9oGPwF6mt1ZI4Gf9D42PD+NkaQqAJrPthBdyuodzqyx8us0iZfSs6coCHbN3kps
        uIaIlx/q+nou3kn3y/f7K9A/zhiLSqJcNPyam/TFOagRIGcLPH6iuuqlJtmVehFFqIHaPTV2ijGmc
        hfP88B52A2HPnF/uxefc+z/AQTg3OzUZMrONI0/BsHUKVSm9uLFcSQD7LsfD4PTN87pREmBcG0KMO
        pvinaVXQ==;
Received: from [201.162.240.87] (port=24644 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hqqOC-000LRN-FJ; Thu, 25 Jul 2019 21:55:24 -0500
Date:   Thu, 25 Jul 2019 21:55:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
Message-ID: <20190726025521.GA1824@embeddedor>
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
X-Source-IP: 201.162.240.87
X-Source-L: No
X-Exim-ID: 1hqqOC-000LRN-FJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.87]:24644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Kees let me know about the problems you had with my previous pull-request.
Apologies for the inconvenience. 

Here is a new pull-request that includes a fix for those warnings you
were seeing with the dcn20_dccg driver.

Just for you to know, I'm building allmodconfig.

Please, let me know if you have any trouble and I'll address it ASAP.

Thanks!
--
Gustavo

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc2

for you to fetch changes up to a035d552a93bb9ef6048733bb9f2a0dc857ff869:

  Makefile: Globally enable fall-through warning (2019-07-25 20:13:54 -0500)

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
Gustavo A. R. Silva (12):
      firewire: mark expected switch fall-throughs
      can: mark expected switch fall-throughs
      afs: yfsclient: Mark expected switch fall-throughs
      afs: fsclient: Mark expected switch fall-throughs
      mtd: onenand_base: Mark expected switch fall-through
      perf/x86/intel: Mark expected switch fall-throughs
      drm/amdkfd: Fix missing break in switch statement
      drm/amdgpu/gfx10: Fix missing break in switch statement
      drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
      drm/amd/display: Mark expected switch fall-throughs
      drm/i915: Mark expected switch fall-throughs
      Makefile: Globally enable fall-through warning

 Documentation/process/deprecated.rst              | 14 ++++++
 Makefile                                          |  3 ++
 arch/x86/events/intel/core.c                      |  2 +
 drivers/firewire/core-device.c                    |  2 +-
 drivers/firewire/core-iso.c                       |  2 +-
 drivers/firewire/core-topology.c                  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c             |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  5 +++
 drivers/gpu/drm/i915/Makefile                     |  1 -
 drivers/gpu/drm/i915/display/intel_display.c      |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c           |  1 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c          |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c         |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c             |  1 +
 drivers/mtd/nand/onenand/onenand_base.c           |  1 +
 drivers/net/can/at91_can.c                        |  6 ++-
 drivers/net/can/peak_canfd/peak_pciefd_main.c     |  2 +-
 drivers/net/can/spi/mcp251x.c                     |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c           |  2 +-
 fs/afs/fsclient.c                                 | 51 +++++++++++++--------
 fs/afs/yfsclient.c                                | 54 +++++++++++++++--------
 23 files changed, 111 insertions(+), 49 deletions(-)
