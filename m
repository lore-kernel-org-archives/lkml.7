Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A85C2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEAP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:58:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:12796 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfEAP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115647"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:07 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 00/22] soundwire: code cleanup
Date:   Wed,  1 May 2019 10:57:23 -0500
Message-Id: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Changes since v3:
patch 1,3,4 were merged for 5.2-rc1
No code change, only split patch2 in 21 patches to make Vinod
happy. Each patch only fixes a specific issue. patch 5 is now patch22
and wasn't changed. Not sure why Vinod reported the patch didn't
apply.
Added Takashi's Reviewed-by tag in all patches since the code is
exactly the same as in v3.

Changes since v2:
fixed inversion of devm_kcalloc parameters, detected while rebasing
additional patches.

Changes since v1:
added missing newlines in new patch (suggested by Joe Perches)

Pierre-Louis Bossart (22):
  soundwire: Kconfig: fix help format
  soundwire: fix SPDX license for header files
  soundwire: fix alignment issues in header files
  soundwire: bus: fix alignment issues
  soundwire: bus: fix typos in comments
  soundwire: bus: remove useless parentheses
  soundwire: bus: fix boolean comparisons
  soundwire: bus: remove spurious newline
  soundwire: bus_type: fix alignment issues
  soundwire: mipi_disco: fix alignment issues
  soundwire: mipi_disco: fix boolean comparisons
  soundwire: stream: fix alignment issues
  soundwire: slave: fix alignment issues
  soundwire: intel_init: fix alignment issues
  soundwire: intel: fix alignment issues
  soundwire: intel: protect macro parameters
  soundwire: intel: fix boolean comparison
  soundwire: cadence_master: fix alignment issues
  soundwire: cadence_master: balance parentheses
  soundwire: cadence_master: fix boolean comparisons
  soundwire: cadence_master: remove spurious newline
  soundwire: add missing newlines in dynamic debug logs

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            | 135 ++++++++-------
 drivers/soundwire/bus.h            |  16 +-
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  99 +++++------
 drivers/soundwire/cadence_master.h |  22 +--
 drivers/soundwire/intel.c          |  99 ++++++-----
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +-
 drivers/soundwire/mipi_disco.c     | 116 +++++++------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 265 +++++++++++++++--------------
 12 files changed, 401 insertions(+), 383 deletions(-)

-- 
2.17.1

