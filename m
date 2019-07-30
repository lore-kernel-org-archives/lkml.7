Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFFE20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfG3KKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:10:12 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:44712
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbfG3KKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:10:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BcBwDsFkBd/1/rO8tmHgEfBgeBTgK?=
 =?us-ascii?q?DUwwVEhcTjRqIHQGCQwGJLJEbCQEBAQEBAQEBARscAQGEOgQCAoJkNwYOAQM?=
 =?us-ascii?q?BAQEEAQEBAQUBbYRlRYVLBlYzPxJXBxKDIoF3E64KhAYBhHKBSIE0hwmEboF?=
 =?us-ascii?q?AP4ERg1CEAwobhV0iBJU6lUMJgSV3lBgZmBEtizeBWZloIoFYTR8ZgyeQT0Q?=
 =?us-ascii?q?1MIt0glIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BcBwDsFkBd/1/rO8tmHgEfBgeBTgKDUwwVEhcTjRqIH?=
 =?us-ascii?q?QGCQwGJLJEbCQEBAQEBAQEBARscAQGEOgQCAoJkNwYOAQMBAQEEAQEBAQUBb?=
 =?us-ascii?q?YRlRYVLBlYzPxJXBxKDIoF3E64KhAYBhHKBSIE0hwmEboFAP4ERg1CEAwobh?=
 =?us-ascii?q?V0iBJU6lUMJgSV3lBgZmBEtizeBWZloIoFYTR8ZgyeQT0Q1MIt0glIBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,326,1559491200"; 
   d="scan'208";a="229598849"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 30 Jul 2019 18:10:06 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2 1/2] dt-binding docs: sbs_sbs-battery: Addition of force_load binding
Date:   Tue, 30 Jul 2019 18:10:03 +0800
Message-Id: <1564481404-39505-2-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
References: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for addition of force_load boolean value
to allow loading a battery during boot even if notpresent at that time.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---
 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index 4e78e51..187d7bb 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -15,7 +15,8 @@ Optional properties :
    after an external change notification.
  - sbs,battery-detect-gpios : The gpio which signals battery detection and
    a flag specifying its polarity.
-
+ - sbs,force-load : Allow loading of a hot-pluggable battery when there is no
+   GPIO detect available and the module is statically built.
 Example:
 
 	battery@b {
@@ -24,4 +25,5 @@ Example:
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
+		sbs,force-load;
 	}
-- 
1.8.3.1

