Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E1C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2820659
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="R/fz1Dxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfJLRLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:11:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:54471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfJLRLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570900286;
        bh=Uz2pP5hTF599V0iyIbkgS2qh4IzWWNUk/fRR8WwX2H4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=R/fz1DxnVZV0/WJDRE1tCfl2+PKDAFB48F4EAN/imrZ0EU6gAhPu3egDQ9Pf3Evm1
         B9H1y0euYzFTkQFdtuEFOIKk5OTdXeOUGX2WjYHETw+Gwhb+gzRswx/B6vPhxYjKil
         rikj3ef99sRnnZvJw0zMqv3h2DefVF29+LYYGtVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([213.196.244.109]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1hjUvI3Tkz-00qDFZ; Sat, 12
 Oct 2019 19:11:25 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/4] docs: admin-guide: Sort the "unordered guides" to avoid merge conflicts
Date:   Sat, 12 Oct 2019 19:11:09 +0200
Message-Id: <20191012171114.6589-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5B34xg+6308ya7WPHDCaXqtJ8xGXo98JxaTSCcGd78rRDNlfA2S
 b3B2/5ic+4m87a83vVcTwUedCy33Y4I6iQPXbrhNigLS3IWxQyxGvHN6XUtPGfq7cr8xwDo
 0sFDDLYZv8cJ5EqvHChiY3bFpiM33AGpRHqnSbgH67+lLHojaE4XQLMH6BnDx1/RTv8n2Ek
 RDBNYIIWTMJj99n46ru8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5HByb3ZDp1E=:k08/BnDMmpK0zJYQ62e57h
 VEBseg4VmzEUiwvnrAYX08k9zI64wn8UhkKmt1nza7lsAvhghCLxV7QiP7RtP6HvzwfRkyvru
 NqhUEvVk+MJbGIfJJtFTubecx0AtG8QN+SiwRdBD7T+fZ1TAHbnnTEZTA0aQL86Oc6BxqlAy0
 3Ti3smwOYtmh12yLTolutBuFyMdbJZ7SGD5aayRLbVprxSgng3UIZcBDvZF2KIK9OhVrz5Uix
 MZNP8Nd7hRhwcimIjh+ri5Qt6+gC5mUjQJmgeynj4zQ1oh1o/WvJA019gaUdmmRVDHAzlQhtX
 5QdQ3XtbsqCJVhmpPLiShCLXxCOcgM6yWrT9LRuenGqQoGd2FTrKhG0o0A8GHo+BAEF+TO0vO
 30Z9F4Dy6w3O8MCvSi6tEFXg1pdeK53HcKC4/UtUJlaj/0QIVWu9rc7lO6h4IVE0WrLIO+NoF
 ZrkwVDPOos0NAmSOeQ3z44PtbYcTm5W/cZXCx8kC5vKmw1gK9FLPqNkKK8F+KHvpNAJIPCXAW
 Jgm1c3rHSWfuY9FSy3lxFYXbD8iS4CzvzQs/q8ZYGnNNU0RuhbHZnI3LHDiFP6Dah3QvT58PY
 /mpf8rAA/xvq677a9Q1M3CfaEYX/U8i48h7CtnTgoz7VW04chbAtYxcNwMrkxpyhzZAoH6nWJ
 vbeQNArTn6FQWB1PuMy0nJk8DEyHOwE7oL7ty+1ju4HyHyJU9dDHIjyKWmevR12PIRRpw5CGe
 1rG9+0BSsSwlHii6e13gyDlSr94abjz8O9t2OJEIvy7TFdtwpSa7siJgwXfBb7+dZq0LAlMeU
 lZVqFUWTJmkwS+YPx6q7p0tFgjiR64Y0yNqe0W3IlHovKYCWkIuhNxmpW892sA8r9dHLEm7xO
 vFpnS/zDweEiVv4gul67VZKAqssouTsaHj8NV8NiMCLYnxVnYLJhAPsD+zhYj5m56P4WpgNEp
 gdSmbWI+HMxASjc5D7SOpBrBI9BccJbUnUw/tTcjLpu+J6qUBeDzIZNBAQHYX7LMw8Ey2sAml
 VuBZApRtNcZDQq18TD3yTwk+6xHoTD3KNamfvKmcnzhL0OuVVpSP4clyPmMGGuSGzJ2pAuzGu
 Bm6y12E6XSoNYhzAQ2ijcrxWAVrhUM4GaFUwu+vJ3kFYWQocx1dKnXdDgC2hEsW7PqlOlMBc0
 jDe32vlcfHjwuyRmq58FZZ9cnRQZW13876sOIz8zg1m9h4OefRW/gAPBq2baiarsycoqbdL1o
 EkOiz19+NDOJNJkLUoukd1iNNhwr5bKRhaGbhNM1LRyhiHSrRFlb0Fx3AvWI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the "unordered guides" linked in admin-guide/index.rst are not
supposed to be in any particular order, let's sort them alphabetically
to avoid the risk of merge conflicts by spreading newly added lines more
evenly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

Upon a second look, I noticed that the list wasn't completely unordered:
binfmt-misc is grouped with java and mono, the filesystems are grouped
together.

For the filesystems, I think they should be moved to the filesystems/
directory, and the binfmt documents could perhaps be explicitly grouped
too. But perhaps the loss of this grouping-by-position is reason enough
to drop this patch for now.
=2D--
 Documentation/admin-guide/index.rst | 64 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gui=
de/index.rst
index 34cc20ee7f3a..545ea26364b7 100644
=2D-- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -57,60 +57,60 @@ configure specific aspects of kernel behavior to your =
liking.
 .. toctree::
    :maxdepth: 1

-   initrd
-   cgroup-v2
-   cgroup-v1/index
-   serial-console
-   braille-console
-   parport
-   md
-   module-signing
-   rapidio
-   sysrq
-   unicode
-   vga-softcursor
-   binfmt-misc
-   mono
-   java
-   ras
-   bcache
-   blockdev/index
-   ext4
-   binderfs
-   cifs/index
-   xfs
-   jfs
-   ufs
-   pm/index
-   thunderbolt
-   LSM/index
-   mm/index
-   namespaces/index
-   perf-security
    acpi/index
    aoe/index
+   auxdisplay/index
+   bcache
+   binderfs
+   binfmt-misc
+   blockdev/index
+   braille-console
    btmrvl
+   cgroup-v1/index
+   cgroup-v2
+   cifs/index
    clearing-warn-once
    cpu-load
    cputopology
    device-mapper/index
    efi-stub
+   ext4
    gpio/index
    highuid
    hw_random
+   initrd
    iostats
+   java
+   jfs
    kernel-per-CPU-kthreads
    laptops/index
-   auxdisplay/index
    lcd-panel-cgram
    ldm
    lockup-watchdogs
+   LSM/index
+   md
+   mm/index
+   module-signing
+   mono
+   namespaces/index
    numastat
+   parport
+   perf-security
+   pm/index
    pnp
+   rapidio
+   ras
    rtc
+   serial-console
    svga
-   wimax/index
+   sysrq
+   thunderbolt
+   ufs
+   unicode
+   vga-softcursor
    video-output
+   wimax/index
+   xfs

 .. only::  subproject and html

=2D-
2.20.1

