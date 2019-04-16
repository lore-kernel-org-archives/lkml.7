Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78155C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8972075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383540;
	bh=CZOlaG7OtoPqZ6oV0Y/N5qz2hNPbpzj7A1QKjoWSrkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFBtnHHV5C9aZ1fL1B8/JSQgo0x3EIqIZn0h3uE88yB5+//zKjE17bP5NXE+/kKmc
	 3HxHC/uDvF3YLX3rzLeWlISxxji0JW9lGevKiW64MhnP8OT5WgGYC8IDnk7t2DT5yP
	 lG+xKw/2gt82RanvwqSl3OghZDbD4CyLZqeM2exs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDPC6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tjfpueBhcJKy8pFnSbvSP53KhQdmJRKIfxX07mzjgFE=; b=eGsXbQty9J12EnGG1n+Iezqu7D
        qmbkbYxasFVt8zjkbeImmzuitFOvqr8TvRepbTzFdtw38Mrthf6wEHbfbqRm0qoD56dBlnUFvjva+
        T2wNPIT7FcYUXNxeJKWvXBhka81TzcEvicP49JiNJ690UEhdLynVLG7E2i6TGw2Ar6ua4dGo7kwH5
        LEHSfC+/f3dEzokCNgKdTuR5oWVPsuIIwCx7KLa1AzYRDar1QQE+0PH3iKJ9Zj/7AskBX9kxcfcT4
        OHASvNr8Umz98lPSzjhwJbU1KXYc0LS7nxMB/UNaovxZ6JunUeAulKzZUrvIEkAn++nLCqVPCU53a
        xz7JJ6IQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007al-Qa; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001oC-Mr; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 30/57] docs: s390: Debugging390.txt: convert table to ascii artwork
Date:   Mon, 15 Apr 2019 23:55:55 -0300
Message-Id: <f186aeca9675371b4551425a1fa880d6fc48babc.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first bit/value table inside the document is very
hard to read and won't fit ReST format. Convert it to
a nice ascii artwork table with makes it easier to read
and is compatible with ReST format parser on Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/s390/Debugging390.txt | 210 ++++++++++++++++------------
 1 file changed, 120 insertions(+), 90 deletions(-)

diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
index 5ae7f868a007..c35804c238ad 100644
--- a/Documentation/s390/Debugging390.txt
+++ b/Documentation/s390/Debugging390.txt
@@ -78,96 +78,126 @@ e.g. switching address translation off requires that you
 have a logical=physical mapping for the address you are
 currently running at.
 
