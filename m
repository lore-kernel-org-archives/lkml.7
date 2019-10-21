Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653B3207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 00:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0CwFBqQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJUAim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 20:38:42 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52934 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJUAil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:38:41 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 51A95886BF;
        Mon, 21 Oct 2019 13:38:37 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571618317;
        bh=PahlvPU4REMhlX5lmJjml5c4g5+Iwgma6zY8XQrsVxo=;
        h=From:To:Cc:Subject:Date;
        b=0CwFBqQqmpEQ9b5RLiP3nZW95E+SxNmK9fpDEeTpZekUP+Gcejrmt5PlRSkNpUCPH
         fTwcGqRRO6W3iUWVMpjnZ8ri5ZkN4PWRzUkeTkYN/EW92ErE7isBue008XYs23xNnN
         bCdyXbAzFzA/Vx4QALcYYD+ITeJQ+B+wjFc6AubYyxOXaBXYZ/b5kVnPcUX/FBEzou
         3jb4tfvOeFt/HS3g0817XplXNPlv3IzYyIwTVSrS4depDhAp82K1Mkf1ONEIL2h+fB
         8BzBk23kTCYLvVbJrg14fuySdKcJ68sDvRiSEBw5dNcv2D7FiKqX35eB8jntTzB/G0
         563ke6zIQgeYg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dacfe0c0000>; Mon, 21 Oct 2019 13:38:36 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3760713EED4;
        Mon, 21 Oct 2019 13:38:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1554C280059; Mon, 21 Oct 2019 13:38:37 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] docs/core-api: memory-allocation: fix typo
Date:   Mon, 21 Oct 2019 13:38:32 +1300
Message-Id: <20191021003833.15704-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"on the safe size" should be "on the safe side".

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/core-api/memory-allocation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation=
/core-api/memory-allocation.rst
index 7744aa3bf2e0..e59779aa7615 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -88,7 +88,7 @@ Selecting memory allocator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 The most straightforward way to allocate memory is to use a function
-from the :c:func:`kmalloc` family. And, to be on the safe size it's
+from the :c:func:`kmalloc` family. And, to be on the safe side it's
 best to use routines that set memory to zero, like
 :c:func:`kzalloc`. If you need to allocate memory for an array, there
 are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
--=20
2.23.0

