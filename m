Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB7E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201162;
	bh=qjDI6Cf9NAoyKZcwwRsTDtstU0yRG8bhKdD6wIZZnbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxDpofd3O5nLWnfWkGkgeygizyGE9vz7Kka+R1ktNpGqSVo4nEINcVKYWYe23W9OD
	 M+u44E0qrWjnYYZR81dqXI07WXO1HZKOVbOFRG5L8/yoAq268aeHEyLtEe9/k7spv+
	 4vHh7Dou2zqHOAQDF/f3JS/sxxurx0qLav+Mr7sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfDBKcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfDBKch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CD020883;
        Tue,  2 Apr 2019 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201156;
        bh=qjDI6Cf9NAoyKZcwwRsTDtstU0yRG8bhKdD6wIZZnbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0AG6pquB/U2xo8abLgUJTO1PmDM8Csjq8C1XdZk06MS/nkCCTalBxzXn6lCNTHWJ
         xHsOv+1/gZEtq5G7I2xGmPyY/B2NHIaQkdKVMGt8yjXKzvTcZOjm+dFOD6jurLv6V/
         vx7hTMQ45wU0nMlV5Ci1tp/J8+voW6yHsEuTVzdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 16/16] staging: media: tegra-vde: add proper SPDX identifiers on file that did not have it.
Date:   Tue,  2 Apr 2019 12:32:03 +0200
Message-Id: <20190402103203.14959-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a single file for the tegra-vde driver that did not have SPDX
identifiers on it, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/tegra-vde/uapi.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/uapi.h b/drivers/staging/media/tegra-vde/uapi.h
index 4bce08a7a54c..a0dad1ed94ef 100644
--- a/drivers/staging/media/tegra-vde/uapi.h
+++ b/drivers/staging/media/tegra-vde/uapi.h
@@ -1,12 +1,5 @@
-/*
- * Copyright (C) 2016-2017 Dmitry Osipenko <digetx@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2016-2017 Dmitry Osipenko <digetx@gmail.com> */
 #ifndef _UAPI_TEGRA_VDE_H_
 #define _UAPI_TEGRA_VDE_H_
 
-- 
2.21.0

