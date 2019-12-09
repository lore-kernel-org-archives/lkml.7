Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A13C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E3F20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575919994;
	bh=0W8gGVJjYDtZQlvmewb1/dTzwlrjf/HjG4bOkj24umM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dW9nRB8OuMjlGEWteQ8/nLpIIdAVAoPvJt2rnFjraJqOeauWkQTfaXD6lQGyLMyBU
	 Uy+Ak/k1tjjT5XDANQoPy5aMbiAjFaDO6WzNDkEM98D2iLpqzOj58TzR3IUOiXRb6X
	 2+J0rO/szzzjThqtzbZVpWV7BxUJLbkXSJaENFJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLITdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfLITdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCAF20637;
        Mon,  9 Dec 2019 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575919992;
        bh=0W8gGVJjYDtZQlvmewb1/dTzwlrjf/HjG4bOkj24umM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ootnHT+Bxq0JYJhMp8lJR53Phx2cn1oCTphpYtSn7RMAqlYdGiFmLHD9cogDM2tOD
         usoe7KJEfLcwICsKHvIJ+hyiyx76PvbhIK9aorbi6uGic9OPOfatuD1xWTCFrINdj3
         hBpnInoSbsmeWI/gvT70tSAxloEGH6dNOfuNG3EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/6] drivers/base: base.h: add proper copyright and header info
Date:   Mon,  9 Dec 2019 20:32:58 +0100
Message-Id: <20191209193303.1694546-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base.h didn't have any copyright information in it, so update it with
the correct information.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0d32544b6f91..80598b312940 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -1,4 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2012 Novell Inc.
+ * Copyright (c) 2012-2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2012-2019 Linux Foundation
+ *
+ * Core driver model functions and structures that should not be
+ * shared outside of the drivers/base/ directory.
+ *
+ */
 #include <linux/notifier.h>
 
 /**
-- 
2.24.0

