Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B8CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C62070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lhingX92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437783AbfJXTuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:25 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59728 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437417AbfJXTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:23 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A28A2891A9;
        Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571946618;
        bh=VSn85/7k8/1qpDTEDUSwZG+Mt4ol1M32rsW2dGdsfGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lhingX92ujVW457xzi4BTnt/34uJJt5jtLDFqc4hJdpTvahPshJYRkQvoDpmNfIbZ
         VS5vfwzXR+ct4Bt5QKcF5u0ZxBTwWTXnXCmrxkD8WADneRDlDW4+/VvIOabjruvjuF
         IIydGpmxJdGgmv4ZuqsdGtXBQRbF02hFmA2JI6nP1h7MtqxO00LumGJgQm/LWfwY3c
         SvAIpLWBeOsAizSd/K5oKYuTAQRvl6xXAeMTY4tsxKpZG6bLGtHLahP5atgVkXgLv4
         OPyz5i2FvMMXUzL2CA3/+9iT88et26q2yPzjZK4B0o9camdXg6GveXyYqf/fpsF7ge
         sT7Er3msdi+jA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db200790001>; Fri, 25 Oct 2019 08:50:17 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id A4DC413EEFC;
        Fri, 25 Oct 2019 08:50:22 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7112128005C; Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, rppt@linux.ibm.com, willy@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/3] docs/core-api: memory-allocation: fix typo
Date:   Fri, 25 Oct 2019 08:50:14 +1300
Message-Id: <20191024195016.11054-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
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
index 939e3dfc86e9..dcf851b4520f 100644
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

