Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB35C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7009B20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbfIEUft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:35:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfIEUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:35:48 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MD9Gh-1hwrfp1PeL-0097XB; Thu, 05 Sep 2019 22:35:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: add back ACPI dependency
Date:   Thu,  5 Sep 2019 22:35:09 +0200
Message-Id: <20190905203527.1478314-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vUt90rPVuKBhMvAKaolFnfJ447V2j2l1NdTi2KuiTVUjJF/VMdK
 W4NpP0PCa6CURF+o9a0uqgojYoRFGkOjD+H1QVw6c1sl23slLJYVQ/udPPOI6YYl7pVrw0H
 +XNjujaTYQzsTuyPl38UUjbiBDNoIY6wtQJqIYkzsHssSJFDlYCwd4uGYzVyiNnUSQ1L0q/
 ROw7IblgHWQfBixsU0lQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzvcKXxZC78=:D4by9+2BPSQkdoUL99X1O1
 ZK8Ld98Bzfj/dBWG+LU0lpKk+23JjbFddiD6m+LtcCu0CXqbboDMPnG4vhR1MTF4pEebU4UdY
 V+Nkc8J7rno4TSeQ6BAoQLVrWZvs8WX36UosnuUI40wgIvB6kylyMnfYqsh4IPtbJRPDR15hj
 8ayrQT2/G+GJDDivE1TbF388/NexMqtOfE5ngN/9JkEaZncpz68mvLpCvEB0yRhDi9ejaslJJ
 gnpTw1efGODciNFPRlUKpMf3PryP1JcB0IOl83+HUXk32+hvxPDjB3MVKFVlvpyCIX6zep1vp
 Z59tLfL3UehdlDj3EVnqBnrVOWZikd7ZUjxi+joUuYmWyQWRQnYI3eV+EpkKqb6RT1eqCvxEe
 bDxJQc975yDmboJNNtdbwSM3RMCgJszZsG6V1XFbNJCBSlCd2jfUoKbUK8DVb0JVGm9U3TFf3
 fZkq2j38sNWy33k3ma8Iw/xjRTTbzZed3vm8Z7o0qD8WuQ8wtNq6MH8NicOke2QvnSLwATZw2
 6DFOOSvILMnE3tXAFYdkIa3UbW3w5+q4KDuj4Gfcs85zJetw5qwCWW6C6jORQt9TrG+IzTMyJ
 IMldpPv7l+PN9fZVHn/ANz7heyJX5cYfXAoCnrymFHrBmTzC63s5MatIJCRzxnn9TmWelQrb9
 0g2m7eBLbBR2+xoYlZ4ej8aYXmQ9t4NS3Ck0/TWLT+WHiXppC7pNNtcJ/clIhjeqAL/IphLIW
 8yLWFVYdmyV4lkN30c2xrEmk40yE0jIXcjQpw4lbbe8qweQug7/KeFCEqx5IUOT98I3IfC2Ai
 pLMj7R/jcWL8QjXa70y9hegzAvgSt1Fwj7PIx98leGjH/XBBQ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire gained a warning for randconfig builds without
CONFIG_ACPI during the linux-5.3-rc cycle:

drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]

Add the CONFIG_ACPI dependency at the top level now.

Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soundwire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index f518273cfbe3..c73bfbaa2659 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
+	depends on ACPI
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
-- 
2.20.0

