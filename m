Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38840C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564604881;
	bh=rih8/I9Ea0NXdvuz8DE+q+wh5LNmibVIe1UzP5hmkMI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FHSE/Au8sfoKM4ZyXoT3+84xOSbb0GasANcWT6UkCVtlG3oswDi3hpabbX/ytbf7r
	 b0vLtvVUp529jeUqQ72Zj99C52PLlVrEVwq+qnHNJTMdmKT8l9Bz44R0I1A72lhq/0
	 RvlqFvltK8Zso/AO0HgA3gsUqo1j3kCFhy5yvG8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfGaU17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:27:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfGaU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IRFd+PlshrvLln782PL1UztPzCE0DOFBWjyl1WcrdMY=; b=CRV1fPLzPlmMc8T74PQLDEjIQ
        iLp0Qk3Kn0HOl0ucLNFdVEU02l801EWYr4Nv+Y5R7P7XJjXPw1zlYHTR5sZIZFtVPlrIhXMMhcKKy
        JPryHPJvtNszOnjNuCbHZEiXIqdkP1nAP7BxGBt/49YpyTAND27s3QG+0UNOUBcEjZgxSBhpxUjgI
        llEqmspGu+z0ymdqf/kp/UXYRABbxryWwRzRPlXITa1y2otj5K+qcsPvDEzqsjn9akLlyVeV+uLHY
        6sGGBWrggSkU1jj5+xM64Can2839jez0e0u9KsYj+RuasBoFU8V0AiUj7JV+A+nAjqXQqccF7HeJI
        3TUjsVMLA==;
Received: from [191.33.152.89] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsvCZ-0002PZ-2Z; Wed, 31 Jul 2019 20:27:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hsvCW-0008Be-UY; Wed, 31 Jul 2019 17:27:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: fs: porting.rst: fix a broken reference to another doc
Date:   Wed, 31 Jul 2019 17:27:56 -0300
Message-Id: <13a84a30d8d0b578987f6b3f214697c9a811c2b9.1564604869.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all those document shifts, references to documents get
broken.

Fix one such occurrence at porting.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/filesystems/porting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 66aa521e6376..f18506083ced 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -158,7 +158,7 @@ Callers of notify_change() need ->i_mutex now.
 New super_block field ``struct export_operations *s_export_op`` for
 explicit support for exporting, e.g. via NFS.  The structure is fully
 documented at its declaration in include/linux/fs.h, and in
-Documentation/filesystems/nfs/Exporting.
+Documentation/filesystems/nfs/exporting.rst.
 
 Briefly it allows for the definition of decode_fh and encode_fh operations
 to encode and decode filehandles, and allows the filesystem to use
-- 
2.21.0

