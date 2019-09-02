Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BBEC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEE8217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567438475;
	bh=lA6eyYFAkUUFVvLcmYFaxJIeNymm/A2N6PpCW/HSFvY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2vWRujpOmh+jgJ19xLlsw88PeeZuXqEMZ54/gZH5430sj4u8Kn5+XUdovAGCOvRey
	 kVSHL+RJhpnwO2Nsbzyc7GyEPTSwW6h03kZyL0O4eXBtHKQhGJTRUijCMGI8VsWWVp
	 dQ3pCs34v6ZJYolH0tr5MItxsJhP1xYYhMiC3EPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfIBPee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfIBPee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:34:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6675B2087E;
        Mon,  2 Sep 2019 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567438473;
        bh=lA6eyYFAkUUFVvLcmYFaxJIeNymm/A2N6PpCW/HSFvY=;
        h=Date:From:To:Cc:Subject:From;
        b=wDzTAvsPA1Dtb8QYfOP6In24ZqozuRCgRx+H7MffZNnD6lxd3rwDlhXNKdqL0mN1p
         eVBVIXa4Rg0qbk0oqB3cBjKPhdHQ2mtSqPRcFUyLZgI7Mjq1DBaWRT9zeif02Nl/0N
         cue8FdI8CFH730zUFYGk2raHyhoApu/IIPFgdnT4=
Date:   Mon, 2 Sep 2019 17:34:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.3-rc7
Message-ID: <20190902153431.GA9961@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc7

for you to fetch changes up to 8919dfcb31161fae7d607bbef5247e5e82fd6457:

  fsi: scom: Don't abort operations for minor errors (2019-08-28 22:59:18 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.3-rc7

Here are some small char and misc driver fixes for reported issues for
5.3-rc7

Also included in here is the documentation for how we are handling
hardware issues under embargo that everyone has finally agreed on, as
well as a MAINTAINERS update for the suckers who agreed to handle the
LICENSES/ files.

All of these have been in linux-next last week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (2):
      intel_th: pci: Add support for another Lewisburg PCH
      intel_th: pci: Add Tiger Lake support

Ding Xiang (1):
      stm class: Fix a double free of stm_source_device

Eddie James (1):
      fsi: scom: Don't abort operations for minor errors

Greg Kroah-Hartman (2):
      MAINTAINERS: add entry for LICENSES and SPDX stuff
      Merge tag 'fpga-fixes-for-5.3' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-linus

Nadav Amit (2):
      VMCI: Release resource if the work is already queued
      vmw_balloon: Fix offline page marking with compaction

Phil Reid (1):
      fpga: altera-ps-spi: Fix getting of optional confd gpio

Raul E Rangel (1):
      lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK

Thomas Gleixner (1):
      Documentation/process: Embargoed hardware security issues

Tomas Winkler (1):
      mei: me: add Tiger Lake point LP device ID

 .../process/embargoed-hardware-issues.rst          | 279 +++++++++++++++++++++
 Documentation/process/index.rst                    |   1 +
 MAINTAINERS                                        |  12 +
 drivers/fpga/altera-ps-spi.c                       |  11 +-
 drivers/fsi/fsi-scom.c                             |   8 +-
 drivers/hwtracing/intel_th/pci.c                   |  10 +
 drivers/hwtracing/stm/core.c                       |   1 -
 drivers/misc/lkdtm/bugs.c                          |   4 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/misc/vmw_balloon.c                         |  10 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |   6 +-
 12 files changed, 328 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/process/embargoed-hardware-issues.rst
