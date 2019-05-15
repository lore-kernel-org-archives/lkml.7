Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D820C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FCE21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918728;
	bh=lCA9yCHJbxOvPg1laqgfr1DEDOUsJEVKxcDY6A/EtBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0xwMuBtsmAw0MloFB+kOn/Pv4aCCRegtv9QwgYh2rlTv7jym8Xx051IE6C5TLKvr
	 Q1D0yo1uXxi6dQwN5FB+U+o6GSUl5dYPt4V4WkTDm8e0ZNzE4Hp7d+aZOOc4yZ/eD2
	 79AjGqJ08IxcjDkHg9GpEB62BSpzZ6YfuHiAPkkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfEOLMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfEOLMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B1820644;
        Wed, 15 May 2019 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918724;
        bh=lCA9yCHJbxOvPg1laqgfr1DEDOUsJEVKxcDY6A/EtBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vcly20mnuBGAo1r90Jw7SV9KcFWoaNss/vDmQevgpi+WFZUzN3JxLugVXEKRIwSBy
         eBGIy/gvE3eErlxKKubTQ+mk8OlEInejk1/lcL8Ty3iQW1Hffvuj7mioKtEVtezJgF
         XYinzcUuki40C9HfoxFF7hjWBjEtstn6eBp4Efk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jon Masters <jcm@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 240/266] Documentation: Move L1TF to separate directory
Date:   Wed, 15 May 2019 12:55:47 +0200
Message-Id: <20190515090731.122992345@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 65fd4cb65b2dad97feb8330b6690445910b56d6a upstream.

Move L!TF to a separate directory so the MDS stuff can be added at the
side. Otherwise the all hardware vulnerabilites have their own top level
entry. Should have done that right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jon Masters <jcm@redhat.com>
[bwh: Backported to 4.4: we never added the documentation, so just update
 the log message]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1063,7 +1063,7 @@ static void __init l1tf_select_mitigatio
 		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
 				half_pa);
 		pr_info("However, doing so will make a part of your RAM unusable.\n");
-		pr_info("Reading https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html might help you decide.\n");
+		pr_info("Reading https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html might help you decide.\n");
 		return;
 	}
 


