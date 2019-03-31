Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF2920857
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A+M9YxOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfCaVm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:42:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:56187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfCaVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554068556;
        bh=RFmC8NZ7d/AYlLTqAkEA2ujbImkFx4inNjD6pxv6lpg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=A+M9YxOoz6Nd6IUAtjjNMllN8aYFs0rQ0QOiahAhGe17enDos3vgTJNPVt35BQMlt
         0ymYy1u/+mnUH04u2wZ+xpiK9Ak9ubqZQlzYqjt3b/DZ5Wd1tb14anPxQsXUG+Rw8F
         OF3MMk/tGg1CQEGGRiyzfXWgYgDTUGDRrQeOhZj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNdxu-1hHr660LNq-007Awt; Sun, 31
 Mar 2019 23:42:36 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: core-api: Drop reference to flexible-arrays
Date:   Sun, 31 Mar 2019 23:41:58 +0200
Message-Id: <20190331214159.13987-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+t5APouqfG0GEejklUamiNH4NAkLo3PoKStODJ6GY/FFHdeT8PZ
 IgT9uwRsLGiJ1ingNuPBv0CpllAMXTBLLdIymnzHmGgwcoHe2nqjt9meRpEbbTA7Edg19yx
 Jy5bu1nPgdTZT/wR+6HIPMzsVJBlCiBjaWAVG4MoKGr2WLEBsLYnz+/8Kd8/MrxH4Xw5PT5
 0JdcwfFfZm5WPRrTc+jvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CuyuZCbbBsA=:W0X5sWWPs2QOu7081AlDCs
 Mtl4D/n7aiodlCp6UjP9QCzsG3HyHpFhPJYyu0IcQ24BX6DycNsRCpiKutBsMBof8I6DQXCqQ
 DIia5CwrQ7xA+ZcALaRtKbbIsJiBRyJbLldzSe8LimxRDZzcZJufVK2FSsQWgUxvLg+EdyokR
 YJyL/GnesoNomAfGh8SbeZFqagCHwh9MmVMDLrTbchUkz67s9yad6ZXZez86Ks/PKODfvLxai
 v8cwua8bhZAFoyw7vP+015xFqXm/pPMOdJbBVeiX0QjLzqozlVW+Eu2D/hcmM4WVgoP4/N6IF
 pLHtt9mETmr5HQKHmtouUExaMW1UwBda3mdmxDMCGjWlvyYuJYBcwwRcDnwY2ch2Ll+4+Dik5
 Lz9kLY8f1yuheG5S1d7KHPkjvnD2h6xTvlPDoHMkuSBcpwRwpt/m41CkyMTs1DgKXH3XKUpcs
 0WKMasxjCnDHQAo+/61xpO5VV8eQpJoZL3CYSVb5AQJl1Mwvfevi78nf82cV6eimLIfgwcQWs
 W05zQqovBQm4B16piR+nd81FbZVHkZHaaS81yVZiPupYb5IRcnoKfNY7vUHeQyLirZ0ZA2mcR
 pmsT/Pi3Zoqri8JCuL42nWmICjvznKXstOnxG9gxf4uzyS6jnmfACoOYlzKNe3cAPYK/D0/Cd
 WpWw3+94knmk6LG2ZU2xNTXkzq/F6o0PRRO5Z2/ZGPxIJSa+a0MaTR5JFkFzosxemFEr+EDY8
 s3NP7nvVfLFqNfzkhMZ2nVDESotqpX0u75fobW1Csp/BfabOHvz5rKlTsJe/hbufo1JPJieqC
 Kt22fbXSlO7AIQWvNj9GoAc8OQkbQxmnBz0F7WtpjFv7efE7o8ZXYd4/SbnEhsvbDvgfC9XR7
 bfO2O5T8nwAtjuW9PEszkoXIBBYwNV/PSFsSomCHx/06XC098SSbV9QPcS7+VsA6QUyouHy4P
 tlgqYO1Reuw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file doesn't exist anymore.

Fixes: 586187d7de71 ("Drop flex_arrays")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/core-api/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/ind=
ex.rst
index 6870baffef82..ee1bb8983a88 100644
=2D-- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -22,7 +22,6 @@ Core utilities
    workqueue
    genericirq
    xarray
-   flexible-arrays
    librs
    genalloc
    errseq
=2D-
2.20.1

