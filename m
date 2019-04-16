Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA942075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383520;
	bh=3O0QvX+sVfFvltZUmBqCAhvAFhjAa/bsl1FOqy+EsII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2zeL1tbosb4qZkS6QRMYmOGRVin7E/xZz3BHjdSykwkuOOQmWqf5cI3998HaSKbH
	 0D84ilPVVnYPX0ntfdADrfh5fRy3r+9IzuS1k9QivmPMp5za9RkrnmjK1Nd6doK30/
	 OCtk+JrqOjpFQxTMYQKzTKXuNr2RryNfa3MYxlSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfDPC6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DKgZwtOmDahOm+qEVeiOtpMOINYHL80qWiElbnRPUeM=; b=Ab/IkBdCpkiTXO5rDkP5G9eVLK
        MDJ5Mg41rOdxjKI3s6ICFsPcwGpWOhcfTMX4cAJSZLVfYACzSUYf3OKtWEMf4OoJYx20hw7cikrtG
        OKr/B8oZnMIhxzDIh9BL/S+ziyFVryrhfMswoSpd87P90fk4NgiTcCfz9cpJV7lVzVoxC96UGF12N
        3PSlXWwvKkCnb1imlU/Aov40V6DjfiKyk0UCWuH5YtcarSqwvhxvy6VtCwP5Of26RKS+AVPj3SpjZ
        MUe1ALkG3AMRD0K5RVdxk0yRNyYOYEMoneR21ZpyGtOhfn6pNE0MMPOdsfnReJYyzj9GrcfyW5lZN
        iz476G5g==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGv-0007aK-GF; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001pI-3R; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 43/57] docs: lcd-panel-cgram.txt convert it to ReST and move to admin-guide
Date:   Mon, 15 Apr 2019 23:56:08 -0300
Message-Id: <72926ed6d984297dd3f6fe5a5dcfe3c3fae3222d.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small text file describes the usage of parallel port LCD
displays from userspace PoV. So, a good candidate for the
admin guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/auxdisplay/lcd-panel-cgram.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/auxdisplay/lcd-panel-cgram.txt b/Documentation/auxdisplay/lcd-panel-cgram.txt
index 7f82c905763d..a3eb00c62f53 100644
--- a/Documentation/auxdisplay/lcd-panel-cgram.txt
+++ b/Documentation/auxdisplay/lcd-panel-cgram.txt
@@ -1,3 +1,7 @@
+======================================
+Parallel port LCD/Keypad Panel support
+======================================
+
 Some LCDs allow you to define up to 8 characters, mapped to ASCII
 characters 0 to 7. The escape code to define a new character is
 '\e[LG' followed by one digit from 0 to 7, representing the character
@@ -7,7 +11,7 @@ illuminated pixel with LSB on the right. Lines are numbered from the
 top of the character to the bottom. On a 5x7 matrix, only the 5 lower
 bits of the 7 first bytes are used for each character. If the string
 is incomplete, only complete lines will be redefined. Here are some
-examples :
+examples::
 
   printf "\e[LG0010101050D1F0C04;"  => 0 = [enter]
   printf "\e[LG1040E1F0000000000;"  => 1 = [up]
@@ -21,4 +25,3 @@ examples :
   printf "\e[LG00002061E1E060200;"  => small speaker
 
 Willy
-
-- 
2.20.1

