Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABA20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="InpQlwRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHLQHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:07:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:46663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLQHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565626046;
        bh=jYqSSfwsqy4C7rhUIFY1F8fvGU/ThZ9cQcIj55AiQe0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=InpQlwRl0mir4fU+tcBZwX+2oo9SB+CkYV7NIIRpaheI9NJEzcWvW7ebOq1bWEC8D
         4KDiHOCzSxkRdoViEpqh4jfF0MO2xM+6UENsea+nYs7sAn8U2i+Tq6jrRnYUEhzIRU
         Ub0JKNuGTRHf+dEf0hF6XrFAMpZyRXAl4JnKb26U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([78.34.97.158]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1ihZ5B2kjT-00lAky; Mon, 12
 Aug 2019 18:07:26 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Documentation: sphinx: Add missing comma to list of strings
Date:   Mon, 12 Aug 2019 18:07:04 +0200
Message-Id: <20190812160708.32172-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m3/VrLP0nK4HpNyVMEvCewsjH/ETwFJt9ujTkwCs/jS4bS1mQ9H
 JZY4OwJQWCeZiCM0mlR5U9KPe7QdzhqDqqegA0HnMueToF8pivvBOem5HwsbxQNoUF7tmmA
 MpqSujIg7mkXzi9kZGf0QZvYvXxhXanmeL0BXDrgBJFY+aq8mJYviXy9dYZLNjYvLAztzCa
 JBqScbZmd2E2vy/GoDf3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:whMTWpobSPw=:cx8Joqsvn5xwMhlo4mhlZ6
 j0YBFQCGkFess/Aq4HAzCR0m8EROXSPukdSPl1AhN5DbTcR/XHfZTHM6aX4f89C3CRQ/QPcvX
 zXERYa+ninHW2AQpYRx6vbmESHyWoyDk4hd3KXWq9GEwjlCkzzK06oKbUbemTGLcp7iyCpCsJ
 73D4YThdeD5e9ncisM/Kw7RriQdOSzgxylO98ccumk2aRABso3aVRCSENanhHq+FnA47at8j9
 jYaQdGztFDxfsFWxWHnbeAkb9+HPCNyqBQLV8GQ3F5cLvTdMNmekXaEzuOSSsAlwo2K7HUOOP
 jQrQIMmMThj/SMGvXP4h28g1il9MYpa6OjaP2MFS4CwlpqLUM2dpKQNlG7j0Daa49qSoRsbqO
 +F6ilW1DPKp4lXg3T1vo9S0FnEuHdUdWbRthAGvkw3o1d3oH7sIVm5s57SmzEHTF3pLshuRiS
 WsLNMLs8s6UeaMvFTPnwv/YIFIBEFaiSEx1GDcJ6oeEvRXgxqy+mvP8CLKHrndA/FlMCCUuDj
 QDzrdrxmu9o9VLQRUeItqx6CTZzq5li6gZj7ZIijDIRuFmjrt06CL8C/rP3+ZpS9HH2j1gCcA
 IBvBFudponbMgG3VPj4G8MkTBUtRCsZ97c4559TZrbQXJOJWF/G6jPaXY47rENen3X331pxeL
 /1WPAfPdieRxqMbx6ZXnXxclncRzJrtOoVX1lI3dE60QpHUbFcO2ZxuWclZdvRErrofm/GGCr
 UdsJghXm7r6fWUxD1vSM+qWMcv9NLMhCI+L8F7P9/slS7pa/i9IoYaiIV2TP7TJG9zpYpopzz
 e8LoFZcXimPRIelroabWEIUmvEZ/9XNaXG4w7FGqhdo/8ZAM04orv9RMMhXKy/jAmyxKFO8xq
 ++vwxppK4ZAcxj71AGxxK9NdIhia2pyN3ukYwPJn6XxeJT8K+wMX/0yu72FecTuAv6e6l1aXy
 Do8euI05nCeWK4wxX5vWf1YSRAi7r3sDle8C0jLVBSCmNoWddnhpJZ6iLfkJLigZy5WQnjeZY
 oh5SQEkqrej9PLNxUoo8khPHrkhBEU7yVsg/Q5T4lfTz+2N6ZxOSQA4moGM04dcKpyBKR4pWz
 4dJy/aln+WIae1mBGKs84dGNPF0JOoaVZeYAe2py1SuSmQgj9orMGnsN9LxgF7x4GVHAlvIqg
 XCjss=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Python, like in C, when a comma is omitted in a list of strings, the
two strings around the missing comma are concatenated.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- new patch
=2D--
 Documentation/sphinx/automarkup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/aut=
omarkup.py
index 77e89c1956d7..a8798369e8f7 100644
=2D-- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -25,7 +25,7 @@ RE_function =3D re.compile(r'([\w_][\w\d_]+\(\))')
 # to the creation of incorrect and confusing cross references.  So
 # just don't even try with these names.
 #
-Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap'
+Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl']

 #
=2D-
2.20.1

