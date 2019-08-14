Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ADC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5178206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfHNNYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:24:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:15870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfHNNY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:24:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 06:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="194533760"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 06:24:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: usb: fusb302: Remove deprecated properties
Date:   Wed, 14 Aug 2019 16:24:18 +0300
Message-Id: <20190814132419.39759-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no platforms using them anymore.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/devicetree/bindings/usb/fcs,fusb302.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
index a5d011d2efc8..ba2e32d500c0 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
+++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
@@ -11,13 +11,6 @@ Required sub-node:
 
 	Documentation/devicetree/bindings/connector/usb-connector.txt
 
-Deprecated properties :
-- fcs,max-sink-microvolt : Maximum sink voltage accepted by port controller
-- fcs,max-sink-microamp : Maximum sink current accepted by port controller
-- fcs,max-sink-microwatt : Maximum sink power accepted by port controller
-- fcs,operating-sink-microwatt : Minimum amount of power accepted from a sink
-  when negotiating
-
 
 Example:
 
-- 
2.20.1

