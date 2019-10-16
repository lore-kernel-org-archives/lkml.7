Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49CFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0DC218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571250208;
	bh=qOn8waA+zgEWubBBsdrdFJVWywhr2NIlx75oglvQnc4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u9vWX0PkEv5EgyI8YSjCBtOmtepzpAMIWu3DUvtDhjkfqkNtfDiIq7rZNhdcW6kn7
	 +1W59DWm+53x08TP7b1Hct1umQ2RDygSEZLEtjAGAFm+v1H8mOfIlJxKySOBMXdWmw
	 bLrXy4mlhXdmHgPtnUuUPcBQjZJivBMlwKJX9gFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbfJPSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:23:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJPSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:23:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so15257274pfw.2;
        Wed, 16 Oct 2019 11:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+VfwqglWVpaFadCaIJr0D3t4hhVVL9W1U7Pka0rge0=;
        b=Et/N9Pj4J1Yx653ej6HZksTCPldOrjDf+rpkvi/nNT9aRHCYQHqcp/vu/WfmL6QxIQ
         wZfzUHYDUczTrDS59++nI/D9dHSFY5LE89Nd+t+Z5lVvRI9AK+Do6w53iRCi01uYVrKH
         k3Q9Js/+jVJFwopdsBkGUsXPGAeuJJToiKxNSMnwtge8uVbQXsUwS5832LWcfj0ZpepI
         JUM6wXWUwLcL/doG9uH1nQZoosyY7WTtWPyWzr+nHcIjpXjNuciwBfEMEHwvTx6c2qza
         Z/QfqYcaNrnFB/chSbuCG4HU32UoSFEL4MX+GcaBZ+SQ8B7uwat/BHxmnW20MxgKdWy3
         AMEA==
X-Gm-Message-State: APjAAAXXLUHuFj/1fESVH+HF1xiILm0GBtIM/fY3PV5SlaggH/d46Ajp
        7hXqmlu2uTCmwHBdceyS5elrvIKHXy9h6Q==
X-Google-Smtp-Source: APXvYqzk9l4j6SRRWV2mYSvjDpLyhvRTK5UWHrs3+KnUWj0EbROGGuciNTpr4U0uAIA2EIbeVGtPwA==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr9146920pgg.242.1571250204986;
        Wed, 16 Oct 2019 11:23:24 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id 193sm26291834pfc.59.2019.10.16.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 11:23:24 -0700 (PDT)
From:   Paul Burton <paulburton@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Paul Burton <paulburton@kernel.org>
Subject: [PATCH] MAINTAINERS: Use @kernel.org address for Paul Burton
Date:   Wed, 16 Oct 2019 11:23:16 -0700
Message-Id: <20191016182316.535398-1-paulburton@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

Switch to using my paulburton@kernel.org email address in order to avoid
subject mangling that's being imposed on my previous address.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
---
 .mailmap    |  3 ++-
 MAINTAINERS | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index edcac87e76c8..10b27ecb61c0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -196,7 +196,8 @@ Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
 Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
-Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..6c4dc607074a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3096,7 +3096,7 @@ S:	Supported
 F:	arch/arm64/net/
 
 BPF JIT for MIPS (32-BIT AND 64-BIT)
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
@@ -8001,7 +8001,7 @@ S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
 IMGTEC ASCII LCD DRIVER
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
 F:	drivers/auxdisplay/img-ascii-lcd.c
@@ -10828,7 +10828,7 @@ F:	drivers/usb/image/microtek.*
 
 MIPS
 M:	Ralf Baechle <ralf@linux-mips.org>
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 M:	James Hogan <jhogan@kernel.org>
 L:	linux-mips@vger.kernel.org
 W:	http://www.linux-mips.org/
@@ -10842,7 +10842,7 @@ F:	arch/mips/
 F:	drivers/platform/mips/
 
 MIPS BOSTON DEVELOPMENT BOARD
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
@@ -10852,7 +10852,7 @@ F:	drivers/clk/imgtec/clk-boston.c
 F:	include/dt-bindings/clock/boston-clock.h
 
 MIPS GENERIC PLATFORM
-M:	Paul Burton <paul.burton@mips.com>
+M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
-- 
2.23.0

