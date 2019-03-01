Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="QPadmG25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfCAD7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:59:49 -0500
Received: from mail.nic.cz ([217.31.204.67]:53122 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfCAD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:59:19 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 90E66634E4;
        Fri,  1 Mar 2019 04:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551412756; bh=HMWCZNg1pA+ShkG/SVbAu3uYNZ0SC9KpCw9eGEjTR+o=;
        h=From:To:Date;
        b=QPadmG25Nf+OYpsvhKBU3Flc0qLTN2Nw2+0aWv5dvvgEUED0JxkCXUUL+PfRLrMJT
         II34e83iUpx20E6kVfpCb5r/MbHOm0Hr3FimMNkQRsRmlEwK3+3hH0SiDXyK1ThHOY
         BvXQ/9j8fcOl//QWvqfiyS9YP6Kz1vZXDpZAUE3c=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 bus+gpio 3/5] bus: moxtet: Add sysfs documentation
Date:   Fri,  1 Mar 2019 04:58:50 +0100
Message-Id: <20190301035852.26780-4-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301035852.26780-1-marek.behun@nic.cz>
References: <20190301035852.26780-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs ABI documentation for the attribute files module_id,
module_name, input_value and output_value of Moxtet devices.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 .../ABI/testing/sysfs-bus-moxtet-devices      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-moxtet-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-moxtet-devices b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
new file mode 100644
index 000000000000..80bae358a90c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-moxtet-devices
@@ -0,0 +1,25 @@
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_id
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Moxtet module ID. Format: %x
+
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/module_name
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Moxtet module name. Format: string
+
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/input_value
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(R) Read input value from module at this Moxtet address.
+		Format: %x
+
+What:		/sys/bus/moxtet/devices/moxtet-<name>.<addr>/output_value
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Marek Behún <marek.behun@nic.cz>
+Description:	(RW) Read last written value or write value to the module on
+		this Moxtet address. Format: %x
-- 
2.19.2

