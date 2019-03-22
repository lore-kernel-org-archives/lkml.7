Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C6C218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258362;
	bh=vWZy7Sx9HAxboYJ28IOL5TsJp43Vd4glxZQ59Au8nMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r6ezSWrSOaAmB43gJs4Ysww9ER/TwFyZxwM7r5bG2Ipcsj01ibQv0Pg3kMMEkbQHM
	 VkCq3ZQ9O4LP4vMQbXsnDWVHsmJazLgtCRFd6/jV3i1+wehudaCmEjRhMe0DbGcDxs
	 zyVFTDoEDflMk7/SFJeY6LzEsCXkryBWGyM3whfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfCVMHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389055AbfCVMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C9E21929;
        Fri, 22 Mar 2019 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256456;
        bh=vWZy7Sx9HAxboYJ28IOL5TsJp43Vd4glxZQ59Au8nMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2LXqndJlHNdPc3vmuUpYTZOQNeNXHXFqZLfue9XSu/Tu4bVjaMAneAYQokVMJoUs
         tWY+FOy/MpLTj61OYxIsUq6zTadDI82uzbmDC8jaUFQQFpkE4qWLmw7q0oYSUhA6IP
         677wflp/j4Yw6dtU3H0UIfgde/YoUzBII2w6bRro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 196/280] clk: ingenic: Fix doc of ingenic_cgu_div_info
Date:   Fri, 22 Mar 2019 12:15:49 +0100
Message-Id: <20190322111329.745146531@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Cercueil <paul@crapouillou.net>

commit 7ca4c922aad2e3c46767a12f80d01c6b25337b59 upstream.

The 'div' field does not represent a number of bits used to divide
(understand: right-shift) the divider, but a number itself used to
divide the divider.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ingenic/cgu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -80,7 +80,7 @@ struct ingenic_cgu_mux_info {
  * @reg: offset of the divider control register within the CGU
  * @shift: number of bits to left shift the divide value by (ie. the index of
  *         the lowest bit of the divide value within its control register)
- * @div: number of bits to divide the divider value by (i.e. if the
+ * @div: number to divide the divider value by (i.e. if the
  *	 effective divider value is the value written to the register
  *	 multiplied by some constant)
  * @bits: the size of the divide value in bits


