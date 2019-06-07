Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B655C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D2621473
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922421;
	bh=y1bzMfbqPphPMtnUPCsYu7EnJPvPqvUKBEnwiVmJSs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kjayFTuwbQxaPLbGmEEu/Z1kOg8gTNsHWkf2Iy1v8OsAjNdbvb7ZlNNAneEY3ZNqy
	 aExDVfOR+g2gMDdqCw1UAE/DxLPFw0myvUyTQmAJRJ0FRk+1smBExAU5oQJnsofeY1
	 +IRIPj7w0E5t5wlS0+LcIAby74ceBVF586K11H9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfFGPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfFGPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:46:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2C32147A;
        Fri,  7 Jun 2019 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922416;
        bh=y1bzMfbqPphPMtnUPCsYu7EnJPvPqvUKBEnwiVmJSs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDeyLA+GsuvZKcJ8Rc8HGuo2pJ3tNHxtVwdFHo4+m2KyZL2u0UkFtupkCPqPcBTRE
         l11SufsP99wA/jaDI+J8asbNLiGoHku4SAb0I7MW2BaPeTVjWNHMOXSwDxFebsAiik
         wdxh0NAyrHxGA+OuVY4vj3NsLswAN7vtW93jaZrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4.19 43/73] docs: Fix conf.py for Sphinx 2.0
Date:   Fri,  7 Jun 2019 17:39:30 +0200
Message-Id: <20190607153853.966681426@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

commit 3bc8088464712fdcb078eefb68837ccfcc413c88 upstream.

Our version check in Documentation/conf.py never envisioned a world where
Sphinx moved beyond 1.x.  Now that the unthinkable has happened, fix our
version check to handle higher version numbers correctly.

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/conf.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -37,7 +37,7 @@ needs_sphinx = '1.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
 
 # The name of the math extension changed on Sphinx 1.4
-if major == 1 and minor > 3:
+if (major == 1 and minor > 3) or (major > 1):
     extensions.append("sphinx.ext.imgmath")
 else:
     extensions.append("sphinx.ext.pngmath")


