Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDF42196E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696700;
	bh=GtMRWRCTCaUF8bzZEMfioAD/OxeWiiYhyTZDSfSYQV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIVmXDi+2GPPMH5B02gtgjq9jUiV6Of/sEPjpsTIbSyWSl735fHnZaahHYdjzpEbp
	 tzquF2kpA09m6aSMpleN4atApO34YjpMCmPxM6+GZRZjBCqLDbVrCxzPNFcp7rvkbo
	 qTwOSl7AKt2MUq9AYInlalXyam7E2yL6ad1lPm1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfJJIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbfJJIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:38:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6257221920;
        Thu, 10 Oct 2019 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696693;
        bh=GtMRWRCTCaUF8bzZEMfioAD/OxeWiiYhyTZDSfSYQV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vt68Wt0NTXkmfUTQ5uNvQVx4OifyRVaRl5k3CpKzotgzoSzjFeJBVMZIs5y4Hh9+k
         Xq542MwXFUQLnVw3tFECEGyKGgqJrpvvYwwVGxYZeubU6RIhQ/FyzMYcRtxEx1QiEs
         11uGUBDUTvi1pNp4oOy++eGblowhdB9RXf5bBylM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 019/148] ASoC: Define a set of DAPM pre/post-up events
Date:   Thu, 10 Oct 2019 10:34:40 +0200
Message-Id: <20191010083612.269223452@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

commit cfc8f568aada98f9608a0a62511ca18d647613e2 upstream.

Prepare to use SND_SOC_DAPM_PRE_POST_PMU definition to
reduce coming code size and make it more readable.

Cc: stable@vger.kernel.org
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/20190719100524.23300-2-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/soc-dapm.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -353,6 +353,8 @@ struct device;
 #define SND_SOC_DAPM_WILL_PMD   0x80    /* called at start of sequence */
 #define SND_SOC_DAPM_PRE_POST_PMD \
 				(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
+#define SND_SOC_DAPM_PRE_POST_PMU \
+				(SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU)
 
 /* convenience event type detection */
 #define SND_SOC_DAPM_EVENT_ON(e)	\


