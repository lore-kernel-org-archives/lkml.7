Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94069C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB77208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724618;
	bh=YDvl3usZPbeemijT9xYfqjTEEq22YEaRdzQX3E+HVKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VHRAER2UileQZTtTSI3fJX23Rm7Z9vUYyCBBW8W0s++HUAGlEcjgTxAx3KchzdTu
	 SIzhV8DjR7Jazf8aLo1RcaMVuuBx2iorSmzQ71SNhGrrpqbL8GS9yNqAimPQlIzW/T
	 UL28dlgBSZQIvGlTfwL98tUYwITVqRJyb5ApDHWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF1MUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1MUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w2oE3fHMwUELpHMjKPZR6ifz6qOBfwvBsOdcYCgH+vA=; b=KXAJLwpiO/FYPrYPiAG1Ok/gF2
        jK6Ba4mrI/mlrD3u5wJQuRIPdrInj4V2HUAoBYqhnbr0aV3L9qdhGhJ9X4K9k2vVnHqYzg/007jJ7
        LcE3HyJWBv5sta6/UA5N4VQa7ia5DBI3VF6v2wo5tXjjAL5dGgcpPhsiwJkGcVW7HGlwi0RWgbWmo
        3p5A93FePPy7M6qTxj9uO6geqcDvJ5tobq5IWRd2xsJg6bEpQDxzBkiEC6/Nx21n3wqgsnxc5wVGz
        9dy2PhE/iTOGsj0PFT87uMvBzz3cHERnqQS1Mq07OsPufPV0Xl9DDnBurOA6afh1K66My/2ISf2dR
        85b3gc/g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009u-4e; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00057K-7L; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/43] docs: lcd-panel-cgram.txt: convert docs to ReST and rename to *.rst
Date:   Fri, 28 Jun 2019 09:20:03 -0300
Message-Id: <7c0f564f55c923be4627d8872db76c65a808b4f0.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
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
index bad1bbb668bc..1606f6cac24d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12000,7 +12000,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
 S:	Odd Fixes
-F:	Documentation/auxdisplay/lcd-panel-cgram.txt
+F:	Documentation/auxdisplay/lcd-panel-cgram.rst
 F:	drivers/auxdisplay/panel.c
 
 PARALLEL PORT SUBSYSTEM
-- 
2.21.0

