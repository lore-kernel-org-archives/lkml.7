Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B374C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213462077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDZLhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:37:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:14970 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDZLhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:37:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 04:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="168164722"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 26 Apr 2019 04:37:28 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 26 Apr 2019 14:37:27 +0300
Date:   Fri, 26 Apr 2019 14:37:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Thunderbolt changes for v5.2
Message-ID: <20190426113727.GQ2583@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v5.2

for you to fetch changes up to 37209783c73a47692dbf1e6b2dba0d07f6ce24b3:

  thunderbolt: Make priority unsigned in struct tb_path (2019-04-25 12:18:27 +0300)

----------------------------------------------------------------
thunderbolt: Changes for v5.2 merge window

This improves software connection manager on older Apple systems with
Thunderbolt 1 and 2 controller to support full PCIe daisy chains,
Display Port tunneling and P2P networking. There are also fixes for
potential NULL pointer dereferences at various places in the driver.

----------------------------------------------------------------

Aditya Pakki (4):
      thunderbolt: Fix to check for kmemdup failure
      thunderbolt: Fix to check return value of ida_simple_get
      thunderbolt: xdomain: Fix to check return value of kmemdup
      thunderbolt: Fix to check the return value of kmemdup

Kangjie Lu (3):
      thunderbolt: property: Fix a NULL pointer dereference
      thunderbolt: Fix a missing check of kmemdup
      thunderbolt: property: Fix a missing check of kzalloc

Mika Westerberg (36):
      net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
      thunderbolt: Remove unused work field in struct tb_switch
      thunderbolt: Drop duplicated get_switch_at_route()
      thunderbolt: Block reads and writes if switch is unplugged
      thunderbolt: Take domain lock in switch sysfs attribute callbacks
      thunderbolt: Do not allocate switch if depth is greater than 6
      thunderbolt: Enable TMU access when accessing port space on legacy devices
      thunderbolt: Add dummy read after port capability list walk on Light Ridge
      thunderbolt: Move LC specific functionality into a separate file
      thunderbolt: Configure lanes when switch is initialized
      thunderbolt: Set sleep bit when suspending switch
      thunderbolt: Properly disable path
      thunderbolt: Cache adapter specific capability offset into struct port
      thunderbolt: Rename tunnel_pci to tunnel
      thunderbolt: Generalize tunnel creation functionality
      thunderbolt: Add functions for allocating and releasing HopIDs
      thunderbolt: Assign remote for both ports in case of dual link
      thunderbolt: Add helper function to iterate from one port to another
      thunderbolt: Extend tunnel creation to more than 2 adjacent switches
      thunderbolt: Deactivate all paths before restarting them
      thunderbolt: Discover preboot PCIe paths the boot firmware established
      thunderbolt: Add support for full PCIe daisy chains
      thunderbolt: Scan only valid NULL adapter ports in hotplug
      thunderbolt: Generalize port finding routines to support all port types
      thunderbolt: Rework NFC credits handling
      thunderbolt: Add support for Display Port tunnels
      thunderbolt: Do not tear down tunnels when driver is unloaded
      thunderbolt: Run tb_xdp_handle_request() in system workqueue
      thunderbolt: Add XDomain UUID exchange support
      thunderbolt: Add support for DMA tunnels
      thunderbolt: Make tb_switch_alloc() return ERR_PTR()
      thunderbolt: Add support for XDomain connections
      thunderbolt: Make __TB_[SW|PORT]_PRINT take const parameters
      thunderbolt: Make rest of the logging to happen at debug level
      thunderbolt: Reword output of tb_dump_hop()
      thunderbolt: Start firmware on Titan Ridge Apple systems

Nathan Chancellor (1):
      thunderbolt: Make priority unsigned in struct tb_path

 drivers/net/thunderbolt.c        |   3 +
 drivers/thunderbolt/Makefile     |   4 +-
 drivers/thunderbolt/cap.c        |  85 ++++-
 drivers/thunderbolt/ctl.c        |   2 +-
 drivers/thunderbolt/icm.c        |  65 ++--
 drivers/thunderbolt/lc.c         | 179 ++++++++++
 drivers/thunderbolt/nhi.c        |   3 +-
 drivers/thunderbolt/path.c       | 420 ++++++++++++++++++++----
 drivers/thunderbolt/property.c   |  16 +-
 drivers/thunderbolt/switch.c     | 557 +++++++++++++++++++++++++------
 drivers/thunderbolt/tb.c         | 608 ++++++++++++++++++++++++++--------
 drivers/thunderbolt/tb.h         | 227 +++++++++++--
 drivers/thunderbolt/tb_msgs.h    |  11 +
 drivers/thunderbolt/tb_regs.h    |  50 ++-
 drivers/thunderbolt/tunnel.c     | 691 +++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tunnel.h     |  78 +++++
 drivers/thunderbolt/tunnel_pci.c | 226 -------------
 drivers/thunderbolt/tunnel_pci.h |  31 --
 drivers/thunderbolt/xdomain.c    | 170 ++++++++--
 include/linux/thunderbolt.h      |   8 +
 20 files changed, 2765 insertions(+), 669 deletions(-)
 create mode 100644 drivers/thunderbolt/lc.c
 create mode 100644 drivers/thunderbolt/tunnel.c
 create mode 100644 drivers/thunderbolt/tunnel.h
 delete mode 100644 drivers/thunderbolt/tunnel_pci.c
 delete mode 100644 drivers/thunderbolt/tunnel_pci.h
