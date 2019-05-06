Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FAEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC682053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155094;
	bh=lPYL5g+WLM6d+0Qykg+Y4Id03XshCXb478aRIX0DWkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ltmfpjNue9t4YyqnzQq4p5b9pi5x3Utvwn8yT+A0EYwPdICKUfEnPj+xoPvUDV9o6
	 TNzb+5IvmYsZoQbyd0Jz3Z4V5KtPH60jHrBMQLn2cYVijJzpntceMRNUkc8SV9W27F
	 q1M8e9rq2+S+8ViwipU60puxI/6YmgmuJURbIGu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfEFOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfEFOiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8929120449;
        Mon,  6 May 2019 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153535;
        bh=lPYL5g+WLM6d+0Qykg+Y4Id03XshCXb478aRIX0DWkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIyNGXLxSPgVBcOEX8QIcyBQ1TbaTLncz9vTsnV+belGliUFdByGgfpb275OHd8E9
         Z1s+YhBdk4qyv3qjgEj/PprNBmons9j8L3haZIrctj5xAL6m5ZgOVEdLGUTMMBfsNM
         4TIiNTlVJZwQby+OPkwDLIQnGxunm2lfwr5mHQLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.0 104/122] platform/x86: intel_pmc_core: Fix PCH IP name
Date:   Mon,  6 May 2019 16:32:42 +0200
Message-Id: <20190506143104.026476119@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

commit d6827015e671cd17871c9b7a0fabe06c044f7470 upstream.

For Cannonlake and Icelake, the IP name for Res_6 should be SPF i.e.
South Port F. No functional change is intended other than just renaming
the IP appropriately.

Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 291101f6a735 ("platform/x86: intel_pmc_core: Add CannonLake PCH support")
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_pmc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -205,7 +205,7 @@ static const struct pmc_bit_map cnp_pfea
 	{"CNVI",                BIT(3)},
 	{"UFS0",                BIT(4)},
 	{"EMMC",                BIT(5)},
-	{"Res_6",               BIT(6)},
+	{"SPF",			BIT(6)},
 	{"SBR6",                BIT(7)},
 
 	{"SBR7",                BIT(0)},


