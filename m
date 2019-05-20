Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D4AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355921;
	bh=IJt24hyJCvJF3H0FS0NaVCue6qeX16pkGyBl5737TZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TlB33NlHJTiWEPXUoodJAW+VtYshmiDGnxj3ZWdO2LAe7lNVIsbWtMbiIk4v8q2sn
	 dpIlhSGtSNLusWpZE58UN5WM+vMzvPzYcP7jglaRC9NG7Qi7TIqz+HvZhkab85TXiv
	 ca5iRbDz1sXFiUHGnECnxTjV+YL66MezXfLpdYpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391413AbfETMik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390987AbfETMeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:34:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B54B21479;
        Mon, 20 May 2019 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355683;
        bh=IJt24hyJCvJF3H0FS0NaVCue6qeX16pkGyBl5737TZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pejclhSDekRzD8kYg3H9E1EjutUzbxwraeiv9wFHVDGfOhiiZBs//vgEAnf6rk+dK
         TFFZQEGx0vbGspiS14FZ2sZ+FVR9OemRTIHVA9qv7NYOiZHaRFTKiNWLa7lNHxVqzh
         iik6rEUVCFWKiBxZA1oAlprMWZyw4i1tsYQ/nSLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.1 044/128] dt-bindings: mmc: Add disable-cqe-dcmd property.
Date:   Mon, 20 May 2019 14:13:51 +0200
Message-Id: <20190520115252.709304225@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Muellner <christoph.muellner@theobroma-systems.com>

commit 28f22fb755ecf9f933f045bc0afdb8140641b01c upstream.

Add disable-cqe-dcmd as optional property for MMC hosts.
This property allows to disable or not enable the direct command
features of the command queue engine.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Fixes: 84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
 1 file changed, 2 insertions(+)

--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -64,6 +64,8 @@ Optional properties:
   whether pwrseq-simple is used. Default to 10ms if no available.
 - supports-cqe : The presence of this property indicates that the corresponding
   MMC host controller supports HW command queue feature.
+- disable-cqe-dcmd: This property indicates that the MMC controller's command
+  queue engine (CQE) does not support direct commands (DCMDs).
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"


