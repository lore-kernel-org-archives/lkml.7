Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B679208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049574;
	bh=6Go5VoISTlGqdZE5sd4nYI9+6hmK4LnlnHZEFEt0F+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=stGBkNomlBOIbWj2tDYsv3i/A1E5RXpzSBM+k98NH4qK9e56GcblvZ4DiP6q6rc9T
	 tlrUhi8zVsz8IyrOfhiXFt/ssFStJgymVjjrT8xy3lzHmn9odYvqaGws0lYewO/W02
	 VgrrZ63XgnKIbKbQqKO0IWfiFV6PFXCLetNmlvNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCHMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfCHMwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA9B2087C;
        Fri,  8 Mar 2019 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049567;
        bh=6Go5VoISTlGqdZE5sd4nYI9+6hmK4LnlnHZEFEt0F+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOuVgc2AF08Ba2iOhaN25Fnyk4oe5+ilVncFzqzOIutWSzrUOGFRissEKh2QwIf0x
         ApewZUwJAwJCJSdCAZCcP4p5WXrMzwAfPahZVwce0S8WgJkupag0k+LrCY9u8lxMPz
         38BTf1GQTZrLyZfywJDL/PeYGG0qgKnLjF2gCHOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.0 35/46] alpha: wire up io_pgetevents system call
Date:   Fri,  8 Mar 2019 13:50:08 +0100
Message-Id: <20190308124904.523289263@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d012d1325ba523b8ef3e55ba79c943e220154fdc upstream.

The io_pgetevents system call was added in linux-4.18 but has
no entry for alpha:

warning: #warning syscall io_pgetevents not implemented [-Wcpp]

Assign a the next system call number here.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/syscalls/syscall.tbl |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 520	common	preadv2				sys_preadv2
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents


