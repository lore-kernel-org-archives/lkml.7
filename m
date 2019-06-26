Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976EE20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561522513;
	bh=9OfSq3Nvez/cQ8gCs8fVcYUWNfY5Mh1PqqMtSyFqK0Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kRbwOdryM5Odf2M1D0ghx6UJP3ok5VnJjcAmS+DO3eV9oWjTgzFA0jmPZSzpwS+HV
	 g8aou8x849yNoccexMGOMp3p8dIYCwkxyvN+YJvkPuwzkn2UobJsLraXqEsa8noi9P
	 mLEs9UIDVnQbRXisQ7I2SITgdTPHBHFuQejG2Yn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfFZEPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfFZEPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:15:03 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C827C20645;
        Wed, 26 Jun 2019 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561522503;
        bh=9OfSq3Nvez/cQ8gCs8fVcYUWNfY5Mh1PqqMtSyFqK0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=DjnWAOzoNliy6Wem0+ZPQFZpSvdq6ojwqsOtMtlWUjnX1D5mQLnL0FgYJyS/3tcSV
         9e3xbHkI/Nu4T41cm42s5OYtWqGxWHbgXNKT59S1nk3V3qkGlUd+9uNX+JWFF1Gvza
         bfC0+JUGUrx3LGNudAgLdaM4XajveynjUOwDa2K0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/2] Unexport __clk_of_table
Date:   Tue, 25 Jun 2019 21:15:00 -0700
Message-Id: <20190626041502.237211-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this lying around, not sure if I sent it or not.

We don't need to export this symbol anymore. And having COMMON_CLK in
clk-provider.h seems to be an artifact. Here's a couple patches to clean
this stuff up.

Stephen Boyd (2):
  clk: Remove ifdef for COMMON_CLK in clk-provider.h
  clk: Unexport __clk_of_table

 drivers/clk/clk.c            | 1 +
 include/linux/clk-provider.h | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
Sent by a computer through tubes

