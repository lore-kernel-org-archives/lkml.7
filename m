Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E43CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCB620684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCGGP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:15:56 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:34423 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:15:55 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h1mJo-00043k-7u from Jiada_Wang@mentor.com ; Wed, 06 Mar 2019 22:15:48 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 6 Mar 2019 22:15:45 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v2 0/2] misc fix in src.c
Date:   Thu, 7 Mar 2019 15:15:52 +0900
Message-ID: <20190307061554.26486-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

two issues were found due to linux-next commit
7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
this patch-set address these two issues

---
v2: Update rsnd_of_match table instead of set priv->flags in probe

v1: initial version

Jiada Wang (2):
  ASoC: rsnd: src: Avoid a potential deadlock
  ASoC: rsnd: src: fix compiler warnings

 sound/soc/sh/rcar/core.c |  3 +++
 sound/soc/sh/rcar/rsnd.h |  5 +++++
 sound/soc/sh/rcar/src.c  | 21 +++++++--------------
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.19.2

