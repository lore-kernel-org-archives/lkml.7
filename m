Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F3C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5820B7C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEDBA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 21:00:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:20914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEDBAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 21:00:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 18:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="148114223"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga007.fm.intel.com with ESMTP; 03 May 2019 18:00:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 4/7] ABI: testing: Add description of soundwire slave sysfs files
Date:   Fri,  3 May 2019 20:00:27 -0500
Message-Id: <20190504010030.29233-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description is directly derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-slave     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-slave

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
new file mode 100644
index 000000000000..db2a0177f68f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
@@ -0,0 +1,85 @@
+What:		/sys/bus/soundwire/devices/sdw:.../bank_delay_support
+		/sys/bus/soundwire/devices/sdw:.../ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../clk_stop_mode1
+		/sys/bus/soundwire/devices/sdw:.../clk_stop_timeout
+		/sys/bus/soundwire/devices/sdw:.../high_PHY_capable
+		/sys/bus/soundwire/devices/sdw:.../master_count
+		/sys/bus/soundwire/devices/sdw:.../mipi_revision
+		/sys/bus/soundwire/devices/sdw:.../p15_behave
+		/sys/bus/soundwire/devices/sdw:.../paging_support
+		/sys/bus/soundwire/devices/sdw:.../reset_behave
+		/sys/bus/soundwire/devices/sdw:.../simple_clk_stop_capable
+		/sys/bus/soundwire/devices/sdw:.../sink_ports
+		/sys/bus/soundwire/devices/sdw:.../source_ports
+		/sys/bus/soundwire/devices/sdw:.../test_mode_capable
+		/sys/bus/soundwire/devices/sdw:.../wake_capable
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the
+		SoundWire Slave and are used by the bus to configure
+		the Slave
+
+
+What:		/sys/bus/soundwire/devices/sdw:.../dp0/BRA_flow_controlled
+		/sys/bus/soundwire/devices/sdw:.../dp0/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../dp0/max_word
+		/sys/bus/soundwire/devices/sdw:.../dp0/min_word
+		/sys/bus/soundwire/devices/sdw:.../dp0/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../dp0/word_bits
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave Data Port-0 DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for the SoundWire. They define various properties of the
+		Data port 0 are used by the bus to configure the Data Port 0.
+
+
+What:		/sys/bus/soundwire/devices/sdw:.../src-dpN/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/channels
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_ch
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_word
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/min_ch
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/min_word
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/modes
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/port_encoding
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/words
+
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/channels
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_ch
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_word
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/min_ch
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/min_word
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/modes
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/port_encoding
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/words
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave Data Source/Sink Port-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the
+		Source/Sink Data port N and are used by the bus to configure
+		the Data Port N.
-- 
2.17.1

