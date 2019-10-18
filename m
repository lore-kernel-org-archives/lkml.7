Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E07CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72AA21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409125AbfJRQC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:02:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:36802 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408951AbfJRQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:02:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AC26C2CA;
        Fri, 18 Oct 2019 16:02:57 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:02:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] Docs: mark admin-guide/iostats.rst as needing updates
Message-ID: <20191018100256.75bb5c60@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file tells us all about how 2.4 reported I/O statistics, which is less
than fully useful.  Put a note at the top advising of this fact and
requesting some kind soul to bring things up to date.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---

I'm thinking about beginning to sprinkle these around Documentation/ in
the hope that they inspire helpful people to improve the situation.  It
works (I think?) for wikipedia, maybe we should give it a try...

 Documentation/admin-guide/iostats.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 5d63b18bd6d1..2d1b1c15fd91 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -2,6 +2,11 @@
 I/O statistics fields
 =====================
 
+.. note::
+
+   This document contains a great deal of outdated information; please
+   consider helping out by updating it to match current reality.
+
 Since 2.4.20 (and some versions before, with patches), and 2.5.45,
 more extensive disk statistics have been introduced to help measure disk
 activity. Tools such as ``sar`` and ``iostat`` typically interpret these and do
-- 
2.21.0

