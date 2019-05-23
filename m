Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C197C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D1721851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638542;
	bh=zZyUwNkjLz79/Q09dfLu0J71rjWtORh+YiQLwpXk0go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ttusxycNFewjq6+V9lnWKsyJ3PetZIfy8AhvGv//0TdANqynSplr6krgA+HUDOEJS
	 iFg7IyqvLl70t872y7TVqG8nOXCtJLvrNco9pcZhR5hnQ5Uc/q9MH0GvJ3A0cSUzAK
	 MjBDhemXZBcHlCQ87dOFsLMoJVNOibE/JtpwVh2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfEWTJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731992AbfEWTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:08:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C66E217D7;
        Thu, 23 May 2019 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638538;
        bh=zZyUwNkjLz79/Q09dfLu0J71rjWtORh+YiQLwpXk0go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qt8qPeTIiXo9uZaVryrkd+VCofNuH0y/zFWlubFOYXAczCwwvbFMc8/y1GwwZ1q5/
         iHKT726YspH9vSzq7BPGoe5I4Mo6DEcnLaGtvosIQ5lSFj2oF/yYl/Cp2641g6OXRv
         o2j+EHTfOPRCvHR44c0CH6+xK2rG59U7xEvifu3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 08/53] parisc: Export running_on_qemu symbol for modules
Date:   Thu, 23 May 2019 21:05:32 +0200
Message-Id: <20190523181712.274451857@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 3e1120f4b57bc12437048494ab56648edaa5b57d upstream.

Signed-off-by: Helge Deller <deller@gmx.de>
CC: stable@vger.kernel.org # v4.9+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/process.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -189,6 +189,7 @@ int dump_task_fpu (struct task_struct *t
  */
 
 int running_on_qemu __read_mostly;
+EXPORT_SYMBOL(running_on_qemu);
 
 void __cpuidle arch_cpu_idle_dead(void)
 {


