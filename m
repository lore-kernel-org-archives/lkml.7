Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9808206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935594;
	bh=7VnK6jTegEgCwnXp3D+hXbGW8Nj3/vYjUFUDbB74H3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0n+M3DsH9hJ5bMUJA4Mj9hBIP0Em9BBSmcTclGOq9itGMd/RYvu0fL/hKl54HQWFt
	 N07PnkMvaZuMHSsHejQwB+JuKHJa4lcGm7Xmm5j+4Dv/zS/xotgpxtb36PyXQXX+xw
	 qJYigWzNw1Jlk1uYD3Rm5m4zlqN+ZzvEvOvabbIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfH0TxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbfH0TxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:53:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4E020674;
        Tue, 27 Aug 2019 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935592;
        bh=7VnK6jTegEgCwnXp3D+hXbGW8Nj3/vYjUFUDbB74H3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G57nGQjgYnA8J8+Ce44IdVaphL5OlxfyJkmJmLzEtpq5ncjxFqyZsqqwOobChc9s2
         4gob3xrM9LR03gkCPdUZQAvsg2gVGvvHBm8tvcd4fpOBHHfJvlNHDX0bB0SLGYiX0D
         2aD41ZJAND8NhbGtoFiSbGrHe0Ygf82+wEjG2UTg=
Date:   Tue, 27 Aug 2019 21:53:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-spdx@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: add entry for LICENSES and SPDX stuff
Message-ID: <20190827195310.GA30618@kroah.com>
References: <20190827172519.GA28849@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827172519.GA28849@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas and I seem to have become the "unofficial" maintainers for these
files and questions about SPDX things.  So let's make it official.

Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:	add Documentation/process/license-rules.rst

 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9234,6 +9234,18 @@ F:	include/linux/nd.h
 F:	include/linux/libnvdimm.h
 F:	include/uapi/linux/ndctl.h
 
+LICENSES and SPDX stuff
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+L:	linux-spdx@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
+F:	COPYING
+F:	Documentation/process/license-rules.rst
+F:	LICENSES/
+F:	scripts/spdxcheck-test.sh
+F:	scripts/spdxcheck.py
+
 LIGHTNVM PLATFORM SUPPORT
 M:	Matias Bjorling <mb@lightnvm.io>
 W:	http://github/OpenChannelSSD
