Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9DDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C8320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380372;
	bh=Apev0aYYQBSo5ry4GYQFHs9O4W7sPWZZ5PA3jAZ2FIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZ0PqBSTj1QVi+wHd8xr4Hs8+12hq8PW/vG2o/O5t4IEFaVM2AvMI67BCN46MU/ix
	 bx/O96iFYYkFTqFu8IZe8qUDoV+DNLM5pyYvERQfWQnPBYdGdJTnfLERxlh6bDHchB
	 GP8KcZ2Vi5+P0v4F9vmb1E7ptFJ8GPFdW3M9HMqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfIMNMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbfIMNMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:49 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005F9208C0;
        Fri, 13 Sep 2019 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380368;
        bh=Apev0aYYQBSo5ry4GYQFHs9O4W7sPWZZ5PA3jAZ2FIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djmdag46P9DyklkH1yKgpuW83Zykh1THmi+EKuvKVfGukplxYH5JKOWg0YNicLi9i
         S0lKUt2DaTe9qesnSlm2/0TwKHFemdoLRpqpfZD8zX7gAgCeVEc7uveSW8fX3D3RM0
         fp6TJOOYVTpWgNy8dCunDdVyueF4lcDUzwaAUSIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/190] riscv: remove unused variable in ftrace
Date:   Fri, 13 Sep 2019 14:04:39 +0100
Message-Id: <20190913130601.564607194@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 397182e0db56b8894a43631ce72de14d90a29834 ]

Noticed while building kernel-4.20.0-0.rc5.git2.1.fc30 for
Fedora 30/RISCV.

[..]
BUILDSTDERR: arch/riscv/kernel/ftrace.c: In function 'prepare_ftrace_return':
BUILDSTDERR: arch/riscv/kernel/ftrace.c:135:6: warning: unused variable 'err' [-Wunused-variable]
BUILDSTDERR:   int err;
BUILDSTDERR:       ^~~
[..]

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: e949b6db51dc1 ("riscv/function_graph: Simplify with function_graph_enter()")
Reviewed-by: Olof Johansson <olof@lixom.net>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c433f6d3dd64f..a840b7d074f7d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
-- 
2.20.1



