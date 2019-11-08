Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F90320656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240824;
	bh=hxzDfQPmSOSmyltI5rLJZbhymPePo8SAfCesBa43av0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFp8Ah2Wcq9lWlhEtcrx6MBMc8YWFgMJg5qOUW0BmTvn7SFLZfrt2oXmQt8ZThDP3
	 c6S+bceTtw6ayf4OsXx0EQvAhl+7Dmaf0rQLCpIx5gRhylnC28epZsozAYBhcxqJhJ
	 B30aRs5xKkStwESqOqaLltFzAlrEGtPaZ9Q9NcxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbfKHTUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389443AbfKHTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4242246A;
        Fri,  8 Nov 2019 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239481;
        bh=hxzDfQPmSOSmyltI5rLJZbhymPePo8SAfCesBa43av0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ei7uJOLWInlRc8CkvDRmxcAfWAK7gyYGb1hLjV3W15s5TMQ1SCTddCoFpnEDpg5rn
         R0+kQIOSJ9XND2EiCbw0BcnjDPDpUafxH45LOGLy8cly6o9vHz6Moz7cGfzoYDcXvk
         XYZtOK7vDsSmy9qW6FJ+ril8TEBjJyukSFt7K0VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alain Volmat <alain.volmat@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/62] i2c: stm32f7: remove warning when compiling with W=1
Date:   Fri,  8 Nov 2019 19:50:08 +0100
Message-Id: <20191108174736.006881709@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
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
index d8cbe149925b5..14f60751729e7 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -219,7 +219,7 @@ struct stm32f7_i2c_dev {
 	struct stm32f7_i2c_timings timing;
 };
 
-/**
+/*
  * All these values are coming from I2C Specification, Version 6.0, 4th of
  * April 2014.
  *
-- 
2.20.1