-      Bit           Value
-s/390 z/Architecture
-0       0     Reserved ( must be 0 ) otherwise specification exception occurs.
-
-1       1     Program Event Recording 1 PER enabled, 
-	      PER is used to facilitate debugging e.g. single stepping.
-
-2-4    2-4    Reserved ( must be 0 ). 
-
-5       5     Dynamic address translation 1=DAT on.
-
-6       6     Input/Output interrupt Mask
-
-7	7     External interrupt Mask used primarily for interprocessor
-	      signalling and clock interrupts.
-
-8-11  8-11    PSW Key used for complex memory protection mechanism
-	      (not used under linux)
-
-12      12    1 on s/390 0 on z/Architecture
-
-13      13    Machine Check Mask 1=enable machine check interrupts
-
-14	14    Wait State. Set this to 1 to stop the processor except for
-	      interrupts and give  time to other LPARS. Used in CPU idle in
-	      the kernel to increase overall usage of processor resources.
-
-15      15    Problem state ( if set to 1 certain instructions are disabled )
-	      all linux user programs run with this bit 1 
-	      ( useful info for debugging under VM ).
-
-16-17 16-17   Address Space Control
-
-	      00 Primary Space Mode:
-	      The register CR1 contains the primary address-space control ele-
-	      ment (PASCE), which points to the primary space region/segment
-	      table origin.
-
-	      01 Access register mode
-
-	      10 Secondary Space Mode:
-	      The register CR7 contains the secondary address-space control
-	      element (SASCE), which points to the secondary space region or
-	      segment table origin.
-
-	      11 Home Space Mode:
-	      The register CR13 contains the home space address-space control
-	      element (HASCE), which points to the home space region/segment
-	      table origin.
-
-	      See "Address Spaces on Linux for s/390 & z/Architecture" below
-	      for more information about address space usage in Linux.
-
-18-19 18-19   Condition codes (CC)
-
-20    20      Fixed point overflow mask if 1=FPU exceptions for this event 
-              occur ( normally 0 ) 
-
-21    21      Decimal overflow mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-22    22      Exponent underflow mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-23    23      Significance Mask if 1=FPU exceptions for this event occur 
-              ( normally 0 )
-
-24-31 24-30   Reserved Must be 0.
-
-      31      Extended Addressing Mode
-      32      Basic Addressing Mode
-              Used to set addressing mode
-	      PSW 31   PSW 32
-                0         0        24 bit
-                0         1        31 bit
-                1         1        64 bit
-
-32             1=31 bit addressing mode 0=24 bit addressing mode (for backward 
-               compatibility), linux always runs with this bit set to 1
-
-33-64          Instruction address.
-      33-63    Reserved must be 0
-      64-127   Address
-               In 24 bits mode bits 64-103=0 bits 104-127 Address 
-               In 31 bits mode bits 64-96=0 bits 97-127 Address
-               Note: unlike 31 bit mode on s/390 bit 96 must be zero
-	       when loading the address with LPSWE otherwise a 
-               specification exception occurs, LPSW is fully backward
-               compatible.
-
++-------------------------+-------------------------------------------------+
+|          Bit            |                                                 |
++--------+----------------+                     Value                       |
+| s/390  | z/Architecture |                                                 |
++========+================+=================================================+
+| 0      |     0          | Reserved (must be 0) otherwise specification    |
+|        |                | exception occurs.                               |
++--------+----------------+-------------------------------------------------+
+| 1      |     1          | Program Event Recording 1 PER enabled,          |
+|        |                | PER is used to facilitate debugging e.g.        |
+|        |                | single stepping.                                |
++--------+----------------+-------------------------------------------------+
+| 2-4    |    2-4         | Reserved (must be 0).                           |
++--------+----------------+-------------------------------------------------+
+| 5      |     5          | Dynamic address translation 1=DAT on.           |
++--------+----------------+-------------------------------------------------+
+| 6      |     6          | Input/Output interrupt Mask                     |
++--------+----------------+-------------------------------------------------+
+| 7      |     7          | External interrupt Mask used primarily for      |
+|        |                | interprocessor signalling and clock interrupts. |
++--------+----------------+-------------------------------------------------+
+| 8-11   |   8-11         | PSW Key used for complex memory protection      |
+|        |                | mechanism (not used under linux)                |
++--------+----------------+-------------------------------------------------+
+| 12     |     12         | 1 on s/390 0 on z/Architecture                  |
++--------+----------------+-------------------------------------------------+
+| 13     |     13         | Machine Check Mask 1=enable machine check       |
+|        |                | interrupts                                      |
++--------+----------------+-------------------------------------------------+
+| 14     |     14         | Wait State. Set this to 1 to stop the processor |
+|        |                | except for interrupts and give  time to other   |
+|        |                | LPARS. Used in CPU idle in the kernel to        |
+|        |                | increase overall usage of processor resources.  |
++--------+----------------+-------------------------------------------------+
+| 15     |     15         | Problem state (if set to 1 certain instructions |
+|        |                | are disabled). All linux user programs run with |
+|        |                | this bit 1 (useful info for debugging under VM).|
++--------+----------------+-------------------------------------------------+
+| 16-17  |    16-17       | Address Space Control                           |
+|        |                |                                                 |
+|        |                | 00 Primary Space Mode:                          |
+|        |                |                                                 |
+|        |                | The register CR1 contains the primary           |
+|        |                | address-space control element (PASCE), which    |
+|        |                | points to the primary space region/segment      |
+|        |                | table origin.                                   |
+|        |                |                                                 |
+|        |                | 01 Access register mode                         |
+|        |                |                                                 |
+|        |                | 10 Secondary Space Mode:                        |
+|        |                |                                                 |
+|        |                | The register CR7 contains the secondary         |
+|        |                | address-space control element (SASCE), which    |
+|        |                | points to the secondary space region or         |
+|        |                | segment table origin.                           |
+|        |                |                                                 |
+|        |                | 11 Home Space Mode:                             |
+|        |                |                                                 |
+|        |                | The register CR13 contains the home space       |
+|        |                | address-space control element (HASCE), which    |
+|        |                | points to the home space region/segment         |
+|        |                | table origin.                                   |
+|        |                |                                                 |
+|        |                | See "Address Spaces on Linux for s/390 &        |
+|        |                | z/Architecture" below for more information      |
+|        |                | about address space usage in Linux.             |
++--------+----------------+-------------------------------------------------+
+| 18-19  |    18-19       | Condition codes (CC)                            |
++--------+----------------+-------------------------------------------------+
+| 20     |    20          | Fixed point overflow mask if 1=FPU exceptions   |
+|        |                | for this event occur (normally 0)               |
++--------+----------------+-------------------------------------------------+
+| 21     |    21          | Decimal overflow mask if 1=FPU exceptions for   |
+|        |                | this event occur (normally 0)                   |
++--------+----------------+-------------------------------------------------+
+| 22     |    22          | Exponent underflow mask if 1=FPU exceptions     |
+|        |                | for this event occur (normally 0)               |
++--------+----------------+-------------------------------------------------+
+| 23     |    23          | Significance Mask if 1=FPU exceptions for this  |
+|        |                | event occur (normally 0)                        |
++--------+----------------+-------------------------------------------------+
+| 24-31  |    24-30       | Reserved Must be 0.                             |
+|        +----------------+-------------------------------------------------+
+|        |    31          | Extended Addressing Mode                        |
+|        +----------------+-------------------------------------------------+
+|        |    32          | Basic Addressing Mode                           |
+|        |                |                                                 |
+|        |                | Used to set addressing mode                     |
+|        |                |                                                 |
+|        |                |    +---------+----------+----------+            |
+|        |                |    | PSW 31  | PSW 32   |          |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   0     |    0     |  24 bit  |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   0     |    1     |  31 bit  |            |
+|        |                |    +---------+----------+----------+            |
+|        |                |    |   1     |    1     |  64 bit  |            |
+|        |                |    +---------+----------+----------+            |
++--------+----------------+-------------------------------------------------+
+| 32     |                | 1=31 bit addressing mode 0=24 bit addressing    |
+|        |                | mode (for backward compatibility), linux        |
+|        |                | always runs with this bit set to 1              |
++--------+----------------+-------------------------------------------------+
+| 33-64  |                | Instruction address.                            |
+|        +----------------+-------------------------------------------------+
+|        |    33-63       | Reserved must be 0                              |
+|        +----------------+-------------------------------------------------+
+|        |    64-127      | Address                                         |
+|        |                |                                                 |
+|        |                |   - In 24 bits mode bits 64-103=0 bits 104-127  |
+|        |                |     Address                                     |
+|        |                |   - In 31 bits mode bits 64-96=0 bits 97-127    |
+|        |                |     Address                                     |
+|        |                |                                                 |
+|        |                | Note:                                           |
+|        |                |     unlike 31 bit mode on s/390 bit 96 must be  |
+|        |                |     zero when loading the address with LPSWE    |
+|        |                |     otherwise a specification exception occurs, |
+|        |                |     LPSW is fully backward compatible.          |
++--------+----------------+-------------------------------------------------+
 
 Prefix Page(s)
 --------------
-- 
2.20.1

