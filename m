Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E4C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28520673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384705;
	bh=eGhmsYZKuBW2PvWz3EQXgbbJszC6F+ic1oPctoDG0lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVZ3PlRjc9NX7ZvGg9eptpPmdwPOVolAl/9zwh/1fzQR1k+bVTGAeJU68YwZ+nMNV
	 dGngM+WAmOe/9eN+PcKYXOa9l7Av5/9d3jNmoYO/VT+/EUT3j5QS1Df4T9bFpKqL7N
	 S7auKfn77u3hPJ+qK84ZMn1htT8Fe0nJCVvZ5v8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJFR6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfJFRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:32:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B5F2133F;
        Sun,  6 Oct 2019 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383135;
        bh=eGhmsYZKuBW2PvWz3EQXgbbJszC6F+ic1oPctoDG0lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdKQbzENdUBzhXn1tkxQfHxz+suYHRoaPmYyCVM8cgTmlQOY3LyPgER1o21+Gf6To
         hqocmdmBZwKycgpZWRDIERxlYI3ndKM5IOnUXMzDAWWTvjlxDGwPRKnyPmRktltJG+
         iHD52sh0y+MRHx0vAfAurGIi4q2KFHRN1JsrUNeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/106] soundwire: Kconfig: fix help format
Date:   Sun,  6 Oct 2019 19:21:46 +0200
Message-Id: <20191006171202.852850922@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 9d7cd9d500826a14fc68fb6994db375432866c6a ]

Move to the regular help format, --help-- is no longer recommended.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 19c8efb9a5ee7..84876a74874fb 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig SOUNDWIRE
 	bool "SoundWire support"
-	---help---
+	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
 	  typically related to audio functions. SoundWire interface is
-- 
2.20.1



