Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC68C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A320850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890236;
	bh=h1w91qjhr78pnIAsWgYKlbFZxpqxhFcF+aY1oYDXM9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WckzN5yf3fXgrjLdtZfbHupecSbpp7PA2zR97Xa7S86pIFB+L9S3CMsFIC3RT4+CN
	 drQvae2OXWzLAPVv5LcroY1KZw99vS+qj0ub7B+V4Y8rVr+smiPf+GsfHic5bA59HD
	 kNycIsnq23egdImAYGq/NJs9sQt4XdTUN9BvtvtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfDJJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:57:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfDJJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VAMFAFAKujLSv3Qur+yCPXsO8JE9Zm7EVPPt0xUnG4w=; b=rlV7Eezkr1xDV7KsL8haeC07UJ
        E8au0Cpc/o6r4HZebT8cwbOB2EljDl74OAsUKCnbkPcWeVvWirn2Mj+JmysddVLVTQBapEboozH/E
        RCzpYCBneY+itXceaEpLj1w2C+SJ1kghzdIyMXcMZqIZzSFAAYMVYloQ7PF3e6oJRMea8ZMpNwWkK
        How4eITB3umQ+R8+ycx4rTYUKK94xz523u5mcS7tCkcdPKyLOaCVou8BS+2cTmkCTJSjQk+FtNW2t
        e+72+o+lBaCae38IKPbU7AavLElsJmbX1OUUKhXLNyW/wrQYUvEi9iwCi3OZe+NwVwuUynUjZbbsx
        k0K53DCA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9y9-0003Cl-7k; Wed, 10 Apr 2019 09:56:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000nx-NN; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/8] docs: DMA-API-HOWTO: add a missing "="
Date:   Wed, 10 Apr 2019 06:56:20 -0300
Message-Id: <3799c957f95603f90ea2f3119b550a9810d0dc79.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The === line is shorter than the section title.

As this will generate a warning with rst build, fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/DMA-API-HOWTO.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 1a721d0f35c8..db48c6fd3162 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -147,7 +147,7 @@ networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
 DMA addressing capabilities
-==========================
+===========================
 
 By default, the kernel assumes that your device can address 32-bits of DMA
 addressing.  For a 64-bit capable device, this needs to be increased, and for
-- 
2.20.1

