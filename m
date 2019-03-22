Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33FF21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCVIZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:25:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:25:32 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.35.112]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1My6xz-1gn55a0fc7-00zVTt; Fri, 22 Mar 2019 09:24:25 +0100
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
Subject: [PATCH V3 2/3] Documentation: pwm-fan: Add description for RPM support
Date:   Fri, 22 Mar 2019 09:24:02 +0100
Message-Id: <1553243043-19486-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:6uCJsKlrlqxnxJLgaVQ6cNoIxg68wTh8301VaiB3BiHDOyif4Xj
 bO7XxX9HK/DqNaO+1BdJ5obWvzMtP8+a3/mRtXXPiSxddvqEWnUvvXrtiYW56KcCi0AGwNy
 uSy9RAyAesomZZU++6g7QPgsMnZ/U264yGdhdyFjGG6caTBK6SioQ63/i7Y+xb+TdYvCyTg
 7mVqgKYyEyfyGbJ2jvR6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IjAhlSo600=:Kw5uu8QusJt5CTLCSqVOeY
 dV1liEaHmXA305ljBb7ZTrkGYbYJsZGos3TPRgrH5s+sKQlbF/yOGy6TxbK4f+WYuKRSNlyPB
 MfJ3lNoNAhldRDTD+OHpt8934M0EcA6v3LJQIEg/kKGzyrrs6LJBmxD777HlEGYc2gwvdXGr6
 GkfPtoaxBtdS5roxpr3gVSwFUDBXAXA6k4GvI+Fdo0mUgAC+7dA6MgFjtSVkp6e6iedlEXEim
 ZcOCJKFMc+skuBs3Yq/Q7c7P9lwnlKrIpQBprm6Py9+JgpLn1vbcxEYLMUVWFvlrBP6qtpB1j
 +56XUuyzHps1yCXNvaaOfKby9j4m5YFScYoBJUlYYcktRtqz7VWaq1BbcPe51/rZITxZZwYPC
 JmNGHUvBLh69BSPEvACwYABnjnpZYTTpE6KO9C3XhAO/EbRNYmHRYK0WL0ef0/3VB2Xgyyyhw
 p23IG/vZddWsOykDroXUhmqnXU8B+oLO43udxUiQ8JL/T/R4En8cWY9zw+Q5aaH51MC12e4+8
 gAirq4yX/oqgMkqvdj6cmlUE/NI/0dUqmZBXJ6kgomxP3/NQe2i3R4HVHrOsnuZeS2ATlS9Xi
 URHCL3B2X4cXbh/yIANkoypjodd2dhAfDa+2kNnYk15dYJ3LMiUNPmbMWO3qw+eHt8V/BprWt
 woIYOw+HEJcIoIUYI8IK23z6O5c2kMY7vk4zFjG33+a6wfm3SMzWtab/RQMlHKSg0rOFaL04D
 h5lhllFRNJCQQFyCHfuabdGj6ac4HrNuef1aFNQa5TMCsfS5rT40s6ya6Ck=
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

