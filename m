Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B412087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240185;
	bh=f4/C8FYZEaey0z2GGEk3DtDShdAB6VYvCKi89Fn4O30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPc5xsstPtQWLotlXf4WgsOd6eHIPCIbOAAi7Qb4ORESmMDGjlmLxmo1lA6tO7Ujp
	 U4S6iSEwRVq9nbm37pPJj8EvO5yiun5V2xcvh2zW2mYGyY/3c7+LKd4CQmomjKv5Tf
	 S4ZOo15GU1cL7+JoKgelCjZRVssMX18s4SAg13QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbfKHTJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390768AbfKHTJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:09:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE2D21D7B;
        Fri,  8 Nov 2019 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240180;
        bh=f4/C8FYZEaey0z2GGEk3DtDShdAB6VYvCKi89Fn4O30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTlpJgbjtOsFnn3/uMUxkpoIGeIWp/bccNjii+008L2nK9I5HN11SjZyiuFxvlRSu
         GjyfSDDeC1tjp6bwW4hvIUOEgEOF75BFbeB/dtU6pORjirmWqwVN088t9wqOUV2OcK
         cX6YsjFIO7Fk5cZ/sxfiubWulM8mvkvgY39jaU6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alain Volmat <alain.volmat@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 074/140] i2c: stm32f7: remove warning when compiling with W=1
Date:   Fri,  8 Nov 2019 19:50:02 +0100
Message-Id: <20191108174909.789503405@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@st.com>

[ Upstream commit 348e46fbb4cdb2aead79aee1fd8bb25ec5fd25db ]

Remove the following warning:

drivers/i2c/busses/i2c-stm32f7.c:315:
warning: cannot understand function prototype:
'struct stm32f7_i2c_spec i2c_specs[] =

Replace a comment starting with /** by simply /* to avoid having
it interpreted as a kernel-doc comment.

Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 82705deef7bff..1fac7344ae9c2 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -305,7 +305,7 @@ struct stm32f7_i2c_dev {
 	struct regmap *regmap;
 };
 
-/**
+/*
  * All these values are coming from I2C Specification, Version 6.0, 4th of
  * April 2014.
  *
-- 
2.20.1



