Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDBEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D262086D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483086;
	bh=ghWIX+m6hgr7up8H2IEj/4iJDmGytA1qPuXv0RVTtfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwAvosxt+AOhq1zAC5BQrabrbAg6uYjqJvgC/qmmEcGvYbDCuI7kWwSbZrwtjjDaa
	 Onvm37TYJ/sISoFEZC3UtU4K9+IRLyuCN90TiCWru/R9lgLFFBG6/McxDl5qGWrMBC
	 MUjTujFNBqiy69YY4kC+dpsprDYMryxub18MN6hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfLDSLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfLDSLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:11:19 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3362084B;
        Wed,  4 Dec 2019 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483079;
        bh=ghWIX+m6hgr7up8H2IEj/4iJDmGytA1qPuXv0RVTtfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMQMqnNe3o8AThvmLYiuQr8novJTo/DZOeib7F6NLJfHSwljHeqf9r8R5KnQ2LalE
         sO+BWoyP0zdpk4sReL95xdCl1uizUGPjqSgFIqEuPBSF6OXsdidKDxmwMiFHYpefnL
         eFHcZ5BwkVvlc6e4G6TUe69RrExZ0joKB6HkB5DI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 044/125] HID: doc: fix wrong data structure reference for UHID_OUTPUT
Date:   Wed,  4 Dec 2019 18:55:49 +0100
Message-Id: <20191204175321.643695817@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hutterer <peter.hutterer@who-t.net>

[ Upstream commit 46b14eef59a8157138dc02f916a7f97c73b3ec53 ]

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hid/uhid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
index c8656dd029a91..958fff9453044 100644
--- a/Documentation/hid/uhid.txt
+++ b/Documentation/hid/uhid.txt
@@ -160,7 +160,7 @@ them but you should handle them according to your needs.
   UHID_OUTPUT:
   This is sent if the HID device driver wants to send raw data to the I/O
   device on the interrupt channel. You should read the payload and forward it to
-  the device. The payload is of type "struct uhid_data_req".
+  the device. The payload is of type "struct uhid_output_req".
   This may be received even though you haven't received UHID_OPEN, yet.
 
   UHID_GET_REPORT:
-- 
2.20.1



