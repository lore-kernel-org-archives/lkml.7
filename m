Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B95DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072062464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578156045;
	bh=pTT1Ysp8sIl8cwLZHzBaCdsphSEHGJ6MisCXp0UzQ1o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2sWuNQZkg3mWSoWWHpRXjBKLhtcNExNM5N96mOu7+FslM6ibGYkEHAzQplw/52FAV
	 h0tG54D2GNAAzBP0xeXQTlze16wf6dBRJMHyHPbC1UXb5vO2GzzRyrzErVBO/pkEWi
	 pckxtw9RbUQUpdgj/EBnBRkcVoxTjWymx1f/NaUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgADQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:40:44 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53353 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:40:43 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004GeKth005724;
        Sun, 5 Jan 2020 01:40:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004GeKth005724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578156020;
        bh=oC1c+VAvJaUXWGl7gGGVl2DrNEN/0FuZrJGvBX6edRo=;
        h=From:To:Cc:Subject:Date:From;
        b=B5BsW6EiBfMv9/ynm1Oku4aHJOT85PZXFFJYvUC298wRs4ecm/FMMDr3rI9sm8JfP
         wzBW91Q0+iVhbRX7cdiKllfCfBucyC3OeQzeIK3GsD++1LcvLoXF9+QzwiSs9DnMwT
         s0gMfBlOYmPL3Mqmgah2wRvMBi+XnplUGkawbMu8Zgkhk9iwZz93VcbxboJYAY57S8
         T+HbZaT7cmvNsiCe31NTsDxMGaLk4Lpcvz1vw4+j3v8SYWcclaq5b2800SmJMQZpcY
         CeI8YhITc/KbGn1+ijt51PHQjdPu/6/zEslSZr0SVPjDwBCoK5xDSeJQm8Xd+Iz0bk
         6NVcy4EgD4v9Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ide: remove unneeded header include path to drivers/ide
Date:   Sun,  5 Jan 2020 01:40:11 +0900
Message-Id: <20200104164011.22189-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can build drivers/ide/ without this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/ide/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index cac02db4098d..d4f4409cfb8b 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -3,8 +3,6 @@
 # link order is important here
 #
 
-ccflags-y				:= -Idrivers/ide
-
 ide-core-y += ide.o ide-ioctls.o ide-io.o ide-iops.o ide-lib.o ide-probe.o \
 	      ide-taskfile.o ide-pm.o ide-park.o ide-sysfs.o ide-devsets.o \
 	      ide-io-std.o ide-eh.o
-- 
2.17.1

