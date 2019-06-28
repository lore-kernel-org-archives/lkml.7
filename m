Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51923C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5412083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725211;
	bh=KGPFBufHK+iVRAxvURc9WtINrMzL7emIBpHeea1B1zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRBhgWcwAIAkagSr/PS8RW+QhtK/Za+ol3CPxTWTzuvOTGUCmaKJoboRphwOO8Nxl
	 oUd8w9xospRVFELGmvjr+F2NuFdmc+qS3933rSjJxPJj1xFY1khZYuXZ1Tw5M3h6AA
	 h2y5h8jJPS0O6ioURMZMFRJzyOV7vHDavzEMAKrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfF1Md3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:33:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1/1PW44265Nq8v4Tih4ww76VxusuESV32OPSK8TNU+U=; b=iSlB9Lth0FhkKClX+zRHWfmSAb
        MoyB72qsJw5pAmqnQLUAszPeb8/XTsfSJ1LD/aGg6TtnQ4HKut0rruwDGq4KYh2EnVao7YHAE1m+I
        FD1JJx8MdZzByMREQ2d4am/mCvfhhq37zUdPjQJKIJIF36hUy3PDi49fB1oCa9kK83kWRYHEsvWVl
        e15W+4pwkYMXTjA4csdle1LNqgo08bphCmE6uZGwXEe/ez1kE2WKwwx7K0oPTsAEd4ePbyJBnVb9p
        R7FoEmc9+Z6yoU9gFDm1L1RArI4ElkdERxlH8CIWHngB052Lfsoguy2oSmheIsDkbmgjqZjvHW6kz
        AoIjQKNQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-000553-2t; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Rd-5u; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/39] docs: md: move it to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:02 -0300
Message-Id: <0ffaece51561c281d0773e6ebc4e8cc5792c568d.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs there were meant to be read by a Kernel developer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst                | 1 +
 Documentation/{ => driver-api}/md/index.rst       | 2 --
 Documentation/{ => driver-api}/md/md-cluster.rst  | 0
 Documentation/{ => driver-api}/md/raid5-cache.rst | 0
 Documentation/{ => driver-api}/md/raid5-ppl.rst   | 0
 5 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{ => driver-api}/md/index.rst (89%)
 rename Documentation/{ => driver-api}/md/md-cluster.rst (100%)
 rename Documentation/{ => driver-api}/md/raid5-cache.rst (100%)
 rename Documentation/{ => driver-api}/md/raid5-ppl.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 55354eacc8bd..2a0b57f12d1a 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -55,6 +55,7 @@ available subsections can be seen below.
    firmware/index
    pinctl
    gpio/index
+   md/index
    misc_devices
    nfc/index
    dmaengine/index
diff --git a/Documentation/md/index.rst b/Documentation/driver-api/md/index.rst
similarity index 89%
rename from Documentation/md/index.rst
rename to Documentation/driver-api/md/index.rst
index c4db34ed327d..205080891a1a 100644
--- a/Documentation/md/index.rst
+++ b/Documentation/driver-api/md/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ====
 RAID
 ====
diff --git a/Documentation/md/md-cluster.rst b/Documentation/driver-api/md/md-cluster.rst
similarity index 100%
rename from Documentation/md/md-cluster.rst
rename to Documentation/driver-api/md/md-cluster.rst
diff --git a/Documentation/md/raid5-cache.rst b/Documentation/driver-api/md/raid5-cache.rst
similarity index 100%
rename from Documentation/md/raid5-cache.rst
rename to Documentation/driver-api/md/raid5-cache.rst
diff --git a/Documentation/md/raid5-ppl.rst b/Documentation/driver-api/md/raid5-ppl.rst
similarity index 100%
rename from Documentation/md/raid5-ppl.rst
rename to Documentation/driver-api/md/raid5-ppl.rst
-- 
2.21.0

