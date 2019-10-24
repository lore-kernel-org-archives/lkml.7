Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C394CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037852070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bEF2VBnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437919AbfJXTuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:32 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59745 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437545AbfJXTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:23 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8116A891AC;
        Fri, 25 Oct 2019 08:50:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571946622;
        bh=ThiNpTXHoycHPLCDbXolfJgvcU9M5rnzh6PH45SgY74=;
        h=From:To:Cc:Subject:Date;
        b=bEF2VBnxH3bvcE4sA9EW7lI4R/hGYa1rlxcy3I7TT15bBnmCoRGNRgbM2626TeK2M
         U8QQulm1/9lP/0uKlXFIm+aIrd1P1LJUecMUDHPs04v4h5S41WJEv37MoVuj5tKHXT
         kff0lu4bd+Ohcysx25wZU3rw9uwxCgnhbBdM06HZmSzThT+At5w3VB3TSzD8OXvixP
         e3wLtNWPPdTReYVMSpjDDILXOFxHa3lX/0Li+a7bjVwZ5JnMhhDom2FOjtSyKUtO2Q
         duzYZ0FdN/ky3PnmECJp9AAIFj9ycarX7siUXQeGUZe4SGC3dM33ZFXq8ssocYQftZ
         cChWwUxKz10Dw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db200790000>; Fri, 25 Oct 2019 08:50:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 896A313EEEB;
        Fri, 25 Oct 2019 08:50:22 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5358A28005C; Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, rppt@linux.ibm.com, willy@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] docs/core-api: memory-allocation: minor cleanups
Date:   Fri, 25 Oct 2019 08:50:13 +1300
Message-Id: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some formatting and add references to helpers for calculating si=
zes
safely.

This series is based of v5.4-rc4.

There was a merge conflict with commit 59bb47985c1d ("mm, sl[aou]b: guara=
ntee
natural alignment for kmalloc(power-of-two)") and the c:func: patch is
dependent on the typo fix. The former was resolved with a rebase, the lat=
ter by
actually sending it as part of the series.

Chris Packham (3):
  docs/core-api: memory-allocation: fix typo
  docs/core-api: memory-allocation: remove uses of c:func:
  docs/core-api: memory-allocation: mention size helpers

 Documentation/core-api/memory-allocation.rst | 50 ++++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

--=20
2.23.0

