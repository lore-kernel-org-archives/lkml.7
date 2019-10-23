Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2C6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA721928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405962AbfJWVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:15:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:7549 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbfJWVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:15:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="373003313"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 14:15:06 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] ASoC: SOF: Intel: Soundwire integration
Date:   Wed, 23 Oct 2019 16:14:59 -0500
Message-Id: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of the series "[PATCH 0/4] soundwire:
update ASoC interfaces". The SOF/Intel code makes use of the
interfaces defined for initialization.

Build support for SoundWire is not provided for now, all
Soundwire-related code will be handled with a dummy fallback. We will
enable SoundWire interfaces in the Kconfigs when the functionality is
enabled in the soundwire tree.

In short, if the interfaces are agreed on, there is no risk with the
integration of these patches on the ASoC side.

Pierre-Louis Bossart (5):
  ASoC: SOF: Intel: add SoundWire configuration interface
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
  ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend

 include/sound/sof/dai-intel.h    |  18 +--
 sound/soc/sof/intel/hda-dsp.c    |   2 +
 sound/soc/sof/intel/hda-loader.c |  13 ++
 sound/soc/sof/intel/hda.c        | 230 ++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h        |  44 ++++++
 5 files changed, 295 insertions(+), 12 deletions(-)

-- 
2.20.1

