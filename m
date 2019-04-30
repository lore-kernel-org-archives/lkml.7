Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C8C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AB221670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsLOi022"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfD3KwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfD3KwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lPfh28qUBwA6NDJssauYlmo4DTLfQqZGBq58aXTm7uE=; b=XsLOi022t5Gy1qDHOn56jlESe
        JpYV4OLdaK3y7GU/Vv6SIVBETUGWAa5x9UmaSHKq/fgGqu/j4bNH9t2PSaXfkKA5B0rynG1M6h43A
        wtvM0PtWjO8nKcfzJLVU/9Z0/bfO+rtMN9QZPb33BpPosJLpoukGnaNZ1c1gwt0Rdn/zOagVlHREP
        uHXeFvbHpKm8bej7PRUeZPGNc6Xt+adgqncr2J3CV0WuXxjQE+i5C6QrfAmI68MDpe3OowLLQGZGW
        EEFBoyjyNj8rigy0hNPUXn1/0oIT0MbEs5bqtuqLXkb5crIVaA9GkE+qhjX7fctHx67zKfGepQQT/
        VpN3DqHsw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQMq-0007Dj-CW; Tue, 30 Apr 2019 10:52:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: clarify other licenses in LICENSES/
Date:   Tue, 30 Apr 2019 06:51:27 -0400
Message-Id: <20190430105130.24500-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series splits the others category into dual or deprecated,
and also fixes up some other minor bits in the documentation for
these non-preferred licenses.
