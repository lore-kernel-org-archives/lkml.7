Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E95C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0524650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576659658;
	bh=fnQes9rkeo2+ETO5lDeAWB5DEr1Q/KNKRFHy2zE/WJI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cGskbvd0jvcZFNLlv3DFO8PS0LA/sE94NQ1RVe024Fq/itzd9XNk31377smbjW5MC
	 AERqtx50cGh4YbyOELFl84Wj/WFJZpH7zJ9m8yvXulWUmMEpZHgYMcpHP+8c5NLb57
	 pr8YlkBy5D9m3vzNGxH7/lZH4Uw8JH6tU+6Vpm+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRJA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfLRJA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:00:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C3221D7D;
        Wed, 18 Dec 2019 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576659656;
        bh=fnQes9rkeo2+ETO5lDeAWB5DEr1Q/KNKRFHy2zE/WJI=;
        h=Date:From:To:Cc:Subject:From;
        b=Z6eVeybXdWK+ZtbMByC3F2WHSFpRHPwCSoF5Oxrz5oloBJVc5fqpVvP4UzkKPfBkH
         7V783bO/pwQqFEMl/H4r9dip6i3IorVquAOC05UMzuqvJjYD4EKevzmAiqc6a2pCL8
         1TZk66Jn2O0y5lbu8Z3TyjM11wPJLfyau7eE1dlQ=
Date:   Wed, 18 Dec 2019 10:00:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org
Subject: Linux Kernel Code of Conduct Committee: August 2019 to November 2019
 report
Message-ID: <20191218090054.GA5120@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: August 2019 to November 2019 report

In the period of August 1, 2019 through November 31, 2019, the Committee
received no reports.

We would like to thank the Linux kernel community members who have supported
the adoption of the Code of Conduct and who continue to uphold the professional
standards of our community.  If you have questions about this report,
please write to <conduct@kernel.org>.

------------

Side-note, yes, the website at
https://www.kernel.org/code-of-conduct.html is not up to date with the
list of the current members of the kernel code of conduct committee, nor
does it contain this or the prior report yet.  I'll get that working
soon...

thanks,

greg k-h
