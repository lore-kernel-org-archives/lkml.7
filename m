Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB141C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68152084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfDBOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:23:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfDBOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:23:04 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.84]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUXd0-1hK1Uw3S8O-00QP7r; Tue, 02 Apr 2019 16:22:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 2/3] Documentation: pwm-fan: Add description for RPM support
Date:   Tue,  2 Apr 2019 16:21:49 +0200
Message-Id: <1554214910-29925-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:sW79vU0wqdEQ18pGVxWJjoGC9YpoDTcqaW1ETqYXlKp3U1zGahB
 HxgNcz9aH5EDwV70pNcg7vFo+BAgpO2MJerJdAzUSV2k+OD3Pd5WkwYir0P/oumrS6cMOvm
 LQUD8hHpslqSfVVlbDgNznumPL8wCJitqor1Yj9OeZycotwEFbmmh2eJ+HSSWBnL4mNCRQU
 dDFmTHFZCiUzofUeHNZhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jEJ+CZrIMRo=:Cj2whXIIO5n7sfq+ZiaUDb
 Qd9mg8G+3DQWmg9yfEeN7VpX23kqJ4uIBD4FGUMFY6q2+D8Kqe3zb3vgmGKTdWA+NI1SD+mFJ
 Kn/qrTRUBjaKfoG5rJPq6ykWVymTX6RRFWt25lMqy7fH3T6YuRroRbPYupSjpc95bcWOW2LP/
 aSKwyUAcEZvFBKVmlDD/q64Ikr9rHxofyp6kiQmo47BU1I9o58NnYe4piWkbuXB4NdgsMKEH5
 rgAuvfGjmc2TT8Ztj3+0qU/d2vVU574Pkuz0QKQLpWp1i0QnJpFHNYn0dhPINh4a64KASuQQh
 q7P9uEvvh/r79MsxVK7BnWH+AQLzHeZaNdrBS0rORsMDqOHZT5HNUycUjer4KnJI4S98+N8pg
 LwMnzVBo8hvpHXlyQiz5L+nTeqJzyv7u79XRpqQkxsnBfIxeiBhUlSJPxuDGdK2oEYh+S4Gr3
 0zH8O78a4Ox+3/oZdxiXr3YyO1lOzFO9DOUL+qKO0iuo8Fn4IWCWiK3LGTxozZS6169Wj1Dws
 ubkBqVfgMEkC14s04haMUF8G9211efB/kW1R+sfxlDS2WKvHJ/8udAQ8dgDy8Md8XKUAao8Ia
 QI+ErzEC8OxJARaMb7nbyd+mwJXJzIqsQ9i2EEKek28l3FQfo/aFaOHJ2VJXSqO9byOPD+rqn
 EHP30stPibKFOH0lMm+UMER0638a8OLFh/DnS37eqBzzewL0AavGfnkTSWb8nDrqn+KGUvjSy
 SDXvF+T9ngXmx+pYsRpjCjtkAz+noW54ZxYg5Jifc/DBACPyyaN1DIMvylQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a short description for the new RPM support of the pwm-fan
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/hwmon/pwm-fan | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/pwm-fan b/Documentation/hwmon/pwm-fan
index 18529d2..82fe967 100644
--- a/Documentation/hwmon/pwm-fan
+++ b/Documentation/hwmon/pwm-fan
@@ -15,3 +15,6 @@ The driver implements a simple interface for driving a fan connected to
 a PWM output. It uses the generic PWM interface, thus it can be used with
 a range of SoCs. The driver exposes the fan to the user space through
 the hwmon's sysfs interface.
+
+The fan rotation speed returned via the optional 'fan1_input' is extrapolated
+from the sampled interrupts from the tachometer signal within 1 second.
-- 
2.7.4

