Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A3C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573F821A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfJBMCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:02:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfJBMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ma1wa-1iaceH2QCq-00W25Y; Wed, 02 Oct 2019 14:01:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] amdgpu build fixes
Date:   Wed,  2 Oct 2019 14:01:21 +0200
Message-Id: <20191002120136.1777161-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LX1FNtvLcwDIdLB+i4qzflq2ZYlCE6KB5K5rZJynUoqPGyIkUPY
 4Mz6djh6520XrlLSv3g57aFtMwJKS+y9hLWUvZH12eQqTQeiw1qnt1FSbmj6CTyowpdYqE0
 WuhmsmWfyydswcAYpuzkFYUaxnI42aBCHE/yPsUVi8yz+hz+FKV6WtoLKY7ceGsBXWg2p0a
 9ac7GLueW+ohA1srPf4fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AqG46Q0Fqto=:DiGthsIlGZVRMpN4RTeFID
 MzWbk55Uax7YvMfxb5flyijER5Y97yOw9nqFFa9gNvalWz1RX1Smch6ciGu18NmJHcqo0vQsz
 4l/7L3Zvi6eStA4nSOz8V/J4DiViiY8LkeqfzJrxOO/NVKP8Djf4M08+BnRnqk5CJ3v5zd8hX
 QDoE81CpQZCCZuwnDM94TI6hsfxnv4uRj6UmodLtuWn8ouOUWQ3BvNTa42LLs0PFgd3aPvy3R
 ZuGilRa/9oD9CHqYxJZCaVKtFi71PHznXaZTTotzR71MEgICxHUtFhHLRr3Ti2PnseiC1Zf1K
 6sWSVtmTkJAn4LkBU9/Apur7egleGe3RjtTIwURZP6M7wWuZJ/WKoeaigTXtryVTgwsIJD0lF
 Os8EmR+Ea6imlxUnoAli7g16cVWBTGco29yJHZ01a0bR6A4b6YxOx5/EkMZo9RyZFqOEAx6aj
 Ip/4JP2jXmrZl8f2218bFr7WKMXq0THxulwMq7BTOx4IU0aaNX0JPEO4WIIUE/1zpr1W60SnB
 WPcojRp9/gFMVUYeeYbVjhYIlXE/vE2/zUKjzcaszN/nLpQtWiDhWUaH7FRDAJNSnzXjp0fKF
 g9s4vuuiPGigbTT0maHwmZ5KjCe8Zbkk6d2MxiUk9m+2a7vUjdRcYd+x8ELkQE8uWqyHmwpav
 TBjAZiHYmqsMEV6OeAKSBplfwhfU3DRHKUI13FEH10G+ymiGpst8RDBbYVvvpeXS5WrojWn8f
 hNa3V2lvlNUuESik+LKIqAzocxOERxp4NcosOxZpY+79kYf+k8dylDD6cCFSdaMNoQpLUNmFM
 qBFAdKa8Y9BJi7eFpoDMujcFwwBTjBTJwwfnSoSKe0C/+UQ303ozpFPAqr2bgMjmIqx1058AK
 tFDKQ930L4atVk7VQzEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a couple of build fixes from my backlog in the randconfig
tree. It would be good to get them all into linux-5.4.

     Arnd

Arnd Bergmann (6):
  drm/amdgpu: make pmu support optional, again
  drm/amdgpu: hide another #warning
  drm/amdgpu: display_mode_vba_21: remove uint typedef
  drm/amd/display: fix dcn21 Makefile for clang
  [RESEND] drm/amd/display: hide an unused variable
  [RESEND] drm/amdgpu: work around llvm bug #42576

 drivers/gpu/drm/amd/amdgpu/Makefile                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                  |  2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile       | 12 +++++++++++-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 13 +++++--------
 6 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.20.0

