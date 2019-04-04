Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647AD206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDDSWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:22:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:44486 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfDDSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:22:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 11:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="220617762"
Received: from qcummins-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.110.11])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2019 11:22:07 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] soundwire: code cleanup
Date:   Thu,  4 Apr 2019 13:22:01 -0500
Message-Id: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

While I am at it, I could use feedback from maintainers. We are ready
to release a number of required patches that were not provided
earlier, but the initial contributors have either left Intel or moved
on to other domains. While I'd like to give them credit for their
work, I don't think leaving the email addresses as is is a good
solution (email bounces, etc). I also don't think providing a
non-Intel address is correct since the work was funded by Intel. Is
there a recommended practice here?

Pierre-Louis Bossart (3):
  soundwire: fix style issues
  soundwire: bus: remove useless initializations
  soundwire: stream: remove useless initialization of local variable

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            |  89 ++++++++--------
 drivers/soundwire/bus.h            |  16 +--
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  87 +++++++--------
 drivers/soundwire/cadence_master.h |  22 ++--
 drivers/soundwire/intel.c          |  89 ++++++++--------
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +--
 drivers/soundwire/mipi_disco.c     | 116 +++++++++++---------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 163 +++++++++++++++--------------
 12 files changed, 315 insertions(+), 299 deletions(-)

-- 
2.17.1

