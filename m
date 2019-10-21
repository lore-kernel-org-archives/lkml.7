Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22165CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431A218BA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kQ2XDAO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfJUBns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 21:43:48 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53072 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfJUBnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 21:43:47 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 442FD806A8;
        Mon, 21 Oct 2019 14:43:45 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571622225;
        bh=b3bnFzbf3TgftQnfn5vIsLWzOb143SfhFz8wgRbgD1E=;
        h=From:To:Cc:Subject:Date;
        b=kQ2XDAO1JL+wMLGPDEXPOQq2TAG5+7xyxnA9ir2L4XJQ5cEKQxI5U176rTm6Zf3x7
         s9Te9/IdQll6lblS5AYM0EicBLH7EG3CWqXBmsFGry9feWNCb2EolaAMxYLMgOd9vc
         yMgNqbuZKMspl4qukzgP2cYVPn0HWVLTjXOmE+VUWoO008rA5cNAIYaoX3UpVy/1lF
         DGbhfbU7HfVOlDSaR9h2Bf7Pfn7dsTBwvr3PnlElNB2mHjteDD5OzXuLkFoU6fhWvZ
         xHPLjWvP1bZd7GrlhRnVY/e43VdGRUghuBV00KSVhy7/ltbOYaBne7taXmTvt9J1Ht
         J7G72lhsm3u9g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dad0d4b0000>; Mon, 21 Oct 2019 14:43:44 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3388613EED4;
        Mon, 21 Oct 2019 14:43:44 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0E931280059; Mon, 21 Oct 2019 14:43:40 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] docs: ioctl: fix typo
Date:   Mon, 21 Oct 2019 14:43:36 +1300
Message-Id: <20191021014336.14030-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pointres" should be "pointers".

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/ioctl/botching-up-ioctls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ioctl/botching-up-ioctls.rst b/Documentation/i=
octl/botching-up-ioctls.rst
index ac697fef3545..2d4829b2fb09 100644
--- a/Documentation/ioctl/botching-up-ioctls.rst
+++ b/Documentation/ioctl/botching-up-ioctls.rst
@@ -46,7 +46,7 @@ will need to add a 32-bit compat layer:
    conversion or worse, fiddle the raw __u64 through your code since tha=
t
    diminishes the checking tools like sparse can provide. The macro
    u64_to_user_ptr can be used in the kernel to avoid warnings about int=
egers
-   and pointres of different sizes.
+   and pointers of different sizes.
=20
=20
 Basics
--=20
2.23.0

