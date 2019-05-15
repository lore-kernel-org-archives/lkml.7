Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB92C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8E82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918749;
	bh=cXkUWaJKFNGT0UDCgndx8rzLPOQvubfRIOTueJoC8eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbyvcb43qSepKpAj+ElHopNy85P6G/bpzxdUVXnuCwhal6Ofp3KinN4GaMCcKDkxu
	 ylw1Aed/vPl0qF6XqGYGoOqSOkLdulKSIY59xz8cXF5OOukJuLaRmEHphTPlpFQtnn
	 SL3m6hjGQB8bCrPAQeAdbEOjwb7TQz4M3kuFF4MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfEOLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfEOLMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BA22084E;
        Wed, 15 May 2019 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918740;
        bh=cXkUWaJKFNGT0UDCgndx8rzLPOQvubfRIOTueJoC8eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/HmI9G8fsBMMMcqTq2DwDPofahND40EbptZGcpYpanjVcitbiNDwMhD04Jf9FPNG
         1SSlzEDqyBt4w40DbsBbfp34MTWo75GPB0uF+et1arl5XTHvkNHAhH7kRXQzCCbp1Y
         cmBdcHltcGxcxEXBzyXaVAvRMlIGwVd24YPLGw8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 245/266] x86/speculation/mds: Fix comment
Date:   Wed, 15 May 2019 12:55:52 +0200
Message-Id: <20190515090731.296093965@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit cae5ec342645746d617dd420d206e1588d47768a upstream.

s/L1TF/MDS/

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -210,7 +210,7 @@ static void x86_amd_ssb_disable(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"MDS: " fmt
 
-/* Default mitigation for L1TF-affected CPUs */
+/* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation = MDS_MITIGATION_FULL;
 
 static const char * const mds_strings[] = {


