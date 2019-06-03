Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA842C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A1280CD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lh2B0Lam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfFCMVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:21:39 -0400
Received: from mout.web.de ([212.227.17.11]:55411 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFCMVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559564486;
        bh=H+mYUcCUxLh+PaxmPpuNy/NUK3kvMoT8KgwI5OrJRH0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lh2B0LamfEDclMUyxIJw6kQ+/NNtsbJFM8n1xZtbiY3Vp4k8uienlblCXqMBwIhwz
         8VS3gZ3OIcSB1A4mE3p/hie/ya1Ts7ab5xHGHvSCmnVbV8ODza2GuDJH2Pmp74b+tB
         Nw/Tmh7Aj38nUk/KYOj5Byv0XcIy8i1pytZG2uV0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MK24P-1hWP3L1FS9-001SxR; Mon, 03 Jun 2019 14:21:26 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 0/3] Fixing style errors in staging/drivers/rtl8192u
Date:   Mon,  3 Jun 2019 14:21:01 +0200
Message-Id: <20190603122104.2564-1-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VPSFcTBh0Ipw6QYZ0N/RslXaVNL2v2bwzj2HYaZwVIFdP7fr9Qn
 UDCcvVCRNAzcxLyxlMHcs7/J78/KIDlSALfG77AQNkLMUFB8DSO8EtpXDoxaV9bqFKFVLE1
 E6s6VF/3+kJrpD5O4JaAt72tEoqePiDVLMnxC6P9LwYXvi8wtROg6SLfIr3Um+dhnEf0OUx
 tBxFonv9MgbLFn9UPyv5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTJZ7FqmO1k=:8f/TeISIdn+Z4R21lYXDRs
 wEFNoc4wEnIYKaq0ALBY2sZ3MzwrDrGnvvQKXabAM5ehXe9hy6hlbWos/UxjryBo582lFZQ4Q
 Sxo2T8g63yS84bhIol6kJBEY7Wv7iWRFYzoYtR14sqBcpfVf9fg6ufEU4L4r2m0Gz4fLI2L7+
 b3jmPRQxZmnzNFDQLuBXNG8n9lik0gDntzMq6+Ehm3O/ZG96Bnu+cTydIRP7qOauJGbu6XJ9m
 AA4swYrbd+zQIQhmEU6MduC4gCYCxIoPF2mXR5wK+XKWZE80B73n/E+OkRkAfuxce3hUJIqb3
 CFaEU4pthiIMfRIufCCvjthpOlBN7BA/lUgllpTafsfKamoacHCK1D/TNjq+c7IZUQLAlyxUs
 3rt5xXxpJX6WZoTlyfQEQVhNeL75bbzaLeBgxcAjEakwYs7mb2XvAYBU7QnBuE59zemvD9f2y
 wgfiM+143tiSZMCAhO0qI30xoFZD8jjjfKSCkNAAL9Ka9+h2Gem3JhlG8EmqlbLjiJ2LJGhe9
 kMBgcBEZ3KeaTtubBdHwtyRZChoyssAua21Pa0oNpZ3LAlyTgcw1u9an0mDINgzoySExmHqGq
 KfhxIei98y5JTOUlTjIcG+CROZNcgTrXuElAx/z7HN+0QUA/S1Hn5NxczsgFnNvtTt719KEjy
 FoyPuhn8Eq+YLWJctjVGz4uRf+9aN65sdyNHFY/QRwl3Vw2uhn0mXQbVZ359udd2iDdouukq+
 RvJkSbPAa9GiEuNy5h7XEZMMbEpHGzH4crwOZE+VWuK05+lsTlWYdP535nX0gCazT1wfqZ9IO
 ipnjWzpwL5dVXuPqZ73vvNECrCeElZA1fCwTSU75ZMro9pk4NZKlzAF0CeYbDbcEtrhHQL0Wu
 cLkYpKoSdD+wa6U9so2T1vHtmLwI6P+IuNR3RlCMce2TXzH0X6xfMtRVlXNdCWjFtDOWKxye0
 Devw0xUML8wnqXFI3uYQZ9nYUIhnfm/Wt+/Pt01PPzsGS5GsJzi0O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches fixes various style errors in the rtl8192u
staging driver. These fixes contain reformatting of code comments,
changing of indentations, cleaning up commented out code within the
source-code and fixes for individual errors indicated by the checkpatch to=
ol.

Christian M=C3=BCller (1):
  drivers/staging/rtl8192u: Fix of checkpatch-errors

Felix Trommer (2):
  drivers/staging/rtl8192u: Reformat comments
  drivers/staging/rtl8192u: Remove comment-out code

 drivers/staging/rtl8192u/ieee80211/dot11d.c   |   6 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h   |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 311 +++---
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |   3 +-
 .../rtl8192u/ieee80211/ieee80211_crypt.h      |  15 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   7 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  13 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |   9 +-
 .../rtl8192u/ieee80211/ieee80211_module.c     |   6 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 973 ++++++++----------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 336 +++---
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c |  21 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 311 +++---
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c | 115 +--
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |   2 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 169 +--
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 111 +-
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 264 ++---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  |  24 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 110 +-
 drivers/staging/rtl8192u/r8180_93cx6.c        |   3 +-
 drivers/staging/rtl8192u/r8180_93cx6.h        |   4 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c      |  36 +-
 drivers/staging/rtl8192u/r8192U.h             |  47 +-
 drivers/staging/rtl8192u/r8192U_core.c        | 159 ++-
 drivers/staging/rtl8192u/r8192U_dm.c          | 232 ++---
 drivers/staging/rtl8192u/r8192U_dm.h          |  22 +-
 drivers/staging/rtl8192u/r8192U_hw.h          | 192 ++--
 drivers/staging/rtl8192u/r8192U_wx.c          |  17 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c      |  77 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h      |  14 +-
 drivers/staging/rtl8192u/r819xU_firmware.c    |  12 +-
 drivers/staging/rtl8192u/r819xU_phy.c         |  30 +-
 drivers/staging/rtl8192u/r819xU_phy.h         |   4 +-
 drivers/staging/rtl8192u/r819xU_phyreg.h      |   9 +-
 35 files changed, 1747 insertions(+), 1919 deletions(-)

=2D-
2.17.1

