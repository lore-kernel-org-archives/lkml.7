Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D5C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A333B24650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578150203;
	bh=fUsYRRJnL+vBR/iTDS5tGHHgO5+pC1xmHCTBxBe+1b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwCN9VJhd4z2BXwrsCxJKHKfiZ/pazQ9ZoZK19GOXFuL0n1b0+M0yWKlXLq4U02hM
	 0HI1sgIUJGMfeiAMc8oyb8Qs6qo4aU8k3+MXHQIhLwVfjQtzfONbohSXr1+lKZPwm6
	 bLyY0st0un8UVdkzpz5fDbdqzm0N9HvuEFss0rZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgADPDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:03:22 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53555 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:03:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004F2gcT018492;
        Sun, 5 Jan 2020 00:02:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004F2gcT018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578150165;
        bh=zUVXeIJTFh9cAI4ZnqdgT2rf+tWF/1NubRKRJEqQ8Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAyxLQ4/E572t2vCiQaRi2R2U2etpr+ZmpTWNAjOFGt2MBPHtOxYvL0HyWveKyqqI
         BlLc/KPzbaeOihMRogi4t/fTJg6tv+PBUylrDGJtVSFSM+khAarrENp7etVvIXsVNP
         8CtGKwwiTN5m/mUUl2KxWaY8/froJmdSSiZo98QdKInhCOVhHF62pPGQdQhFNXiRF/
         CxCaTEo8DCDvLa+3DXYezg0NhSfgwJIZVU+Wvdk2oqJ6nesx15EkzdoZfLWmyrEvKQ
         NW9xNYERMA/HKt+LVu8UM2jTLGVJA4uNIkW6y7JifD6Ydvf/x1CCOe9GuwkG5CKdVe
         rtmgzaqjqyhEA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] gen_initramfs_list.sh: fix the tool name in the comment
Date:   Sun,  5 Jan 2020 00:02:28 +0900
Message-Id: <20200104150238.19834-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104150238.19834-1-masahiroy@kernel.org>
References: <20200104150238.19834-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no tool named "gen_initramfs". The correct name is
"gen_init_cpio".

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 usr/gen_initramfs_list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
index 909a7b865aa7..1fd93414fb37 100755
--- a/usr/gen_initramfs_list.sh
+++ b/usr/gen_initramfs_list.sh
@@ -189,7 +189,7 @@ dir_filelist() {
 
 # if only one file is specified and it is .cpio file then use it direct as fs
 # if a directory is specified then add all files in given direcotry to fs
-# if a regular file is specified assume it is in gen_initramfs format
+# if a regular file is specified assume it is in gen_init_cpio format
 input_file() {
 	source="$1"
 	if [ -f "$1" ]; then
-- 
2.17.1

