Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A10C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D69208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723998;
	bh=wpA3fct7iSxXYernllB6MhlP+rWmyRFIO1xtTmnvfBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvBhCWSwTmbMao8GRtD0fqKclTgaALi6ZrHlxo+Z34GNSyAvCC81UscJh7/WPO/Gf
	 oS6cc14UPEDGmnwEZ0LhW7nFTdZ5ioEDAgl7W/A78pni+hgvYpirPyjJpPvWnaEdSc
	 m+DpJHL0N4GvIL5SSYmBqLhFFKOwvjLey188Ofpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfF1MNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfF1MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6JxwWHVAcBdRrRCz0Yb9RO5F0idp8+rpIOt9c2tpm1A=; b=X7vN88Nh3bID6QWmEQloNNDMTm
        Poy1jCdiOpkQu63Ziz/ZFYoypBjaqhNqLz9zlJ2QvnYOeVd3BaE3hBF4z9TPcFDSH9EvJCS66CAKz
        3Nx4L4TvVypj7RYvjLU1YfIwLAvJUDnrSf35vmnKxCkOmsDKTKNPo6TTnDZ5DpxiKx+0oo8OrBFLw
        kyGYsNWdC0X8EsxAwOyF1QkIZuKE7wAUlnfbeEFaxjf7DRtUygJJaRIyDJTqc//P/vZhuVBTiBbGJ
        KN5El63OMhg2CTA0swqS5UXwMpAQj+4aTJJoP4c0ebbhXjY25UYE3kSZbWw2LY6cljzqG27yvjSWu
        lqX/bThw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BW-Ac; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zr-Dg; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 9/9] platform: x86: get rid of a non-existent document
Date:   Fri, 28 Jun 2019 09:12:31 -0300
Message-Id: <9472251c3ff159b832b4e82d77836c44f89b49b0.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 163ede97a9a2 ("Documentation: platform: Delete x86-laptop-drivers.txt")
removed the x86-laptop-drivers.txt file, but forgot to update its
Kconfig.

Fixes: 163ede97a9a2 ("Documentation: platform: Delete x86-laptop-drivers.txt")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/platform/x86/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bd15b47abcb4..c318501773bc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -433,9 +433,6 @@ config COMPAL_LAPTOP
 	  It adds support for rfkill, Bluetooth, WLAN, LCD brightness, hwmon
 	  and battery charging level control.
 
-	  For a (possibly incomplete) list of supported laptops, please refer
-	  to: Documentation/platform/x86-laptop-drivers.txt
-
 config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
 	depends on ACPI
-- 
2.21.0

