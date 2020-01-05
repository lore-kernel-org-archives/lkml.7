Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E5C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9AB21734
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgAEWuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:50:35 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52098 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbgAEWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:50:34 -0500
Received: from [37.160.42.38] (port=5507 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ioEj9-00GSqI-5V; Sun, 05 Jan 2020 23:50:31 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/26] docs: i2c: summary: extend introduction
Date:   Sun,  5 Jan 2020 23:49:48 +0100
Message-Id: <20200105225012.11701-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - state the "official" name (I²C, not I2C, according to the spec) at
   the beginning but keep using the more practical I2C elsewhere
 - mention some known different names
 - add link to the specification document

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/summary.rst | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index 3a24eac17375..b7d3e620155b 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -2,12 +2,18 @@
 I2C and SMBus
 =============
 
-I2C (pronounce: I squared C) is a protocol developed by Philips. It is a
-slow two-wire protocol (variable speed, up to 400 kHz), with a high speed
-extension (3.4 MHz).  It provides an inexpensive bus for connecting many
-types of devices with infrequent or low bandwidth communications needs.
-I2C is widely used with embedded systems.  Some systems use variants that
-don't meet branding requirements, and so are not advertised as being I2C.
+I²C (pronounce: I squared C and written I2C in the kernel documentation) is
+a protocol developed by Philips. It is a slow two-wire protocol (variable
+speed, up to 400 kHz), with a high speed extension (3.4 MHz).  It provides
+an inexpensive bus for connecting many types of devices with infrequent or
+low bandwidth communications needs.  I2C is widely used with embedded
+systems.  Some systems use variants that don't meet branding requirements,
+and so are not advertised as being I2C but with different names, e.g. TWI
+(Two Wire Interface), IIC.
+
+The official I2C specification is the `"I2C-bus specification and user
+manual" (UM10204) <https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_
+published by NXP Semiconductors.
 
 SMBus (System Management Bus) is based on the I2C protocol, and is mostly
 a subset of I2C protocols and signaling.  Many I2C devices will work on an
-- 
2.24.1

