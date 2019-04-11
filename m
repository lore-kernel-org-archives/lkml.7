Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77BC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DCF2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKDRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:17:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:50947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKDRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:17:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 20:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; 
   d="scan'208";a="160147274"
Received: from slin7-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.204.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 20:17:12 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/5] soundwire: code cleanup
Date:   Wed, 10 Apr 2019 22:16:56 -0500
Message-Id: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire support will be provided in Linux with the Sound Open
Firmware (SOF) on Intel platforms. Before we start adding the missing
pieces, there are a number of warnings and style issues reported by
checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Changes since v2:
fixed inversion of devm_kcalloc parameters, detected while rebasing
additional patches.

Changes since v1:
added missing newlines in new patch (suggested by Joe Perches)

Pierre-Louis Bossart (5):
  soundwire: intel: fix inversion in devm_kcalloc parameters
  soundwire: fix style issues
  soundwire: bus: remove useless initializations
  soundwire: stream: remove useless initialization of local variable
  soundwire: add missing newlines in dynamic debug logs

 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            | 137 ++++++++-------
 drivers/soundwire/bus.h            |  16 +-
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  99 +++++------
 drivers/soundwire/cadence_master.h |  22 +--
 drivers/soundwire/intel.c          | 103 ++++++-----
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +-
 drivers/soundwire/mipi_disco.c     | 116 +++++++------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 267 +++++++++++++++--------------
 12 files changed, 404 insertions(+), 388 deletions(-)

-- 
2.17.1

