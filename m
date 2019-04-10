Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69B620818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YnuxASh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfDJICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:02:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfDJICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZ2Z6ur3EIQ6lvifzseHRO/TnRmEadu7mVBXOqzZNmE=; b=YnuxASh/yJjpLNEJVHCl3mEZp
        EHAM0gK/ddnX+fj3GXujjO4uJl9a/3pH/h3Pp14EYpU+tVVOD2mK03EQit3f7DWPiB2o8z30bHXu6
        c3gDgZcO5wSl3hESiwSZSYkmzUwasyLCM8cARiSQ2PeEtqOrREY9SiEvYdSdVs0Uiw9HmH6TqwD/B
        FWyzLe010b4G8nPw43rSISGQBujiDzUbzSQI2WBjnpxOyXSLwBDoqBX0p4Ad/lkcPqtZQJEyOEzTA
        c+ONV5wjnQpgIAtgOjMF8M6BfTWYozVgn/2W4KD3XBz/xp38Fb+z/eQWxrZxLe942jp7OGtmebvUx
        Ol0kcCsbQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE8By-0007XK-4Q; Wed, 10 Apr 2019 08:02:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: two small DMA-related Kconfig cleanups for x86
Date:   Wed, 10 Apr 2019 10:02:18 +0200
Message-Id: <20190410080220.21705-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleaning up the Kconfig files for some of the changes happening
over the last years..


