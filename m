Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6326C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D23F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577200252;
	bh=qc+WAzd/64gmuhSeO6A8i3hiy3i6zzsArB2SUfgWvNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEzDWZtBewJNgkslR44eA3qrq2Px08ltYA0ZoAhSPdZEahavDVBy0EkvmIqVdG0ri
	 Da9d/VKHbGEqazyFyOJiS5kDwG6sob8p9y1BA8hJRtRrug3UdU5ynY8KCwPCg5WNnb
	 jBGP8e+3hfuDC9yYAae/17KOxfGy6irGMKwNAsrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLXPKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 10:10:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfLXPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:49 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1AC2071E;
        Tue, 24 Dec 2019 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200249;
        bh=qc+WAzd/64gmuhSeO6A8i3hiy3i6zzsArB2SUfgWvNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYlTr11B6zPXbpsMpsjz7uDUPhE1q+BdxwTvweE4jUb9tVaHcvGV8CL51ofVRXgc7
         HXHr5PyjnOhvvZPN0koLNy3Fmeu6NQPnPLqSb98yO0+twKZenHma1I1y/2XaDm0mDa
         xZAkS5ChE+0WqAewlA/v1ClW8DEOKF24TPhS0dNI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 02/25] efi/gop: Remove unused typedef
Date:   Tue, 24 Dec 2019 16:10:02 +0100
Message-Id: <20191224151025.32482-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

We have stopped using gop->query_mode(), so remove the unused typedef
for the function prototype.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 83a62f5c3fd7..9ea81cfe1576 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1479,10 +1479,6 @@ struct efi_graphics_output_protocol {
 	struct efi_graphics_output_protocol_mode *mode;
 };
 
-typedef efi_status_t (*efi_graphics_output_protocol_query_mode)(
-	struct efi_graphics_output_protocol *, u32, unsigned long *,
-	struct efi_graphics_output_mode_info **);
-
 extern struct list_head efivar_sysfs_list;
 
 static inline void
-- 
2.20.1

