Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8014C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EDF218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XfWcDdH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDFKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:16:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:44695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfDFKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554545795;
        bh=WMu1Dlw9XfRKfnYC3A9CbwmjJ2Zo3HlUC/L5YBzwWsw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XfWcDdH1OABUk7FTkRW+/G5G1OatMjhHD50gkEkrYyEKxqnZ9lqs+vKIQ1BBTnq8s
         v5cgc1DvNGmiFFNGZRDbLs5R8XkxscnCZ/kSn/8K0w152OLKjQeqeo/QRI7SoYShz9
         AU+pYyoQyQQVjv33OJ+TIcA5fvBkpd8tnJ8zkv/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1hYLKm2Rrj-00QA8U; Sat, 06
 Apr 2019 12:16:35 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Kepplinger <martink@posteo.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: kernel-docs: Remove entry for vfs.txt
Date:   Sat,  6 Apr 2019 12:15:27 +0200
Message-Id: <20190406101528.23500-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Dx3kq8FU5yy6oG9yDrxJBsIcnADxAiQIgDO97ApXILEFvTIkBf
 bk6X/b3WgXA3lDeZaA9L1XpOmz6JaOS3B+XmKagSHra6vwBEIJSONwsPFXBQ+vNiuyVp7AL
 ocRFCeG8sDJesbVYRcQW2zd3cptGVayj9FNajlYPSA18l52zEoSLMyblETZeSpEBNqYNHiX
 u3XrvxnAbSJCUHZIsqoTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pn9NrLoPegk=:yCBz28wc5780slHnIk8cqZ
 bsPF4B/J87WfR+NVyoY7YKSBmV2PwyKB6Chjdo4p3nWbz5JHz+rO6gHBIFHJIYOUivYdilFct
 OSyVK9v0yOzA2l1u3R8aiguWGfiCpM+gD2ECyJrf9k1X7hc9tdGp56jWao2+8rWLmF5/iNfRZ
 UByqRl+Udb2Ytp/hzXTZxGork/BT0+C5SR3MAsGys3w69kCrtjaEPUKjjr9uQfpmATVOhYpKS
 2B0MPNwE2/uJkSGRSa20Q30x0GpmZPoJNpzFEB7NQrLxEQ4X5NPQeuLpu/NfecZG9OmK+nr8u
 g6CqwMMR2LcBsQCToqsl09Zy56H4mD3iUav+jBPuTQsCYJkKBNSn5v7mIVyRrcqeEDl+OxY31
 hZKIkk//GQr4yvyUCWEpKGNMbQ1P/SfDxsikdbrlXt4t35UYQ2PwCrAeI8DrDSVaMpj8q8CbW
 EQjK0H6GKSv8LwQEBRvRzQ9F6gwbUYtnf5VVyYXB4yNn/Xks7eP9vjE5fb5KDpq9GXQ0N1DKj
 4bmBIL5yA978b+mkS50u3urBk1082NcJZhjpz3ldGYTOLBC2zdsXjnMVEqELGFSIUGk8bPqdM
 8IbQNKx1iwbXiEv9ROnljNqa8r+M33Pa5GirFGYERPIVeGH1Qs2ESWqCJHCSqy+oylR8a8Ggl
 9NtMma7PEE4XZHZ7W72G430LwNn1RzckCFO9Nny7fk93T1kPsfOYPMOcC4kWllaMoygjYA2Jn
 tJt9plH3L0E8BMWSN0hMLcIFcjOstCVt+nu7rXuZ70QVYUk55UuWFGojR8fbpW+OpkYSp5w97
 xUQhrtzaVb5netIbyJR6eWhoXbsdJohbdwGlEqnYhDDtfKGUkuQ/bksMiRKndn0Hay8wr2TND
 ZggOVVfGkK4+eDCnjAbPB9Lm7g94EjtzGZCEZvKtGSITzaPoArBGLm/obmITnQ9L+tqvTPxdL
 LgK6mO7f8Ag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unnecessary to point to an external mirror of the Documentation
directory.

Jonathan Corbet writes in favor of removing this entry, instead of
moving it under "Docs at the Linux Kernel tree":

> We don't want to turn kernel-docs.rst into yet another out-of-date
> index for the rest of Documentation/, and the removal of the external
> URL takes away the only bit of additional information that this entry
> offers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Follow Jonathan Corbet's suggestion of dropping this list entry
  entirely
- I didn't include Martin Kepplinger's R-b, because v2 is significantly
  different from v1

v1:
https://lore.kernel.org/lkml/20190331221439.22892-1-j.neuschaefer@gmx.net/
=2D--
 Documentation/process/kernel-docs.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process=
/kernel-docs.rst
index ab12dddc773e..7a45a8e36ea7 100644
=2D-- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -95,18 +95,6 @@ On-line docs
         [...]. This paper examines some common problems for
         submitting larger changes and some strategies to avoid problems.

-    * Title: **Overview of the Virtual File System**
-
-      :Author: Richard Gooch.
-      :URL: http://www.mjmwired.net/kernel/Documentation/filesystems/vfs.=
txt
-      :Date: 2007
-      :Keywords: VFS, File System, mounting filesystems, opening files,
-        dentries, dcache.
-      :Description: Brief introduction to the Linux Virtual File System.
-        What is it, how it works, operations taken when opening a file or
-        mounting a file system and description of important data
-        structures explaining the purpose of each of their entries.
-
     * Title: **Linux Device Drivers, Third Edition**

       :Author: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
=2D-
2.20.1

