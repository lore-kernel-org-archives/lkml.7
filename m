Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A9020854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCGCe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:34:56 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:63673 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfCGCe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:34:56 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h1irw-0004Ds-8N from Jiada_Wang@mentor.com ; Wed, 06 Mar 2019 18:34:48 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 6 Mar 2019 18:34:45 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v1 0/2] misc fix in src.c
Date:   Thu, 7 Mar 2019 11:34:51 +0900
Message-ID: <20190307023453.25017-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

two issues were found due to linux-next commit
7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
this patch-set address these two issues

Jiada Wang (2):
  ASoC: rsnd: src: Avoid a potential deadlock
  ASoC: rsnd: src: fix compiler warnings

 sound/soc/sh/rcar/core.c |  3 +++
 sound/soc/sh/rcar/rsnd.h |  5 +++++
 sound/soc/sh/rcar/src.c  | 21 +++++++--------------
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.19.2

