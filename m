Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC62C31E60
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EB4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891265;
	bh=RXI0I3RiBJvUIeMwuh1gFuo3S8O6r456MdzTC6Obw4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAuDvaEBF507SYfvK2QJ6VggzpB5xkEOcr3qIYDNCwLSh/v0LLuq0MLuoIxXIHWSv
	 8rWtybTOrNtcDLwhFzO1EdHdTZnSdAMAT0xCgn0X4uEQSiLG1HaL3MHiVXvuQ4KX1u
	 Rpvsl9QPEN4hfvcy3qcPzUs9ZqX4YY80a3GryC84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfFRUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbfFRUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A2e3twB+4rjm1JBun22GZTEDrNTolWfsSR8lN10YJY4=; b=bwzyDOc54aiEVEOy69k9oibYI1
        L+Alwk3UnqYyKSfQI9eRWSHYm6rA8FLb3PMpqrM0mpO8OM6AmWW7SD2nkXHdR3C/qPjjbYEewaHGJ
        K9qFOvr78PkdoJYhNAoWaazk/wt+HaicYxPSeBCiDck4XlfbeRA9RPJ3+0c+y7ldMQcq8yPcMeyDk
        kXp/Us4FZFUs4spBBnPSQ0Aqa6L+4VQHXcwmoKyidc9Kz9WAE5115Bddw89mQVMTjMVMa5LFEEo0A
        ysBcwNilvCqYyLLybSbwDbxGT2odokivRx1D5biHhz41Ko0nO44EpXbdeBF94yODn4Ubwzc9z45/u
        GATOTfEw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008Rb-Ak; Tue, 18 Jun 2019 20:53:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL6z-0001yy-LD; Tue, 18 Jun 2019 17:53:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 02/29] docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
Date:   Tue, 18 Jun 2019 17:53:20 -0300
Message-Id: <3da3e0379da562d703e6896ded6a7839d1272494.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small text file describes the usage of parallel port LCD
displays from userspace PoV. So, a good candidate for the
admin guide.

While this is not part of the admin-guide book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{lcd-panel-cgram.txt => lcd-panel-cgram.rst}         | 9 +++++++--
 MAINTAINERS                                              | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)
 rename Documentation/auxdisplay/{lcd-panel-cgram.txt => lcd-panel-cgram.rst} (88%)

diff --git a/Documentation/auxdisplay/lcd-panel-cgram.txt b/Documentation/auxdisplay/lcd-panel-cgram.rst
similarity index 88%
rename from Documentation/auxdisplay/lcd-panel-cgram.txt
rename to Documentation/auxdisplay/lcd-panel-cgram.rst
index 7f82c905763d..dfef50286018 100644
--- a/Documentation/auxdisplay/lcd-panel-cgram.txt
+++ b/Documentation/auxdisplay/lcd-panel-cgram.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+======================================
+Parallel port LCD/Keypad Panel support
+======================================
+
 Some LCDs allow you to define up to 8 characters, mapped to ASCII
 characters 0 to 7. The escape code to define a new character is
 '\e[LG' followed by one digit from 0 to 7, representing the character
@@ -7,7 +13,7 @@ illuminated pixel with LSB on the right. Lines are numbered from the
 top of the character to the bottom. On a 5x7 matrix, only the 5 lower
 bits of the 7 first bytes are used for each character. If the string
 is incomplete, only complete lines will be redefined. Here are some
-examples :
+examples::
 
   printf "\e[LG0010101050D1F0C04;"  => 0 = [enter]
   printf "\e[LG1040E1F0000000000;"  => 1 = [up]
@@ -21,4 +27,3 @@ examples :
   printf "\e[LG00002061E1E060200;"  => small speaker
 
 Willy
-
diff --git a/MAINTAINERS b/MAINTAINERS
index e20a1762ec0b..d64d8bb46323 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11935,7 +11935,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
 S:	Odd Fixes
-F:	Documentation/auxdisplay/lcd-panel-cgram.txt
+F:	Documentation/auxdisplay/lcd-panel-cgram.rst
 F:	drivers/auxdisplay/panel.c
 
 PARALLEL PORT SUBSYSTEM
-- 
2.21.0

