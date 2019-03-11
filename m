Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965DE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfCKNZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ma1wY-1hWx2b0Ig0-00Vygx for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 072/114] drivers: macintosh: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:24 +0100
Message-Id: <1552310346-7629-73-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:LVdFh4KnuAGCEi09F2EjzRV3InIwhqv6JEwKRFfQdhh0uA4uHOp
 wmZdEKK2JUFyGbDF8+yFGcLsqZY66dKvMiskl0j85bO5iuedvMN6YMXW2QQSAaIu7bqwmVY
 QcjBtypo0Z9lnPKegcCgbh0u6meA7O19H8u6qW4fhDksrsMJEj810P/SyEAdTQgBT0dWtQd
 5ruNzW+ityv9+N+PsdRqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkdE0oZowzY=:kSKd98n5U+G9BlsfFt/GZ3
 VeKdoeIZGA5UKNk+0REpmjYcTpKU/AgOZrXlaIZYob3n9rfDhJwKI/yBVOtYiR6SHsKjWBpQF
 ScA8NQ/eA0K7CdslKir9og9BQlXHOd8tnBw2/U6w99p+RnyQoyJXFhF6SBjtfzNNWrMKlGnni
 lb9GrcrGr+7fOWNWC1zOwBxqi2Bw9gt/UjB5AmoQjdi7CccFra8ApORtfkEM2X0ZK3LXAtAoR
 OJ5DDjZsJ/IBADxpD7qpU3V0BTuhWDTO4B/qKLQNTz6czJHHdwRBgGfpjNu2MIdVjXyTm1OAr
 gA5qY3ViudV66lz/AlomhxSxLTgQn1BVFRI7sTjzTMGfXflzXyD1SRmqzP8Bn46JV/dYP0gtp
 BeAuESVgHj6NujRDiVMc2JJ/VC7giKd4/bjPd+to2mz7oyGp+VmDqoMNz7srKQBnCKApGCpOR
 5v+BBZ91JzVRHmHT+tE1vcdNUATykauhd/8qVl3KQWId3Mw74kIjqEzufMifTjm2P2i47+rtd
 Bt2XaTF5+fydsSxrJVBgYXQ9Ixoiw/rLe1oQ8BRFSWDhOda/F+MeRgWP6moSFY2H6ugb9y1Pb
 B0+vV3ehR68r8C+7d0aCmAMxv+GeWxvjCFxO8ZCOc3Nf1nWJMMcESW4tTGNVW1/nOi6seC6BU
 76BqqgxmAVUnUUi8ExokK6ycXXdjsHH3j355+OAi2+ojVF+YU/dnZuMdhfHNMBMnjB8Eh1mYJ
 15TOmCeeQ+WnzBXq8hlsg7/cpEAu56izBRFFRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/macintosh/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 47c350c..c5baaaf 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -177,7 +177,7 @@ config THERM_ADT746X
 	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
 	help
 	  This driver provides some thermostat and fan control for the
-          iBook G4, and the ATI based aluminium PowerBooks, allowing slightly
+	  iBook G4, and the ATI based aluminium PowerBooks, allowing slightly
 	  better fan behaviour by default, and some manual control.
 
 config WINDFARM
@@ -213,7 +213,7 @@ config WINDFARM_PM91
 	select I2C_POWERMAC
 	help
 	  This driver provides thermal control for the PowerMac9,1
-          which is the recent (SMU based) single CPU desktop G5
+	  which is the recent (SMU based) single CPU desktop G5
 
 config WINDFARM_PM112
 	tristate "Support for thermal management on PowerMac11,2"
@@ -241,7 +241,7 @@ config PMAC_RACKMETER
 	depends on PPC_PMAC
 	help
 	  This driver provides some support to control the front panel
-          blue LEDs "vu-meter" of the XServer macs.
+	  blue LEDs "vu-meter" of the XServer macs.
 
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
-- 
1.9.1

