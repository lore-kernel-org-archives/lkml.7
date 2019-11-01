Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F812086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfKALnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:43:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:43124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfKALnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:43:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 04:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="211771534"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Nov 2019 04:43:19 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 01 Nov 2019 13:43:18 +0200
Date:   Fri, 1 Nov 2019 13:43:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] thunderbolt: Add support for USB4
Message-ID: <20191101114318.GO2593@lahna.fi.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:21:29PM +0300, Mika Westerberg wrote:
> Mika Westerberg (22):
>   thunderbolt: Introduce tb_switch_is_icm()
>   thunderbolt: Log switch route string on config read/write timeout
>   thunderbolt: Log error if adding switch fails
>   thunderbolt: Convert basic adapter register names to follow the USB4 spec
>   thunderbolt: Convert PCIe adapter register names to follow the USB4 spec
>   thunderbolt: Convert DP adapter register names to follow the USB4 spec
>   thunderbolt: Make tb_sw_write() take const parameter
>   thunderbolt: Add helper macro to iterate over switch ports
>   thunderbolt: Refactor add_switch() into two functions
>   thunderbolt: Add support for lane bonding
>   thunderbolt: Add default linking between lane adapters if not provided by DROM
>   thunderbolt: Expand controller name in tb_switch_is_xy()
>   thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
>   thunderbolt: Add Display Port CM handshake for Titan Ridge devices
>   thunderbolt: Add Display Port adapter pairing and resource management
>   thunderbolt: Add bandwidth management for Display Port tunnels
>   thunderbolt: Do not start firmware unless asked by the user
>   thunderbolt: Make tb_find_port() available to other files
>   thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
>   thunderbolt: Add initial support for USB4
>   thunderbolt: Update Kconfig entry to USB4
>   thunderbolt: Update documentation with the USB4 information
> 
> Rajmohan Mani (3):
>   thunderbolt: Make tb_switch_find_cap() available to other files
>   thunderbolt: Add support for Time Management Unit
>   thunderbolt: Add support for USB 3.x tunnels
> 

I queued patches 1-17 for v5.5. I'll leave the rest of USB4 patches to
cook for a while and hopefully we can get them in for v5.6.
